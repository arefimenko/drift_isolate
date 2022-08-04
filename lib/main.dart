import 'package:drift_isolate/data_faker/prices_data_faker.dart';
import 'package:drift_isolate/database/database.dart';
import 'package:drift_isolate/database/database_isolate.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'drift isolate',
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final String databaseType;
  late final _controller = TextEditingController(text: '100');
  int dataCount = 0;
  Duration duration = Duration.zero;
  bool isInsertingData = false;

  Database get database => _database ?? _throwNullableDatabase();

  DatabaseIsolate get databaseIsolate => _databaseIsolate ?? _throwNullableDatabase();

  Database? _database;
  DatabaseIsolate? _databaseIsolate;

  @override
  void dispose() {
    databaseIsolate.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _database == null
              ? [
                  TextButton(
                    onPressed: createFileDb,
                    child: const Text('поднять БД в файле'),
                  ),
                  TextButton(
                    onPressed: createMemoryDb,
                    child: const Text('поднять БД в памяти'),
                  ),
                ]
              : [
                  Text(databaseType),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: CircularProgressIndicator(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                    child: Text(
                      'Время выполнения крайней операции по вставке $duration',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 200),
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Text('Кол-во данных в БД $dataCount'),
                  ),
                  TextButton(
                    onPressed: isInsertingData ? null : insertShopsData,
                    child: const Text('вставить в главном изоляте и получить кол-во'),
                  ),
                  TextButton(
                    onPressed: isInsertingData ? null : insertShopsIsolateData,
                    child: const Text('вставить в поднятом изоляте и получить кол-во'),
                  ),
                ],
        ),
      ),
    );
  }

  Future<void> insertShopsData() async {
    setState(() {
      isInsertingData = true;
    });
    final count = parseInsertCount();
    final sw = Stopwatch()..start();
    await database.insertPrices(PricesDataFaker.generate(count));
    dataCount = await database.pricesCount();
    sw.stop();
    duration = Duration(milliseconds: sw.elapsedMilliseconds);
    isInsertingData = false;
    setState(() {});
  }

  Future<void> insertShopsIsolateData() async {
    setState(() {
      isInsertingData = true;
    });
    final count = parseInsertCount();
    final sw = Stopwatch()..start();
    await databaseIsolate.insertPrices(PricesDataFaker.generate(count));
    dataCount = await databaseIsolate.pricesCount();
    sw.stop();
    duration = Duration(milliseconds: sw.elapsedMilliseconds);
    isInsertingData = false;
    setState(() {});
  }

  int parseInsertCount() {
    return int.tryParse(_controller.text) ?? 100;
  }

  Future<void> createFileDb() async {
    _database = await Database.createFileDatabase();
    _databaseIsolate = DatabaseIsolate(database.isolateConnectPort);
    databaseType = 'БД в файле';
    setState(() {});
  }

  Future<void> createMemoryDb() async {
    _database = await Database.createMemoryDatabase();
    _databaseIsolate = DatabaseIsolate(database.isolateConnectPort);
    databaseType = 'БД в памяти';
    setState(() {});
  }

  Never _throwNullableDatabase() => throw Exception('БД не проинициализированна');
}
