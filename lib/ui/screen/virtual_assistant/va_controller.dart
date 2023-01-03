class VAController {
  VAController._internal();

  static final VAController _instance = VAController._internal();

  factory VAController() => _instance;

  static get instance => _instance;

  bool get registered => true;
}
