import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/ui/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'feed/Frirnds_list.dart';

class navigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          createDrawerHeader(),
          createDrawerBodyItem(
            text: 'Profile',
            // onTap: () => //  Navigator.pushReplacementNamed(context, pageRoutes.home),
          ),
          createDrawerBodyItem(
            text: 'Shop Feed',
            //onTap: () => // Navigator.pushReplacementNamed(context, pageRoutes.profile),
          ),

          createDrawerBodyItem(
            text: 'Map',
            // onTap: () => // Navigator.pushReplacementNamed(context, pageRoutes.event),
          ),
          createDrawerBodyItem(
              text: 'Friends',
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => FriendsList()));
              }),
          // onTap: () => Navigator.pushReplacementNamed(context, pageRoutes.notification),

          createDrawerBodyItem(
            text: 'Payments',
            // onTap: () => Navigator.pushReplacementNamed(context, pageRoutes.contact),
          ),
          createDrawerBodyItem(
            text: 'Messages',
            // onTap: () => Navigator.pushReplacementNamed(context, pageRoutes.contact),
          ),
          createDrawerBodyItem(
              text: 'Settings',
              // onTap: () => Navigator.pushReplacementNamed(context, pageRoutes.contact),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingPage()));
              }),
        ],
      ),
    );
  }

  Widget createDrawerBodyItem(
      {IconData icon, String text, GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 18),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Widget createDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: Color(0xff363636),
      ),
      child: Center(
        child: Column(
          children: [
            Expanded(
              child: CircleAvatar(
                radius: 30.0,
                backgroundImage: NetworkImage(profileimg),
                backgroundColor: Colors.transparent,
              ),
            ),
            Expanded(
              child: Text(
                name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
