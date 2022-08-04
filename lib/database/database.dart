import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift_isolate/database/isolate_starter.dart';

part 'database.g.dart';

/// База данных приложения.
class Database {
  static Database? _instance;

  final _AppDriftDatabase _db;

  final DriftIsolate _isolate;

  /// порт для подключения к БД.
  SendPort get isolateConnectPort => _isolate.connectPort;

  Database.isolateConnect(this._isolate) : _db = _AppDriftDatabase.fromIsolate(_isolate);

  /// создаёт БД в файле.
  static Future<Database> createFileDatabase() async {
    final instance = _instance;
    if (instance != null) return instance;
    final isolate = await createFileIsolate('filename');
    return _instance = Database.isolateConnect(isolate);
  }

  /// создаёт БД в памяти.
  static Future<Database> createMemoryDatabase() async {
    final instance = _instance;
    if (instance != null) return instance;
    final isolate = await createMemoryDriftIsolate();
    return _instance = Database.isolateConnect(isolate);
  }

  Future<int> pricesCount() async {
    return (await _db.select(_db.prices).get()).length;
  }

  Future<void> insertPrices(Iterable<DbPrice> prices) {
    return _db.batch((batch) => batch.insertAllOnConflictUpdate(_db.prices, prices));
  }
}

@DriftDatabase(include: {'drifts/prices.drift'})
class _AppDriftDatabase extends _$_AppDriftDatabase {
  @override
  int get schemaVersion => 1;

  _AppDriftDatabase._connect(DatabaseConnection connection) : super.connect(connection);

  /// Создаёт экземпляр [_AppDriftDatabase].
  ///
  /// На вход принимает изоляет [DriftIsolate] и возвращает ленивый экземпляр [_AppDriftDatabase],
  /// который будет инициализирован при первом обращении.
  factory _AppDriftDatabase.fromIsolate(DriftIsolate isolate) =>
      _AppDriftDatabase._connect(DatabaseConnection.delayed(isolate.connect()));

  /// Блок вспомогательных методов для вставки значений.

  /// Вставить некий объект в соответствующую ему таблицу в БД.
  Future<void> insertByType<I extends Insertable<I>, T extends TableInfo<Table, I>>(
    I data,
  ) async {
    final table = allSchemaEntities.whereType<T>().first;
    await batch((batch) => batch.insert(table, data));
  }

  /// Вставить некий объект в соответствующую ему таблицу в БД.
  ///
  /// Перезапишется в случае конфликта.
  Future<void> insertByTypeOnDiffUpdate<I extends Insertable<I>, T extends TableInfo<Table, I>>(
    I data,
  ) async {
    final table = allSchemaEntities.whereType<T>().first;
    await batch((batch) => batch.insert(table, data, onConflict: DoUpdate((_) => data)));
  }

  /// Вставить массив неких объектов в соответствующую им таблицу в БД.
  Future<void> insertByTypeAll<I extends Insertable<I>, T extends TableInfo<Table, I>>(
    Iterable<I> data,
  ) async {
    final table = allSchemaEntities.whereType<T>().first;
    await batch((batch) => batch.insertAll(table, data));
  }

  /// Вставить массив неких объектов в соответствующую им таблицу в БД.
  ///
  /// Данные перезапишутся в случае конфликта.
  Future<void> insertByTypeAllOnDiffUpdate<I extends Insertable<I>, T extends TableInfo<Table, I>>(
    Iterable<I> data,
  ) async {
    final table = allSchemaEntities.whereType<T>().first;
    await batch((batch) => batch.insertAllOnConflictUpdate(table, data));
  }
}
