import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/appointment_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import '../navigationDrawer.dart';

class AppointmentList extends StatefulWidget {

  @override
  _AppointmentListState createState() => _AppointmentListState();
}

class _AppointmentListState extends State<AppointmentList> {
  double _height;
  double _width;
  double _pixelRatio;
  bool loading=true;
  List<AppointmentModel> taglist = [];
  List<AddedSevriceModel> servicelist = [];
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
        child: CircularProgressIndicator()):
    SingleChildScrollView(
      child: Column(
        //mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          titleRow(),
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
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        primary: false,
        //shrinkWrap: false,// outer ListView
        itemCount: taglist.length,
        itemBuilder: (_, indexX) {
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
                      SizedBox(height: 5,),
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

                          Container(
                            child: Text( "Status",style: TextStyle(fontFamily: 'RobotoRegular'),),
                          ),

                        ],
                      ),
                      SizedBox(height: 5,),
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
                            child: Text(taglist[indexX].status,style: TextStyle(fontFamily: 'RobotoBold',color: Color(0xff7dc27e)),),
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
  Future<List<AppointmentModel>> getAppointmentlist() async {
    print("hello");
    try {
      final response = await http.post(Uri.parse(URL_GetUserAppointment), headers: { HttpHeaders.authorizationHeader: "Bearer $authorization"},
          body: {
            'user_id':user_id
          });
      print("nikitaFFF");
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;
        var tagObjsJson = jsonDecode(data)['data'] as List;
        // var serviceObjsJson = jsonDecode(data)['getShopDetails']['servicePrice'] as List;
        List<AppointmentModel> tagObjs = tagObjsJson.map((tagJson) => AppointmentModel.fromJson(tagJson)).toList();
        //List<AddedSevriceModel> serviceobj = serviceObjsJson.map((serviceobj) => AddedSevriceModel.fromJson(serviceobj)).toList();
        taglist=tagObjs;
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

}