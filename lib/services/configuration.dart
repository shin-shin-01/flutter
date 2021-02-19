class ConfigurationService {
  /// apiRootUrl
  String get apiRootUrl {
    return 'https://wishapp-api.herokuapp.com';
  }

  /// apiVersion
  int get apiVersion => 1;
  String get authorizationHeaderName {
    return 'LINEAuthorization';
  }
}
