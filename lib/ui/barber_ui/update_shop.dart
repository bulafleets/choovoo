import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/model/service_model.dart';
import 'package:choovoo/model/tag_model.dart';
import 'package:choovoo/ui/barber_ui/barber_shoap.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateShoapInfo extends StatefulWidget {
   @override
  _UpdateShoapInfoState createState() => _UpdateShoapInfoState();
}

class _UpdateShoapInfoState extends State<UpdateShoapInfo> {
  static const kGoogleApiKey = "AIzaSyBltuyqYBtlJJ1MgNuBwYIII_C5wvDhsCY";


  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  bool appointment = false;
  bool isloading = true;
  bool locationacess = false;
  final List<TextEditingController> _controllers = List();
  TextEditingController shoapnamecontroll = TextEditingController();
  TextEditingController shoaplocationcontroll = TextEditingController();
  TextEditingController pricecontroll = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();
  GoogleMapsPlaces _places;
  List<ServiceModel> taglist = List();
  bool _shoapvalid=false;
  bool _shoaplocvalid=false;
  String shoaplat;
  String shoaplng;
  String shopid;
  String shopimg;
  PickedFile imageFile=null;
  String base64Image="";
  @override
  void initState() {

    _places  = GoogleMapsPlaces(apiKey: kGoogleApiKey);
    getshopdetail();
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

    return Scaffold(
      backgroundColor: AppColors.backgroundcolor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.Appbarcolor.withOpacity(1),
        /* leading: Text(name,style: TextStyle(color: Colors.white,),textAlign: Tex,
        ),*/
        title: Image.asset("assets/round_logo.png", height: 40,
          width: 40,),
        centerTitle: true,
      ),
      /*drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff363636), //This will change the drawer background to blue.
          ),
          child: navigationDrawer()),*/
      body:isloading?Container(
          alignment: Alignment.center,
          child: CircularProgressIndicator()): Container(
        margin: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              skipText(),
              SizedBox(height:15,),
              imageFile!= null?Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Stack(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(left: 20,right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: ClipRRect(
                          //borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            File(imageFile.path),
                            width: MediaQuery.of(context).size.width,
                            height: 130,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                            onTap: (){
                              _showPicker(context);
                            },
                            child: Icon(Icons.edit)),
                      )
                    ]
                ),
              ): Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                child: Stack(
                    children: [
                      Container(
                        // margin: EdgeInsets.only(left: 20,right: 20),
                        width: MediaQuery.of(context).size.width,
                        height: 130,
                        child: ClipRRect(
                          //borderRadius: BorderRadius.circular(50),
                          child: CachedNetworkImage(
                            imageUrl: shopimg,
                            placeholder: (context, url) => new Center(child: CircularProgressIndicator(),),
                            errorWidget: (context, url, error) => new Image.asset(
                              'images/profile.png',
                              height: 130,
                              width: 130,
                            ),
                            imageBuilder: (context, imageProvider) => Container(
                              width: 130.0,
                              height: 130.0,
                              decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                image: DecorationImage(
                                  image: imageProvider, fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      Colors.black.withOpacity(0.8),
                                      BlendMode.dstATop
                                  ),),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: GestureDetector(
                            onTap: (){
                              _showPicker(context);
                            },
                            child: Icon(Icons.edit)),
                      )
                    ]
                ),
              ),
              SizedBox(height:15,),
              shoapname(),
              shoapnameform(),
              SizedBox(height:20,),
              shoaplocation(),
              shoaplocationform(),
              SizedBox(height:20,),
              tagname(),
              taglistbody(),
              SizedBox(height:20,),
              Divider(color: Color(0xFF555555),height: 1, indent: 20,endIndent: 20,),
              mobileappointment(),
              locationaccess(),
              SizedBox(height:20,),
              nextbutton(),
              SizedBox(height: 10,),
              //nextbutton()

              //signInTextRow(),
            ],
          ),
        ),
      ),
    );


  }
  BoxDecoration myBoxDecoration() {
    return BoxDecoration(
      color: Color(0xFFf2f5f7),
      border: Border.all(color: Color(0xffd9dadc)
      ),
      borderRadius: BorderRadius.all(
          Radius.circular(5.0) //                 <--- border radius here
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
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(left: 15),
            child: Text(
              "Update your shop's info",
              style: TextStyle(
                fontFamily: 'RobotoBold',
                color: Color(0xFF4f68a5),
                fontWeight: FontWeight.w400,
                fontSize: 18,
              ),
            ),
          ),
          SizedBox(height: 10,),
        ],

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
  Widget shoapname() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20.0),
      child: Row(
        children: <Widget>[
          Text(
            "Shop Name",
            style: TextStyle(
              fontFamily: 'RobotoBold',
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
            "Services",
            style: TextStyle(
              fontFamily: 'RobotoBold',
              color: Color(0xFF38405c),
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),

          Text(
            "Price",
            style: TextStyle(
              fontFamily: 'RobotoBold',
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
      child: shoapnameTextFormField(),
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
              fontFamily: 'RobotoBold',
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
      child: shoaplocationTextFormField(),
    );
  }

  Widget mobileappointment() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20.0,right: _width / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Mobile Appointments?",
            style: TextStyle(
              fontFamily: 'RobotoBold',
              color: Color(0xFF38405c),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),

          Container(
            alignment: Alignment.centerRight,
            child: Checkbox(
              value: appointment,
              onChanged: (bool newValue) {
                setState(() {
                  appointment = newValue;
                });
              },
            ),
          )

        ],
      ),
    );

  }

  Widget locationaccess() {
    return Container(
      margin: EdgeInsets.only(left: _width / 20.0,right: _width / 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "Location Access?",
            style: TextStyle(
              fontFamily: 'RobotoBold',
              color: Color(0xFF38405c),
              fontWeight: FontWeight.w500,
              fontSize: 16,
            ),
          ),
          //SizedBox
          Container(
            alignment: Alignment.centerRight,
            child: Checkbox(
              value: locationacess,
              onChanged: (bool newValue) {
                setState(() {
                  locationacess = newValue;
                });
              },
            ),
          )

        ],
      ),
    );

  }





  Widget shoapnameTextFormField() {
    return TextField(
      controller: shoapnamecontroll,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      style:  TextStyle(color:Color(0xFF4d5060),  fontFamily: 'RobotoRegular',) ,
      onChanged: (val){
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFedf0fd),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFedf0fd)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFedf0fd)),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(),
          errorText: _shoapvalid?"Enter Shop Name":null
      ),
    );
  }
  Widget shoaplocationTextFormField() {
    return TextField(
      controller: shoaplocationcontroll,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      style:  TextStyle(color:Color(0xFF4d5060),fontFamily: 'RobotoRegular') ,
      onChanged: (val){
      },
      onTap: () async {
        Prediction p = await getPaceOverlay(context);

        if (p != null) {
          PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(p.placeId);
          shoaplat = detail.result.geometry.location.lat.toString();
          shoaplng = detail.result.geometry.location.lng.toString();
          print(detail.result.formattedAddress);
          setState(() {
            shoaplocationcontroll.text=detail.result.formattedAddress;
          });
        }
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFedf0fd),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFedf0fd)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFedf0fd)),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(),
          errorText: _shoaplocvalid?"Enter Your shop location":null
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
          primary:Color(0xFF00a7ff),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: () async {

          if (shoapnamecontroll.text.isEmpty) {
            setState(() {
              _shoapvalid=true;
            });
          }
          else if(shoaplocationcontroll.text.isEmpty){
            setState(() {
              _shoaplocvalid=true;
            });
          }
          else{
            var json = jsonEncode(taglist.map((e) => e.toJson()).toList());
            print(json);
            print(shoaplat);

            CreateShoap(json);
          }
        },
        child: Text(
          "Create Shop",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'RobotoBold'),
        ),
      ),
    );
  }


  Future<Prediction> getPaceOverlay (BuildContext context) async{

    return await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      mode: Mode.overlay, // Mode.fullscreen
      language: "en",
    );

  }

   Future<void> getshopdetail() async {
    try {
      final response = await http.post(Uri.parse(URL_GetBarberShop), headers: {HttpHeaders.authorizationHeader: "Bearer $authorization"},
      body: {
        'user_id':user_id
      });
      String data = response.body;
      print(data);
      if (response.statusCode == 200) {

        shopid=jsonDecode(data)['getShopDetails']['_id'];
        shopimg=jsonDecode(data)['getShopDetails']['shop_photo'];
        shoapnamecontroll.text=jsonDecode(data)['getShopDetails']['shop_name'];
        shoaplocationcontroll.text=jsonDecode(data)['getShopDetails']['shop_location'];
        shoaplat=jsonDecode(data)['getShopDetails']['lattitude'].toString();
        shoaplng=jsonDecode(data)['getShopDetails']['longitude'].toString();
        appointment=jsonDecode(data)['getShopDetails']['is_mobile_appointment'];
        locationacess=jsonDecode(data)['getShopDetails']['is_location_access'];
        var tagObjsJson = jsonDecode(response.body)['getShopDetails']['servicePrice'] as List;
        List<ServiceModel> tagObjs = tagObjsJson.map((tagJson) => ServiceModel.fromJson(tagJson)).toList();
        setState(() {
          taglist=tagObjs;
          isloading=false;
        });
      } else {
        setState(() {
          isloading=false;
        });
      }
    } catch (e) {
      setState(() {
        isloading=false;
      });
    }
  }

  static List<TagModel> parseUsers(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<TagModel>((json) => TagModel.fromJson(json)).toList();
  }
  Widget taglistbody() {
    print("liiiii${taglist.length}");
    return ListView.builder(
        padding: EdgeInsets.only(left: _width / 20.0,right: _width / 20.0),
        physics: const BouncingScrollPhysics(),
        itemCount: taglist.length,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          _controllers.add(new TextEditingController());
          _controllers[index].text = taglist[index].price.toString();
          return Container(
              padding: EdgeInsets.only(top: 0, right: 10, left: 10),
              child: Row(children: <Widget>[
                expandStyle(
                    2,
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Text(taglist[index].tagname))),
                expandStyle(
                    1,
                    Container(
                        margin: EdgeInsets.only(top: 10),
                        child:
                        TextFormField(
                            style:  TextStyle(color:Color(0xFF4d5060),fontFamily: 'RobotoRegular') ,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Color(0xFFedf0fd),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFedf0fd)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Color(0xFFedf0fd)),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              border: OutlineInputBorder(),
                            ),
                            controller: TextEditingController.fromValue(
                                TextEditingValue(
                                    text: taglist[index].price.toString(),
                                    selection: new TextSelection.collapsed(
                                        offset:
                                        taglist[index].price.toString().length))),
                            keyboardType: TextInputType.number,
                            onChanged: (String str) {
                              taglist[index].price =int.parse(str) ;
                              var total = taglist.fold(0,
                                      (t, e) =>
                                  t +
                                      double.parse(
                                          e.price.toString().isEmpty ? '0' : e.price.toString()));
                              print(total);
                            })))
              ]));
        });
  }
  expandStyle(int flex, Widget child) => Expanded(flex: flex, child: child);

  Future<void> CreateShoap(String json) async {
    print(user_id);
    /* if(imageFile!=null) {
       List<int> imageBytes = await imageFile.readAsBytes();
       base64Image = base64Encode(imageBytes);
     }*/
    /*    final response = await http.post(Uri.parse(URL_CreateShoap),headers: {HttpHeaders.authorizationHeader: "Bearer $authorization"},
       body: {
         'user_id': user_id,
         'shop_name': shoapnamecontroll.text,
         'shop_location': shoaplocationcontroll.text,
         'is_mobile_appointment': appointment.toString(),
         'is_location_access': locationacess.toString(),
         'tag': json,
         'lattitude':shoaplat,
         'longitude': shoaplng,
         'shop_image':base64Image
       },
     );*/
    var request = http.MultipartRequest('POST', Uri.parse(URL_CreateShoap));
    request.headers.addAll({"Authorization": "Bearer $authorization"});
    request.files.add(
        await http.MultipartFile.fromPath(
            'shop_photo',
            imageFile.path
        )
    );
    request.fields['user_id'] = user_id;
    request.fields['shop_name'] = shoapnamecontroll.text;
    request.fields['shop_location'] = shoaplocationcontroll.text;
    request.fields['is_mobile_appointment'] = appointment.toString();
    request.fields['is_location_access'] = locationacess.toString();
    request.fields['tag'] = json;
    request.fields['lattitude'] = shoaplat;
    request.fields['longitude'] = shoaplng;
    var res = await request.send();
    var response=await http.Response.fromStream(res);
    String data = response.body;
    print(data);
    String status = jsonDecode(data)['status'].toString();

    EasyLoading.dismiss();
    if (status == '200') {
      String message = jsonDecode(data)['message'].toString();
      EasyLoading.showToast(message);
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('shoap_added', "done");
      Navigator.of(context).pushNamedAndRemoveUntil(BARBER_DASHBOARD,(Route<dynamic> route) => false);

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