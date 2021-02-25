import 'package:get_it/get_it.dart';

import 'package:my_app/services/api.dart';
import 'package:my_app/services/authentication.dart';
import 'package:my_app/services/startup.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/services/configuration.dart';
import 'package:my_app/services/data.dart';

/// servicesLocator
GetIt servicesLocator = GetIt.instance;

/// setupServiceLocator
/// - register instance (single) of every services
/// that are going to be used in the app
void setupServiceLocator() {
  servicesLocator.registerSingleton(ConfigurationService());
  servicesLocator.registerSingleton(DataService());
  // LazySingleton refers to a class whose resource will not be initialised
  // until its used for the 1st time.
  // It's generally used to save resources and memory
  servicesLocator.registerLazySingleton(() => AuthService());
  servicesLocator.registerLazySingleton(() => APIService());
  servicesLocator.registerLazySingleton(() => NavigationService());
  servicesLocator.registerLazySingleton(() => StartupService());
}
