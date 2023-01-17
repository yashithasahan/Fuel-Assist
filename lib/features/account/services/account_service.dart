import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:speed_shop/constant/utils.dart';
import 'package:speed_shop/features/auth/screens/auth_screen.dart';
import 'package:speed_shop/features/owner/screens/owner_screen.dart';

import '../../../common/widgets/user_navigation.dart';

class AccountServices {
  void logOut(BuildContext context) async {
    try {
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      await sharedPreferences.setString('x-auth-token', '');
      Navigator.pushNamedAndRemoveUntil(
          context, AuthScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }


  void chngedash(BuildContext context) async {
    try {
      Navigator.pushNamedAndRemoveUntil(
          context, OwnerScreen.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  void chngedashback(BuildContext context) async {
    try {
      Navigator.pushNamedAndRemoveUntil(
          context, UserNavigation.routeName, (route) => false);
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}


  

