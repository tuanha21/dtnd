/// Application flavors for various environments
enum Environment {
  /// Local test flavor
  test,

  ///Production environment flavor
  production,
}

extension EnvironmentX on Environment {
  String get envFileName => '${name}_domain_config.env';
}

/// Class responsible for flavor configuration
class E {
  static Environment fromString(String? string) {
    switch (string) {
      case "TEST":
        return Environment.test;
      default:
        return Environment.production;
    }
  }
}
