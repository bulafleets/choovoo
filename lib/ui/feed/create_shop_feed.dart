import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/constants/widget/responsive_ui.dart';
import 'package:choovoo/model/tag_model.dart';
import 'package:choovoo/ui/barber_ui/barber_shoap.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../navigationDrawer.dart';

class CreateShopFeed extends StatefulWidget {
   @override
  _CreateShopFeedState createState() => _CreateShopFeedState();
}

class _CreateShopFeedState extends State<CreateShopFeed> {

  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;

  TextEditingController titlecontrol = TextEditingController();
  TextEditingController postcontroll = TextEditingController();
  List<File> selectedimages = [];
  GlobalKey<FormState> _formkey = GlobalKey();
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  void initState() {

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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(Icons.notifications,color: Colors.white,),
          ),
        ],
        title: Image.asset("assets/round_logo.png", height: 40,
          width: 40,),
        centerTitle: true,

      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff363636), //This will change the drawer background to blue.
            //other styles
          ),
          child: navigationDrawer()),
      /*drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff363636), //This will change the drawer background to blue.
          ),
          child: navigationDrawer()),*/
      body: Container(
        margin: EdgeInsets.only(bottom: 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[

              skipText(),
              SizedBox(height:15,),
               Container(
                margin: EdgeInsets.only(left: 20,right: 20),
                width: MediaQuery.of(context).size.width,
                height: 150,
                alignment: Alignment.center,
                decoration: myBoxDecoration(),
                child: selectedimages.length!=0?carouselwidget(): Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: Text(
                        "Add Photos Or Videos",
                        style: TextStyle(fontSize: 14.0,color: Color(0xff8892a3),fontFamily: 'RobotoBold'),
                      ),
                    ),
                    SizedBox(height:10,),
                    GestureDetector(
                        onTap: () async {
                          FilePickerResult result = await FilePicker.platform.pickFiles(allowMultiple: true);

                          if(result != null) {
                            List<File> files = result.paths.map((path) => File(path)).toList();
                            setState(() {
                              selectedimages=files;
                            });

                          } else {
                            // User canceled the picker
                          }
                        },
                        child:
                        Icon(Icons.add_circle,size: 55,color: Color(0xff49b7cc),)
                    )
                  ],
                ),
                /*  GestureDetector(
                        onTap: () {
                          _showPicker(context);
                          // print("Routing to Sign up screen");
                        },
                        child:imageFile!= null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.file(
                            File(imageFile.path),
                            width: 100,
                            height: 100,
                            fit: BoxFit.fitHeight,
                          ),
                        ):
                        Image.asset(
                          'images/shoap.png',
                          height: _height/3.5,
                          width: _width/3.5,
                        ),

                      ),*/

              ),
              SizedBox(height:15,),

             // shoapnameform(),
              SizedBox(height:10,),
              form(),
              SizedBox(height:30,),
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

  Widget carouselwidget(){
   return SizedBox(
     height: 150,
       width: 400,
       child:
       CarouselSlider(
         options: CarouselOptions(),
         items: selectedimages
             .map((item) => Container(
           child:  ClipRRect(
             //borderRadius: BorderRadius.circular(50),
             child: Image.file(item,
               width: MediaQuery.of(context).size.width,
               height: 130,
               fit: BoxFit.fill,
             ),
           ),
         ))
             .toList(),
       )
   );
  }
  Widget skipText() {
    return Container(
      height: 80,
      alignment: Alignment.topCenter,
      color: Color(0xFFf7f7f7),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Icon(Icons.arrow_back_ios, size: 18,color: Color(0xff405d80),),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //
              Text("Upload Post",style: TextStyle(color:Color(0xff405d80),fontSize: 18,fontWeight: FontWeight.w600)),
              Text("",style: TextStyle(color: Color(0xff3e5c7e),fontSize: 18,fontWeight: FontWeight.w600)),

            ],
          ),
        ],
      ),
    );
  }


  Widget form() {
    return Container(

      child: Form(
        key: _formkey,
        child: Column(
          children: <Widget>[
            // firstNameTextFormField(),
            //SizedBox(height: _height/ 60.0),
           postformfield()
          ],
        ),
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

  Widget shoapnameTextFormField() {
    return TextField(
      controller: titlecontrol,
      keyboardType: TextInputType.text,
      cursorColor: Colors.grey,
      style:  TextStyle(color:Colors.black,  fontFamily: 'RobotoRegular',) ,
      onChanged: (val){
      },
      decoration: InputDecoration(
          filled: true,
          fillColor: Color(0xFFf2f5f7),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFf2f5f7)),
            borderRadius: BorderRadius.circular(8),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFf2f5f7)),
            borderRadius: BorderRadius.circular(8),
          ),
          border: OutlineInputBorder(),
          labelText: 'Type a post title here....',
          labelStyle: TextStyle(color:Color(0xFFa1bec2),  fontFamily: 'RobotoRegular',)
        //errorText: "Type a post title here...."
      ),
    );
  }

  Widget postformfield() {
    return Container(
      margin: EdgeInsets.only(
          left:_width/ 20.0,
          right: _width / 20.0,
          top:5),
      child: TextFormField(
        controller: postcontroll,
        validator:RequiredValidator(errorText: "Please add your post."),
        keyboardType: TextInputType.text,
        cursorColor: Colors.grey,
        maxLines: 4,
        style:  TextStyle(color:Colors.black,  fontFamily: 'RobotoRegular',) ,
        onChanged: (val){
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFf2f5f7),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFf2f5f7)),
              borderRadius: BorderRadius.circular(8),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFf2f5f7)),
              borderRadius: BorderRadius.circular(8),
            ),
            border: OutlineInputBorder(),
            labelText: 'Post text here....',
            labelStyle: TextStyle(color:Color(0xFFa1bec2),  fontFamily: 'RobotoRegular',)
          //errorText: "Type a post title here...."
        ),
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
          primary:Color(0xFF41d57a),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onPressed: () async {
            if(selectedimages.length==0){
              EasyLoading.showToast("Please upload image");
            }
         else{
              CreateShoap() ;
            }

          //  CreateShoap(json);

        },
        child: Text(
          "Upload To Community",style: TextStyle(color: Colors.white,fontSize: 16,fontFamily: 'RobotoBold'),
        ),
      ),
    );
  }



  Future<void> CreateShoap() async {
    print(user_id);
    var request = http.MultipartRequest('POST', Uri.parse(URL_FeedCreate));
    request.headers.addAll({"Authorization": "Bearer $authorization"});

   /* for (var i=0;i<selectedimages.length;i++){
      String ssss='media${[i]}';
      print(ssss);
      request.files.add(
          await http.MultipartFile.fromPath(
              'media${[i]}', selectedimages[i].path
            // imageFile.path
          )
      );
    }*/
    await Future.forEach(
        selectedimages,
            (file) async => {
    request.files.add(
        await http.MultipartFile.fromPath(
            'media', file.path
          // imageFile.path
        )
    )
  });

    request.fields['user_id'] = user_id;
    request.fields['title'] = postcontroll.text;
    print(request.fields);


     /*  await Future.forEach(
      selectedimages,
          (file) async => {
        request.files.add(
          http.MultipartFile(
            'media',
            (http.ByteStream(file.openRead())).cast(),
            await file.length(),
            filename: file.path.split('/').last,
          ),
        )
      },
    );*/

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