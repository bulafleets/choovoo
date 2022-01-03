import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/ui/add_fullshoap_info.dart';
import 'package:choovoo/ui/barber_ui/get_shoap_bygoogle.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddShoap extends StatefulWidget {

  @override
  _AddShoapState createState() => _AddShoapState();
}

class _AddShoapState extends State<AddShoap> {
   double _height;
   double _width;
   double _pixelRatio;
   bool _large;
   bool _medium;
  TextEditingController namecontroll = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
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
          /*floatingActionButton: keyboardIsOpened ?
          null :nextbutton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/
          backgroundColor: Colors.transparent,

          body: Container(
            height: _height,
            width: _width,
            margin: EdgeInsets.only(bottom: 5),
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 50,
                  ),
                  skipText(),
                  SizedBox(
                    height: 30,
                  ),
                  topText(),
                  SizedBox(height: _height/15,),
                   nextbutton(),
                  SizedBox(
                    height: 30,
                  ),
                  orText(),
                  SizedBox(
                    height: 30,
                  ),
                  alreadyshoap(),
                  // acceptTermsTextRow(),
                  SizedBox(height: _height/25,),
                  //nextbutton()

                  //signInTextRow(),
                ],
              ),
            ),
          ),
        ),
      ]
    );
  }
  Widget skipText() {
    return Container(
      alignment: Alignment.topRight,
      margin: EdgeInsets.only(top: _width / 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
          onTap: () async {
            SharedPreferences _prefs = await SharedPreferences.getInstance();
            _prefs.setString('shoap_added', "done");
            Navigator.of(context).pushNamedAndRemoveUntil(BARBER_DASHBOARD,(Route<dynamic> route) => false);
            // Navigator.of(context).pushNamed(FORGOTPASS);
    // print("Routing to Sign up screen");
    },
         child: Container(
            width: 50,
            child: Text(
              "SKIP",
              style: TextStyle(
                fontFamily: 'RobotoBold',
                color: Colors.white,
                fontWeight: FontWeight.w400,
                fontSize: _large? 16 : (_medium? 14.5 : 12),
              ),
            ),
          ),
          ),
        ],
      ),
    );
  }
  Widget topText() {
    return Container(
      alignment: Alignment.center,
        margin: EdgeInsets.only(top: _width / 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Profile Details",
            style: TextStyle(
              fontFamily: 'MontserratBold',
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            "CHOOVOO needs to know what shop ",
            style: TextStyle(
              fontFamily: 'RobotoBold',
              color: Color(0xFF88a5d8),
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
          ),
          Text(
            "you're currently working at.",
            style: TextStyle(
              fontFamily: 'RobotoBold',
              color: Color(0xFF88a5d8),
              fontWeight: FontWeight.w200,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

   Widget orText() {
     return Container(
       margin: EdgeInsets.only(left: 30.0,right: 30.0),
       alignment: Alignment.center,
       child:  Row(
             children: <Widget>[
               Expanded(
                   child: Divider(color: Color(0xFF908fb1),height: 1, indent: 20,endIndent: 20,),
               ),

               Text("OR",style: TextStyle(color: Colors.white),),

               Expanded(
                   child:  Divider(color: Color(0xFF908fb1),height: 1, indent: 20,endIndent: 20,),
               ),
             ]
         )
     );
   }






  Widget nextbutton(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,

      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary:Color(0xFF373436),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AddFullShoapInfo(shoapname: "",shoaplat: "",shoaplng: "",shoapaddess: "",)));
           // EasyLoading.show(status: 'Please Wait ...');
           // RegisterUser();


        },
        child: Text(
          "Add Shop Name",style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'RobotoBold'),
        ),
      ),
    );
  }
   Widget alreadyshoap(){
     return Container(
       width: MediaQuery.of(context).size.width,
       height: 60,

       padding: EdgeInsets.symmetric(horizontal: 16),
       child: ElevatedButton(
         style: ElevatedButton.styleFrom(
           onPrimary: Colors.white,
           primary:Color(0xFF373436),
           minimumSize: Size(88, 36),
           padding: EdgeInsets.symmetric(horizontal: 16),
           shape: const RoundedRectangleBorder(
             borderRadius: BorderRadius.all(Radius.circular(30)),
           ),
         ),
         onPressed: () {

           Navigator.push(
               context,
               MaterialPageRoute(
                   builder: (context) => GetShoapGoogle()));


         },
         child: Text(
           "Already have a shop",style: TextStyle(color: Colors.white,fontSize: 14,fontFamily: 'RobotoBold'),
         ),
       ),
     );
   }
}