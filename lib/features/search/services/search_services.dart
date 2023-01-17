import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:speed_shop/constant/error_handlig.dart';
import 'package:http/http.dart' as http;
import '../../../constant/global_var.dart';
import '../../../constant/utils.dart';
import '../../../models/station.dart';
import '../../../providers/user_provider.dart';

class SearchServices {
  Future<List<Station>> fetchSearchStation({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Station> stationList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/stations/search/$searchQuery'), headers: {
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
    }

    return stationList;
  }
}
