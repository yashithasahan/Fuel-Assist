// import 'package:flutter/cupertino.dart';
// import 'package:speed_shop/models/user.dart';

// class UserProvider extends ChangeNotifier {
//   User _user = User(
//     id: "",
//     name: "",
//     password: "",
//     email: "",
//     address: "",
//     type: "",
//     token: "",
//   );

//   User get user => _user;

//   void setUser(String user) {
//     _user = User.fromJson(user);
//     notifyListeners();
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:speed_shop/models/station.dart';

class StationProvider extends ChangeNotifier {
  Station _station = Station(
      name: "",
      id: "",
      city: "",
      district: "",
      description: "",
      regId: 0,
      userId: "",
      isPetrolAvailable: false,
      isDieselAvailable: false,
      petrolDate: 0,
      petrolVolume: 0,
      dieslVoulme: 0,
      dieslDate: 0);

  Station get station => _station;
  void setStation(String station) {
    _station = Station.fromJson(station);
    notifyListeners();
  }
}
