import 'dart:ui';

import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/ui/feed/friend_request_accept.dart';
import 'package:flutter/material.dart';

import '../navigationDrawer.dart';

class FriendRequest extends StatefulWidget {
  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
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
        body: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(38, 38, 38, 1),
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios)),
              ),
              title: Text('Friend\'s requests',
                  style: TextStyle(
                      fontFamily: 'RobotoBold',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              centerTitle: true,
            ),
            body: ListView.builder(
                itemCount: 10,
                itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 20),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                            'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574?b=1&k=20&m=1300972574&s=170667a&w=0&h=2nBGC7tr0kWIU8zRQ3dMg-C5JLo9H2sNUuDjQ5mlYfo='),
                                      ),
                                      Container(
                                          height: 20,
                                          width: 20,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                          ),
                                          child: Icon(
                                            Icons.cut,
                                            size: 11,
                                            color:
                                                Color.fromRGBO(79, 24, 233, 1),
                                          ))
                                    ]),
                                SizedBox(width: 15),
                                Text(
                                  'Name last',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: 'RobotoBold',
                                      color: Color.fromRGBO(71, 85, 100, 1)),
                                ),
                              ]),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {},
                                child: Text('Decline',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color.fromRGBO(223, 46, 46, 1),
                                      fontSize: 15,
                                    )),
                              ),
                              SizedBox(width: 15),
                              InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (_) => FriendRequestAccept());
                                },
                                child: Container(
                                    // width: 90,
                                    // height: 35,
                                    width: 105,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 15),
                                    decoration: BoxDecoration(
                                        color:
                                            Color.fromRGBO(106, 101, 246, 0.93),
                                        borderRadius: BorderRadius.circular(5),
                                        border: Border.all(
                                            color: Color.fromRGBO(
                                                112, 112, 112, 1))),
                                    child: Text('Accept',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ))),
                              ),
                              SizedBox(width: 20)
                            ],
                          )
                        ],
                      ),
                    )))));
  }
}
