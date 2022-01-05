import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/ui/client_ui/update_profile.dart';
import 'package:choovoo/ui/feed/Frirnds_list.dart';
import 'package:choovoo/ui/feed/friend_request.dart';
import 'package:choovoo/ui/setting_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigationDrawer.dart';
import 'appointment_list.dart';

class ClientProfile extends StatefulWidget {
  @override
  ClientProfileState createState() => new ClientProfileState();
}

class ClientProfileState extends State<ClientProfile> {
  double _height;
  double _width;
  double _pixelRatio;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
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
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          //SizedBox(height: 10,),
          createHeader(),
          SizedBox(
            height: 20,
          ),
          Container(
            margin: EdgeInsets.only(left: 15, right: 15),
            child: Expanded(
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                children: <Widget>[
                  createDrawerBodyItem(
                      icon: Icons.message,
                      text: 'Messages',
                      // onTap: () => //  Navigator.pushReplacementNamed(context, pageRoutes.home),
                      color: Color(0xff741cb0)),
                  Divider(),
                  createDrawerBodyItem(
                      icon: Icons.favorite,
                      text: 'Friends',
                      //onTap: () => // Navigator.pushReplacementNamed(context, pageRoutes.profile),
                      color: Color(0xff14cae2),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FriendsList()));
                      }),
                  Divider(),
                  createDrawerBodyItem(
                      icon: Icons.contact_support,
                      text: 'About Choovoo App',
                      // onTap: () => // Navigator.pushReplacementNamed(context, pageRoutes.event),
                      color: Color(0xffe14490)),
                  Divider(),
                  createDrawerBodyItem(
                      icon: Icons.people,
                      text: 'Friends Request',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FriendRequest()));
                      },
                      // onTap: () => //  Navigator.pushReplacementNamed(context, pageRoutes.home),
                      color: Color(0xff2b44e7)),
                  Divider(),
                  createDrawerBodyItem(
                      icon: Icons.list,
                      text: 'My Appointments',
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AppointmentList()));
                      },
                      color: Color(0xff77b01c)),
                  Divider(),
                  createDrawerBodyItem(
                      icon: Icons.settings,
                      text: 'Settings',
                      // onTap: () => Navigator.pushReplacementNamed(context, pageRoutes.notification),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingPage()));
                      },
                      color: Color(0xff556ef7)),
                  Divider(),
                  createDrawerBodyItem(
                      icon: Icons.logout_outlined,
                      text: 'Logout',
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (_) => LogoutOverlay(),
                        );
                      },
                      // onTap: () => Navigator.pushReplacementNamed(context, pageRoutes.contact),
                      color: Color(0xffc0c4d1)),
                ],
              ),
            ),
          ),
        ])));
  }

  Widget createDrawerBodyItem(
      {IconData icon, String text, GestureTapCallback onTap, Color color}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(
            icon,
            color: color,
          ),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              text,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                  fontFamily: 'RobotoBold'),
            ),
          )
        ],
      ),
      onTap: onTap,
      trailing: Icon(
        Icons.arrow_forward_ios_outlined,
        size: 14,
      ),
    );
  }

  Widget createHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfff4f5f8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.center,
                  child: CachedNetworkImage(
                    imageUrl: profileimg,
                    placeholder: (context, url) => new Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => new Image.asset(
                      'images/profile.png',
                      height: 100,
                      width: 100,
                    ),
                    imageBuilder: (context, imageProvider) => Container(
                      width: 110.0,
                      height: 110.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: imageProvider,
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.8), BlendMode.dstATop),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              /* CircleAvatar(
                  radius: 30.0,
                  backgroundImage:
                  //NetworkImage(profileimg),
                  backgroundColor: Colors.transparent,
                ),*/

              Container(
                margin: EdgeInsets.only(left: 15),
                child: Expanded(
                  child: Text(
                    name,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'RobotoBold'),
                  ),
                ),
              ),
            ],
          ),
          Container(
              margin: EdgeInsets.only(right: 12),
              alignment: Alignment.topRight,
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen()));
                  },
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 14,
                  )))
        ]),
      ),
    );
  }
}

class LogoutOverlay extends StatefulWidget {
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
                height: 200.0,
                width: 280.0,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: AppColors.Appbarcolor))),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Text(
                        "Are You Sure You Want To Logout ?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 16.0,
                            fontFamily: 'RobotoBold'),
                      ),
                    ),
                    Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                              height: 35.0,
                              minWidth: 160.0,
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                splashColor: AppColors.Appbarcolor,
                                child: Text(
                                  'Logout',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13.0),
                                ),
                                onPressed: () async {
                                  SharedPreferences _prefs =
                                      await SharedPreferences.getInstance();
                                  _prefs.remove('name');
                                  _prefs.remove('email');
                                  _prefs.remove('user_id');
                                  _prefs.remove('mobileno');
                                  _prefs.remove('profileimg');
                                  _prefs.remove('role');
                                  _prefs.remove('password');
                                  _prefs.remove('token');
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      LOGIN, (Route<dynamic> route) => false);
                                },
                              )),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: ButtonTheme(
                                height: 35.0,
                                minWidth: 160.0,
                                child: RaisedButton(
                                  color: Colors.red,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: BorderSide(color: Colors.red)),
                                  splashColor: Colors.red,
                                  child: Text(
                                    'Cancel',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.0),
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context, rootNavigator: true)
                                          .pop('dialog');
                                    });
                                  },
                                ))),
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
