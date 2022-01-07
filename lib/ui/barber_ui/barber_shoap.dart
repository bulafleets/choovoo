import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/ui/barber_ui/barber_appointment_list.dart';
import 'package:choovoo/ui/barber_ui/barber_profile.dart';
import 'package:choovoo/ui/barber_ui/barber_profile_forFeed.dart';
import 'package:choovoo/ui/client_ui/client_profile_forFeed.dart';
import 'package:choovoo/ui/feed/feed_Details.dart';
import 'package:choovoo/ui/feed/create_shop_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigationDrawer.dart';
import 'barber_feed.dart';

class BarberDashboard extends StatefulWidget {
  @override
  BarberDashboardState createState() => new BarberDashboardState();
}

class BarberDashboardState extends State<BarberDashboard>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  int selectedpage = 1;
  var _children = [BarberProfile(), BarberFeed(), BarberAppointmentList()];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Color(0xff1a1c1d),
          unselectedItemColor: Color(0xff696e71),
          showUnselectedLabels: true,
          selectedFontSize: 18,
          selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
          selectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          currentIndex: selectedpage,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
            BottomNavigationBarItem(
              backgroundColor: Color(0xff465258),
              icon: Icon(Icons.favorite),
              label: 'Shop feed',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book_online),
              label: 'Appointment',
            ),
          ],
        ),
        body: _children[selectedpage]);
  }

  void _selectPage(int index) {
    setState(() {
      selectedpage = index;
      // if (selectedpage == 0) {
      //   BarberProfile();
      //   // Navigator.push(
      //   //     context, MaterialPageRoute(builder: (context) => BarberProfile()));
      // }
      // if (selectedpage == 2) {
      //   BarberAppointmentList();
      //   // Navigator.push(context,
      //   //     MaterialPageRoute(builder: (context) => BarberAppointmentList()));
      // }
    });
  }
}