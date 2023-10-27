import '../pages/login_page.dart';
import '../pages/main_pages/page_navigation.dart';

var appRoutes = {
  "/": (context) => LoginPage(),
  "/login": (context) => LoginPage(),
  "/home": (context) => PageNavigation(),
};
