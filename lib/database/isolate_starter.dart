import 'dart:io';
import 'dart:isolate';

import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

Future<DriftIsolate> createFileIsolate(String filename) async {
  final dataDirectory = await getApplicationDocumentsDirectory();
  final dbFilepath = p.join(dataDirectory.path, '$filename.sqlite');
  return _createDriftIsolate(dbFilepath);
}

/// Создаёт изолят с базой данных.
///
/// Принимает путь к sqlite-файлу для открытия/создания необходмой базы данных.
Future<DriftIsolate> _createDriftIsolate(String filePath) async {
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startBackground,
    _IsolateStartRequest(receivePort.sendPort, filePath),
  );

  return await receivePort.first as DriftIsolate;
}

/// Открывает файл базы данных в изоляте.
///
/// Принимает в себя обёртку с путём до файла базы данных.
void _startBackground(_IsolateStartRequest request) {
  final executor = NativeDatabase(File(request.targetPath));
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
    killIsolateWhenDone: true,
  );
  request.sendDriftIsolate.send(driftIsolate);
}

/// Обёртка для передачи пути до каталога с файлом базы данных в изолят
class _IsolateStartRequest {
  final SendPort sendDriftIsolate;
  final String targetPath;

  _IsolateStartRequest(this.sendDriftIsolate, this.targetPath);
}

/// Создаёт изолят с базой данных в памяти.
Future<DriftIsolate> createMemoryDriftIsolate() async {
  final receivePort = ReceivePort();

  await Isolate.spawn(
    _startMemoryDatabase,
    receivePort.sendPort,
  );

  return await receivePort.first as DriftIsolate;
}

void _startMemoryDatabase(SendPort sendPort) {
  final executor = NativeDatabase.memory();
  final driftIsolate = DriftIsolate.inCurrent(
    () => DatabaseConnection.fromExecutor(executor),
  );
  sendPort.send(driftIsolate);
}
