import 'package:flutter/material.dart';
import 'package:speed_shop/features/auth/screens/auth_screen.dart';
import 'package:speed_shop/features/home/screens/home_screen.dart';
import 'package:speed_shop/features/owner/screens/add_station_screen.dart';
import 'package:speed_shop/features/search/screens/search_screen.dart';

import 'package:speed_shop/features/welcome/screens/welcome_screen.dart';
import 'package:speed_shop/models/station.dart';

import 'common/widgets/user_navigation.dart';
import 'features/owner/screens/dash_screen.dart';
import 'features/owner/screens/owner_screen.dart';
import 'features/station/screens/station_screen.dart';

Route<dynamic> genarateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AuthScreen(),
      );

    case HomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const HomeScreen(),
      );

    case WelcomeScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const WelcomeScreen(),
      );
    case UserNavigation.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const UserNavigation(),
      );
    case OwnerScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const OwnerScreen(),
      );
    case AddStationScreen.routeName:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const AddStationScreen(),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case StationScreen.routeName:
      var staion = routeSettings.arguments as Station;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => StationScreen(
          staion: staion,
        ),
      );
    case OwnerDashScreen.routeName:
      var staion = routeSettings.arguments as Station;
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => OwnerDashScreen(
          station: staion,
        ),
      );
    default:
      return MaterialPageRoute(
        settings: routeSettings,
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Page not found!'),
          ),
        ),
      );
  }
}
