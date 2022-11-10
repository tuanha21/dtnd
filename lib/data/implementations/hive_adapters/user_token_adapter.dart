import 'package:dtnd/=models=/response/user_token.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

class UserTokenAdapter extends TypeAdapter<UserToken> with EquatableMixin {
  @override
  final typeId = 0;
  @override
  UserToken read(BinaryReader reader) {
    throw UnimplementedError();
  }

  @override
  void write(BinaryWriter writer, UserToken obj) {
    // TODO: implement write
  }
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
