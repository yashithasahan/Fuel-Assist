import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:tuple/tuple.dart';
import '../../../constant/error_handlig.dart';
import '../../../constant/global_var.dart';
import '../../../constant/utils.dart';
import '../../../models/station.dart';
import '../../../providers/user_provider.dart';


class StationQueueServices {
  
  
  void queueUpdate({
    required BuildContext context,
    required Station station,
    required bool isInQueue,
    required bool isFuelled,
    required int duration,
    required String userID,
    required String vehicle,

    //update the user queue data
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.patch(
        Uri.parse('$uri/api/queue-update/$userID'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': station.id,
          'isInQueue': isInQueue,
          'isFuelled': isFuelled,
          'duration': duration,
          'vehicle': vehicle,
        }),
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  Future<Tuple6<int, int, int, int, int, int>> queueLength({
    
    required BuildContext context,
    required Station station,

    //retrieve the station queue data
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String staionId = station.id;
    int queueCount = 0;
    int motorcycleCount = 0;
    int therweelerCount = 0;
    int carVanCount = 0;
    int busLorryCount = 0;
    int otherCount = 0;
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/queue-length/$staionId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        var queueCount = data['count'];
        var motorcycleCount = data['motorCycle'];
        var therweelerCount = data['threeweeler'];
        var carVanCount = data['car'];
        var busLorryCount = data['bus'];
        var otherCount = data['other'];

        return Future.value(Tuple6(queueCount, motorcycleCount, therweelerCount,
            carVanCount, busLorryCount, otherCount));
        
      } else {
        
      }

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return Future.value(Tuple6(queueCount, motorcycleCount, therweelerCount,
        carVanCount, busLorryCount, otherCount));
  
  }


// get average watiting time

  Future<int> queueDuration({
    required BuildContext context,
    required Station station,

    //retrieve the station queue data
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    String staionId = station.id;
    int averageDuration = 0;

    try {
      http.Response res = await http.get(
        Uri.parse('$uri/api/waiting-time/$staionId'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );
      if (res.statusCode == 200) {
        var data = jsonDecode(res.body);
        var averageDuration = data['waitingTime'];

        return Future.value(averageDuration.toInt());
      } else {
        
      }

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {},
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return Future.value(averageDuration.toInt());
  }







}
