import 'package:choovoo/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'navigationDrawer.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  var isToggled = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.Appbarcolor,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
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
            foregroundColor: Color.fromRGBO(128, 147, 170, 1),
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            title: Text('Settings',
                style: TextStyle(
                    fontFamily: 'RobotoBold',
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(128, 147, 170, 1),
                    fontSize: 18)),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: ListView(
              children: [
                // SizedBox(height: 10),
                ListTile(
                  horizontalTitleGap: 1,
                  onTap: () {},
                  leading: Icon(Icons.notifications,
                      color: Color.fromRGBO(176, 28, 151, 1)),
                  title: Text('Notification'),
                  trailing: Container(
                    height: 50,
                    width: 40,
                    child: FlutterSwitch(
                      height: 20.0,
                      width: 40.0,
                      padding: 4.0,
                      toggleSize: 15.0,
                      borderRadius: 10.0,
                      activeColor: Color.fromRGBO(176, 28, 151, 1),
                      inactiveText: 'off',
                      activeText: 'on',
                      activeTextColor: Colors.black,
                      value: isToggled,
                      onToggle: (value) {
                        setState(() {
                          isToggled = value;
                        });
                      },
                    ),
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 1,
                  onTap: () {},
                  leading:
                      Icon(Icons.lock, color: Color.fromRGBO(176, 28, 151, 1)),
                  title: Text('Change Password'),
                ),
                ListTile(
                  horizontalTitleGap: 1,
                  onTap: () {},
                  leading:
                      Icon(Icons.info, color: Color.fromRGBO(176, 28, 151, 1)),
                  title: Text('About Us'),
                ),
                ListTile(
                  horizontalTitleGap: 1,
                  onTap: () {},
                  leading: Icon(Icons.privacy_tip_sharp,
                      color: Color.fromRGBO(176, 28, 151, 1)),
                  title: Text('Privacy Policy'),
                )
              ],
            ),
          ),
        ));
  }
}
