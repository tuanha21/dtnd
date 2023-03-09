import 'package:dtnd/data/i_user_service.dart';
import 'package:dtnd/data/implementations/user_service.dart';

class VAController {
  VAController._internal();

  static final VAController _instance = VAController._internal();

  factory VAController() => _instance;

  static get instance => _instance;

  final IUserService userService = UserService();

  bool get registered => true;
}
