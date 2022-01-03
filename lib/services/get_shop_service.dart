
import 'dart:convert';
import 'dart:io';

import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/get_barberlist.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class GetShopService {
  Future<List<GetBarber>> getBarberShoap(Position currentPosition) async {
    print('getting barber');
    print(currentPosition.latitude);
    print(currentPosition.longitude);
    try {
      final response = await http.post(Uri.parse(URL_GetShoapByLoc),
        headers: {HttpHeaders.authorizationHeader: "Bearer $authorization"},
        body: {
          'lattitude': currentPosition.latitude.toString(),
          'longitude': currentPosition.longitude.toString(),
         /* 'lattitude': "48.906060",
          'longitude': "2.152680",*/
        },
      );
      if (response.statusCode == 200) {
        print("nikita");
        print(response.body);
        var tagObjsJson = jsonDecode(response.body)['nearbyShops2'] as List;
        List<GetBarber> tagObjs = tagObjsJson.map((tagJson) =>
            GetBarber.fromJson(tagJson)).toList();
        return tagObjs;
      } else {
        List<GetBarber> tagObjs=[];
       return tagObjs;
      }
    } catch (e) {
     return [];
    }
  }
}