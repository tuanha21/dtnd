/// Application flavors for various environments
enum Flavor {
  /// Local test flavor
  test,

  ///Production environment flavor
  production,
}

/// Class responsible for flavor configuration
class F {
  /// Describes the flavor that the app is currently using
  static Flavor? appFlavor;

  /// Adds flavor to the name of the app
  // static String get title => 'Example ${appFlavor?.name}';

  /// Defines the environment variables filename for each flavor
  static String get envFileName => '${appFlavor?.name}_domain_config.env';
}
