
import 'dart:convert';
import 'dart:ui';

import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/ui/set_password_otp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:http/http.dart' as http;

class ForgotScreen extends StatefulWidget {
  @override
  _ForgotScreenState createState() => _ForgotScreenState();
}

class _ForgotScreenState extends State<ForgotScreen> {
  bool isObscureText = true;
  bool checkBoxValue = false;
   double _height;
   double _width;
   double _pixelRatio;
   bool _large;
   bool _medium;
  bool isalldone=false;
  TextEditingController emailController = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey();
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
  }
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
            floatingActionButton: keyboardIsOpened ?
            null :nextbutton(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("Forgot Password",style: TextStyle(color: Colors.white,fontFamily: 'RobotoBold'),),
              centerTitle: true,
            ),
            body: Container(
              height: _height,
              width: _width,
              margin: EdgeInsets.only(bottom: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    SizedBox(height: _height/25,),
                    Container(

                      height: _height / 5.5,
                      alignment: Alignment.center,

                      child: Image.asset(
                        'images/fpassword.png',
                        height: _height/2.5,
                        width: _width/2.5,
                      ),

                    ),
                    SizedBox(height: _height/25,),
                    form(),
                    // acceptTermsTextRow(),
                    SizedBox(height: _height/25,),
                   // nextbutton()

                    //signInTextRow(),
                  ],
                ),
              ),
            ),
          ),
        ]
    );
  }



  Widget form() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          left:40,
          right: 40,
          top: _height / 20.0),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            // firstNameTextFormField(),
            //SizedBox(height: _height/ 60.0),
            emaildInputField(),
           /* SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
            SizedBox(height: _height / 60.0),
            confirmpasswordTextFormField(),*/
          ],
        ),
      ),
    );
  }



  Widget emaildInputField() {
    return  Container(
      height: 100,
      child: TextFormField(
        validator:emailValidator,
        controller: emailController,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Colors.grey,
        style:  TextStyle(color:Colors.white) ,
        onChanged: (val){

         setState(() {
           if(val.length==0){
             isalldone = false;
           }
           else {
             isalldone = true;
           }
         });
        },
        decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFF44405a),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF44405a)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFF44405a)),
            borderRadius: BorderRadius.circular(8),
          ),
          prefixIcon: Icon(Icons.email, color: Colors.grey, size: 20),
          labelText: "Enter Email Address",
          labelStyle: TextStyle(color:Color(0xFFb6b3c6).withOpacity(0.8),fontFamily: 'RobotoBold' ),
          border: OutlineInputBorder(),
        ),

      ),
    );
  }

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Please Enter Email ID'),
    EmailValidator( errorText: 'Please Enter Valid Email ID'),
  ]);





  Widget nextbutton(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary:isalldone?Color(0xFF0ebb8e):Color(0xFF51506a),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onPressed: () {

          if (_formkey.currentState.validate()) {
            showDialog(
              context: context,
              builder: (_) => LogoutOverlay(email: emailController.text),
            );
          //  EasyLoading.show(status: 'Please Wait ...');
            //sendRESENT();
            //CircularProgressIndicator();
          //  EasyLoading.show(status: 'Please Wait ...');

            //print("Routing to your account");
          }
        },
        child: Text(
          "Next",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: 'RobotoBold'),
        ),
      ),
    );
  }


  Future<void> sendRESENT() async {

    final response = await http.post( Uri.parse(URL_ResetPassword),
      body: {
        'username': emailController.text,
      },
    );
   // print(URL_OTP+widget.emailid);

    String data = response.body;
    print(data);
    String status = jsonDecode(data)['status'].toString();

     EasyLoading.dismiss();
    if (status == "200") {
      String message = jsonDecode(data)['message'];
     // EasyLoading.showToast(message);
      showDialog(
        context: context,
        builder: (_) => LogoutOverlay(email: emailController.text),
      );
     // Navigator.of(context).pushReplacementNamed(LOGIN);
    }
    if(status=="400"){
      String   message = jsonDecode(data)['message'];
      EasyLoading.showToast(message);
    }
  }

  }
class LogoutOverlay extends StatefulWidget {
  final String email;
  LogoutOverlay({ Key key, this.email}) : super(key: key);

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
                height: 230.0,
                width: 350.0,
                decoration: ShapeDecoration(
                    color: Color(0xff131331),
                    shadows: [
                      BoxShadow(
                        color: Colors.white.withOpacity(0.1),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(color: Color(0xff131331)))),
                child: Column(
  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                   Icon(Icons.verified, size:40,color: Color(0xFF05a98f)),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 10.0, left: 20.0, right: 20.0, bottom: 10.0),
                      child: Text(
                        "A 4 Digit OTP Sent to "+widget.email+". kindly check your email inbox.",
                        style: TextStyle(color: Colors.white,
                            fontFamily: 'RobotoBold',
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                              height: 45.0,
                              minWidth: 130.0,
                              child: RaisedButton(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                splashColor: Colors.white,
                                child: Text(
                                  'Ok',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'RobotoBold',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0),
                                ),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop('dialog');
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => SetPasswordOTP(email: widget.email,)));

                                },
                              )),
                        ),

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
