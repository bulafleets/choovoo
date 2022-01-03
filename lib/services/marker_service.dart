
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:choovoo/model/get_barberlist.dart';
import 'package:choovoo/models/place.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MarkerService {

  List<Marker> getMarkers(List<GetBarber> places) {

    var markers = List<Marker>();
    BitmapDescriptor customIcon;
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
      'assets/logo.png',)
        .then((d) {
      customIcon = d;
    });
    places.forEach((place) async {

      Marker marker = Marker(
        onTap: (){
          //_showBottomSheet();
          print("ontap");
        },
          markerId: MarkerId(place.id),
          draggable: false,
          // icon: BitmapDescriptor.fromBytes(response.bodyBytes),
           icon: await BitmapDescriptor.fromAssetImage( ImageConfiguration(devicePixelRatio: 2.5),"assets/mapmarker.png"),
          infoWindow: InfoWindow(title: place.shoapname, snippet: place.shoaploc),
          position:
              LatLng(place.shoplat,  place.shoplng));

      markers.add(marker);
    });

    return markers;
  }

}
