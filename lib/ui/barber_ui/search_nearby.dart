import 'package:choovoo/models/place.dart';
import 'package:choovoo/services/geolocator_service.dart';
import 'package:choovoo/services/marker_service.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:geolocator/geolocator.dart';

import '../add_fullshoap_info.dart';


class Search extends  StatefulWidget {

@override
_SearchState createState() => _SearchState();
}
class _SearchState extends State<Search> {
String shoapname="";
String shoapaddress="";
  String lat="";
  String long="";
List<Place> _shoapDetails = [];
List<Place> _searchResult = [];
int  tappedIndex = -1;
  TextEditingController editingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final currentPosition = Provider.of<Position>(context);
    final placesProvider = Provider.of<Future<List<Place>>>(context);
    final geoService = GeoLocatorService();
    final markerService = MarkerService();

    return FutureProvider(
      create: (context) => placesProvider,
      child: Scaffold(
        body: (currentPosition != null)
            ? Consumer<List<Place>>(
          builder: (_, places, __) {
            _shoapDetails=places;
            return (_shoapDetails != null)
                ? Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
            Container(
            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
            child: TextField(
            controller: editingController,
            keyboardType: TextInputType.text,
            cursorColor: Colors.grey,
            style:  TextStyle(color:Color(0xFF4d5060)) ,
            onChanged: (val){
              _searchResult.clear();
              if (val.isEmpty) {
                setState(() {});
                return;
              }

              _shoapDetails.forEach((userDetail) {
                  if(userDetail.name?.toLowerCase().contains(val?.toLowerCase()))
                  _searchResult.add(userDetail);
              });

              setState(() {});
            },
            onTap: () {
            },
            decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFedf0fd),
            enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFedf0fd)),
            borderRadius: BorderRadius.circular(30),
            ),
            focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFedf0fd)),
            borderRadius: BorderRadius.circular(30),
            ),
            prefixIcon: Icon(Icons.search, color: Color(0xffb7c2d5), size: 20),
            labelText: "Search for companies",
            labelStyle: TextStyle(color: Color(0xffb7c2d5),fontFamily: 'RobotoBold' ),
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
                                  currentPosition.latitude,
                                  currentPosition.longitude,
                                  _searchResult[index]
                                      .geometry
                                      .location
                                      .lat,
                                  _searchResult[index]
                                      .geometry
                                      .location
                                      .lng),
                          child: Card(
                            child: ListTile(
                              onTap: ()async {
                                shoapname= _searchResult[index].name;
                                shoapaddress=_searchResult[index].vicinity;
                                lat= _searchResult[index]
                                    .geometry
                                    .location
                                    .lat.toString();
                                long= _searchResult[index]
                                    .geometry
                                    .location
                                    .lng.toString();
                                showDialog(
                                  context: context,
                                  builder: (_) => LogoutOverlay(shoapname:shoapname ,shoaplat: lat,shoaplng: long,shoapaddess:shoapaddress,),
                                );
                              },
                              title: Text(_searchResult[index].name,style: TextStyle(fontFamily: 'RobotoBold'),),
                              subtitle: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 3.0,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Consumer<double>(
                                    builder:
                                        (context, meters, wiget) {
                                      return (meters != null)
                                          ? Text(
                                          '${_searchResult[index].vicinity} \u00b7 ${(meters / 1000).toStringAsFixed(1)} km',style: TextStyle(fontFamily: 'RobotoRegular'),)
                                          : Container();
                                    },
                                  )
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
                                  currentPosition.latitude,
                                  currentPosition.longitude,
                                  _shoapDetails[index]
                                      .geometry
                                      .location
                                      .lat,
                                  _shoapDetails[index]
                                      .geometry
                                      .location
                                      .lng),
                          child: Card(
                            child: Ink(
                              color: tappedIndex==index?Color(0xff00a5ac):Colors.transparent,
                              child: ListTile(
                                onTap: ()async {
                                    setState(() {
                                      tappedIndex=index;
                                    });
                                  shoapname= _shoapDetails[index].name;
                                  shoapaddress=_shoapDetails[index].vicinity;
                                  lat= _shoapDetails[index]
                                      .geometry
                                      .location
                                      .lat.toString();
                                  long= _shoapDetails[index]
                                      .geometry
                                      .location
                                      .lng.toString();
                                  showDialog(
                                    context: context,
                                    builder: (_) => LogoutOverlay(shoapname:shoapname ,shoaplat: lat,shoaplng: long,shoapaddess:shoapaddress,),
                                  );
                                },
                                title: Text(_shoapDetails[index].name,style: TextStyle(fontFamily: 'RobotoBold',fontSize: 16),),
                                subtitle: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    SizedBox(
                                      height: 3.0,
                                    ),
                                    SizedBox(
                                      height: 5.0,
                                    ),
                                    Consumer<double>(
                                      builder:
                                          (context, meters, wiget) {
                                        return (meters != null)
                                            ? Text(
                                            '${_shoapDetails[index].vicinity} \u00b7 ${(meters / 1000).toStringAsFixed(1)} km',style: TextStyle(fontFamily: 'RobotoRegular',fontSize: 14))
                                            : Container();
                                      },
                                    )
                                  ],
                                ),

                              ),
                            ),
                          ),
                        );
                      }),
                )
              ],
            )
                : Center(child: CircularProgressIndicator());
          },
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
  Widget nearbyRow() {
    return Container(
      margin: EdgeInsets.only(left:30),
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15,),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(Icons.location_on, size: 22,color: Color(0xff5170d9),),
                ),
                TextSpan(
                  text: "Near Me ",style: TextStyle(color: Color(0xff5170d9),fontSize: 22,fontWeight: FontWeight.w600,fontFamily: 'RobotoBold')
                ),
              ],
            ),
          ),
          SizedBox(height: 5,),
          Text("Companies",style: TextStyle(color: Color(0xff91c7ff),fontWeight: FontWeight.w500,fontFamily: 'RobotoBold'),)
        ],
      ),
    );
  }
}
class LogoutOverlay extends StatefulWidget {
  final String shoapname;
  final String shoaplat;
  final String shoaplng;
  final String shoapaddess;
  LogoutOverlay({ Key key, this.shoapname, this.shoaplat, this.shoaplng,this.shoapaddess}) : super(key: key);
  @override
  State<StatefulWidget> createState() => LogoutOverlayState();
}

class LogoutOverlayState extends State<LogoutOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.elasticInOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                height: 170.0,
                width: 330.0,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),side:BorderSide(color: Colors.grey))),
                child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0,bottom: 10.0),
                      child: Text(
                        "Is this your store?",
                        style: TextStyle(color: Color(0xFF767f9b), fontSize: 16.0,fontWeight: FontWeight.w700,fontFamily: 'RobotoBold'),
                      ),
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                              height: 35.0,
                              minWidth: 100.0,
                              child: RaisedButton(
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                splashColor: Color(0xff0095FF),
                                child: Text(
                                  'Confirm',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0),
                                ),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true).pop('dialog');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AddFullShoapInfo(shoapname:widget.shoapname ,shoaplat: widget.shoaplat,shoaplng: widget.shoaplng,shoapaddess: widget.shoapaddess,)));
                                },
                              )),
                        ),
                        Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0),
                            child:  ButtonTheme(
                                height: 35.0,
                                minWidth: 100.0,
                                child: RaisedButton(
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),side: BorderSide(color: Colors.red)),
                                  splashColor: Colors.red,
                                  child: Text(
                                    'Not Now',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context, rootNavigator: true).pop('dialog');
                                    });
                                  },
                                ))
                        ),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
}