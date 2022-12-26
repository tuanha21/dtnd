// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'saved_catalog.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SavedCatalogAdapter extends TypeAdapter<SavedCatalog> {
  @override
  final int typeId = 3;

  @override
  SavedCatalog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SavedCatalog(
      fields[0] as String,
    );
  }

  @override
  void write(BinaryWriter writer, SavedCatalog obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._user)
      ..writeByte(1)
      ..write(obj.catalogs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SavedCatalogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
