import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/BarberAppointment.dart';
import 'package:choovoo/model/appointment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../navigationDrawer.dart';

class ScheduledList extends StatefulWidget {

  @override
  _ScheduledListState createState() => _ScheduledListState();
}

class _ScheduledListState extends State<ScheduledList> {
  double _height;
  double _width;
  double _pixelRatio;
  bool loading=true;
  List<String> selectedItemValue = List<String>();
  List<BarberAppointmentModel> taglist = [];
  List<BarberSevriceModel> servicelist = [];
  @override
  void initState() {

    getAppointmentlist();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;

    return MaterialApp(
        home:  Scaffold(
          backgroundColor: AppColors.backgroundcolor,
          body: loading?Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator()):
          taglist.length==0?Container(
              alignment: Alignment.center,
              child: Text("No Scheduled Appointments",style: TextStyle(color:Colors.black,fontFamily: 'RobotoBold'),))
              :
          SingleChildScrollView(
            child: Column(
              //mainAxisSize: MainAxisSize.min,
              children: <Widget>[
               // titleRow(),
                listwidget()

              ],
            ),
          ),

          /* SingleChildScrollView(
          child: Column(

              children: <Widget>[
                titleRow(),
               listwidget(),

                ]
          ),
        ),*/
        )
    );
  }



  Widget titleRow() {
    return Container(
      color: Color(0xff363636),
      height: 50,
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 10,),
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
                            child: Icon(Icons.arrow_back_ios, size: 18,color: Colors.white,),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              //
              Text("Appointment List",style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w600)),
              Text("",style: TextStyle(color: Color(0xff3e5c7e),fontSize: 18,fontWeight: FontWeight.w600)),

            ],
          ),
        ],
      ),
    );
  }
  Widget listwidget() {
    return SizedBox(
      height: _height,
      child: ListView.builder(

        // scrollDirection: Axis.vertical,
        //shrinkWrap: true,// outer ListView
        itemCount: taglist.length,
        itemBuilder: (_, indexX) {
          print("appid${taglist[indexX].id}");
          for (int i = 0; i < taglist.length; i++) {
            selectedItemValue.add("Update Status");
          }
          return Container(
            margin: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: Color(0xffdedede),
              /*border: Border.all(
                  width: 1.0
              ),*/
              borderRadius: BorderRadius.all(
                  Radius.circular(8.0) //                 <--- border radius here
              ),
            ),
            //,
            child: Column(
              children: [
                ListTile(
                  onTap: ()async {

                  },
                  leading:
                  CachedNetworkImage(
                    imageUrl: taglist[indexX].shop_photo,
                    width: 80,
                    height: 80,
                    imageBuilder: (context, imageProvider) => Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image: imageProvider, fit: BoxFit.cover),
                      ),
                    ),
                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                        Container(alignment: Alignment.center,
                            child: CircularProgressIndicator(value: downloadProgress.progress)),
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      size: 100,
                      color: Colors.red,
                    ),
                  ),

                  title: Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(taglist[indexX].shop_name,style: TextStyle(fontFamily: 'RobotoBold')),
                        Text('\$ '+taglist[indexX].totalAmt.toString(),style: TextStyle(fontFamily: 'RobotoRegular'))
                      ],
                    ),

                  ),
                  subtitle: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.calendar_today, size: 14,color: Color(0xff6e6e6e),),
                                ),
                                TextSpan(
                                    text: " "+taglist[indexX].appointment_date,style: TextStyle(color: Color(0xff6e6e6e),fontFamily: 'RobotoRegular')
                                ),
                              ],
                            ),
                          ),

                          DropdownButton(
                            underline: SizedBox(),
                            value: selectedItemValue[indexX].toString(),
                            items: _dropDownItem(),
                            onChanged: (value) {
                              selectedItemValue[indexX] = value;
                              setState(() {});
                              UpdateStatus(taglist[indexX].id,value,indexX);
                            },
                            hint: Text('Status'),
                          ),

                        ],
                      ),
                     // SizedBox(height: 5,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          RichText(
                            text: TextSpan(
                              children: [
                                WidgetSpan(
                                  child: Icon(Icons.watch_later_outlined, size: 14,color: Color(0xff6e6e6e),),
                                ),
                                TextSpan(
                                    text: " "+taglist[indexX].time,style: TextStyle(color: Color(0xff6e6e6e),fontFamily: 'RobotoRegular')
                                ),
                              ],
                            ),
                          ),

                          Container(
                            child: Text(taglist[indexX].status,style: TextStyle(fontFamily: 'RobotoRegular',color: Color(0xff929d87)),),
                          ),

                        ],
                      ),
                    ],
                  ),

                ),
                SizedBox(height: 8,),
                Container(
                  //height: 50,
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: MediaQuery.of(context).size.width /
                              (MediaQuery.of(context).size.height / 4),
                        ),
                        shrinkWrap: true,
                        itemCount: taglist[indexX].service_list.length,
                        itemBuilder: (BuildContext ctx, index) {
                          servicelist=taglist[indexX].service_list;
                          return Container(

                            child: Text('\u2022  '+servicelist[index].tagname,textAlign: TextAlign.center,),
                          );
                        }

                    )
                  /*ListView.builder(
                    // inner ListView
                  shrinkWrap: true,
                   scrollDirection: Axis.horizontal,
                    physics: ClampingScrollPhysics(), // 2nd add
                    itemCount: taglist[indexX].service_list.length,
                    itemBuilder: (_, index) {
                      servicelist=taglist[indexX].service_list;
                    return  ListTile(title: Text(servicelist[index].tagname));
                    }
                  ),*/
                )
              ],
            ),
          );
        },
      ),
    );
  }
  List<DropdownMenuItem<String>> _dropDownItem() {
    List<String> ddl = ["Update Status", "Completed", "No Show"];
    return ddl
        .map((value) => DropdownMenuItem(
      value: value,
      child: Text(value,style: TextStyle(color: Color(0xff007aff),fontSize: 14,fontFamily: 'RobotoRegular'),),
    ))
        .toList();
  }
  Future<List<BarberAppointmentModel>> getAppointmentlist() async {
    print("hello$user_id");
    try {
      final response = await http.post(Uri.parse(URL_GetBarberAppointment), headers: { HttpHeaders.authorizationHeader: "Bearer $authorization"},
          body: {
            'user_id':user_id
          });
      print("nikitaFFF");
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;
        var tagObjsJson = jsonDecode(data)['data'] as List;
        // var serviceObjsJson = jsonDecode(data)['getShopDetails']['servicePrice'] as List;
        List<BarberAppointmentModel> tagObjs = tagObjsJson.map((tagJson) => BarberAppointmentModel.fromJson(tagJson)).toList();
        List<BarberAppointmentModel> sec=[];
        for (var i=0;i<tagObjs.length;i++){
          if(tagObjs[i].status=="scheduled"){
            sec.add(tagObjs[i]);
          }
        }
        taglist=sec;
        // servicelist = serviceobj;
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
  Future<void> UpdateStatus(String id,String ststatus,int index) async {


    final response = await http.post( Uri.parse(URL_UpdateStatus),headers: { HttpHeaders.authorizationHeader: "Bearer $authorization"},
      body: {
        '_id': id,
        'status': ststatus,
      },
    );
    // print(URL_OTP+widget.emailid);

    String data = response.body;
    print(data);
    String status = jsonDecode(data)['status'].toString();

    EasyLoading.dismiss();
    if (status == "200") {
      taglist.removeAt(index);
      setState(() {
      });
      String message = jsonDecode(data)['message'];
      EasyLoading.showToast(message);

      // Navigator.of(context).pushReplacementNamed(LOGIN);
    }
    if(status=="400"){
      String   message = jsonDecode(data)['message'];
      EasyLoading.showToast(message);
    }
  }

}