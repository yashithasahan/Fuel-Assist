import 'package:flutter/material.dart';
import 'package:speed_shop/features/auth/screens/auth_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomeScreen(),
    );
  }
}

class WelcomeScreen extends StatefulWidget {
   static const String routeName = '/welcome';
  const WelcomeScreen({super.key});

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          const WelcomePage(
            title:
                '"Welcome to Fuel Assist - the ultimate fuel management app. With our app, you can track the fuel station queues, fuel arrival time and fuel availability at the station. Stay informed and plan your fuel stops accordingly, saving you time and money"',
            imageUrl: 'assets/images/welcome_1.png',
            
          ),
          const WelcomePage(
            title:
                '" Discover new features, Fuel Station Queue and Availability: Keep track of the fuel station queues, fuel arrival time and fuel availability, allowing you to plan your fuel stops and save time "',
            imageUrl: 'assets/images/welcome_2.png',
            
          ),
          WelcomePage(
            title: '',
            imageUrl: 'assets/images/welcome_3.png',
            onNext: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                AuthScreen.routeName,
                (route) => false,
              );
            },
          ),
        ],
      ),
    );
  }
}

class WelcomePage extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback? onNext;

  const WelcomePage({
    Key? key,
    required this.title,
    required this.imageUrl,
    this.onNext,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 100, bottom: 150, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Color.fromARGB(255, 74, 74, 74),
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 16),
            Image.asset(imageUrl),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: onNext,
              child: const Text('Let`s Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
