import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_shop/features/search/screens/search_screen.dart';
import 'package:speed_shop/providers/user_provider.dart';
import '../../../constant/global_var.dart';
import '../widgets/stop_watch.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void navigateToSearchScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        title: Column(
          children: [
            Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                gradient: GlobalVar.appBarGradient,
              ),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  const Center(
                    child: Text(
                      "Fuel Assist",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 15, right: 15),
                    child: Material(
                      borderRadius: BorderRadius.circular(9),
                      elevation: 12,
                      child: TextFormField(
                        onFieldSubmitted: navigateToSearchScreen,
                        decoration: InputDecoration(
                          hintText: "Staion name, City, Province ...",
                          hintStyle: const TextStyle(fontSize: 14),
                          prefixIcon: InkWell(
                            onTap: () {},
                            child: const Padding(
                              padding: EdgeInsets.only(
                                left: 6,
                              ),
                              child: Icon(
                                Icons.search,
                                color: Colors.orange,
                                size: 20,
                              ),
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.only(top: 10),
                          border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(7),
                            ),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(gradient: GlobalVar.appBarGradient),
        ),
      ),
      body: Center(
          child: Container(
        width: 350,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(width: 20.0, height: 100.0),
            DefaultTextStyle(
              style: const TextStyle(
                  fontSize: 40.0,
                  fontFamily: 'Horizon',
                  fontWeight: FontWeight.bold,
                  color: Colors.orange),
              child: AnimatedTextKit(
                isRepeatingAnimation: true,
                totalRepeatCount: 100,
                animatedTexts: [
                  RotateAnimatedText('Fuel on demand'),
                  RotateAnimatedText('Fueling smart'),
                  RotateAnimatedText('No more waiting'),
                  RotateAnimatedText('Fuel on the go'),
                  RotateAnimatedText('Fueling the future'),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}
