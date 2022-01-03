import 'dart:convert';

import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;

class RateBarber extends StatefulWidget {
  final String shopid;
  final String shopname;
  RateBarber({ Key key, this.shopid, this.shopname,}) : super(key: key);
  @override
  State<StatefulWidget> createState() => RateBarberState();
}

class RateBarberState extends State<RateBarber>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  String strating="";
  TextEditingController nameController = TextEditingController();
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
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large =  ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium =  ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Center(
      child: Container(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
               // margin: EdgeInsets.all(10.0),
               // padding: EdgeInsets.all(10.0),
                height: 400.0,
                width: 320.0,
                decoration: ShapeDecoration(
                    color: Color(0xffd9e4ef),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),side:BorderSide(color: AppColors.Appbarcolor))),
                child: Column(

                  children: <Widget>[
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: Color(0xff1c50a8),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0, left: 20.0, right: 20.0,bottom: 20.0),
                        child: Text(
                          "Write a Review",
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 16.0,fontFamily: 'RobotoBold'),
                        ),
                      ),
                    ),
                     SizedBox(height: 20,),
                     Text(
                      "Barbershoap",
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Color(0xff718293), fontSize: 14.0,fontFamily: 'RobotoBold'),
                    ),
                     SizedBox(height: 10,),
              RatingBar.builder(
                initialRating: 0,
                itemCount: 5,
                itemBuilder: (context, index) {
                  switch (index) {
                    case 0:
                      return Icon(
                        Icons.sentiment_very_dissatisfied,
                        color: Colors.red,
                      );
                    case 1:
                      return Icon(
                        Icons.sentiment_dissatisfied,
                        color: Colors.redAccent,
                      );
                    case 2:
                      return Icon(
                        Icons.sentiment_neutral,
                        color: Colors.amber,
                      );
                    case 3:
                      return Icon(
                        Icons.sentiment_satisfied,
                        color: Colors.lightGreen,
                      );
                    case 4:
                      return Icon(
                        Icons.sentiment_very_satisfied,
                        color: Colors.green,
                      );
                  }
                },
                onRatingUpdate: (rating) {
                  strating=rating.toString();
                  print(rating);
                },
              ),
            SizedBox(height: 15,),
            Container(
              margin: EdgeInsets.only(left: 15,right: 15),

              child: TextField(
               // validator:RequiredValidator(errorText: "Please Enter Your Name."),
                controller: nameController,
                keyboardType: TextInputType.text,
                cursorColor: Colors.grey,
                maxLines: 4,
                decoration: InputDecoration(
                 // prefixIcon: Icon(Icons.person, color: Colors.grey, size: 20),
                  labelText: "Write about your experience",
                  labelStyle: TextStyle(color:Color(0xFF9eadba).withOpacity(0.8),fontFamily: 'RobotoRegular' ),
                  border: OutlineInputBorder(),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  filled: true,
                  fillColor: Color(0xfff1f6fd),
                ),
              ),
            ),
                    SizedBox(height: 20,),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 40,
                      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          onPrimary: Colors.white,
                          primary:Color(0xFF2c9eff),
                          minimumSize: Size(88, 36),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                          ),
                        ),
                        onPressed: () {
                          if(strating.isEmpty || strating==""){
                            EasyLoading.showToast("Please rate Barber");
                          }
                        },
                        child: Text(
                          "Submit",style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "RobotoRegular"),
                        ),
                      ),
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }
  Future<void> RateUser() async {
    final response = await http.post(Uri.parse(URL_CreateShopReview),
      body:{
        'shop_id': widget.shopid,
        'user_id': user_id,
        'review': "fcmtoken",
        'rating': strating,
      },
    );
    EasyLoading.dismiss();
    String data = response.body;
    String status = jsonDecode(data)['status'].toString();
    print(data);

    if (status == '200') {
      String message = jsonDecode(data)['message'];
      EasyLoading.showToast(message);
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