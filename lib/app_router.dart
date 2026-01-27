
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'introduction/introduction_screen.dart';
import 'help_about.dart';
import 'offline/offline_screen.dart';
import 'safety/safety_page.dart';

class AppRouter {
  static Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/intro':
        return MaterialPageRoute(builder: (_) => const IntroductionScreen());
      case '/help':
        return MaterialPageRoute(builder: (_) => const HelpAboutPage());
      case '/offline':
        return MaterialPageRoute(builder: (_) => const OfflineScreen());
      case '/safety':
        return MaterialPageRoute(builder: (_) => const SafetyPage());
      default:
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
 
