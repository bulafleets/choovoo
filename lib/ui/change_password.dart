import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/ui/LoginScreen.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  bool isCurrentObscureText = true;
  bool isObscureText = true;
  bool iscObscureText = true;
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool isalldone = false;
  TextEditingController currentPasswordController = TextEditingController();
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
    bool keyboardIsOpened = MediaQuery.of(context).viewInsets.bottom != 0.0;
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Stack(children: [
      Image.asset(
        'assets/background.png',
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      Scaffold(
        floatingActionButton: keyboardIsOpened ? null : nextbutton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: AppColors.primaryColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "Change Password",
            style: TextStyle(color: Colors.white, fontFamily: 'RobotoBold'),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: _height / 25,
                ),
                Container(
                  height: _height / 5.5,
                  alignment: Alignment.center,
                  child: Image.asset(
                    'images/fpassword.png',
                    height: _height / 2.5,
                    width: _width / 2.5,
                  ),
                ),
                SizedBox(
                  height: _height / 25,
                ),
                form(),
                // acceptTermsTextRow(),
                SizedBox(
                  height: _height / 25,
                ),
                // nextbutton()

                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget form() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(left: 40, right: 40, top: _height / 20.0),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            // firstNameTextFormField(),
            //SizedBox(height: _height/ 60.0),
            currentPassword(),
            SizedBox(height: _height / 60.0),
            passwordTextFormField(),
            SizedBox(height: _height / 60.0),
            confirmpasswordTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget currentPassword() {
    return TextFormField(
      // validator: emailValidator,
      controller: currentPasswordController,
      obscureText: isCurrentObscureText,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      style: TextStyle(color: Colors.white),
      validator: (val) {
        if (val.isEmpty) return 'Please Enter current Password';
        if (val.length < 8) return 'Please enter Minimum 8 char Password';
        return null;
      },
      onChanged: (val) {
        setState(() {
          if (val.length == 0) {
            isalldone = false;
          } else {
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
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            isCurrentObscureText ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              isCurrentObscureText = !isCurrentObscureText;
            });
          },
        ),
        labelText: "Current Password",
        labelStyle: TextStyle(
            color: Color(0xFFb6b3c6).withOpacity(0.8),
            fontFamily: 'RobotoBold'),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget passwordTextFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      validator: (val) {
        if (val.isEmpty) return 'Please Enter Password';
        if (val.length < 8) return 'Please enter Minimum 8 char Password';
        return null;
      },
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      controller: passwordController,
      keyboardType: TextInputType.text,
      obscureText: isObscureText,
      cursorColor: Colors.grey,
      onChanged: (val) {
        setState(() {
          if (currentPasswordController.text.isNotEmpty &&
              passwordController.text.isNotEmpty &&
              confirmcontroll.text.isNotEmpty) {
            isalldone = true;
          } else {
            isalldone = false;
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
        labelStyle: TextStyle(
            color: Color(0xFFb6b3c6).withOpacity(0.8),
            fontFamily: 'RobotoRegular'),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget confirmpasswordTextFormField() {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      inputFormatters: [
        LengthLimitingTextInputFormatter(20),
      ],
      validator: (val) {
        if (val.isEmpty) return 'Please Enter Password';
        if (val != passwordController.text) return 'Password not match';
        if (val.length < 8) return 'Please enter Minimum 8 char Password';
        return null;
      },
      controller: confirmcontroll,
      keyboardType: TextInputType.text,
      obscureText: iscObscureText,
      cursorColor: Colors.grey,
      onChanged: (val) {
        setState(() {
          if (currentPasswordController.text.isNotEmpty &&
              passwordController.text.isNotEmpty &&
              confirmcontroll.text.isNotEmpty) {
            isalldone = true;
          } else {
            isalldone = false;
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
        labelStyle: TextStyle(
            color: Color(0xFFb6b3c6).withOpacity(0.8),
            fontFamily: 'RobotoRegular'),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget nextbutton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: isalldone ? Color(0xFF0ebb8e) : Color(0xFF51506a),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onPressed: () {
          if (_formkey.currentState.validate()) {
            ChangePassword();
            // showDialog(context: context, builder: (_) {}
            // LogoutOverlay(email: currentPasswordController.text),
            // );
            //  EasyLoading.show(status: 'Please Wait ...');
            //sendRESENT();
            //CircularProgressIndicator();
            //  EasyLoading.show(status: 'Please Wait ...');

            //print("Routing to your account");
          }
        },
        child: Text(
          "Next",
          style: TextStyle(
              color: Colors.white, fontSize: 18, fontFamily: 'RobotoBold'),
        ),
      ),
    );
  }

  Future<void> ChangePassword() async {
    final response = await http.post(Uri.parse(URL_ChangePassword), body: {
      'email': email,
      'password': passwordController.text.toString(),
    }, headers: {
      HttpHeaders.authorizationHeader: "Bearer $authorization"
    });
    EasyLoading.dismiss();
    String data = response.body;
    String status = jsonDecode(data)['status'].toString();
    print(data);

    if (status == '200') {
      String message = jsonDecode(data)['message'];
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.remove('name');
      _prefs.remove('email');
      _prefs.remove('user_id');
      _prefs.remove('mobileno');
      _prefs.remove('profileimg');
      _prefs.remove('role');
      _prefs.remove('password');
      _prefs.remove('token');
      Navigator.of(context)
          .pushNamedAndRemoveUntil(LOGIN, (Route<dynamic> route) => false);

      EasyLoading.showToast(message);
    } else if (status == '400') {
      String message = jsonDecode(data)['message'];
      EasyLoading.showToast(message);
    } else {
      EasyLoading.showToast("Something Happen Wrong");
    }
  }
}
