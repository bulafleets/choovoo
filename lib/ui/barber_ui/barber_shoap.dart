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

class BarberDashboard extends StatefulWidget {
  @override
  BarberDashboardState createState() => new BarberDashboardState();
}

class BarberDashboardState extends State<BarberDashboard>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;
  int selectedpage = 1;
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
            Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ],
          title: Image.asset(
            "assets/round_logo.png",
            height: 50,
            width: 50,
          ),
          centerTitle: true,
        ),
        drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Color(
                  0xff363636), //This will change the drawer background to blue.
              //other styles
            ),
            child: navigationDrawer()),
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
        body: ListView(

            // mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                //crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 300,
                    height: 50,
                    margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromRGBO(78, 114, 136, .15),
                          )
                        ]),
                    child: TextField(
                      controller: editingController,
                      keyboardType: TextInputType.text,
                      cursorColor: Colors.grey,
                      style: TextStyle(
                          color: Color(0xFF4d5060), fontFamily: 'RobotoBold'),
                      onChanged: (val) {},
                      onTap: () {},
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
                        prefixIcon: Icon(Icons.search,
                            color: Color(0xffb7c2d5), size: 20),
                        hintText: "Search Barber Community....",
                        hintStyle: TextStyle(color: Color(0xffb7c2d5)),
                        // contentPadding: const EdgeInsets.all(20),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 10),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CreateShopFeed()));
                          },
                          child: Icon(
                            Icons.add_circle,
                            color: Color(0xff1ad37f),
                            size: 40,
                          )))
                ],
              ),
              // Container(
              //   alignment: Alignment.center,
              //  height: 400,
              //   child: Text("Shop Feed",style: TextStyle(fontFamily: 'RobotoBold',fontSize: 20),),
              // )
              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedDetails()));
                },
                child: Card(
                    child: Column(children: [
                  ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BarberProfileForFeed()));
                      },
                      leading: CircleAvatar(),
                      title: Text('Profile Name',
                          style: TextStyle(
                              color: Color.fromRGBO(39, 159, 178, 1),
                              fontWeight: FontWeight.bold)),
                      subtitle: Text('time')),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      'some description about feed and post',
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(98, 125, 129, 1)),
                    ),
                  ),
                  Container(
                      color: Theme.of(context).primaryColor,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://st2.depositphotos.com/2931363/9695/i/950/depositphotos_96952028-stock-photo-young-handsome-man-in-barbershop.jpg',
                        errorWidget: (context, url, error) =>
                            Icon(Icons.broken_image),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        fit: BoxFit.cover,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Colors.grey[350])),
                                  child: Icon(Icons.thumb_up,
                                      color: Colors.grey[350])),
                              SizedBox(width: 10),
                              Text(
                                '24.6K Likes',
                                style: TextStyle(color: Colors.grey[350]),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                      Icon(Icons.thumb_up, color: Colors.blue)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.chat_rounded,
                                      color: Colors.grey)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.share, color: Colors.grey)),
                            ],
                          )
                        ],
                      ))
                ])),
              ),

              InkWell(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => FeedDetails()));
                },
                child: Card(
                    child: Column(children: [
                  ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ClientProfileForFeed()));
                      },
                      leading: CircleAvatar(),
                      title: Text('Profile Name',
                          style: TextStyle(
                            color: Color.fromRGBO(39, 159, 178, 1),
                            fontWeight: FontWeight.bold,
                          )),
                      subtitle: Text('time')),
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(7.0),
                    child: Text(
                      'some description about feed and post',
                      overflow: TextOverflow.visible,
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Color.fromRGBO(98, 125, 129, 1)),
                    ),
                  ),
                  Container(
                      color: Theme.of(context).primaryColor,
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://st2.depositphotos.com/2931363/9695/i/950/depositphotos_96952028-stock-photo-young-handsome-man-in-barbershop.jpg',
                        errorWidget: (context, url, error) =>
                            Icon(Icons.broken_image),
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height / 4,
                        fit: BoxFit.cover,
                      )),
                  Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                  padding: const EdgeInsets.all(5),
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border:
                                          Border.all(color: Colors.grey[350])),
                                  child: Icon(Icons.thumb_up,
                                      color: Colors.grey[350])),
                              SizedBox(width: 10),
                              Text(
                                '24.6K Likes',
                                style: TextStyle(color: Colors.grey[350]),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () {},
                                  icon:
                                      Icon(Icons.thumb_up, color: Colors.blue)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.chat_rounded,
                                      color: Colors.grey)),
                              IconButton(
                                  onPressed: () {},
                                  icon: Icon(Icons.share, color: Colors.grey)),
                            ],
                          )
                        ],
                      ))
                ])),
              ),
            ]));
  }

  void _selectPage(int index) {
    setState(() {
      selectedpage = index;
      if (selectedpage == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BarberProfile()));
      }
      if (selectedpage == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BarberAppointmentList()));
      }
    });
  }
}
