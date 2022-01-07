import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/feed_comment_model.dart';
import 'package:choovoo/ui/barber_ui/barber_appointment_list.dart';
import 'package:choovoo/ui/barber_ui/barber_profile.dart';
import 'package:choovoo/ui/navigationDrawer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class FeedDetails extends StatefulWidget {
  final String feedid;
  FeedDetails({ Key key, this.feedid}) : super(key: key);
  @override
  _FeedDetailsState createState() => _FeedDetailsState();
}

class _FeedDetailsState extends State<FeedDetails> {
  TextEditingController editingController = TextEditingController();
  int selectedpage = 1;
  bool loading=true;
  List<FeedCommentModel> taglist = [];
  List<ImageModel> servicelist = [];
  List<AllCommentModel> allcomments = [];
  int _current = 0;
  final CarouselController _controller = CarouselController();
  void _selectPage(int index) {
    setState(() {
      selectedpage = index;
      if (selectedpage == 0) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => BarberProfile()));
      }
      if (selectedpage == 2) {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => BarberAppointmentList()));
      }
    });
  }
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
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Color(0xff1a1c1d),
        unselectedItemColor: Color(0xff696e71),
        showUnselectedLabels: true,
        selectedFontSize: 18,
        selectedIconTheme: IconThemeData(color: Colors.white, size: 30),
        selectedItemColor: Colors.white,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        currentIndex: selectedpage,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            backgroundColor: Color(0xff465258),
            icon: Icon(Icons.favorite),
            label: 'Shop feed',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_online),
            label: 'Appointment',
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height - 220,
        child: Column(

          children: [
            _spacer(),
            loading?Container(
                alignment: Alignment.center,
                child: CircularProgressIndicator()):
            Expanded(
              child:  ListView.builder(
            itemCount: taglist.length,
          itemBuilder: (_, indexX) {
            return InkWell(
             child: Card(
                child: Column(
                  children: [
                    ListTile(
                      onTap: () {},
                      leading: CachedNetworkImage(
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
                      subtitle: Text(taglist[indexX].date),
                      trailing: Container(
                          padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          decoration: BoxDecoration(
                              border:
                              Border.all(color: Color.fromRGBO(112, 112, 112, 1)),
                              borderRadius: BorderRadius.circular(5)),
                          child: Text(taglist[indexX].isfriend?'Unfriend':'Add Friend',
                              style:
                              TextStyle(color: Color.fromRGBO(112, 112, 112, 1)))),
                    ),

              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  taglist[indexX].title,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Color.fromRGBO(98, 125, 129, 1)),
                ),
              ),
              Container(
                  /*color: Theme
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
                                    border: Border.all(color: Colors
                                        .grey[400])),
                                child: Icon(Icons.thumb_up,
                                    color: Colors.grey[400])),
                            SizedBox(width: 10),
                            Text(
                                taglist[indexX].totallike.toString()+" Likes",
                              style: TextStyle(color: Colors.grey[400]),
                            ),
                          ],
                        ),
                        Row(children: [
                          IconButton(
                              onPressed: () {
                                AddLikes(taglist[indexX].id,indexX);
                              },
                              icon: Icon(Icons.thumb_up,
                                  color: taglist[indexX].isLike?Colors.blue:Colors.grey[350], size: 30)),
                         /* IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.chat_rounded,
                                  color: Color.fromRGBO(13, 222, 206, 1),
                                  size: 30)),*/
                          IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.share_outlined,
                                  color: Colors.grey[400], size: 30)),
                        ])
                      ])),
                  ],
                ),
             ),
              /*_spacer(),
              ListTile(
                // isThreeLine: true,
                leading: CircleAvatar(radius: 25),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'PaulMacy8',
                    style: TextStyle(color: Color.fromRGBO(75, 75, 82, 1)),
                  ),
                ),
                subtitle: Text(
                  'Thank you for commenting this post',
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Icon(Icons.favorite, color: Colors.pink),
              ),
              _spacer(),
              ListTile(
                leading: CircleAvatar(radius: 25),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    'Luckytwoshoes',
                    style: TextStyle(
                      color: Color.fromRGBO(75, 75, 82, 1),
                    ),
                  ),
                ),
                subtitle: Text(
                  'With this online tool you can upload an image or provide a website URL and get the RGB Color, HEX Color and HSL Color code',
                  style: TextStyle(color: Colors.grey),
                ),
                trailing: Icon(Icons.favorite_border),
              ),*/
            );
          }
              )),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(5),
        color: Colors.black,
        child: TextField(
          controller: editingController,
          keyboardType: TextInputType.text,
          cursorColor: Colors.grey,
          style: TextStyle(color: Color(0xFF4d5060), fontFamily: 'RobotoBold'),
          onChanged: (val) {},
          onTap: () {},
          decoration: InputDecoration(
            filled: true,
            fillColor: Color(0xFFffffff),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFedf0fd)),
              borderRadius: BorderRadius.circular(25),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFedf0fd)),
              borderRadius: BorderRadius.circular(20),
            ),
            suffixIcon: Icon(Icons.arrow_forward_ios, color: Color(0xffb7c2d5)),
            // labelText: "Search Barber Community....",
            contentPadding: EdgeInsets.all(20.0),
            hintText: ' Write comment...',
            hintStyle: TextStyle(color: Color(0xffb7c2d5)),
            labelStyle: TextStyle(color: Color(0xffb7c2d5)),
            border: OutlineInputBorder(),
          ),
        ),
      ),
    );
  }

  Widget _spacer() {
    return SizedBox(height: 15);
  }
  Future<List<FeedCommentModel>> getfeedlist() async {
    print("hello");
    try {
      final response = await http.post(Uri.parse(URL_GetFeedDetail), headers: { HttpHeaders.authorizationHeader: "Bearer $authorization"},
          body: {
            'feed_id':widget.feedid
          }
      );
      print("nikitaFFF");
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;
        var tagObjsJson = jsonDecode(data)['feed'] as List;
        // var serviceObjsJson = jsonDecode(data)['getShopDetails']['servicePrice'] as List;
        List<FeedCommentModel> tagObjs = tagObjsJson.map((tagJson) => FeedCommentModel.fromJson(tagJson)).toList();
        //List<AddedSevriceModel> serviceobj = serviceObjsJson.map((serviceobj) => AddedSevriceModel.fromJson(serviceobj)).toList();
        taglist=tagObjs;
        print("listlenth${taglist.length}");
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
