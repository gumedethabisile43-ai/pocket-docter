import 'package:flutter/material.dart';

// App pages
import 'home_page.dart';
import 'introduction/introduction_screen.dart';
import 'help_about.dart';
import 'offline/offline_screen.dart';
import 'safety/safety_page.dart';
import 'donate/donate_page.dart'; // <-- NEW

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
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

      // NEW: Donate page route
      case '/donate':
        return MaterialPageRoute(builder: (_) => const DonatePage());

      default:
        // Fallback to home if an unknown route is requested
        return MaterialPageRoute(builder: (_) => const HomePage());
    }
  }
}
 
