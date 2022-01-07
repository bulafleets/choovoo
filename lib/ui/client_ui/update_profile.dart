import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/ui/client_ui/client_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfileScreen extends StatefulWidget {
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  bool isObscureText = true;
  bool checkBoxValue = false;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  bool isalldone = false;
  String base64Image;
  TextEditingController namecontroll = TextEditingController();

  GlobalKey<FormState> _formkey = GlobalKey();
  PickedFile imageFile = null;
  @override
  void initState() {
    // TODO: implement initState
    namecontroll.text = name;
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
            "Update Profile",
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
                  child: GestureDetector(
                    onTap: () {
                      _showPicker(context);
                      // print("Routing to Sign up screen");
                    },
                    child: imageFile != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.file(
                              File(imageFile.path),
                              width: 100,
                              height: 100,
                              fit: BoxFit.fitHeight,
                            ),
                          )
                        : CachedNetworkImage(
                            imageUrl: profileimg,
                            placeholder: (context, url) => new Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                new Image.asset(
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
                                      Colors.black.withOpacity(0.8),
                                      BlendMode.dstATop),
                                ),
                              ),
                            ),
                          ),
                  ),
                ),
                SizedBox(
                  height: _height / 40,
                ),
                signInTextRow(),
                // SizedBox(height: _height/25,),
                form(),
                // acceptTermsTextRow(),
                SizedBox(
                  height: _height / 25,
                ),
                //nextbutton()

                //signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    ]);
  }

  Widget signInTextRow() {
    return Container(
      alignment: Alignment.center,
      //  margin: EdgeInsets.only(left: _width / 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Tap Here To Upload Profile Pic",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w200,
              fontFamily: 'RobotoRegular',
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
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
            SizedBox(height: _height / 60.0),
            firstNameTextFormField(),
          ],
        ),
      ),
    );
  }

  Widget firstNameTextFormField() {
    return TextFormField(
      validator: RequiredValidator(errorText: "Please Enter Your Name."),
      controller: namecontroll,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      style: TextStyle(color: Colors.white),
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
        prefixIcon: Icon(Icons.person, color: Colors.grey, size: 20),
        labelText: "Name",
        labelStyle: TextStyle(color: Color(0xFFb6b3c6)),
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
            //CircularProgressIndicator();
            EasyLoading.show(status: 'Please Wait ...');
            RegisterUser();
            //print("Routing to your account");
          }
        },
        child: Text(
          "Next",
          style: TextStyle(
              color: Colors.white, fontSize: 16, fontFamily: 'RobotoBold'),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      imageFile = pickedFile;
    });
  }

  _imgFromGallery() async {
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      imageFile = pickedFile;
    });
  }

  Future<void> RegisterUser() async {
    if (imageFile != null) {
      print("notnull");
      var request =
          http.MultipartRequest('POST', Uri.parse(URL_UpdateUserProfile));
      request.headers.addAll({"Authorization": "Bearer $authorization"});
      request.files
          .add(await http.MultipartFile.fromPath('avatar', imageFile.path));
      request.fields['name'] = namecontroll.text;
      request.fields['_id'] = user_id;
      var res = await request.send();
      var response = await http.Response.fromStream(res);
      String data = response.body;
      print(data);
      String status = jsonDecode(data)['status'].toString();
      String userphoto = jsonDecode(data)['user_photo'].toString();

      EasyLoading.dismiss();
      if (status == '200') {
        name = namecontroll.text;
        profileimg = userphoto;
        Navigator.of(context).pop();
        // Navigator.of(context).pushNamed(OTP_SCREEN);
      } else if (status == '400') {
        String message = jsonDecode(data)['message'].toString();
        EasyLoading.showToast(message);
      } else {
        EasyLoading.showToast("Something Happen Wrong");
      }
    } else {
      print("null");
      final response = await http.post(
        Uri.parse(URL_UpdateUserProfile),
        headers: {HttpHeaders.authorizationHeader: "Bearer $authorization"},
        body: {
          'name': namecontroll.text,
          '_id': user_id,
          'avatar': "",
        },
      );
      String data = response.body;
      print(data);
      String status = jsonDecode(data)['status'].toString();

      EasyLoading.dismiss();
      if (status == '200') {
        name = namecontroll.text;
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => ClientProfile()));
        // Navigator.of(context).pushNamed(OTP_SCREEN);
      } else if (status == '400') {
        String message = jsonDecode(data)['message'].toString();
        EasyLoading.showToast(message);
      } else {
        EasyLoading.showToast("Something Happen Wrong");
      }
    }
  }
}
