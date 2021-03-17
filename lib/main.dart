import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_line_sdk/flutter_line_sdk.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart' as DotEnv;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:my_app/services_locator.dart';
import 'package:my_app/services/navigation.dart';
import 'package:my_app/shared/success_screen.dart';
import 'package:my_app/shared/error_screen.dart';
import 'package:my_app/ui/sign_in/sign_in_view.dart';
import 'package:my_app/ui/splash/splash_view.dart';
import 'package:my_app/ui/root/root_view.dart';

void main() async {
  await DotEnv.load(fileName: ".env");

  setupServiceLocator();
  // LINE LOGIN
  WidgetsFlutterBinding.ensureInitialized();
  LineSDK.instance.setup(env["LINE_CHANNEL_ID"]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final _navigation = servicesLocator<NavigationService>();

  @override
  Widget build(BuildContext context) {
    /// - #3f3f3f グレー
    /// - #dfefff 薄い青
    final appTheme = ThemeData();

    return MaterialApp(
      title: 'Wish',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      navigatorKey: _navigation.navigatorKey,
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (context) => SplashView(),
        '/sign_in': (context) => SignInView(),
        '/root': (context) => RootView(),
        '/success': (context) => SuccessScreen(),
        '/error': (context) => ErrorScreen()
        // '/settings': (context) => SettingsPage(),
      },
    );
  }
}
