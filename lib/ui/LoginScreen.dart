
import 'dart:convert';

import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/ui/otp_screen.dart';
import 'package:choovoo/ui/profile_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isObscureText = true;
  bool checkBoxValue = false;
   double _height;
   double _width;
   double _pixelRatio;
   bool _large;
   bool _medium;
  bool isalldone=false;
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmcontroll = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String fcmtoken="";
  @override
  void initState() {
    // TODO: implement initState

    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(
            sound: true, badge: true, alert: true, provisional: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      setState(() {
        fcmtoken = token;
      });
      print(fcmtoken);
    });
    super.initState();
  }
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
            'assets/loginbackground.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Container(
              //alignment: Alignment.center,
              height: _height,
              width: _width,
              margin: EdgeInsets.only(bottom: 5),
                child: SingleChildScrollView(
    child:  Column(
      //mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: 80,),
                    Container(
                      height: _height / 5.5,
                      alignment: Alignment.center,

                      child: Image.asset(
                        'images/signup_logo.png',
                        height: _height/2.5,
                        width: _width/2.5,
                      ),
                    ),
                    SizedBox(height: _height/25,),
                    signInTextRow(),
                    form(),
                    forgotTextRow(),
                    // acceptTermsTextRow(),
                    SizedBox(height: 50,),
                    nextbutton(),
                    SizedBox(height: 10,),
                    signUpTextRow(),
                    SizedBox(height: 50,),
                       Column(
                         mainAxisAlignment: MainAxisAlignment.end,
                         children: [
                           Text("Sign In With Social Media",style:
                           TextStyle(color: Colors.white,fontSize:16,fontFamily: 'RobotoBold'),),
                           SizedBox(height: 20,),
                           socialmedia()
                         ],
                       ),


                    //SizedBox(height: _height/25,),


                    //signInTextRow(),
                  ],
                ),
              ),
            ),
          ),
        ]
    );
  }

  Widget signInTextRow() {
    return Container(
      margin: EdgeInsets.only(left: _width / 8.0),
      child: Row(
        children: <Widget>[
          Text(
            "Sign in",
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'RobotoBold',
              fontWeight: FontWeight.w400,
              fontSize: _large? 20 : (_medium? 17.5 : 15),
            ),
          ),
        ],
      ),
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left:_width/ 12.0,
          right: _width / 12.0,
          top: 5),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            // firstNameTextFormField(),
            //SizedBox(height: _height/ 60.0),
            emaildInputField(),
            /*SizedBox(height: _height / 60.0),
            phoneTextFormField(),*/
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
           // SizedBox(height: _height / 60.0),

          ],
        ),
      ),
    );
  }


  Widget firstNameTextFormField() {
    return TextFormField(
      validator:RequiredValidator(errorText: "Please Enter Your Name."),
      controller: nameController,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person, color: Colors.grey, size: 20),
        labelText: "Name",
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget emaildInputField() {
    return  TextFormField(
      validator:emailValidator,
      controller: emailController,
      inputFormatters: [
        LengthLimitingTextInputFormatter(25),
      ],
      keyboardType: TextInputType.emailAddress,
      cursorColor: Colors.grey,
      style:  TextStyle(color:Colors.white) ,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF83784d)),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF83784d)),
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.person, color: Colors.white, size: 20),
        labelText: "Email",
        labelStyle: TextStyle(color:Colors.white ),
        border: OutlineInputBorder(),
      ),

    );
  }

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Please Enter Email ID'),
    EmailValidator( errorText: 'Please Enter Valid Email ID'),
  ]);

  Widget passwordTextFormField() {
    return TextFormField(
      style:  TextStyle(color:Colors.white) ,
      validator:(val){
      if(val.isEmpty)
        return 'Please Enter Password';
      if(val.length<8)
        return 'Please enter Minimum 8 char Password';
      return null;
    },
      controller: passwordController,
      keyboardType: TextInputType.text,
      obscureText:  isObscureText,
      cursorColor: Colors.grey,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            isObscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              isObscureText = !isObscureText;
            });
          },
        ),

        filled: true,
        fillColor: Colors.white.withOpacity(0.3),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF83784d)),
          borderRadius: BorderRadius.circular(30),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xFF83784d)),
          borderRadius: BorderRadius.circular(30),
        ),
        prefixIcon: Icon(Icons.lock, color: Colors.white, size: 20),
        labelText: "Password",
        labelStyle: TextStyle(color:Colors.white ),
        border: OutlineInputBorder(),
      ),
    );
  }


  Widget forgotTextRow() {
    return Container(
      margin: EdgeInsets.only(top: 10, left:_width/ 8.0,
        right: _width / 12.0,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[

          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(FORGOTPASS);
              // print("Routing to Sign up screen");
            },
            child: Text(
              "Forgot Your Password?",
              style: TextStyle(
                   color: Colors.white, fontSize: 14,fontFamily: 'RobotoRegular', decoration: TextDecoration.underline,),
            ),
          )
        ],
      ),
    );
  }

  Widget signUpTextRow() {
    return Container(
      margin: EdgeInsets.only(top: 10, left:_width/ 8.0,
        right: _width / 12.0,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[


             Text(
              "Don't have an account? ",
              style: TextStyle(
                color: Colors.white, fontSize: 14,fontFamily: 'RobotoRegular'),
            ),

      GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(SIGNUP);
          // print("Routing to Sign up screen");
        },
        child:  Text(
            "Signup here",
            style: TextStyle(
              color: Colors.white, fontSize: 14,fontFamily: 'RobotoRegular', decoration: TextDecoration.underline,),
          ),
      )
        ],
      ),
    );
  }

  Widget socialmedia() {
    return Container(
      margin: EdgeInsets.only( left:40,
        right: 40,),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: new Image.asset('images/fb.png',height: 18,width: 18,),
                ),
                TextSpan(
                  text: " FACEBOOK ", style: TextStyle(fontFamily: 'RobotoRegular',fontSize: 14)
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: new Image.asset('images/twitter.png',height: 18,width: 18,),
                ),
                TextSpan(
                    text: " TWITTER ",style: TextStyle(fontFamily: 'RobotoRegular',fontSize: 14)
                ),
              ],
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                WidgetSpan(
                  child: new Image.asset('images/google.png',height: 18,width: 18,),
                ),
                TextSpan(
                    text: " GOOGLE ",style: TextStyle(fontFamily: 'RobotoRegular',fontSize: 14)
                ),
              ],
            ),
          )
        ],
      ),
    );
  }



  Widget nextbutton(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary:Color(0xFFd92222),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onPressed: () {

          if (_formkey.currentState.validate()) {
            EasyLoading.show(status: 'Please Wait ...');
            LoginUser();
           /* Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ProfileScreen()));*/
            //CircularProgressIndicator();
           // EasyLoading.show(status: 'Please Wait ...');

            //print("Routing to your account");
          }
        },
        child: Text(
          "SIGN IN",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'RobotoBold'),
        ),
      ),
    );
  }


  Future<void> LoginUser() async {
    final response = await http.post(Uri.parse(URL_Login),
      body:{
        'username': emailController.text,
        'password': passwordController.text,
        'firebase_token': fcmtoken,
      },
    );
    print(fcmtoken);
    EasyLoading.dismiss();
    String data = response.body;
    String status = jsonDecode(data)['status'].toString();
    print(data);

    if (status == 'true') {
       authorization = jsonDecode(data)['accessToken'];
      String userdata = jsonDecode(data)['user'].toString();
      name=jsonDecode(data)['user']['name'];
      email=jsonDecode(data)['user']['email'];
      phoneno=jsonDecode(data)['user']['mobile_number'];
      user_id=jsonDecode(data)['user']['_id'].toString();
      AccountType=jsonDecode(data)['user']['role'];
      String isshop=jsonDecode(data)['user']['isShop'].toString();
      profileimg=jsonDecode(data)['user']['avatar'].toString();
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('name', name);
      _prefs.setString('email', email);
      _prefs.setString('user_id', user_id);
      _prefs.setString('mobileno', phoneno);
      _prefs.setString('profileimg', profileimg);
      _prefs.setString('role', AccountType);
      _prefs.setString('password',"");
      _prefs.setString('token', authorization);
      if(isshop=="true"){
        _prefs.setString('shoap_added', "done");
      }
      Navigator.of(context).pushNamedAndRemoveUntil(FINAL_GET_START,(Route<dynamic> route) => false);

    }
    else if (status == '400') {
      String message = jsonDecode(data)['message'];
      EasyLoading.showToast(message);
    }
    else{
      EasyLoading.showToast("Something Happen Wrong");
    }
  }

}
