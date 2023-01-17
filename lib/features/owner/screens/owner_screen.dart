import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_shop/features/account/screens/account_screen.dart';
import 'package:speed_shop/features/owner/screens/gas_station_screen.dart';
import 'package:speed_shop/features/owner/screens/owner_account_screen.dart';
import 'package:speed_shop/providers/user_provider.dart';
import '../../../constant/global_var.dart';
import '../../home/screens/home_screen.dart';
import '../../map/screen/map_screen.dart';
import '../widgets/custom_date_picker.txt';

class OwnerScreen extends StatefulWidget {
  static const String routeName = '/owner';
  const OwnerScreen({super.key});

  @override
  State<OwnerScreen> createState() => _OwnerScreenState();
}

class _OwnerScreenState extends State<OwnerScreen> {
  int _page = 1;
  double bottomBarWidth = 40;
  double bottomBarBorderWidth = 2;

  List<Widget> pages = [
    const MapScreen(),
    const GasStationScreen(),
    const HomeScreen(),
    const OwnerAccountScreen(),
  ];

  void updatePage(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
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
                  Icons.local_gas_station,
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
                  Icons.search_outlined,
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
                        color: _page == 3
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
        ));
  }
}
