import 'package:flutter/material.dart';

import 'package:my_app/services/startup.dart';
import 'package:my_app/services_locator.dart';
import 'package:my_app/shared/loading.dart';

/// SplashView
/// - the first (blank) screen that is opened when the app starts up
/// - if user is logged in and user's record exists on database,
///   - show ComingSoonScreen or TermsScreen
/// - else show SignInScreen
class SplashView extends StatefulWidget {
  @override
  _SplashViewState createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    servicesLocator<StartupService>().handleStartUpLogicFake();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Loading();
  }
}
