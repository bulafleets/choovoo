import 'dart:convert';
import 'dart:io';

import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/model/service_model.dart';
import 'package:choovoo/model/tag_model.dart';
import 'package:choovoo/ui/barber_ui/barber_shoap.dart';
import 'package:choovoo/ui/client_ui/appointment_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigationDrawer.dart';

class BookAppointment extends StatefulWidget {
 final String shop_id;
 BookAppointment({ Key key, this.shop_id}) : super(key: key);
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
 // static const kGoogleApiKey = "AIzaSyBltuyqYBtlJJ1MgNuBwYIII_C5wvDhsCY";
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  bool appointment = false;
  bool locationacess = false;
  final List<TextEditingController> _controllers = List();
  TextEditingController shoapnamecontroll = TextEditingController();
  TextEditingController shoaplocationcontroll = TextEditingController();
  TextEditingController pricecontroll = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();
  GoogleMapsPlaces _places;
  List<ServiceModel> taglist = List();
 String shop_name="";
 String shop_loc="";
bool loading=true;
  String _date = "Select Date";
  String _time = "Select Time";

  String datemonth="";
  @override
  void initState() {
    datemonth= DateFormat("MMMMd").format(DateTime.now());
    print(datemonth);
  getShopDetail(widget.shop_id);
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
       // FutureProvider(create: (context) => getShopDetail(widget.shop_id)),
    return MaterialApp(
    home:  Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.Appbarcolor,
        /* leading: Text(name,style: TextStyle(color: Colors.white,),textAlign: Tex,
        ),*/
        title: Image.asset("assets/round_logo.png", height: 50,
          width: 50,),
        centerTitle: true,
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff363636), //This will change the drawer background to blue.
          ),
          child: navigationDrawer()),
      body: loading?Container(
        alignment: Alignment.center,
          child: CircularProgressIndicator()):Container(
        margin: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              skipText(),
              SizedBox(height:20,),
              shoapname(),
              shoapnameform(),
              SizedBox(height:20,),
              shoaplocation(),
              shoaplocationform(),
              SizedBox(height:20,),
              datetandtime(),
              SizedBox(height:20,),
              tagname(),
              taglistbody(),
              SizedBox(height:20,),
            //  Divider(color: Color(0xFF555555),height: 1, indent: 20,endIndent: 20,),
             // SizedBox(height:20,),
              nextbutton(),
              SizedBox(height: 10,),
              //nextbutton()

              //signInTextRow(),
            ],
          ),
        ),
      ),
      ),

    );


  }
  Widget skipText() {
    return Container(
      height: 80,
      alignment: Alignment.topCenter,
      color: Color(0xFFf2f4ff),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[

          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "New Appointment",
              style: TextStyle(
                color: Color(0xFF343c50),
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 5,),
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(left: 15),
            child: Text(
              datemonth,
              style: TextStyle(
                color: Color(0xFF4f68a5),
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
        ],

      ),

    );
  }


  Widget shoapname() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20.0),
      child: Row(
        children: <Widget>[
          Text(
            "Shop Name",
            style: TextStyle(
              color: Color(0xFF38405c),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

        ],
      ),
    );
  }
  Widget tagname() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20.0,right:70),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Services (select all that apply)",
            style: TextStyle(
              color: Color(0xFF38405c),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),


        ],
      ),
    );
  }
  Widget shoapnameform() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          left:_width/ 20.0,
          right: _width / 20.0,
          top:5),
      child:  Container(
        alignment: Alignment.centerLeft,
        width: _width,
        height: 50,
        // margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            color: Color(0xffedf0fd),
            border: Border.all(color:Color(0xFFedf0fd)),
           borderRadius: BorderRadius.circular(8)
        ),
        child: Text(shop_name,style: TextStyle(color:Color(0xFF4d5060),fontWeight: FontWeight.w600),),
      ),
    );
  }

  Widget shoaplocation() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20.0),
      child: Row(
        children: <Widget>[
          Text(
            "Shop Location",
            style: TextStyle(
              color: Color(0xFF38405c),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

        ],
      ),
    );
  }
  Widget shoaplocationform() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(
          left:_width/ 20.0,
          right: _width / 20.0,
          top:5),
      child:  Container(
        alignment: Alignment.centerLeft,
        width: _width,
        height: 50,
        // margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(3.0),
        decoration: BoxDecoration(
            color: Color(0xffedf0fd),
            border: Border.all(color:Color(0xFFedf0fd)),
            borderRadius: BorderRadius.circular(8)
        ),
        child: Text(shop_loc,style: TextStyle(color:Color(0xFF4d5060)),),
      ),
    );
  }


  Widget nextbutton(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary:Color(0xFF00a7ff),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: () async {
          String isoneselect="";
          List<ServiceModel> selectedlist=[];
          for(var i = 0; i < taglist.length; i++){
              if(taglist[i].ischecked==true){
                selectedlist.add(taglist[i]);
                isoneselect="yes";
              }
          }
          if(_date=="Select Date"){
            EasyLoading.showToast("Please select appointment date");
          }
          else if(_time=="Select Time"){
            EasyLoading.showToast("Please select appointment time");
          }
          else if(isoneselect==""){
            EasyLoading.showToast("Please select one of services");
          }
          else{
            var json = jsonEncode(selectedlist.map((e) => e.toJson()).toList());
            CreateAppointment(json,widget.shop_id);
          }

        },
        child: Text(
          "Book Visit",style: TextStyle(color: Colors.white,fontSize: 18),
        ),
      ),
    );
  }




   Future<List<ServiceModel>> getShopDetail(String shopid) async {
    print("hello");
    try {
      final response = await http.post(Uri.parse(URL_GetShoapDetail), headers: { HttpHeaders.authorizationHeader: "Bearer $authorization"},
      body: {
        'shop_id':shopid
      });
      print("nikitaFFF");
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;
        shop_name=jsonDecode(data)['getShopDetails']['shop_name'];
        shop_loc=jsonDecode(data)['getShopDetails']['shop_location'];
        var tagObjsJson = jsonDecode(data)['getShopDetails']['servicePrice'] as List;
        List<ServiceModel> tagObjs = tagObjsJson.map((tagJson) => ServiceModel.fromJson(tagJson)).toList();
        taglist=tagObjs;
        setState(() {
          loading=false;
        });
        return tagObjs;
      } else {
        setState(() {
          loading=false;
        });
        return [];
      }
    } catch (e) {
      print(e.toString());
      return [];
    }
  }

  Widget taglistbody() {
    return ListView.builder(
        padding: EdgeInsets.only(left: _width / 20.0,right: _width / 20.0),
        physics: const BouncingScrollPhysics(),
        itemCount: taglist.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
         // _controllers.add(new TextEditingController());
         // _controllers[index].text = taglist[index].price.toString();
          return Container(
              padding: EdgeInsets.only(top: 0, right: 10, left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Align( alignment: Alignment.topLeft, child: Text(taglist[index].tagname))),
                        ),
                        new Checkbox(
                        value: taglist[index].ischecked,
                 onChanged: (bool value) {
                     setState(() {
                       taglist[index].ischecked = value;
                     });
                 })
                      ],
                    ),

                 Align( alignment:Alignment.topLeft,child: Text("\$ "+taglist[index].price.toString()))

              ]));
        });
  }
  expandStyle(int flex, Widget child) => Expanded(flex: flex, child: child);


  Widget datetandtime(){
    return Container(
      //color: Color(0xffedf0fd),
      margin: EdgeInsets.only(
          left:_width/ 20.0,
          right: _width / 20.0,
          ),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(

            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 4.0,
            onPressed: () {
              DatePicker.showDatePicker(context,
                  theme: DatePickerTheme(
                    containerHeight: 210.0,
                  ),
                  showTitleActions: true,
                  minTime: DateTime(2000, 1, 1),
                  maxTime: DateTime(2022, 12, 31), onConfirm: (date) {
                    print('confirm $date');
                    _date = '${date.year}-${date.month}-${date.day}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: Container(
              alignment: Alignment.center,
              color: Color(0xffedf0fd),
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.date_range,
                              size: 18.0,
                              color: Color(0xFF4d5060),
                            ),
                            Text(
                              " $_date",
                              style: TextStyle(
                                  color: Color(0xFF4d5060),
                                //  fontSize: 18.0
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    "  Change",
                    style: TextStyle(
                        color: Color(0xFF4d5060),
                       // fontWeight: FontWeight.bold,
                       // fontSize: 18.0
                    ),
                  ),
                ],
              ),
            ),
            color: Color(0xffedf0fd),
          ),
          SizedBox(
            height: 10.0,
          ),
          RaisedButton(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)),
            elevation: 4.0,
            onPressed: () {
              DatePicker.showTimePicker(context,
                  theme: DatePickerTheme(
                    containerHeight: 210.0,
                  ),
                  showTitleActions: true, onConfirm: (time) {
                    print('confirm $time');
                    _time = '${time.hour}:${time.minute}:${time.second}';
                    setState(() {});
                  }, currentTime: DateTime.now(), locale: LocaleType.en);
              setState(() {});
            },
            child: Container(
              alignment: Alignment.center,
              height: 50.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              size: 18.0,
                              color: Color(0xFF4d5060),
                            ),
                            Text(
                              " $_time",
                              style: TextStyle(
                                  color: Color(0xFF4d5060),
                                 // fontWeight: FontWeight.bold,
                                 // fontSize: 18.0
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Text(
                    "  Change",
                    style: TextStyle(
                        color:Color(0xFF4d5060),
                       // fontWeight: FontWeight.bold,
                      //  fontSize: 18.0
                    ),
                  ),
                ],
              ),
            ),
            color: Color(0xFFedf0fd),
          )
        ],
      ),
    );
  }
  Future<void> CreateAppointment(String json,String shop_id) async {
    print(_date+":"+_time);
        final response = await http.post(Uri.parse(URL_CreateAppointment),headers: {HttpHeaders.authorizationHeader: "Bearer $authorization"},
       body: {
         'shop_id': shop_id,
         'user_id': user_id,
         'appointment_date': _date+":"+_time,
         'service_tags': json,
       },
     );
        var cdc={
          'shop_id': shop_id,
          'user_id': user_id,
          'appointment_date': _date+":"+_time,
          'service_tags': json,
        };
        print(cdc);

    String data = response.body;
    print(data);
    String status = jsonDecode(data)['status'].toString();

    EasyLoading.dismiss();
    if (status == '200') {
      String message = jsonDecode(data)['message'].toString();
      EasyLoading.showToast(message);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AppointmentList())

      );
    }
    else if(status=='400'){
      String message = jsonDecode(data)['message'].toString();
      EasyLoading.showToast(message);
    }
    else{
      EasyLoading.showToast("Something Happen Wrong");
    }
  }
}