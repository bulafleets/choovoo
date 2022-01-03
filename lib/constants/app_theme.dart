
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';


class AppThemes {
  AppThemes._(); // this basically makes it so you can instantiate this class


  static final CupertinoThemeData iosthemeData = new CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.white,

  );


  static final kTitleStyle = TextStyle(
    color: Color(0xFF767f9b),
    fontSize: 16.0,
    fontFamily: 'RobotoBold',
    height: 1.5,
  );

  static final kSubtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    height: 1.2,
  );



}


