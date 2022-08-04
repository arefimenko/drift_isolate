import 'package:drift_isolate/database/database.dart';
import 'package:faker/faker.dart';

/// Фейковые данные по ценам.
class PricesDataFaker {
  static Iterable<DbPrice> generate([int count = 100]) sync* {
    final fk = Faker();
    assert(count > 0);
    for (var i = 0; i < count; i++) {
      yield DbPrice(
        id: fk.randomGenerator.string(12),
        brand: fk.company.name(),
        barcode: fk.randomGenerator.string(13),
        newPrice: fk.randomGenerator.integer(999999),
        oldPrice: fk.randomGenerator.integer(999999),
        article: fk.randomGenerator.string(50),
      );
    }
  }
}
