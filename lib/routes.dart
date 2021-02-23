import 'package:cryptokeep/screens/home_page.dart';
import 'package:cryptokeep/screens/login_details.dart';
import 'package:cryptokeep/screens/splash.dart';

final appRoutes = {
  "/splash": (context) => SplashScreen(),
  "/home": (context) => HomePage(),
  "/login_details": (context) => LoginDetails()
};
