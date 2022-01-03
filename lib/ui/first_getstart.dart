import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/ui/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Signup_screen.dart';

class FirstGetStart extends StatefulWidget {
  @override
  FirstGetStartState createState() => new FirstGetStartState();
}

class FirstGetStartState extends State<FirstGetStart>{
  final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary: AppColors.primaryColor,
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
  );

  final ButtonStyle getstyle = ElevatedButton.styleFrom(
    onPrimary: Colors.white,
    primary:Color(0xFF00A379),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(26)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/splash_02_bg.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height - 200,
                  child: Text("",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 40),
                      textAlign: TextAlign.center),
                  // child: Text("What would would you like to do?",
                  //     style: Theme.of(context).textTheme.headline5,
                  //     textAlign: TextAlign.center),
                ),
                Container(

                  width: MediaQuery.of(context).size.width,

                  decoration: new BoxDecoration(
                    color: Color(0xff202122),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    ),
    ),
                  child: Column(
                    children: [

                      SizedBox(
                        height: 30,
                      ),

                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 60,

                        margin: const EdgeInsets.only(left: 50.0, right: 50.0),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          style: getstyle,

                          child: new Text("GET STARTED ",style: TextStyle(color: Colors.white,fontFamily: "RobotoBold")),
                          /*shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(16)),
                          ),*/

                        /*  borderSide: BorderSide(
                            color:Color(0xFF0ebb8e),
                          ),*/
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpScreen()));
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        width: MediaQuery.of(context).size.width,
                         alignment: Alignment.center,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child:GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Log in",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "RobotoBold")),
                        ),

                          /*ElevatedButton(
                          style: raisedButtonStyle,
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoginScreen()));
                          },
                          child: Text(
                            "Log in",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "RobotoBold"),
                          ),
                        ),*/
                      ),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
  
}