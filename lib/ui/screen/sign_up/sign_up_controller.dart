class SignUpController {
  static final SignUpController _instance = SignUpController._intern();
  static SignUpController get instance => _instance;
  SignUpController._intern();

  factory SignUpController() {
    return _instance;
  }
}
