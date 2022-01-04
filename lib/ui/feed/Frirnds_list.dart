import 'dart:ui';

import 'package:choovoo/constants/colors.dart';
import 'package:flutter/material.dart';

import 'navigationDrawer.dart';

class FriendsList extends StatefulWidget {
  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
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
      body: ListView(
        children: [
          skipText(),
          ListTile(
              leading: CircleAvatar(),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Name lastname',
                    style: TextStyle(fontFamily: 'RobotoBold', fontSize: 18),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        // width: 90,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Text('Unfriend',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey))),
                  ),
                ],
              ),
              trailing: IconButton(
                  onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))),
        ],
      ),
    );
  }

  Widget skipText() {
    return Container(
      height: 80,
      alignment: Alignment.topCenter,
      color: Color.fromRGBO(38, 38, 38, 1),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 18,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //
              Text("166 Friends",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
              Text("",
                  style: TextStyle(
                      color: Color(0xff3e5c7e),
                      fontSize: 18,
                      fontWeight: FontWeight.w600)),
            ],
          ),
        ],
      ),
    );
  }
}
