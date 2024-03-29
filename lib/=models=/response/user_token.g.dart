// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_token.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTokenAdapter extends TypeAdapter<UserToken> {
  @override
  final int typeId = 0;

  @override
  UserToken read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserToken(
      user: fields[0] as String,
      name: fields[1] as String,
      sid: fields[2] as String,
      address: fields[3] as String,
      defaultAcc: fields[4] as String,
      iFlag: fields[5] as num,
      countLoginFail: fields[6] as num,
      authenType: fields[7] as String,
      iP: fields[8] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserToken obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.sid)
      ..writeByte(3)
      ..write(obj.address)
      ..writeByte(4)
      ..write(obj.defaultAcc)
      ..writeByte(5)
      ..write(obj.iFlag)
      ..writeByte(6)
      ..write(obj.countLoginFail)
      ..writeByte(7)
      ..write(obj.authenType)
      ..writeByte(8)
      ..write(obj.iP);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTokenAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
