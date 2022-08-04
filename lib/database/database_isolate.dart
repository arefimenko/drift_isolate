import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:drift/isolate.dart';
import 'package:drift_isolate/database/database.dart';

/// Обработчик ивентов в [Isolate].
///
/// Первостепенно отправляется [SendPort] для взаимодействия,
/// в дальнейшем через полученный и отправленный [SendPort] происходит взаимодействие.
Future<void> _isolateHandler(_DatabaseMessage message) async {
  final receivePort = ReceivePort();
  SendPort? sendPort;
  if (message is _DatabaseInitMessage) {
    sendPort = message.sendPort..send(receivePort.sendPort);
  }

  late final Database storeDatabase;

  await for (final message in receivePort) {
    if (sendPort != null && message is _DatabaseMessage) {
      if (message is _DatabaseConnectMessage) {
        try {
          final isolate = DriftIsolate.fromConnectPort(message.connectPort);
          storeDatabase = Database.isolateConnect(isolate);
          sendPort.send(_DatabaseIsolateResult(message.id));
        } on Object catch (e, s) {
          sendPort.send(_DatabaseIsolateException._(message.id, e, s));
        }
      } else if (message is _DatabaseInsertPrices) {
        try {
          await storeDatabase.insertPrices(message.prices);
          sendPort.send(_DatabaseIsolateResult(message.id));
        } on Object catch (e, s) {
          sendPort.send(_DatabaseIsolateException._(message.id, e, s));
        }
      } else if (message is _DatabaseCountOfPricesEvent) {
        try {
          final pricesCount = await storeDatabase.pricesCount();
          sendPort.send(_DatabaseCountOfPricesResult(pricesCount, message.id));
        } on Object catch (e, s) {
          sendPort.send(_DatabaseIsolateException._(message.id, e, s));
        }
      }
    }
  }
}

/// Обёртка для работы с [Database] в рамках [Isolate].
///
/// Позволяет отправлять данные для записи в БД.
class DatabaseIsolate {
  /// [SendPort] для общения с поднятым [Isolate].
  ///
  /// Сделан через [Completer] для моментальной возможности работать с [DatabaseIsolate].
  late final Completer<SendPort> _sendPort = Completer<SendPort>();

  /// Стрим с результатами выполнения [_DatabaseMessage].
  late final StreamController<_DatabaseIsolateMessageIdentifier> _stream =
      StreamController<_DatabaseIsolateMessageIdentifier>.broadcast();
  late final Completer<Isolate> _isolateCompleter = Completer<Isolate>();
  late final Random _rand = Random();

  /// Порт подключения к БД.
  final SendPort _storeConnectPort;

  /// Было ли вызвано закрытие [Isolate].
  bool _isClosed = false;

  /// При создании объекта поднимает [Isolate] и необходимые для взаимодействия с ним контракты.
  DatabaseIsolate(this._storeConnectPort) {
    _init();
  }

  /// Вставить цены в БД.
  Future<void> insertPrices(Iterable<DbPrice> prices) {
    return _performAction((workId) => _DatabaseInsertPrices(prices, workId));
  }

  /// Вставить цены в БД.
  Future<int> pricesCount() async {
    final workId = _getActionId();
    final sendPort = await _sendPort.future;
    sendPort.send(_DatabaseCountOfPricesEvent(workId));
    return _stream.stream.firstWhere((response) => response.id == workId).then((value) {
      if (value is _DatabaseCountOfPricesResult) return value.count;
      if (value is _DatabaseIsolateException) throw value.exception;
      throw UnimplementedError(
        'Для данного типа $value не обработан результат выполнения в switchTo.',
      );
    });
  }

  /// Закрывает текущий изолят для взаимодействия.
  Future<void> dispose() async {
    if (_isClosed) return;
    _isClosed = true;
    await _stream.close();
    await _isolateCompleter.future.then((isolate) => isolate.kill());
  }

  /// Инициализация работы с [Isolate].
  ///
  /// Создаёт необходимые для общения объекты, полученные результаты отправляются
  /// в локальный стрим для получения результатов выполнения [_DatabaseMessage].
  Future<void> _init() async {
    final receivePort = ReceivePort();
    final sendPort = receivePort.sendPort;
    final isolate = await Isolate.spawn<_DatabaseMessage>(
      _isolateHandler,
      _DatabaseInitMessage(sendPort, _getActionId()),
    );
    _isolateCompleter.complete(isolate);
    receivePort.listen(
      // ignore: avoid_annotating_with_dynamic
      (dynamic message) {
        if (message is SendPort) _handleSendPort(message);
        if (message is _DatabaseIsolateMessageIdentifier) _stream.sink.add(message);
      },
    );
  }

