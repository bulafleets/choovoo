import 'dart:async';

import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/ui/barber_ui/barber_appointment_list.dart';
import 'package:choovoo/ui/barber_ui/barber_profile.dart';
import 'package:choovoo/ui/feed/create_shop_feed.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigationDrawer.dart';



class BarberDashboard extends StatefulWidget {
  @override
  BarberDashboardState createState() => new BarberDashboardState();
}

class BarberDashboardState extends State<BarberDashboard>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  int selectedpage=1;
  TextEditingController editingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.Appbarcolor,
        actions: [
          Icon(Icons.notifications,color: Colors.white,),
          ],
        title: Image.asset("assets/round_logo.png", height: 50,
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
      body:
    Column(
    mainAxisAlignment: MainAxisAlignment.start,
    children: <Widget>[
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      //crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
           width: 300,
            height: 50,
            margin: EdgeInsets.only(left: 15,right: 15,top: 15),
            child: TextField(
              controller: editingController,
              keyboardType: TextInputType.text,
              cursorColor: Colors.grey,
              style:  TextStyle(color:Color(0xFF4d5060),fontFamily: 'RobotoBold') ,
              onChanged: (val){
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
                labelText: "Search Barber Community....",
                labelStyle: TextStyle(color: Color(0xffb7c2d5) ),
                border: OutlineInputBorder(),
              ),
            ),

        ),
        Container(
          margin: EdgeInsets.only(top: 10),
            child: GestureDetector(
              onTap: (){
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CreateShopFeed()));
              },
                child: Icon(Icons.add_circle,color: Color(0xff1ad37f),size: 40,)))
      ],
    ),
      Container(
        alignment: Alignment.center,
       height: 400,
        child: Text("Shop Feed",style: TextStyle(fontFamily: 'RobotoBold',fontSize: 20),),
      )
        ]
    )
    );
  }
  void _selectPage(int index) {
    setState(() {
      selectedpage = index;
      if(selectedpage==0){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BarberProfile()));

      }
      if(selectedpage==2){
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => BarberAppointmentList()));

      }
    });
  }
}