import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/ui/LoginScreen.dart';
import 'package:choovoo/ui/add_shoap.dart';
import 'package:choovoo/ui/barber_ui/barber_shoap.dart';
import 'package:choovoo/ui/client_ui/client_dashboard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Signup_screen.dart';

class FinalGetStart extends StatefulWidget {
  @override
  FinalGetStartState createState() => new FinalGetStartState();
}

class FinalGetStartState extends State<FinalGetStart>{
   double _height;
   double _width;
   double _pixelRatio;
   bool _large;
   bool _medium;
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
    primary:Color(0xFF0ebb8e),
    minimumSize: Size(88, 36),
    padding: EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(26)),
    ),
  );
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Stack(
      children: [
        Image.asset(
          'assets/background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
           /* leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),*/
            title: Text("Welcome, "+name,style: TextStyle(color: Colors.white,fontFamily: 'RobotoBold'),),
            centerTitle: true,
          ),
          body: Container(

            height: _height,
            width: _width,

            child: Column(
             mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.only(top: 100.0),
                  height: _height / 4.5,
                  alignment: Alignment.center,

                  child: Image.asset(
                    'assets/logo.png',
                    height: _height/2.0,
                    width: _width/2.0,
                  ),      ),
                SizedBox(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.bottomCenter,
                  width: MediaQuery.of(context).size.width,
                  height: 250,

                  decoration: new BoxDecoration(
                    color: Color(0xff182748),
                    borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(40.0),
                      topRight: const Radius.circular(40.0),
                    ),
                  ),
                  child: Column(
                    children: [

                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        //margin: const EdgeInsets.only(left: 50.0, right: 50.0),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text("Welcome to",style: TextStyle(color: Colors.white,fontSize: 12,fontFamily: 'RobotoRegular'))
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          //margin: const EdgeInsets.only(left: 50.0, right: 50.0),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text("CHOOVOO",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600,fontFamily: 'Montserrat'))
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                          alignment: Alignment.center,
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                         // padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text("Choovoo is lorem ipsum dncj njncj jdnzjdnjez ndjzndjz dnzjndzj zdjzdjz ndjzndjz jncjncje cjcnje",style: TextStyle(color: Colors.white,fontFamily: 'RobotoRegular',),textAlign: TextAlign.center,)
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        margin: const EdgeInsets.only(left: 50.0, right: 50.0),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: ElevatedButton(
                          style: getstyle,
                          child: new Text("GET STARTED ",style: TextStyle(color: Colors.white,fontFamily: 'RobotoBold')),
                          onPressed: () async {
                            if(AccountType=="BARBER") {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool CheckValue = _prefs.containsKey('shoap_added');
    print(CheckValue);
    if(CheckValue) {
      Navigator.of(context).pushNamedAndRemoveUntil(BARBER_DASHBOARD,(Route<dynamic> route) => false);

    }
    else {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => AddShoap()), (route) => false);
    }
                            }
                            else{
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ClientHome()), (
                                  route) => false);
                            }
                          },
                        ),
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