  /// Получаем [SendPort] от [Isolate] и отправляем [SendPort] для подключения к БД.
  ///
  /// Не упаковывать данный метод в [_performAction].
  Future<void> _handleSendPort(SendPort sendPort) async {
    final workId = _getActionId();
    sendPort.send(_DatabaseConnectMessage(_storeConnectPort, workId));
    await _stream.stream.firstWhere((response) => response.id == workId).then((value) {
      if (value is _DatabaseIsolateResult) return;
      if (value is _DatabaseIsolateException) throw value.exception;
      throw UnimplementedError(
        'Для данного типа $value не обработан результат выполнения в _handleSendPort.',
      );
    });
    _sendPort.complete(sendPort);
  }

  /// Выполнить некое действие в изоляте.
  Future<void> _performAction(_DatabaseMessage Function(int workId) message) async {
    final workId = _getActionId();
    final sendPort = await _sendPort.future;
    sendPort.send(message(workId));
    return _stream.stream.firstWhere((response) => response.id == workId).then((value) {
      if (value is _DatabaseIsolateResult) return;
      if (value is _DatabaseIsolateException) throw value.exception;
      throw UnimplementedError(
        'Для данного типа $value не обработан результат выполнения в _performAction.',
      );
    });
  }

  /// Случайное целое значение для идентификации действия.
  ///
  /// Используется для соотношения [_DatabaseIsolateResult] к [_DatabaseMessage].
  int _getActionId() => _rand.nextInt(2 ^ 32);
}

/// Исключение, произошедшее в рамках [DatabaseIsolate].
class _DatabaseIsolateException implements Exception, _DatabaseIsolateMessageIdentifier {
  @override
  final int id;

  /// Ошибка, которая произошла во время выполнения записи.
  final Object error;

  /// Информация об очерёности выполнения, при которой произошло исключение.
  final StackTrace stackTrace;

  /// Преобразованная ошибка до исключения.
  Exception get exception {
    final error = this.error;
    return error is Exception ? error : Exception(error);
  }

  _DatabaseIsolateException._(this.id, this.error, this.stackTrace);

  @override
  String toString() {
    return 'StoreIsolateActionException{error: $error}';
  }
}

/// Идентификатор сообщения для работы с [DatabaseIsolate].
class _DatabaseIsolateMessageIdentifier {
  final int id;

  _DatabaseIsolateMessageIdentifier(this.id);
}

/// Сообщение для общения с [Isolate].
class _DatabaseMessage implements _DatabaseIsolateMessageIdentifier {
  @override
  final int id;

  _DatabaseMessage(this.id);
}

/// Первое сообщение в [Isolate] для создания подключения.
class _DatabaseInitMessage extends _DatabaseMessage {
  final SendPort sendPort;

  _DatabaseInitMessage(this.sendPort, super.id);
}

/// Сообщение с [SendPort] для подключения к БД.
class _DatabaseConnectMessage extends _DatabaseMessage {
  final SendPort connectPort;

  _DatabaseConnectMessage(this.connectPort, super.id);
}

/// Сообщение для вставки цен.
class _DatabaseInsertPrices extends _DatabaseMessage {
  final Iterable<DbPrice> prices;

  _DatabaseInsertPrices(this.prices, super.id);
}

/// Сообщение для получения кол-ва цен в БД.
class _DatabaseCountOfPricesEvent extends _DatabaseMessage {
  _DatabaseCountOfPricesEvent(super.id);
}

/// Результат выполнения [_DatabaseCountOfPricesEvent].
class _DatabaseCountOfPricesResult extends _DatabaseIsolateResult {
  final int count;

  _DatabaseCountOfPricesResult(this.count, super.id);
}

/// Результат выполнения действия в рамках изолята.
class _DatabaseIsolateResult implements _DatabaseIsolateMessageIdentifier {
  /// id для идентификации с [_DatabaseMessage].
  @override
  final int id;

  const _DatabaseIsolateResult(this.id);
}
