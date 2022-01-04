import 'package:choovoo/constants/colors.dart';
import 'package:flutter/material.dart';

import '../navigationDrawer.dart';

class ClientProfileForFeed extends StatelessWidget {
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
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
              centerTitle: true,
              title: Text('Profile',
                  style: TextStyle(
                      color: Color.fromRGBO(4, 33, 77, 1),
                      fontWeight: FontWeight.bold))),
          body: Center(
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(radius: 70),
                SizedBox(height: 12),
                Text('Robert Jr',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.blue)),
                SizedBox(height: 15),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                        width: 90,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Text('Unfriend',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.grey))),
                  ),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        width: 90,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                            color: Colors.blue),
                        child: Text('Message',
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.white))),
                  ),
                ])
              ],
            ),
          ),
        ));
  }
}
