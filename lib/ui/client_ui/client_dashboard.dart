import 'dart:convert';
import 'dart:io';

import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/model/get_barberlist.dart';
import 'package:choovoo/models/place.dart';
import 'package:choovoo/services/geolocator_service.dart';
import 'package:choovoo/services/get_shop_service.dart';
import 'package:choovoo/ui/client_ui/client_profile.dart';
import 'package:choovoo/ui/client_ui/rate_barber.dart';
import 'package:choovoo/ui/client_ui/shoaw_barber_onMap.dart';
import 'package:choovoo/ui/client_ui/show_barber_onlist.dart';
import 'package:choovoo/ui/navigationDrawer.dart';
import 'package:choovoo/utils/PushNotificationService.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'appointment_list.dart';

class ClientHome extends StatefulWidget {
  @override
  _ClientHomeState createState() => _ClientHomeState();
}

class _ClientHomeState extends State<ClientHome> {

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  int selectedpage=2;
  bool islist=false;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  @override
  void initState() {


    super.initState();
  }
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
   /* final pushNotificationService = PushNotificationService(_firebaseMessaging);
    pushNotificationService.initialise();*/
    final locatorService = GeoLocatorService();
    // TODO: implement build
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return MultiProvider(
      providers: [
        FutureProvider(create: (context) => locatorService.getLocation()),
        ProxyProvider<Position, Future<List<GetBarber>>>(
          update: (context, position, places) {
            return (position != null)
                ? GetShopService().getBarberShoap(position)
                : null;
          },
        )
      ],
      child: MaterialApp(
        home: Scaffold(

          appBar: AppBar(
            backgroundColor: AppColors.Appbarcolor,
            actions: [
              Padding(
                padding: const EdgeInsets.only(top:8.0,bottom: 8.0),
                child: GestureDetector(
                  onTap: (){
                    print("cliclk");
                   /* showDialog(
                      context: context,
                      builder: (_) => RateBarber(),
                    );*/
                    setState(() {
                      if(islist){
                        islist=false;
                      }
                      else{
                        islist=true;
                      }

                    });
                  },
                    child: islist?Image.asset("images/map.png", height: 30,
                      width: 50,):Image.asset("images/list.png", height: 30,
                      width: 50,),),
              ),
              Icon(Icons.notifications,color: Colors.white,),
            ],
            title:
            Image.asset("assets/round_logo.png", height: 50,
              width: 50,),
            centerTitle: true,
          ),
    drawer: Theme(
    data: Theme.of(context).copyWith(
    canvasColor: Color(0xff363636), //This will change the drawer background to blue.
    //other styles
    ),
    child: navigationDrawer()),
          bottomNavigationBar: BottomNavigationBar(
            onTap: _selectPage,
            backgroundColor: Color(0xff1a1c1d),
            unselectedItemColor:Color(0xff696e71) ,
            showUnselectedLabels: true,
            selectedFontSize:18,
            selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
            selectedItemColor: Colors.white,
            selectedLabelStyle: TextStyle(fontWeight: FontWeight.w400,fontFamily: 'RobotoBold'),
            currentIndex: selectedpage,
            items: const <BottomNavigationBarItem>[

              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.person),
                ),
                label: 'Profile',
              ),
              BottomNavigationBarItem(
                backgroundColor: Color(0xff465258),
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.favorite),
                ),
                label: 'Shop feed',
              ),
              BottomNavigationBarItem(
                icon: Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(Icons.cut),
                ),
                label: 'Barbers',
              ),

            ],
          ),
          body: islist?ShowBraberList(islist: islist,):ShowBraberMap(islist: islist,),
        ),
      ),
    );
  }

  void _selectPage(int index) {
    setState(() {
      selectedpage = index;
    });
    if(selectedpage==0){
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ClientProfile())

      );
    }
  }


}