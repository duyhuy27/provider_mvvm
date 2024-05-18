// ignore_for_file: constant_identifier_names

enum Environment {
  PRODUCTION('production'),
  TEST('staging'),
  DEV('development');

  final String envEnum;
  const Environment(this.envEnum);
}

class AppUrl {
  static Environment get currentEnvironment => Environment.TEST;

  static String get baseUrl {
    switch (currentEnvironment) {
      case Environment.PRODUCTION:
        return 'https://reqres.in/';
      case Environment.TEST:
        return 'https://reqres.in/';
      case Environment.DEV:
        return 'https://reqres.in/';
      default:
        return 'https://reqres.in/';
    }
  }

  static String _urlHandle(String url) =>
      (url.contains('http') ? '' : baseUrl) + url;

  static String loginApiEndpoint = _urlHandle("api/login");
  static String registerApiEndpoint = _urlHandle("api/register");
  static String getUserApiEndpoint(int id) => _urlHandle("api/users/$id");
}

class ContentType {
  static const Application_Json = 'application/json';
  static const URL_Encoded = 'application/x-www-form-urlencoded';
  static const Multipart = 'multipart/form-data';
}
