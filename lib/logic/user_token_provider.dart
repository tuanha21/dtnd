import 'package:dtnd/=models=/response/user_token.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserTokenNotifier extends StateNotifier<UserToken?> {
  UserTokenNotifier() : super(null);

  Future<void> login(String user, String password) async {
    return;
  }
}
