// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class DbShop extends DataClass implements Insertable<DbShop> {
  final String id;
  final int numId;
  final String name;
  final bool active;
  final String brandId;
  final String brandName;
  final int mallId;
  final String mallName;
  final String? mallAddress;
  final int cityId;
  final String cityName;
  final String? cityRegion;
  DbShop(
      {required this.id,
      required this.numId,
      required this.name,
      required this.active,
      required this.brandId,
      required this.brandName,
      required this.mallId,
      required this.mallName,
      this.mallAddress,
      required this.cityId,
      required this.cityName,
      this.cityRegion});
  factory DbShop.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DbShop(
      id: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      numId: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}numId'])!,
      name: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}name'])!,
      active: const BoolType().mapFromDatabaseResponse(data['${effectivePrefix}active'])!,
      brandId: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}brandId'])!,
      brandName: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}brandName'])!,
      mallId: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}mallId'])!,
      mallName: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}mallName'])!,
      mallAddress:
          const StringType().mapFromDatabaseResponse(data['${effectivePrefix}mallAddress']),
      cityId: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}cityId'])!,
      cityName: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}cityName'])!,
      cityRegion: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}cityRegion']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['numId'] = Variable<int>(numId);
    map['name'] = Variable<String>(name);
    map['active'] = Variable<bool>(active);
    map['brandId'] = Variable<String>(brandId);
    map['brandName'] = Variable<String>(brandName);
    map['mallId'] = Variable<int>(mallId);
    map['mallName'] = Variable<String>(mallName);
    if (!nullToAbsent || mallAddress != null) {
      map['mallAddress'] = Variable<String?>(mallAddress);
    }
    map['cityId'] = Variable<int>(cityId);
    map['cityName'] = Variable<String>(cityName);
    if (!nullToAbsent || cityRegion != null) {
      map['cityRegion'] = Variable<String?>(cityRegion);
    }
    return map;
  }

  ShopsCompanion toCompanion(bool nullToAbsent) {
    return ShopsCompanion(
      id: Value(id),
      numId: Value(numId),
      name: Value(name),
      active: Value(active),
      brandId: Value(brandId),
      brandName: Value(brandName),
      mallId: Value(mallId),
      mallName: Value(mallName),
      mallAddress: mallAddress == null && nullToAbsent ? const Value.absent() : Value(mallAddress),
      cityId: Value(cityId),
      cityName: Value(cityName),
      cityRegion: cityRegion == null && nullToAbsent ? const Value.absent() : Value(cityRegion),
    );
  }

  factory DbShop.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbShop(
      id: serializer.fromJson<String>(json['id']),
      numId: serializer.fromJson<int>(json['numId']),
      name: serializer.fromJson<String>(json['name']),
      active: serializer.fromJson<bool>(json['active']),
      brandId: serializer.fromJson<String>(json['brandId']),
      brandName: serializer.fromJson<String>(json['brandName']),
      mallId: serializer.fromJson<int>(json['mallId']),
      mallName: serializer.fromJson<String>(json['mallName']),
      mallAddress: serializer.fromJson<String?>(json['mallAddress']),
      cityId: serializer.fromJson<int>(json['cityId']),
      cityName: serializer.fromJson<String>(json['cityName']),
      cityRegion: serializer.fromJson<String?>(json['cityRegion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'numId': serializer.toJson<int>(numId),
      'name': serializer.toJson<String>(name),
      'active': serializer.toJson<bool>(active),
      'brandId': serializer.toJson<String>(brandId),
      'brandName': serializer.toJson<String>(brandName),
      'mallId': serializer.toJson<int>(mallId),
      'mallName': serializer.toJson<String>(mallName),
      'mallAddress': serializer.toJson<String?>(mallAddress),
      'cityId': serializer.toJson<int>(cityId),
      'cityName': serializer.toJson<String>(cityName),
      'cityRegion': serializer.toJson<String?>(cityRegion),
    };
  }

  DbShop copyWith(
          {String? id,
          int? numId,
          String? name,
          bool? active,
          String? brandId,
          String? brandName,
          int? mallId,
          String? mallName,
          String? mallAddress,
          int? cityId,
          String? cityName,
          String? cityRegion}) =>
      DbShop(
        id: id ?? this.id,
        numId: numId ?? this.numId,
        name: name ?? this.name,
        active: active ?? this.active,
        brandId: brandId ?? this.brandId,
        brandName: brandName ?? this.brandName,
        mallId: mallId ?? this.mallId,
        mallName: mallName ?? this.mallName,
        mallAddress: mallAddress ?? this.mallAddress,
        cityId: cityId ?? this.cityId,
        cityName: cityName ?? this.cityName,
        cityRegion: cityRegion ?? this.cityRegion,
      );
  @override
  String toString() {
    return (StringBuffer('DbShop(')
          ..write('id: $id, ')
          ..write('numId: $numId, ')
          ..write('name: $name, ')
          ..write('active: $active, ')
          ..write('brandId: $brandId, ')
          ..write('brandName: $brandName, ')
          ..write('mallId: $mallId, ')
          ..write('mallName: $mallName, ')
          ..write('mallAddress: $mallAddress, ')
          ..write('cityId: $cityId, ')
          ..write('cityName: $cityName, ')
          ..write('cityRegion: $cityRegion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, numId, name, active, brandId, brandName, mallId, mallName,
      mallAddress, cityId, cityName, cityRegion);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbShop &&
          other.id == this.id &&
          other.numId == this.numId &&
          other.name == this.name &&
          other.active == this.active &&
          other.brandId == this.brandId &&
          other.brandName == this.brandName &&
          other.mallId == this.mallId &&
          other.mallName == this.mallName &&
          other.mallAddress == this.mallAddress &&
          other.cityId == this.cityId &&
          other.cityName == this.cityName &&
          other.cityRegion == this.cityRegion);
}

class ShopsCompanion extends UpdateCompanion<DbShop> {
  final Value<String> id;
  final Value<int> numId;
  final Value<String> name;
  final Value<bool> active;
  final Value<String> brandId;
  final Value<String> brandName;
  final Value<int> mallId;
  final Value<String> mallName;
  final Value<String?> mallAddress;
  final Value<int> cityId;
  final Value<String> cityName;
  final Value<String?> cityRegion;
  const ShopsCompanion({
    this.id = const Value.absent(),
    this.numId = const Value.absent(),
    this.name = const Value.absent(),
    this.active = const Value.absent(),
    this.brandId = const Value.absent(),
    this.brandName = const Value.absent(),
    this.mallId = const Value.absent(),
    this.mallName = const Value.absent(),
    this.mallAddress = const Value.absent(),
    this.cityId = const Value.absent(),
    this.cityName = const Value.absent(),
    this.cityRegion = const Value.absent(),
  });
  ShopsCompanion.insert({
    required String id,
    required int numId,
    required String name,
    required bool active,
    required String brandId,
    required String brandName,
    required int mallId,
    required String mallName,
    this.mallAddress = const Value.absent(),
    required int cityId,
    required String cityName,
    this.cityRegion = const Value.absent(),
  })  : id = Value(id),
        numId = Value(numId),
        name = Value(name),
        active = Value(active),
        brandId = Value(brandId),
        brandName = Value(brandName),
        mallId = Value(mallId),
        mallName = Value(mallName),
        cityId = Value(cityId),
        cityName = Value(cityName);
  static Insertable<DbShop> custom({
    Expression<String>? id,
    Expression<int>? numId,
    Expression<String>? name,
    Expression<bool>? active,
    Expression<String>? brandId,
    Expression<String>? brandName,
    Expression<int>? mallId,
    Expression<String>? mallName,
    Expression<String?>? mallAddress,
    Expression<int>? cityId,
    Expression<String>? cityName,
    Expression<String?>? cityRegion,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (numId != null) 'numId': numId,
      if (name != null) 'name': name,
      if (active != null) 'active': active,
      if (brandId != null) 'brandId': brandId,
      if (brandName != null) 'brandName': brandName,
      if (mallId != null) 'mallId': mallId,
      if (mallName != null) 'mallName': mallName,
      if (mallAddress != null) 'mallAddress': mallAddress,
      if (cityId != null) 'cityId': cityId,
      if (cityName != null) 'cityName': cityName,
      if (cityRegion != null) 'cityRegion': cityRegion,
    });
  }

  ShopsCompanion copyWith(
      {Value<String>? id,
      Value<int>? numId,
      Value<String>? name,
      Value<bool>? active,
      Value<String>? brandId,
      Value<String>? brandName,
      Value<int>? mallId,
      Value<String>? mallName,
      Value<String?>? mallAddress,
      Value<int>? cityId,
      Value<String>? cityName,
      Value<String?>? cityRegion}) {
    return ShopsCompanion(
      id: id ?? this.id,
      numId: numId ?? this.numId,
      name: name ?? this.name,
      active: active ?? this.active,
      brandId: brandId ?? this.brandId,
      brandName: brandName ?? this.brandName,
      mallId: mallId ?? this.mallId,
      mallName: mallName ?? this.mallName,
      mallAddress: mallAddress ?? this.mallAddress,
      cityId: cityId ?? this.cityId,
      cityName: cityName ?? this.cityName,
      cityRegion: cityRegion ?? this.cityRegion,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (numId.present) {
      map['numId'] = Variable<int>(numId.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (active.present) {
      map['active'] = Variable<bool>(active.value);
    }
    if (brandId.present) {
      map['brandId'] = Variable<String>(brandId.value);
    }
    if (brandName.present) {
      map['brandName'] = Variable<String>(brandName.value);
    }
    if (mallId.present) {
      map['mallId'] = Variable<int>(mallId.value);
    }
    if (mallName.present) {
      map['mallName'] = Variable<String>(mallName.value);
    }
    if (mallAddress.present) {
      map['mallAddress'] = Variable<String?>(mallAddress.value);
    }
    if (cityId.present) {
      map['cityId'] = Variable<int>(cityId.value);
    }
    if (cityName.present) {
      map['cityName'] = Variable<String>(cityName.value);
    }
    if (cityRegion.present) {
      map['cityRegion'] = Variable<String?>(cityRegion.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ShopsCompanion(')
          ..write('id: $id, ')
          ..write('numId: $numId, ')
          ..write('name: $name, ')
          ..write('active: $active, ')
          ..write('brandId: $brandId, ')
          ..write('brandName: $brandName, ')
          ..write('mallId: $mallId, ')
          ..write('mallName: $mallName, ')
          ..write('mallAddress: $mallAddress, ')
          ..write('cityId: $cityId, ')
          ..write('cityName: $cityName, ')
          ..write('cityRegion: $cityRegion')
          ..write(')'))
        .toString();
  }
}

class Shops extends Table with TableInfo<Shops, DbShop> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Shops(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>('id', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  final VerificationMeta _numIdMeta = const VerificationMeta('numId');
  late final GeneratedColumn<int?> numId = GeneratedColumn<int?>('numId', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _nameMeta = const VerificationMeta('name');
  late final GeneratedColumn<String?> name = GeneratedColumn<String?>('name', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _activeMeta = const VerificationMeta('active');
  late final GeneratedColumn<bool?> active = GeneratedColumn<bool?>('active', aliasedName, false,
      type: const BoolType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _brandIdMeta = const VerificationMeta('brandId');
  late final GeneratedColumn<String?> brandId = GeneratedColumn<String?>(
      'brandId', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _brandNameMeta = const VerificationMeta('brandName');
  late final GeneratedColumn<String?> brandName = GeneratedColumn<String?>(
      'brandName', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _mallIdMeta = const VerificationMeta('mallId');
  late final GeneratedColumn<int?> mallId = GeneratedColumn<int?>('mallId', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _mallNameMeta = const VerificationMeta('mallName');
  late final GeneratedColumn<String?> mallName = GeneratedColumn<String?>(
      'mallName', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _mallAddressMeta = const VerificationMeta('mallAddress');
  late final GeneratedColumn<String?> mallAddress = GeneratedColumn<String?>(
      'mallAddress', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _cityIdMeta = const VerificationMeta('cityId');
  late final GeneratedColumn<int?> cityId = GeneratedColumn<int?>('cityId', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _cityNameMeta = const VerificationMeta('cityName');
  late final GeneratedColumn<String?> cityName = GeneratedColumn<String?>(
      'cityName', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _cityRegionMeta = const VerificationMeta('cityRegion');
  late final GeneratedColumn<String?> cityRegion = GeneratedColumn<String?>(
      'cityRegion', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false, $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        id,
        numId,
        name,
        active,
        brandId,
        brandName,
        mallId,
        mallName,
        mallAddress,
        cityId,
        cityName,
        cityRegion
      ];
  @override
  String get aliasedName => _alias ?? 'shops';
  @override
  String get actualTableName => 'shops';
  @override
  VerificationContext validateIntegrity(Insertable<DbShop> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('numId')) {
      context.handle(_numIdMeta, numId.isAcceptableOrUnknown(data['numId']!, _numIdMeta));
    } else if (isInserting) {
      context.missing(_numIdMeta);
    }
    if (data.containsKey('name')) {
      context.handle(_nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('active')) {
      context.handle(_activeMeta, active.isAcceptableOrUnknown(data['active']!, _activeMeta));
    } else if (isInserting) {
      context.missing(_activeMeta);
    }
    if (data.containsKey('brandId')) {
      context.handle(_brandIdMeta, brandId.isAcceptableOrUnknown(data['brandId']!, _brandIdMeta));
    } else if (isInserting) {
      context.missing(_brandIdMeta);
    }
    if (data.containsKey('brandName')) {
      context.handle(
          _brandNameMeta, brandName.isAcceptableOrUnknown(data['brandName']!, _brandNameMeta));
    } else if (isInserting) {
      context.missing(_brandNameMeta);
    }
    if (data.containsKey('mallId')) {
      context.handle(_mallIdMeta, mallId.isAcceptableOrUnknown(data['mallId']!, _mallIdMeta));
    } else if (isInserting) {
      context.missing(_mallIdMeta);
    }
    if (data.containsKey('mallName')) {
      context.handle(
          _mallNameMeta, mallName.isAcceptableOrUnknown(data['mallName']!, _mallNameMeta));
    } else if (isInserting) {
      context.missing(_mallNameMeta);
    }
    if (data.containsKey('mallAddress')) {
      context.handle(_mallAddressMeta,
          mallAddress.isAcceptableOrUnknown(data['mallAddress']!, _mallAddressMeta));
    }
    if (data.containsKey('cityId')) {
      context.handle(_cityIdMeta, cityId.isAcceptableOrUnknown(data['cityId']!, _cityIdMeta));
    } else if (isInserting) {
      context.missing(_cityIdMeta);
    }
    if (data.containsKey('cityName')) {
      context.handle(
          _cityNameMeta, cityName.isAcceptableOrUnknown(data['cityName']!, _cityNameMeta));
    } else if (isInserting) {
      context.missing(_cityNameMeta);
    }
    if (data.containsKey('cityRegion')) {
      context.handle(
          _cityRegionMeta, cityRegion.isAcceptableOrUnknown(data['cityRegion']!, _cityRegionMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  DbShop map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DbShop.fromData(data, prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Shops createAlias(String alias) {
    return Shops(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class DbPrice extends DataClass implements Insertable<DbPrice> {
  final String? id;
  final String? brand;
  final String barcode;
  final int newPrice;
  final int? oldPrice;
  final String article;
  DbPrice(
      {this.id,
      this.brand,
      required this.barcode,
      required this.newPrice,
      this.oldPrice,
      required this.article});
  factory DbPrice.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return DbPrice(
      id: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      brand: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}brand']),
      barcode: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}barcode'])!,
      newPrice: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}newPrice'])!,
      oldPrice: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}oldPrice']),
      article: const StringType().mapFromDatabaseResponse(data['${effectivePrefix}article'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<String?>(id);
    }
    if (!nullToAbsent || brand != null) {
      map['brand'] = Variable<String?>(brand);
    }
    map['barcode'] = Variable<String>(barcode);
    map['newPrice'] = Variable<int>(newPrice);
    if (!nullToAbsent || oldPrice != null) {
      map['oldPrice'] = Variable<int?>(oldPrice);
    }
    map['article'] = Variable<String>(article);
    return map;
  }

  PricesCompanion toCompanion(bool nullToAbsent) {
    return PricesCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      brand: brand == null && nullToAbsent ? const Value.absent() : Value(brand),
      barcode: Value(barcode),
      newPrice: Value(newPrice),
      oldPrice: oldPrice == null && nullToAbsent ? const Value.absent() : Value(oldPrice),
      article: Value(article),
    );
  }

  factory DbPrice.fromJson(Map<String, dynamic> json, {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DbPrice(
      id: serializer.fromJson<String?>(json['id']),
      brand: serializer.fromJson<String?>(json['brand']),
      barcode: serializer.fromJson<String>(json['barcode']),
      newPrice: serializer.fromJson<int>(json['newPrice']),
      oldPrice: serializer.fromJson<int?>(json['oldPrice']),
      article: serializer.fromJson<String>(json['article']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String?>(id),
      'brand': serializer.toJson<String?>(brand),
      'barcode': serializer.toJson<String>(barcode),
      'newPrice': serializer.toJson<int>(newPrice),
      'oldPrice': serializer.toJson<int?>(oldPrice),
      'article': serializer.toJson<String>(article),
    };
  }

  DbPrice copyWith(
          {String? id,
          String? brand,
          String? barcode,
          int? newPrice,
          int? oldPrice,
          String? article}) =>
      DbPrice(
        id: id ?? this.id,
        brand: brand ?? this.brand,
        barcode: barcode ?? this.barcode,
        newPrice: newPrice ?? this.newPrice,
        oldPrice: oldPrice ?? this.oldPrice,
        article: article ?? this.article,
      );
  @override
  String toString() {
    return (StringBuffer('DbPrice(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('newPrice: $newPrice, ')
          ..write('oldPrice: $oldPrice, ')
          ..write('article: $article')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, brand, barcode, newPrice, oldPrice, article);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DbPrice &&
          other.id == this.id &&
          other.brand == this.brand &&
          other.barcode == this.barcode &&
          other.newPrice == this.newPrice &&
          other.oldPrice == this.oldPrice &&
          other.article == this.article);
}

class PricesCompanion extends UpdateCompanion<DbPrice> {
  final Value<String?> id;
  final Value<String?> brand;
  final Value<String> barcode;
  final Value<int> newPrice;
  final Value<int?> oldPrice;
  final Value<String> article;
  const PricesCompanion({
    this.id = const Value.absent(),
    this.brand = const Value.absent(),
    this.barcode = const Value.absent(),
    this.newPrice = const Value.absent(),
    this.oldPrice = const Value.absent(),
    this.article = const Value.absent(),
  });
  PricesCompanion.insert({
    this.id = const Value.absent(),
    this.brand = const Value.absent(),
    required String barcode,
    required int newPrice,
    this.oldPrice = const Value.absent(),
    required String article,
  })  : barcode = Value(barcode),
        newPrice = Value(newPrice),
        article = Value(article);
  static Insertable<DbPrice> custom({
    Expression<String?>? id,
    Expression<String?>? brand,
    Expression<String>? barcode,
    Expression<int>? newPrice,
    Expression<int?>? oldPrice,
    Expression<String>? article,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (brand != null) 'brand': brand,
      if (barcode != null) 'barcode': barcode,
      if (newPrice != null) 'newPrice': newPrice,
      if (oldPrice != null) 'oldPrice': oldPrice,
      if (article != null) 'article': article,
    });
  }

  PricesCompanion copyWith(
      {Value<String?>? id,
      Value<String?>? brand,
      Value<String>? barcode,
      Value<int>? newPrice,
      Value<int?>? oldPrice,
      Value<String>? article}) {
    return PricesCompanion(
      id: id ?? this.id,
      brand: brand ?? this.brand,
      barcode: barcode ?? this.barcode,
      newPrice: newPrice ?? this.newPrice,
      oldPrice: oldPrice ?? this.oldPrice,
      article: article ?? this.article,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String?>(id.value);
    }
    if (brand.present) {
      map['brand'] = Variable<String?>(brand.value);
    }
    if (barcode.present) {
      map['barcode'] = Variable<String>(barcode.value);
    }
    if (newPrice.present) {
      map['newPrice'] = Variable<int>(newPrice.value);
    }
    if (oldPrice.present) {
      map['oldPrice'] = Variable<int?>(oldPrice.value);
    }
    if (article.present) {
      map['article'] = Variable<String>(article.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PricesCompanion(')
          ..write('id: $id, ')
          ..write('brand: $brand, ')
          ..write('barcode: $barcode, ')
          ..write('newPrice: $newPrice, ')
          ..write('oldPrice: $oldPrice, ')
          ..write('article: $article')
          ..write(')'))
        .toString();
  }
}

class Prices extends Table with TableInfo<Prices, DbPrice> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  Prices(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<String?> id = GeneratedColumn<String?>('id', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _brandMeta = const VerificationMeta('brand');
  late final GeneratedColumn<String?> brand = GeneratedColumn<String?>('brand', aliasedName, true,
      type: const StringType(), requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _barcodeMeta = const VerificationMeta('barcode');
  late final GeneratedColumn<String?> barcode = GeneratedColumn<String?>(
      'barcode', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _newPriceMeta = const VerificationMeta('newPrice');
  late final GeneratedColumn<int?> newPrice = GeneratedColumn<int?>('newPrice', aliasedName, false,
      type: const IntType(), requiredDuringInsert: true, $customConstraints: 'NOT NULL');
  final VerificationMeta _oldPriceMeta = const VerificationMeta('oldPrice');
  late final GeneratedColumn<int?> oldPrice = GeneratedColumn<int?>('oldPrice', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _articleMeta = const VerificationMeta('article');
  late final GeneratedColumn<String?> article = GeneratedColumn<String?>(
      'article', aliasedName, false,
      type: const StringType(),
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL PRIMARY KEY');
  @override
  List<GeneratedColumn> get $columns => [id, brand, barcode, newPrice, oldPrice, article];
  @override
  String get aliasedName => _alias ?? 'prices';
  @override
  String get actualTableName => 'prices';
  @override
  VerificationContext validateIntegrity(Insertable<DbPrice> instance, {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('brand')) {
      context.handle(_brandMeta, brand.isAcceptableOrUnknown(data['brand']!, _brandMeta));
    }
    if (data.containsKey('barcode')) {
      context.handle(_barcodeMeta, barcode.isAcceptableOrUnknown(data['barcode']!, _barcodeMeta));
    } else if (isInserting) {
      context.missing(_barcodeMeta);
    }
    if (data.containsKey('newPrice')) {
      context.handle(
          _newPriceMeta, newPrice.isAcceptableOrUnknown(data['newPrice']!, _newPriceMeta));
    } else if (isInserting) {
      context.missing(_newPriceMeta);
    }
    if (data.containsKey('oldPrice')) {
      context.handle(
          _oldPriceMeta, oldPrice.isAcceptableOrUnknown(data['oldPrice']!, _oldPriceMeta));
    }
    if (data.containsKey('article')) {
      context.handle(_articleMeta, article.isAcceptableOrUnknown(data['article']!, _articleMeta));
    } else if (isInserting) {
      context.missing(_articleMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {article};
  @override
  DbPrice map(Map<String, dynamic> data, {String? tablePrefix}) {
    return DbPrice.fromData(data, prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Prices createAlias(String alias) {
    return Prices(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$_AppDriftDatabase extends GeneratedDatabase {
  _$_AppDriftDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$_AppDriftDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final Shops shops = Shops(this);
  late final Prices prices = Prices(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [shops, prices];
}
