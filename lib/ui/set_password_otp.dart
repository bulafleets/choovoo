
import 'dart:async';
import 'dart:convert';

import 'package:argon_buttons_flutter/argon_buttons_flutter.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/ui/profile_screen.dart';
import 'package:choovoo/ui/set_newpassword.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:http/http.dart' as http;

class SetPasswordOTP extends StatefulWidget {
  final String email;

  static const String routeName = 'CustomOtpScreenInForgetPass';
  SetPasswordOTP({ Key key,this.email}) : super(key: key);
  @override
  _SetPasswordOTPState createState() => _SetPasswordOTPState();
}

class _SetPasswordOTPState extends State<SetPasswordOTP> {
  GlobalKey<FormState> _formkey = GlobalKey();
  String OTP="";
  TextEditingController otpcontroller = TextEditingController();
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  Timer _timer;
  int _start = 25;
  bool isselect=false;
  bool isverify=false;
  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            _start--;
          });
        }
      },
    );
  }
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
  @override
  void initState() {
    // TODO: implement initState
    sendOTP();
    startTimer();
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
            'assets/background.png',
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            fit: BoxFit.cover,
          ),
          Scaffold(
            floatingActionButton: isselect?verifyRow():Container(),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: AppColors.primaryColor,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.of(context).pop(),
              ),
              title: Text("OTP Verification",style: TextStyle(color: Colors.white,fontFamily: 'RobotoBold'),),
              centerTitle: true,
            ),
            body: Container(
              alignment: Alignment.center,
              height: _height,
              width: _width,
              margin: EdgeInsets.only(bottom: 5),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[

                    signInTextRow(),
                    form(),
                    ResendText(),
                    // acceptTermsTextRow(),
                    SizedBox(height: _height/25,),
                    //nextbutton(),
                    SizedBox(height: _height/25,),
                    // signUpTextRow()

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
      alignment: Alignment.center,
      //margin: EdgeInsets.only(left: _width / 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Please enter the verification code",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontFamily: 'RobotoBold',
              fontSize: 16,
            ),
          ),
          Text(
            "sent to "+widget.email,
            style: TextStyle(
              fontFamily: 'RobotoBold',
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize:16,
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
          top: _height / 40.0),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            // firstNameTextFormField(),
            //SizedBox(height: _height/ 60.0),
            OtpPinField(),
            /*SizedBox(height: _height / 60.0),
            phoneTextFormField(),*/
            //SizedBox(height: _height / 60.0),
            // passwordTextFormField(),
            //SizedBox(height: _height / 60.0),

          ],
        ),
      ),
    );
  }
  Widget OtpPinField() {
    return PinCodeTextField(
      length: 4,
      obscureText: false,
      keyboardType: TextInputType.phone,
      animationType: AnimationType.fade,
      validator: (val){
        if(val.isEmpty)
          return 'Please Enter OTP';
        if(val != OTP)
          return 'OTP IS Not Correct';
        return null;
      },
      textStyle: TextStyle(color: Colors.white),
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 80,
        fieldWidth: 60,
        activeFillColor: Color(0xFF44405a),
        selectedColor: Color(0xFF44405a),
        selectedFillColor: Color(0xFF44405a),
        inactiveColor: Color(0xFF44405a),
        disabledColor: Color(0xFF44405a),
        inactiveFillColor: Color(0xFF44405a),
        errorBorderColor: Color(0xFF44405a),
      ),
      animationDuration: Duration(milliseconds: 300),
      // backgroundColor: Colors.blue.shade50,
      enableActiveFill: true,
      //errorAnimationController: errorController,
      controller: otpcontroller,
      onCompleted: (v) {
        _timer.cancel();
        setState(() {
          if(v==OTP) {
            isselect = true;
            isverify = true;
          }
        });
        print(otpcontroller.text);
      },
      onChanged: (value) {
        setState(() {
          if(value.length<4){
            isselect=false;
          }
        });
      },
      beforeTextPaste: (text) {
        print("Allowing to paste $text");
        //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
        //but you can show anything you want here, like your pop up saying wrong paste format or etc
        return true;
      }, appContext: context,
    );
  }

  Widget ResendText() {
    return Container(
      alignment: Alignment.center,
      //margin: EdgeInsets.only(left: _width / 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              if(_start==0){
                sendOTP();
                setState(() {
                  _start = 25;
                  startTimer();
                });

              }
            },
            child: Text(
              _start==0?"RESEND OTP":"Wait | "+_start.toString(),
              style: TextStyle(
                color: Color(0xFF05a98f),
                fontFamily: 'RobotoBold',
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
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
          primary:isselect?Color(0xFF1890d8):Color(0xFF51506a),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onPressed: () {
          if(_formkey.currentState.validate()) {
            _timer.cancel();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                SetPassword(email: widget.email,)));
          };
        },
        child: Text(
          "Next",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'RobotoBold'),
        ),
      ),
    );
  }
  Widget verifyRow() {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[

          SizedBox(height: 15,),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                    text: "Verified ",style: TextStyle(color: Color(0xFF05a98f),fontSize: 16,fontWeight: FontWeight.w400,fontFamily: 'RobotoBold')
                ),
                WidgetSpan(
                  child: Icon(Icons.verified_user_outlined, size: 18,color: Color(0xFF05a98f),),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
          nextbutton()
        ],
      ),
    );
  }
  Future<void> sendOTP() async {

    final response = await http.post( Uri.parse(URL_ResetPassword),
      body: {
        'username': widget.email,
      },
    );
    print(URL_OTP+widget.email);

    String data = response.body;
    print(data);
    String status = jsonDecode(data)['status'].toString();

    // EasyLoading.dismiss();
    if (status == "200") {
      OTP = jsonDecode(data)['otp'];
      // Navigator.of(context).pushNamed(OTP_SCREEN);
    }
    if(status=="400"){
      String   message = jsonDecode(data)['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}



