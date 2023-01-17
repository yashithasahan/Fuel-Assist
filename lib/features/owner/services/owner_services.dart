import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:speed_shop/constant/error_handlig.dart';
import 'package:speed_shop/constant/global_var.dart';
import 'package:speed_shop/constant/utils.dart';
import 'package:http/http.dart' as http;
import 'package:speed_shop/providers/station_provider.dart';
import 'package:speed_shop/providers/user_provider.dart';
import '../../../models/station.dart';

class OwnerServices {
  void addStation({
    required BuildContext context,
    required String name,
    required String city,
    required String district,
    required String description,
    required int regId,
    required String userId,
    required bool isPetrolAvailable,
    int? petrolVolume,
    int? petrolDate,
    int? dieslVoulme,
    required bool isDieselAvailable,
    int? dieslDate,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      Station station = Station(
        id: "",
        name: name,
        city: city,
        district: district,
        description: description,
        regId: regId,
        userId: userId,
        isPetrolAvailable: false,
        petrolVolume: 0,
        petrolDate: 0,
        isDieselAvailable: false,
        dieslVoulme: 0,
        dieslDate: 0,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/owner/add-station'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: station.toJson(),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Station Succefully added!");
          Navigator.pop(context); // back to the main screen
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

//get station back // use method and button to reftresh the list
  Future<List<Station>> fetchAllStations(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    
    

    List<Station> stationList = [];
    try {
      http.Response res =
          await http.get(
          Uri.parse('$uri/owner/get-stations/${userProvider.user.id}'),
          headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });
      httpErrorHandle(
          response: res,
          context: context,
          onSuccess: () {
            for (int i = 0; i < jsonDecode(res.body).length; i++) {
              stationList.add(
                Station.fromJson(
                  jsonEncode(
                    jsonDecode(res.body)[i],
                  ),
                ),
              );
            }
          });
    } catch (e) {
      showSnackBar(context, e.toString());
      print(e);
    }

    return stationList;
  }
// petrol status
  void updateStationPetrolAvailability({
    required BuildContext context,
    required id,
    required petrolStauts,
    required petrolDate,
    
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
   
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/owner/update-petrol-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'fuled':petrolStauts,
          'id':id,
          'petrolDate': petrolDate,
          
          
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          
          showSnackBar(context, "Station petrol availability updated!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
  
  // diesel State
   void updateStationDieselAvailability({
    required BuildContext context,
    required id,
    required dieselStauts,
    required dieselDate,
    
    
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
   
    try {
      http.Response res = await http.put(
        Uri.parse('$uri/owner/update-diesel-status'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'fuled': dieselStauts,
          'id':id,
          'dieseldate': dieselDate,
          
          
          
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          
          showSnackBar(context, "Station diesel availability updated!");
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}


