import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/get_barberlist.dart';
import 'package:choovoo/services/geolocator_service.dart';
import 'package:choovoo/services/get_shop_service.dart';
import 'package:choovoo/services/marker_service.dart';
import 'package:choovoo/ui/client_ui/show_barber_onlist.dart';
import 'package:choovoo/utils/LocationProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

import '../../main.dart';
import 'barber_profile_user.dart';

class ShowBraberMap extends StatefulWidget {
  bool islist;
  ShowBraberMap({ Key key, this.islist}) : super(key: key);
  @override
  _ShowBraberMapState createState() => _ShowBraberMapState();
}

class _ShowBraberMapState extends State<ShowBraberMap> {
  static const kGoogleApiKey = "AIzaSyBltuyqYBtlJJ1MgNuBwYIII_C5wvDhsCY";
  GoogleMapController _controller;
  List<GetBarber> shoplist = [];
  TextEditingController editingController = TextEditingController();

  LatLng center = null;
  final locationService = getIt.get<LocationProvider>();
  bool mapLoading = true;
  bool barbloading = true;
  String _mapStyle;
  List<GetBarber> barblist=[];
  List<Marker> nearByCabMarkers = List<Marker>();
  BitmapDescriptor cabIcon = BitmapDescriptor.defaultMarker;
  GoogleMapsPlaces _places;
  @override
  void initState() {
    super.initState();
    _places  = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
    _getUserLocation();
  }
  void _getUserLocation() async {
    Position position = await locationService.provideCurrentLocation();
      center = LatLng(position.latitude, position.longitude);
    currentaddress=center;
    barblist= getBarberShoap(center) as List<GetBarber>;

    print("cntt");
    print(center.latitude);
  }
  void _onMapCreated(GoogleMapController mycontroller) {
    _controller = mycontroller;
    mycontroller.setMapStyle(_mapStyle);
    mapLoading = false;
    _getUserLocationName(center);
   // mapsPresenter.showNearbyCabs(center);
  }
  void _getUserLocationName(LatLng latLng) async {

   // Placemark position = await locationService.getAddressFromLocation(latLng.latitude, latLng.longitude);
  // String  pickUpLocationTag = position.name + ", " + position.locality;
    final coordinates = new Coordinates(latLng.latitude, latLng.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
   print("adddress${first.featureName+"//"+first.addressLine}");
   setState(() {
     editingController.text=first.addressLine;
   });
   /* setState(() {
      pickupLocation =
          LatLng(position.position.latitude, position.position.longitude);
      pickUpLocationTag = position.name + ", " + position.administrativeArea;
    });*/
  }
  @override
  Widget build(BuildContext context) {
  
    final currentPosition = Provider.of<Position>(context);
   //
    final markerService = MarkerService();
    final geoService = GeoLocatorService();
    print("nikkk${widget.islist}");
    final placesProvider = Provider.of<Future<List<GetBarber>>>(context);
    return  Scaffold(
        body:    barbloading? Center(child: CircularProgressIndicator()): SingleChildScrollView(
              child:   Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                 Container(
                    width: MediaQuery.of(context).size.width, // or use fixed size like 200
                    height: MediaQuery.of(context).size.height,
                    child:Stack(
                      children: <Widget>[
                         /* AnimatedOpacity(
                            opacity: mapLoading ? 0 : 1,
                            curve: Curves.easeInOut,
                            duration: Duration(milliseconds: 1000),
                            child: Container(
                              color: Colors.white24,
                              child:*/ GoogleMap(
                                myLocationEnabled: true,
                                onMapCreated: _onMapCreated,
                                //padding: EdgeInsets.only(top: 130.0,),
                                initialCameraPosition: CameraPosition(
                                  target: center,
                                  zoom: 15.0,
                                ),
                                markers: Set<Marker>.of(nearByCabMarkers),
                                  onCameraMove: (position) async {
                                    Position position = await locationService.provideCurrentLocation();
                                    center = LatLng(position.latitude, position.longitude);
                                    currentaddress=center;
                                    _getUserLocationName(center);
                             setState(() {
                               Set<Marker>.of(nearByCabMarkers);
                             });
                           },
                               // polylines: cabToPickUpLine,
                                mapType: MapType.normal,
                              ),

                           /* ),
                          ),*/
                        searchtop(),

                        //if (!requestCabClicked) pickAndDropLayout(),

                      ],
                    )

                 )
                ],

              )

            )



    );
  }

