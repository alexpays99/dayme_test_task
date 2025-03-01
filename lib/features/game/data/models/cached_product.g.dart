// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cached_product.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CachedProductAdapter extends TypeAdapter<CachedProduct> {
  @override
  final int typeId = 0;

  @override
  CachedProduct read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CachedProduct(
      productId: fields[0] as int,
      name: fields[1] as String,
      photoUrl: fields[2] as String,
      cachedAt: fields[3] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CachedProduct obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.productId)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.photoUrl)
      ..writeByte(3)
      ..write(obj.cachedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CachedProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
