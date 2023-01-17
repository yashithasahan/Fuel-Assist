import 'package:flutter/cupertino.dart';
import 'package:speed_shop/models/user.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: "",
    name: "",
    password: "",
    email: "",
    address: "",
    type: "",
    token: "",
    date: 0,
    duration: 0,
    isFulled: false,
    isInQueue: false,
    stationId: '',
    vehicleType: '',
  );

  User get user => _user;

  void setUser(String user) {
    _user = User.fromJson(user);
    notifyListeners();
  }
}