  /*void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }*/
  List<Marker> getMarkers(List<GetBarber> places, BuildContext context, Position currentPosition) {

    var markers = List<Marker>();
    BitmapDescriptor customIcon;
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
      'images/green.png',)
        .then((d) {
      customIcon = d;
    });
    places.forEach((place) async {

      Marker marker = Marker(
          onTap: (){
           // _showBottomSheet();
            print("ontap");
            showModalBottomSheet(
              backgroundColor:Color((0xff2c2c2c)) ,
                context: context,
                builder: (context) {
              return Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                    child: ListTile(
                      leading:Image.network(
                        place.shop_photo,
                        fit: BoxFit.fill,
                         width: 100,
                        height: 150,
                      ),
                      trailing: GestureDetector(
                        onTap: (){
                  double totalDistance = calculateDistance(currentPosition.longitude, currentPosition.longitude,place.shoplat, place.shoplng);
                  print("dis$totalDistance");
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                  builder: (context) => BarberProfileUser(shop_id: place.id,shop_km:"24",shop_name: place.shoapname,shop_photo: place.shop_photo,shop_loc:place.shoaploc,minprice: place.minprice.toString(),maxprice: place.maxprice.toString(),)));
                        },
                          child: IconButton(icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),)),
                      title: Text(place.shoapname,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600),),
                      subtitle: Text(place.shoaploc,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400),),
                    ),
                  ),
                ],
              );
            },);
          },
          markerId: MarkerId(place.id),
          draggable: false,
          // icon: BitmapDescriptor.fromBytes(response.bodyBytes),
          icon: await BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),"assets/green.png"),
          infoWindow: InfoWindow(title: place.shoapname, snippet: place.shoaploc),
          position:
          LatLng(place.shoplat,  place.shoplng));

      markers.add(marker);
    });

    return markers;
  }
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }

  Widget searchtop(){
    return Container(
     // height: 50.0,
      margin: EdgeInsets.only(left: 50,right: 55,top: 10),
      child: TextField(
        controller: editingController,
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        style:  TextStyle(color:Colors.black) ,
        onChanged: (val){
        },
        onTap: () async {
          Prediction p = await getPaceOverlay(context);

          if (p != null) {
            PlacesDetailsResponse detail =
            await _places.getDetailsByPlaceId(p.placeId);
            center = LatLng(detail.result.geometry.location.lat, detail.result.geometry.location.lng);
             await getBarberShoap(center);
            currentaddress=center;
             print(center);
              var newPosition = CameraPosition(
                  target: LatLng(detail.result.geometry.location.lat, detail.result.geometry.location.lng),
                  zoom: 15);
              CameraUpdate update =CameraUpdate.newCameraPosition(newPosition);
              _controller.moveCamera(update);
            setState(() {
             // nearByCabMarkers=markers;
              editingController.text=detail.result.formattedAddress;

            });
           /* shoaplat = detail.result.geometry.location.lat.toString();
            shoaplng = detail.result.geometry.location.lng.toString();*/

          }
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.circular(40),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFedf0fd)),
            borderRadius: BorderRadius.circular(40),
          ),
          prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
          labelText: "Search...",
          labelStyle: TextStyle(color: Colors.grey),
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
  Future<Prediction> getPaceOverlay (BuildContext context) async{

    return await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay, // Mode.fullscreen
      language: "en",
    );

  }

  Future<List<GetBarber>> getBarberShoap(LatLng center) async {
    print('getting barber');
    try {
      final response = await http.post(Uri.parse(URL_GetShoapByLoc),
        headers: {HttpHeaders.authorizationHeader: "Bearer $authorization"},
        body: {
           'lattitude': center.latitude.toString(),
          'longitude': center.longitude.toString(),
         /* 'lattitude': "48.906060",
          'longitude': "2.152680",*/
        },
      );
      print(center.latitude.toString()+"//"+center.longitude.toString());
      if (response.statusCode == 200) {
        print("nikita");
        print(response.body);
        var tagObjsJson = jsonDecode(response.body)['nearbyShops2'] as List;
        List<GetBarber> tagObjs = tagObjsJson.map((tagJson) =>
            GetBarber.fromJson(tagJson)).toList();
        var markers = (GetBarber != null)
            ? getupdatedMarkers(tagObjs,context,center)
            : List<Marker>();

        setState(() {
          barbloading = false;
        });
        return tagObjs;
      } else {
        setState(() {
          barbloading = false;
        });
        List<GetBarber> tagObjs=[];
        return tagObjs;
      }
    } catch (e) {
      setState(() {
        barbloading = false;
      });
      return [];
    }
  }
  List<Marker> getupdatedMarkers(List<GetBarber> places, BuildContext context, LatLng currentPosition) {

    var markers = List<Marker>();
    BitmapDescriptor customIcon;
    BitmapDescriptor.fromAssetImage(ImageConfiguration(size: Size(12, 12)),
      'images/green.png',)
        .then((d) {
      customIcon = d;
    });
    places.forEach((place) async {

      Marker marker = Marker(
          onTap: (){
            // _showBottomSheet();
            print("ontap");
            showModalBottomSheet(
              backgroundColor:Color((0xff2c2c2c)) ,
              context: context,
              builder: (context) {
                return Wrap(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10.0,bottom: 10.0),
                      child:
                      /*Row(
                       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            margin: EdgeInsets.only(left:15.0),
                            child: CachedNetworkImage(
                              imageUrl: place.shop_photo,
                              imageBuilder: (context, imageProvider) => Container(
                                width: 80.0,
                                height: 80.0,
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  image: DecorationImage(
                                      image: imageProvider, fit: BoxFit.cover),
                                ),
                              ),
                              progressIndicatorBuilder: (context, url, downloadProgress) =>
                                  Container(alignment: Alignment.center,
                                      child: CircularProgressIndicator(value: downloadProgress.progress)),
                              errorWidget: (context, url, error) => Icon(
                                Icons.error,
                                size: 100,
                                color: Colors.red,
                              ),
                            ),
                          ),
                          SizedBox(height: 8,),
                          Container(
                            margin: EdgeInsets.only(left:10.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(place.shoapname,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400,fontFamily: 'RobotoBold',),textAlign:TextAlign.start),
                                SizedBox(height: 5,),
                                Text(place.shoaploc,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'RobotoRegular'),textAlign:TextAlign.start),
                                SizedBox(height: 5,),
                                Text( "Prices from \$"+place.minprice.toString()+"-"+"\$"+place.maxprice.toString(),textAlign:TextAlign.start,style: TextStyle(fontFamily: 'RobotoRegular',color: Colors.white),),

                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left:15.0),
                            child: GestureDetector(
                                onTap: (){
                                  double totalDistance = calculateDistance(currentPosition.longitude, currentPosition.longitude,place.shoplat, place.shoplng);
                                  print("dis$totalDistance");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => BarberProfileUser(shop_id: place.id,shop_km:"24",shop_name: place.shoapname,shop_photo: place.shop_photo,shop_loc:place.shoaploc,minprice: place.minprice.toString(),maxprice: place.maxprice.toString(),)));
                                },
                                child: IconButton(icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),)),
                          ),

                        ],
                      )*/

                      ListTile(
                        leading:Image.network(
                          place.shop_photo,
                          fit: BoxFit.fill,
                          width: 100,
                          height: 200,
                        ),
                        trailing: GestureDetector(
                            onTap: (){
                              double totalDistance = calculateDistance(currentPosition.longitude, currentPosition.longitude,place.shoplat, place.shoplng);
                              print("dis$totalDistance");
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => BarberProfileUser(shop_id: place.id,shop_km:"24",shop_name: place.shoapname,shop_photo: place.shop_photo,shop_loc:place.shoaploc,minprice: place.minprice.toString(),maxprice: place.maxprice.toString(),)));
                            },
                            child: IconButton(icon: Icon(Icons.arrow_forward_ios,color: Colors.white,),)),
                        title:Text(place.shoapname,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w400,fontFamily: 'RobotoBold',),textAlign:TextAlign.start),

                        subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 5,),
                                Text(place.shoaploc,style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.w400,fontFamily: 'RobotoRegular'),textAlign:TextAlign.start),
                                SizedBox(height: 5,),
                                Text( "Prices from \$"+place.minprice.toString()+"-"+"\$"+place.maxprice.toString(),textAlign:TextAlign.start,style: TextStyle(fontFamily: 'RobotoRegular',color: Colors.white),),

                              ],
                            ),
                      ),
                    ),
                  ],
                );
              },);
          },
          markerId: MarkerId(place.id),
          draggable: false,
          // icon: BitmapDescriptor.fromBytes(response.bodyBytes),
          icon: await BitmapDescriptor.fromAssetImage( ImageConfiguration(devicePixelRatio: 2.5),"assets/green.png"),
          infoWindow: InfoWindow(title: place.shoapname, snippet: place.shoaploc),
          position:
          LatLng(place.shoplat,  place.shoplng));
     nearByCabMarkers.add(marker);
      markers.add(marker);
    });

    return markers;
  }
}
