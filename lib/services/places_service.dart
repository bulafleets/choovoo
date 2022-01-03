
import 'package:choovoo/models/place.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class PlacesService {
  final key = 'AIzaSyBltuyqYBtlJJ1MgNuBwYIII_C5wvDhsCY';
  static String place = 'beauty_salon';
  Future<List<Place>> getPlaces(double lat, double lng) async {
    var response = await http.get(Uri.parse('https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$lng&type=$place&rankby=distance&key=$key'));
    var json = convert.jsonDecode(response.body);
    var jsonResults = json['results'] as List;
    return jsonResults.map((place) => Place.fromJson(place)).toList();
  }
}
