class ConfigurationService {
  /// apiRootUrl
  String get apiRootUrl {
    return 'https://wishapp-api.herokuapp.com';
    // return 'http://localhost:3000';
  }

  /// apiVersion
  int get apiVersion => 1;
  String get authorizationHeaderName {
    return 'LINEAuthorization';
  }
}
