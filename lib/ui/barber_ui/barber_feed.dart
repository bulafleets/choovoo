import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/feed_list_model.dart';
import 'package:choovoo/ui/client_ui/client_profile_forFeed.dart';
import 'package:choovoo/ui/feed/create_shop_feed.dart';
import 'package:choovoo/ui/feed/feed_Details.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/components/carousel/gf_carousel.dart';
import 'package:http/http.dart' as http;
import '../navigationDrawer.dart';
import 'barber_profile_forFeed.dart';

class BarberFeed extends StatefulWidget {
  @override
  _BarberFeedState createState() => _BarberFeedState();
}

class _BarberFeedState extends State<BarberFeed> {
  TextEditingController editingController = TextEditingController();
  bool loading=true;
  List<FeedlistModel> taglist = [];
  List<ImageModel> servicelist = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  @override
  void initState() {
  getfeedlist();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.Appbarcolor,
          actions: [
            Icon(
              Icons.notifications,
              color: Colors.white,
            ),
          ],
          title: Image.asset(
            "assets/round_logo.png",
            height: 50,
            width: 50,
          ),
          centerTitle: true,
        ),
        drawer: Theme(
            data: Theme.of(context).copyWith(
              canvasColor: Color(
                  0xff363636), //This will change the drawer background to blue.
              //other styles
            ),
            child: navigationDrawer()),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 300,
                  height: 50,
                  margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(78, 114, 136, .15),
                        )
                      ]),
                  child: TextField(
                    controller: editingController,
                    keyboardType: TextInputType.text,
                    cursorColor: Colors.grey,
                    style: TextStyle(
                        color: Color(0xFF4d5060), fontFamily: 'RobotoBold'),
                    onChanged: (val) {},
                    onTap: () {},
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Color(0xFFffffff),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFedf0fd)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Color(0xFFedf0fd)),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      prefixIcon: Icon(Icons.search,
                          color: Color(0xffb7c2d5), size: 20),
                      hintText: "Search Barber Community....",
                      hintStyle: TextStyle(color: Color(0xffb7c2d5)),
                      // contentPadding: const EdgeInsets.all(20),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CreateShopFeed()));
                        },
                        child: Icon(
                          Icons.add_circle,
                          color: Color(0xff1ad37f),
                          size: 40,
                        )))
              ],
            ),
            SizedBox(height: 15,),
            loading?Container(
              height: 400,
                alignment: Alignment.center,
                child: CircularProgressIndicator()):
            taglist.length==0?Center(
              child: Container(
                  height: 400,
                  alignment: Alignment.center,
                  child: Text("No Feeds",style: TextStyle(color:Colors.black,fontFamily: 'RobotoBold'),)),
            )
                : Expanded(
              child: ListView.builder(
                //physics: NeverScrollableScrollPhysics(),
                //shrinkWrap: true,
                // mainAxisAlignment: MainAxisAlignment.start,
              itemCount: taglist.length,
              itemBuilder: (_, indexX) {
              return  InkWell(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => FeedDetails(feedid: taglist[indexX].id,)));
                  },
                  child: Card(
                      child: Column(children: [
                        ListTile(
                            onTap: () {
                              if(taglist[indexX].isbarber) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            BarberProfileForFeed()));
                              }
                              else{
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ClientProfileForFeed()));
                              }
                            },
                            leading:  CachedNetworkImage(
                              imageUrl: taglist[indexX].photo,
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
                                size: 80,
                                color: Colors.red,
                              ),
                            ),
                            title: Text(taglist[indexX].name,
                                style: TextStyle(
                                    color: Color.fromRGBO(39, 159, 178, 1),
                                    fontWeight: FontWeight.bold)),
                            subtitle: Text(taglist[indexX].date)),
                        Container(
                          alignment: Alignment.topLeft,
                          padding: const EdgeInsets.all(7.0),
                          child: Text(
                            taglist[indexX].title,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color.fromRGBO(98, 125, 129, 1)),
                          ),
                        ),
                        Container(
                           /* color: Theme
                                .of(context)
                                .primaryColor,*/
                            child: CarouselSlider(
                              carouselController: _controller,
                              options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  aspectRatio: 2.0,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                              items: taglist[indexX].img_list.map(
                                    (url) {
                                  return Container(
                                   // margin: EdgeInsets.all(3.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                                      child: Image.network(
                                          url.feedphoto,
                                          fit: BoxFit.cover,
                                          width: 1000.0
                                      ),
                                    ),
                                  );
                                },
                              ).toList(),


                            ),
                        ),
                        Padding(
                            padding: const EdgeInsets.all(10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border:
                                            Border.all(
                                                color: Colors.grey[350])),
                                        child: Icon(Icons.thumb_up,
                                            color: Colors.grey[350])),
                                    SizedBox(width: 10),
                                    Text(
                                      taglist[indexX].totallike.toString()+" Likes",
                                      style: TextStyle(color: Colors.grey[350]),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                        onPressed: () {
                                          AddLikes(taglist[indexX].id,indexX);
                                        },
                                        icon:
                                        Icon(Icons.thumb_up,
                                            color: taglist[indexX].isLike?Colors.blue:Colors.grey[350])),
                                   /* IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.chat_rounded,
                                            color: Colors.grey)),*/
                                    IconButton(
                                        onPressed: () {},
                                        icon: Icon(
                                            Icons.share, color: Colors.grey)),
                                  ],
                                )
                              ],
                            ))
                      ])),
                );
              }),
            ),
          ],
        ));
  }

  Future<List<FeedlistModel>> getfeedlist() async {
    print("hello");
    try {
      final response = await http.post(Uri.parse(URL_GetFeedList), headers: { HttpHeaders.authorizationHeader: "Bearer $authorization"},
          body: {
            'user_id':user_id
          }
          );
      print("nikitaFFF");
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;
        var tagObjsJson = jsonDecode(data)['feeds'] as List;
        // var serviceObjsJson = jsonDecode(data)['getShopDetails']['servicePrice'] as List;
        List<FeedlistModel> tagObjs = tagObjsJson.map((tagJson) => FeedlistModel.fromJson(tagJson)).toList();
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
  Future<void> AddLikes(String feedid,int pos) async {

    final response = await http.post( Uri.parse(URL_AddLikeRemove,),headers: { HttpHeaders.authorizationHeader: "Bearer $authorization"},
      body: {
        'user_id': user_id,
        'feed_id': feedid,
      },
    );
    String data = response.body;
    print(data);
    String status = jsonDecode(data)['status'].toString();

    // EasyLoading.dismiss();
    if (status == "200") {
     setState(() {
       if( taglist[pos].isLike){
         taglist[pos].isLike=false;
         taglist[pos].totallike=taglist[pos].totallike-1;
       }
       else{
         taglist[pos].isLike=true;
         taglist[pos].totallike=taglist[pos].totallike+1;
       }

     });
      // Navigator.of(context).pushNamed(OTP_SCREEN);
    }
    if(status=="400"){
      String   message = jsonDecode(data)['message'];
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
      ));
    }
  }
}