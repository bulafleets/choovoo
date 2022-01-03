import 'package:geolocator/geolocator.dart';

class GeoLocatorService {
  final geolocator = Geolocator();
  bool serviceEnabled;
  Future<Position> getLocation() async {

    return await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        locationPermissionLevel: GeolocationPermission.location
        );
  }

  Future<double> getDistance(double startLatitude, double startLongitude,
      double endLatitude, double endLongitude) async {
    return await Geolocator().distanceBetween(
        startLatitude, startLongitude, endLatitude, endLongitude);
  }
}
