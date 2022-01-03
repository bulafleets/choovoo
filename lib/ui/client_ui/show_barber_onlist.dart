import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/get_barberlist.dart';
import 'package:choovoo/services/geolocator_service.dart';
import 'package:choovoo/services/marker_service.dart';
import 'package:choovoo/ui/client_ui/barber_profile_user.dart';
import 'package:choovoo/utils/LocationProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class ShowBraberList extends StatefulWidget {
  bool islist;
  ShowBraberList({ Key key, this.islist}) : super(key: key);
  @override
  _ShowBraberListState createState() => _ShowBraberListState();
}

class _ShowBraberListState extends State<ShowBraberList> {
  Completer<GoogleMapController> _controller = Completer();
  List<GetBarber> shoplist = [];
  TextEditingController editingController = TextEditingController();
  List<GetBarber> _shoapDetails = [];
  List<GetBarber> _searchResult = [];
  LatLng center = null;
  bool barbloading = true;
  final locationService = getIt.get<LocationProvider>();
  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }
  void _getUserLocation() async {
    Position position = await locationService.provideCurrentLocation();
    center = LatLng(position.latitude, position.longitude);
   getBarberShoap(currentaddress) as List<GetBarber>;

    print("cntt");
    print(center.latitude);
  }
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final markerService = MarkerService();
    final geoService = GeoLocatorService();
    print("nikkk${widget.islist}");
    final placesProvider = Provider.of<Future<List<GetBarber>>>(context);

    return  Scaffold(
        backgroundColor: Color(0xfff4f6ff),
        body: barbloading? Center(child: CircularProgressIndicator()): Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 50,
                  margin: EdgeInsets.only(left: 15,right: 15,top: 15),
                  child: TextField(
                    controller: editingController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.grey,
                    style:  TextStyle(color:Color(0xFF4d5060),fontFamily: 'RobotoBold') ,
                    onChanged: (val){
                      _searchResult.clear();
                      if (val.isEmpty) {
                        setState(() {});
                        return;
                      }
                      _shoapDetails.forEach((userDetail) {
                        if(userDetail.shoapname?.toLowerCase().contains(val?.toLowerCase()))
                          _searchResult.add(userDetail);
                      });
                      setState(() {});
                    },
                    onTap: () {
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFffffff),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFedf0fd)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFedf0fd)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.search, color: Color(0xffb7c2d5), size: 20),
                      labelText: "Search for barbershop....",
                      labelStyle: TextStyle(color: Color(0xffb7c2d5) ),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                nearbyRow(),
                SizedBox(
                  height: 10.0,
                ),
                Expanded(
                  child: _searchResult.length != 0 || editingController.text.isNotEmpty?
                  new ListView.builder(
                      itemCount: _searchResult.length,
                      itemBuilder: (context, index) {
                        return FutureProvider(
                          create: (context) =>
                              geoService.getDistance(
                                  currentaddress.latitude,
                                  currentaddress.longitude,
                                  _searchResult[index]
                                      .shoplat,
                                  _searchResult[index]
                                      .shoplng),
                          child: Card(
                            child: ListTile(
                              onTap: ()async {

                              },
                              leading:
                              CachedNetworkImage(
                                width: 80,
                                height: 250,
                                fit: BoxFit.cover,

                                imageUrl: _searchResult[index].shop_photo,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Container(alignment: Alignment.center,
                                        child: CircularProgressIndicator(value: downloadProgress.progress)),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  size: 150,
                                  color: Colors.red,
                                ),
                              ),

                              /*CircleAvatar(
                                radius: 30.0,
                                backgroundImage:
                                NetworkImage(_shoapDetails[index].shop_photo,),
                                backgroundColor: Colors.transparent,
                              )*/
                              title: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_searchResult[index].shoapname,style: TextStyle(fontFamily: 'RobotoBold')),
                                    Consumer<double>(
                                      builder:
                                          (context, meters, wiget) {
                                        return (meters != null)
                                            ? Text(
                                            '${(meters / 1000).toStringAsFixed(1)} km',style: TextStyle(fontFamily: 'RobotoRegular'))
                                            : Container();
                                      },
                                    )
                                  ],
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Consumer<double>(
                                    builder:
                                        (context, meters, wiget) {
                                      return (meters != null)
                                          ? Text(
                                          _searchResult[index].shoaploc,style: TextStyle(fontFamily: 'RobotoRegular'))
                                          : Container();
                                    },
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    child: Text( "Prices from \$"+_searchResult[index].minprice.toString()+"-"+"\$"+_searchResult[index].maxprice.toString(),style: TextStyle(fontFamily: 'RobotoRegular'),),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        onPrimary: Color(0xFFc5cdd5),
                                        primary:Color(0xFFf4f6ff),
                                        minimumSize: Size(88, 36),
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(2)),
                                        ),
                                      ),
                                      onPressed: () {
                                        double totalDistance = calculateDistance(currentPosition.longitude, currentPosition.longitude,_shoapDetails[index].shoplat, _shoapDetails[index].shoplng);
                                        print("dis$totalDistance");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BarberProfileUser(shop_id: _searchResult[index].id,shop_km:"24",shop_name: _searchResult[index].shoapname,shop_photo: _searchResult[index].shop_photo,shop_loc: _searchResult[index].shoaploc,minprice: _searchResult[index].minprice.toString(),maxprice: _searchResult[index].maxprice.toString(),)));
                                      },
                                      child: Text(
                                        "See Profile",style: TextStyle(color: Color(0xff3c7db4),fontFamily: 'RobotoBold'),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ),
                          ),
                        );
                      }):new
                  ListView.builder(
                      itemCount: _shoapDetails.length,
                      itemBuilder: (context, index) {
                        return FutureProvider(
                          create: (context) =>
                              geoService.getDistance(
                                  currentaddress.latitude,
                                  currentaddress.longitude,
                                  _shoapDetails[index]
                                      .shoplat
                                      ,
                                  _shoapDetails[index]
                                      .shoplng),
                          child: Card(
                            child: ListTile(
                              onTap: ()async {

                              },
                              leading:CachedNetworkImage(
                                width: 80,
                                height: 250,
                                fit: BoxFit.cover,
                                imageUrl: _shoapDetails[index].shop_photo,
                                progressIndicatorBuilder: (context, url, downloadProgress) =>
                                    Container(alignment: Alignment.center,
                                        child: CircularProgressIndicator(value: downloadProgress.progress)),
                                errorWidget: (context, url, error) => Icon(
                                  Icons.error,
                                  size: 100,
                                  color: Colors.red,
                                ),
                              ),
                              title: Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(_shoapDetails[index].shoapname,style: TextStyle(fontFamily: 'RobotoBold'),),
                                    Consumer<double>(
                                      builder:
                                          (context, meters, wiget) {
                                        return (meters != null)
                                            ? Text(
                                            '${(meters / 1000).toStringAsFixed(1)} km',style: TextStyle(fontFamily: 'RobotoRegular'),)
                                            : Container();
                                      },
                                    )
                                  ],
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Consumer<double>(
                                    builder:
                                        (context, meters, wiget) {
                                      return (meters != null)
                                          ? Text(
                                          _shoapDetails[index].shoaploc,style: TextStyle(fontFamily: 'RobotoRegular'),)
                                          : Container();
                                    },
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    child: Text( "Prices from \$"+_shoapDetails[index].minprice.toString()+"-"+"\$"+_shoapDetails[index].maxprice.toString(),style: TextStyle(fontFamily: 'RobotoRegular'),),
                                  ),
                                  Container(
                                    alignment: Alignment.centerRight,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        onPrimary: Color(0xFFc5cdd5),
                                        primary:Color(0xFFf4f6ff),
                                        minimumSize: Size(88, 36),
                                        padding: EdgeInsets.symmetric(horizontal: 16),
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(Radius.circular(2)),
                                        ),
                                      ),
                                      onPressed: () {
                                        double totalDistance = calculateDistance(currentPosition.longitude, currentPosition.longitude,_shoapDetails[index].shoplat, _shoapDetails[index].shoplng);
                                        print("dis$totalDistance");
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => BarberProfileUser(shop_id: _shoapDetails[index].id,shop_km:"24",shop_name: _shoapDetails[index].shoapname,shop_photo: _shoapDetails[index].shop_photo,shop_loc: _shoapDetails[index].shoaploc,minprice: _shoapDetails[index].minprice.toString(),maxprice: _shoapDetails[index].maxprice.toString(),)));
                                      },
                                      child: Text(
                                        "See Profile",style: TextStyle(color: Color(0xff3c7db4),fontFamily: 'RobotoBold'),
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                            ),
                          ),
                        );
                      }),
                )
              ],
            )
         // },
        //)

    );
  }
  double calculateDistance(lat1, lon1, lat2, lon2){
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 - c((lat2 - lat1) * p)/2 +
        c(lat1 * p) * c(lat2 * p) *
            (1 - c((lon2 - lon1) * p))/2;
    return 12742 * asin(sqrt(a));
  }
  Widget listcolumn() {
  return  Expanded(
      child: Column(
        // align the text to the left instead of centered
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: [
              Text('Title', style: TextStyle(fontSize: 16),),
            ],
          ),
          Text('subtitle'),
        ],
      ),
    );
  }
  Widget nearbyRow() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15,),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.location_on, size: 22,color: Color(0xff535f91),),
                ),
                TextSpan(
                    text: "Nearest Barbershp ",style: TextStyle(color: Color(0xff535f91),fontSize: 22,fontWeight: FontWeight.w400,fontFamily: 'RobotoBold')
                ),
              ],
            ),
          ),
             ],
      ),
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
      if (response.statusCode == 200) {
        print("nikita");
        print(response.body);
        var tagObjsJson = jsonDecode(response.body)['nearbyShops2'] as List;
        List<GetBarber> tagObjs = tagObjsJson.map((tagJson) =>
            GetBarber.fromJson(tagJson)).toList();
        _shoapDetails=tagObjs;
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
}
