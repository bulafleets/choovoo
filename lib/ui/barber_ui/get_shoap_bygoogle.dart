import 'package:choovoo/constants/app_theme.dart';
import 'package:choovoo/models/place.dart';
import 'package:choovoo/services/geolocator_service.dart';
import 'package:choovoo/services/places_service.dart';
import 'package:choovoo/ui/barber_ui/search_nearby.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class GetShoapGoogle extends StatelessWidget {


  final locatorService = GeoLocatorService();
  final placesService = PlacesService();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    PlacesService.place = "beauty_salon";
   return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<Place>>>(
          update: (context, position, places) {
            return (position != null)
                ? placesService.getPlaces(position.latitude, position.longitude)
                : null;
          },
        )
      ],
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Where are you working?',style: AppThemes.kTitleStyle,),
            centerTitle: true,
            backgroundColor: Colors.white,
          ),
          body: Search(),
        ),
      ),
    );
  }
}