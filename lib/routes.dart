import 'package:cryptokeep/components/create_update_login.dart';
import 'package:cryptokeep/screens/get_started.dart';
import 'package:cryptokeep/screens/home_page.dart';
import 'package:cryptokeep/screens/login_details.dart';
import 'package:cryptokeep/screens/splash.dart';
import 'package:cryptokeep/utils/common.dart';

final appRoutes = {
  "/splash": (context) => SplashScreen(),
  "/home": (context) => HomePage(),
  "/login_details": (context) => LoginDetails(),
  "/create": (context) => CreateUpdateDialog(CreateUpdateType.create),
  "/update": (context) => CreateUpdateDialog(CreateUpdateType.update),
  "/get_started": (context) => GetStarted(),
};
