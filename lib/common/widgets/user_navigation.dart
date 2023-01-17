import 'package:flutter/material.dart';
import 'package:speed_shop/constant/global_var.dart';
import 'package:speed_shop/features/home/screens/home_screen.dart';
import 'package:speed_shop/features/map/screen/map_screen.dart';

import '../../features/account/screens/account_screen.dart';

class UserNavigation extends StatefulWidget {
  static const String routeName = '/my-home';
  const UserNavigation({super.key});

  @override
  State<UserNavigation> createState() => _UserNavigationState();
}

class _UserNavigationState extends State<UserNavigation> {
  int _page = 1;
  double bottomBarWidth = 40;
  double bottomBarBorderWidth = 2;

  List<Widget> pages = [
    const MapScreen(),
    const HomeScreen(),
    const AccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: Colors.orange,
        unselectedItemColor: GlobalVar.unselectedNavBarColor,
        backgroundColor: GlobalVar.backgroundColor,
        iconSize: 28,
        onTap: updatePage,
        items: [
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: _page == 0
                          ? Colors.orange
                          : GlobalVar.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const Icon(
                Icons.map_outlined,
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: _page == 1
                          ? Colors.orange
                          : GlobalVar.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
             
                child: const Icon(
                  Icons.home_outlined,
                ),
              
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Container(
              width: bottomBarWidth,
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                      color: _page == 2
                          ? Colors.orange
                          : GlobalVar.backgroundColor,
                      width: bottomBarBorderWidth),
                ),
              ),
              child: const Icon(
                Icons.person_outline,
              ),
            ),
            label: '',
          )
        ],
      ),
    );
  }
}
