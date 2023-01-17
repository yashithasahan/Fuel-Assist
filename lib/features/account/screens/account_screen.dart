
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:speed_shop/common/widgets/custom_button.dart';
import 'package:speed_shop/constant/global_var.dart';
import 'package:speed_shop/features/account/widgets/account_buttons.dart';
import 'package:speed_shop/features/owner/screens/owner_screen.dart';
import '../../../providers/user_provider.dart';
import '../../auth/screens/auth_screen.dart';
import '../services/account_service.dart';


class AccountScreen extends StatelessWidget {
  
  const AccountScreen({super.key});







  @override
  Widget build(BuildContext context) {
    
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text("Hello ${user.name} !"),
          elevation: 6,
          flexibleSpace: Container(
            decoration: const BoxDecoration(gradient: GlobalVar.appBarGradient),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Card(
                      color: Color.fromARGB(255, 255, 194, 101),
                      elevation: 8,
                      child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Text(
                          "  Name : ${user.name}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Card(
                      color: Color.fromARGB(255, 255, 194, 101),
                      elevation: 8,
                      child: SizedBox(
                        width: double.infinity,
                        height: 30,
                        child: Text(
                          "  Email : ${user.email}",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    const SizedBox(
                      height: 200,
                    )
                  ],
                ),
                if (user.type == 'true')
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: CustomButton(
                        text: "Manage Stations",
                        onTap: () => AccountServices().chngedash(context)),
                  ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20, right: 20, bottom: 30),
                  child: CustomButton(
                      text: "Sign Out",
                      onTap: () => AccountServices().logOut(context)),
                ),
              ],
            ),
          ),
        ));
  }
}
