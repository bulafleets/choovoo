import 'dart:convert';
import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/appointment_model.dart';
import 'package:choovoo/ui/barber_ui/completed_list.dart';
import 'package:choovoo/ui/barber_ui/noshow_list.dart';
import 'package:choovoo/ui/barber_ui/scheduled_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:http/http.dart' as http;
import '../navigationDrawer.dart';

class BarberAppointmentList extends StatefulWidget {

  @override
  _BarberAppointmentListState createState() => _BarberAppointmentListState();
}

class _BarberAppointmentListState extends State<BarberAppointmentList> {
  double _height;
  double _width;
  double _pixelRatio;
  bool loading=true;
  List<AppointmentModel> taglist = [];
  List<AddedSevriceModel> servicelist = [];
  @override
  void initState() {
   // getAppointmentlist();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
print("barberid$user_id");
    return DefaultTabController(
        length: 3,  // Added
        initialIndex: 0,
        child:  Scaffold(
         // backgroundColor: AppColors.backgroundcolor,
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            backgroundColor: AppColors.Appbarcolor,
            /* leading: Text(name,style: TextStyle(color: Colors.white,),textAlign: Tex,
        ),*/
            title: Image.asset("assets/round_logo.png", height: 50,
              width: 50,),
            centerTitle: true,
            bottom: TabBar(
              labelColor: Color(0xffc68d43),
              unselectedLabelColor: Colors.white,
              indicatorColor: Colors.white,
              tabs: [
               // Tab(child: Text('All')),
                Tab(child: Text('Scheduled')),
                Tab(child: Text('Completed')),
                Tab(child: Text('No Show')),

              ],
            ),
          ),
          drawer: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Color(0xff363636), //This will change the drawer background to blue.
              ),
              child: navigationDrawer()),
          body:TabBarView(
            children: <Widget>[
            // Text("All"),
             ScheduledList(),
             CompletedList(),
            NoshowList(),
            ],
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



  Widget listwidget() {
    return ListView.builder(
      // scrollDirection: Axis.vertical,
      shrinkWrap: true,// outer ListView
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
        List<AppointmentModel> sec=[];
        for (var i=0;i<tagObjs.length;i++){
          if(tagObjs[i].status=="scheduled"){
            sec.add(tagObjs[i]);
          }
        }
        //List<AddedSevriceModel> serviceobj = serviceObjsJson.map((serviceobj) => AddedSevriceModel.fromJson(serviceobj)).toList();
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

}