import 'package:cryptokeep/screens/create_update_login.dart';
import 'package:cryptokeep/screens/get_started.dart';
import 'package:cryptokeep/screens/home_page.dart';
import 'package:cryptokeep/screens/login_details.dart';
import 'package:cryptokeep/screens/seetings_screen.dart';
import 'package:cryptokeep/screens/splash.dart';

final appRoutes = {
  "/splash": (context) => SplashScreen(),
  "/home": (context) => HomePage(),
  "/login_details": (context) => LoginDetails(),
  "/create": (context) => CreateUpdatePage(),
  "/update": (context) => CreateUpdatePage(),
  "/get_started": (context) => GetStarted(),
  "/settings": (context) => Settings()
};
