// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_catalog.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserCatalogAdapter extends TypeAdapter<UserCatalog> {
  @override
  final int typeId = 4;

  @override
  UserCatalog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserCatalog(
      fields[0] as String,
      (fields[1] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserCatalog obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._name)
      ..writeByte(1)
      ..write(obj._stocks);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserCatalogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
