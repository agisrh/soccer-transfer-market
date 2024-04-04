enum Environment { dev, staging, production }

class EnvironmentConfig {
  static Environment environment = Environment.dev;

  static String baseUrl({String version = 'v1'}) {
    switch (environment) {
      case Environment.production:
        return "https://www.fotmob.com/api/";
      case Environment.staging:
        return "https://www.fotmob.com/api/";
      default:
        return "https://www.fotmob.com/api/";
    }
  }
}
