


import 'dart:convert';
import 'dart:io';

import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  final String emailid;
  final String phoneno;
  final String password;
  ProfileScreen({ Key key, this.emailid, this.phoneno, this.password}) : super(key: key);
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isObscureText = true;
  bool checkBoxValue = false;
   double _height;
   double _width;
   double _pixelRatio;
   bool _large;
   bool _medium;
  bool isalldone=false;
   String base64Image;
   String fcmtoken="";
  TextEditingController namecontroll = TextEditingController();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  GlobalKey<FormState> _formkey = GlobalKey();
  PickedFile imageFile=null;
  @override
  void initState() {
    // TODO: implement initState
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
      //  _showItemDialog(message);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        //_navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        //_navigateToItemDetail(message);
      },
    );
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
              title: Text("Sign Up",style: TextStyle(color: Colors.white,fontFamily: 'RobotoBold'),),
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
                    child:  GestureDetector(
                        onTap: () {
                          _showPicker(context);
                          // print("Routing to Sign up screen");
                        },
                      child:  imageFile!= null
                          ? ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image.file(
                          File(imageFile.path),
                          width: 100,
                          height: 100,
                          fit: BoxFit.fitHeight,
                        ),
                      )
                      :Image.asset(
                        'images/profile.png',
                        height: _height/2.5,
                        width: _width/2.5,
                      ),
                      ),

                    ),
                    SizedBox(height: _height/40,),
                    signInTextRow(),
                   // SizedBox(height: _height/25,),
                    form(),
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
      margin: EdgeInsets.only(
          left:40,
          right: 40,
          top: _height / 20.0),
      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            // firstNameTextFormField(),
            SizedBox(height: _height/ 60.0),
            firstNameTextFormField(),
          ],
        ),
      ),
    );
  }



  Widget firstNameTextFormField() {
    return TextFormField(
      validator:RequiredValidator(errorText: "Please Enter Your Name."),
      controller: namecontroll,
      keyboardType: TextInputType.text,
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
      prefixIcon: Icon(Icons.person, color: Colors.grey, size: 20),
      labelText: "Name",
      labelStyle: TextStyle(color:Color(0xFFb6b3c6) ),
      border: OutlineInputBorder(),
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
              EasyLoading.show(status: 'Please Wait ...');
               RegisterUser();
            //print("Routing to your account");
          }
        },
        child: Text(
          "Next",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'RobotoBold'),
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
        }
    );
  }
  _imgFromCamera() async {
    final pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera ,
    );
    setState(() {
      imageFile = pickedFile;
    });
  }

  _imgFromGallery() async {
    final pickedFile = await  ImagePicker().getImage(
        source: ImageSource.gallery, imageQuality: 50
    ) ;

    setState(() {
      imageFile = pickedFile;
    });
  }
  Future<void> RegisterUser() async {
   if(imageFile!=null){
     print("notnull");
     var request = http.MultipartRequest('POST', Uri.parse(URL_Signup));
     request.files.add(
         await http.MultipartFile.fromPath(
             'avatar',
             imageFile.path
         )
     );
     request.fields['mobile_number'] = widget.phoneno;
     request.fields['name'] = namecontroll.text;
     request.fields['email'] = widget.emailid;
     request.fields['password'] = widget.password;
     request.fields['roleType'] = AccountType;
     request.fields['firebase_token'] = fcmtoken;

     var res = await request.send();
     var response=await http.Response.fromStream(res);
     String data = response.body;
     print(data);
     String status = jsonDecode(data)['status'].toString();

     EasyLoading.dismiss();
     if (status == '200') {
       String userid = jsonDecode(data)['user_id'].toString();
       authorization = jsonDecode(data)['accessToken'].toString();
       SharedPreferences _prefs = await SharedPreferences.getInstance();
       _prefs.setString('name', namecontroll.text);
       _prefs.setString('email', widget.emailid);
       _prefs.setString('user_id', userid);
       _prefs.setString('mobileno', widget.phoneno);
       _prefs.setString('profileimg', "");
       _prefs.setString('role', AccountType);
       _prefs.setString('password', widget.password);
       _prefs.setString('token', authorization);
       name = namecontroll.text;
       email = widget.emailid;
       phoneno = widget.phoneno;
       password = widget.password;
       user_id = userid;
       Navigator.of(context).pushNamedAndRemoveUntil(
           FINAL_GET_START, (Route<dynamic> route) => false);
       // Navigator.of(context).pushNamed(OTP_SCREEN);
     }
     else if (status == '400') {
       String message = jsonDecode(data)['message'].toString();
       EasyLoading.showToast(message);
     }
     else {
       EasyLoading.showToast("Something Happen Wrong");
     }
   }
   else {
     print("null");
     var request = http.MultipartRequest('POST', Uri.parse(URL_Signup));
     request.fields['mobile_number'] = widget.phoneno;
     request.fields['name'] = namecontroll.text;
     request.fields['email'] = widget.emailid;
     request.fields['password'] = widget.password;
     request.fields['roleType'] = AccountType;
     request.fields['avatar'] = "";
     request.fields['firebase_token'] = fcmtoken;

     var res = await request.send();
     var response=await http.Response.fromStream(res);
     String data = response.body;
     /*final response = await http.post(Uri.parse(URL_Signup),
       body: {
         'mobile_number': widget.phoneno,
         'name': namecontroll.text,
         'email': widget.emailid,
         'password': widget.password,
         'roleType': AccountType,
         'avatar': "",
       },
     );
     String data = response.body;*/
     print(data);
     String status = jsonDecode(data)['status'].toString();

     EasyLoading.dismiss();
     if (status == '200') {
       String userid = jsonDecode(data)['user_id'].toString();
       authorization = jsonDecode(data)['accessToken'].toString();
       SharedPreferences _prefs = await SharedPreferences.getInstance();
       _prefs.setString('name', namecontroll.text);
       _prefs.setString('email', widget.emailid);
       _prefs.setString('user_id', userid);
       _prefs.setString('mobileno', widget.phoneno);
       _prefs.setString('profileimg', "");
       _prefs.setString('role', AccountType);
       _prefs.setString('password', widget.password);
       _prefs.setString('token', authorization);
       name = namecontroll.text;
       email = widget.emailid;
       phoneno = widget.phoneno;
       password = widget.password;
       user_id = userid;
       Navigator.of(context).pushNamedAndRemoveUntil(
           FINAL_GET_START, (Route<dynamic> route) => false);
       // Navigator.of(context).pushNamed(OTP_SCREEN);
     }
     else if (status == '400') {
       String message = jsonDecode(data)['message'].toString();
       EasyLoading.showToast(message);
     }
     else {
       EasyLoading.showToast("Something Happen Wrong");
     }
   }
  }
}
