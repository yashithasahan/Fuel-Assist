import 'package:flutter/material.dart';
import 'package:speed_shop/constant/global_var.dart';
import 'package:speed_shop/features/auth/screens/auth_screen.dart';
import 'package:speed_shop/features/auth/services/auth_service.dart';
import 'package:speed_shop/features/owner/screens/owner_screen.dart';
import 'package:speed_shop/features/welcome/screens/welcome_screen.dart';
import 'package:speed_shop/providers/station_provider.dart';
import 'package:speed_shop/providers/user_provider.dart';
import 'package:speed_shop/router.dart';
import 'package:provider/provider.dart';
import 'common/widgets/user_navigation.dart';
import 'features/owner/screens/gas_station_screen.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
    ChangeNotifierProvider(
      create: (context) => StationProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();
  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fuel Assit',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVar.backgroundColor,
        colorScheme: const ColorScheme.light(
          primary: GlobalVar.secondaryColor,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      onGenerateRoute: (settings) => genarateRoute(settings),
      home: Provider.of<UserProvider>(context).user.token.isNotEmpty
          ? Provider.of<UserProvider>(context).user.type == 'false'
              ? const UserNavigation()
              : const OwnerScreen()
          : const WelcomeScreen(),
    );
  }
}
