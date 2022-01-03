
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:http/http.dart' as http;

import 'otp_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isObscureText = true;
  bool iscObscureText = true;
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
  @override
  void initState() {
    // TODO: implement initState

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
         backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Sign Up",style: TextStyle(color: Colors.white,fontFamily: "RobotoBold"),),
          centerTitle: true,
        ),
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: _height / 5.5,
                  alignment: Alignment.center,

                  child: Image.asset(
                    'images/signup_logo.png',
                    height: _height/3.5,
                    width: _width/3.5,
                  ),      ),
                form(),
                // acceptTermsTextRow(),
                SizedBox(height: _height/15,),
               nextbutton(),
                SizedBox(height: 20,),
                signUpTextRow()

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
      margin: EdgeInsets.only(
          left:_width/ 12.0,
          right: _width / 12.0,
          top: _height / 20.0),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
           // firstNameTextFormField(),
           //SizedBox(height: _height/ 60.0),
            emaildInputField(),
            SizedBox(height: _height / 60.0),
            phoneTextFormField(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
            SizedBox(height: _height / 60.0),
            confirmpasswordTextFormField(),
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
      onChanged: (val){
        setState(() {
          print(mobilenumberController.text);
          if(emailController.text.isNotEmpty&&mobilenumberController.text.isNotEmpty&&passwordController.text.isNotEmpty&&confirmcontroll.text.isNotEmpty){
            isalldone=true;
          }
          else{
            isalldone=false;
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
        labelText: "Email ID",
        labelStyle: TextStyle(color:Color(0xFFb6b3c6).withOpacity(0.8),fontFamily: 'RobotoRegular' ),
        border: OutlineInputBorder(),
      ),

    );
  }

  final emailValidator = MultiValidator([
    RequiredValidator(errorText: 'Please Enter Email ID'),
    EmailValidator( errorText: 'Please Enter Valid Email ID'),
  ]);
  Widget phoneTextFormField() {
    return  TextFormField(
      style:  TextStyle(color:Colors.white) ,
      validator:RequiredValidator(errorText: "Please Enter Your Mobile Number."),
      controller: mobilenumberController,
      keyboardType: TextInputType.phone,
      cursorColor: Colors.grey,
      inputFormatters: [
        LengthLimitingTextInputFormatter(10),
      ],
      onChanged: (val){
        setState(() {
          if(emailController.text.isNotEmpty&&mobilenumberController.text.isNotEmpty&&passwordController.text.isNotEmpty&&confirmcontroll.text.isNotEmpty){
            isalldone=true;
          }
          else{
            isalldone=false;
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
        prefixIcon: Icon(Icons.phone, color: Colors.grey, size: 20),
        labelText: "Phone Number",
        labelStyle: TextStyle(color:Color(0xFFb6b3c6).withOpacity(0.8),fontFamily: 'RobotoRegular' ),
        border: OutlineInputBorder(),
      ),

    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      style:  TextStyle(color:Colors.white) ,
      validator: (val){
        if(val.isEmpty)
          return 'Please Enter Password';
        if(val.length<8)
          return 'Please enter Minimum 8 char Password';
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      controller: passwordController,
      keyboardType: TextInputType.text,
      obscureText:  isObscureText,
      cursorColor: Colors.grey,
      onChanged: (val){
        setState(() {
          if(emailController.text.isNotEmpty&&mobilenumberController.text.isNotEmpty&&passwordController.text.isNotEmpty&&confirmcontroll.text.isNotEmpty){
            isalldone=true;
          }
          else{
            isalldone=false;
          }
        });
      },
      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            isObscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              isObscureText = !isObscureText;
            });
          },
        ),
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
        prefixIcon: Icon(Icons.lock, color: Colors.grey, size: 20),
        labelText: "Create Password",
        labelStyle: TextStyle(color:Color(0xFFb6b3c6).withOpacity(0.8),fontFamily: 'RobotoRegular' ),
        border: OutlineInputBorder(),
      ),
    );
  }
  Widget confirmpasswordTextFormField() {
    return TextFormField(
      style:  TextStyle(color:Colors.white) ,
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      validator: (val){
        if(val.isEmpty)
          return 'Please Enter Password';
        if(val != passwordController.text)
          return 'Password not match';
        if(val.length<8)
          return 'Please enter Minimum 8 char Password';
        return null;
      },
      controller: confirmcontroll,
      keyboardType: TextInputType.text,
      obscureText:  iscObscureText,
      cursorColor: Colors.grey,
      onChanged: (val){
        setState(() {
          if(emailController.text.isNotEmpty&&mobilenumberController.text.isNotEmpty&&passwordController.text.isNotEmpty&&confirmcontroll.text.isNotEmpty){
            isalldone=true;
          }
       else{
         isalldone=false;
       }
        });
      },

      decoration: InputDecoration(
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            iscObscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              iscObscureText = !iscObscureText;
            });
          },
        ),
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
        prefixIcon: Icon(Icons.lock, color: Colors.grey, size: 20),
        labelText: "Confirm Password",
        labelStyle: TextStyle(color:Color(0xFFb6b3c6).withOpacity(0.8),fontFamily: 'RobotoRegular' ),
        border: OutlineInputBorder(),
      ),
    );
  }



  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () {
        if (_formkey.currentState.validate()) {
          EasyLoading.show(status: 'Please Wait ...');
        }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large? _width/2 : (_medium? _width/2.75: _width/2.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text('NEXT', style: TextStyle(fontSize: 14,)),
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
          primary:isalldone?Color(0xFF0ebb8e):Color(0xFF51506a),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onPressed: () {

          if (_formkey.currentState.validate()) {
            //CircularProgressIndicator();
           // EasyLoading.show(status: 'Please Wait ...');
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => CustomOtpScreen(emailid: emailController.text,phoneno: mobilenumberController.text,password: passwordController.text,)));
            //print("Routing to your account");
          }
        },
        child: Text(
          "Next",style: TextStyle(color: isalldone?Colors.white:Colors.white.withOpacity(0.2),fontSize: 18,fontFamily: "RobotoRegular"),
        ),
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
            "Already have an account? ",
            style: TextStyle(
                color: Colors.white, fontSize: 14,fontFamily: 'RobotoRegular'),
          ),

          GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(LOGIN);
              // print("Routing to Sign up screen");
            },
            child:  Text(
              "Login here",
              style: TextStyle(
                color: Colors.white, fontSize: 14,fontFamily: 'RobotoRegular', decoration: TextDecoration.underline,),
            ),
          )
        ],
      ),
    );
  }

}
