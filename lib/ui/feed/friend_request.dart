import 'dart:convert';
import 'dart:io';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/friendRequestListModel.dart';
import 'package:choovoo/ui/feed/friend_request_accept.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

import '../navigationDrawer.dart';
import 'package:http/http.dart' as http;

class FriendRequest extends StatefulWidget {
  @override
  State<FriendRequest> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequest> {
  var loading = false;
  Future<FriendRequestListModel> _future;
  @override
  void initState() {
    _future = friendRequestApi();
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
        body: Scaffold(
            appBar: AppBar(
              backgroundColor: Color.fromRGBO(38, 38, 38, 1),
              leading: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(Icons.arrow_back_ios)),
              ),
              title: Text('Friend\'s requests',
                  style: TextStyle(
                      fontFamily: 'RobotoBold',
                      fontWeight: FontWeight.bold,
                      fontSize: 16)),
              centerTitle: true,
            ),
            body: FutureBuilder<FriendRequestListModel>(
                future: _future,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.myAllFriendRequests.length != 0) {
                      return ListView.builder(
                          itemCount: snapshot.data.myAllFriendRequests.length,
                          itemBuilder: (context, index) => Padding(
                              padding:
                                  const EdgeInsets.only(top: 20.0, left: 20),
                              child: InkWell(
                                onTap: () {},
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Stack(
                                              alignment: Alignment.bottomRight,
                                              children: [
                                                CircleAvatar(
                                                  radius: 25,
                                                  backgroundImage: NetworkImage(
                                                      snapshot
                                                          .data
                                                          .myAllFriendRequests[
                                                              index]
                                                          .avatar),
                                                ),
                                                Container(
                                                    height: 20,
                                                    width: 20,
                                                    decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: Colors.white,
                                                    ),
                                                    child: Icon(
                                                      Icons.cut,
                                                      size: 11,
                                                      color: Color.fromRGBO(
                                                          79, 24, 233, 1),
                                                    ))
                                              ]),
                                          SizedBox(width: 15),
                                          Text(
                                            snapshot.data
                                                .myAllFriendRequests[index].name
                                                .toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontFamily: 'RobotoBold',
                                                color: Color.fromRGBO(
                                                    71, 85, 100, 1)),
                                          ),
                                        ]),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () => DeleteRequest(snapshot
                                              .data
                                              .myAllFriendRequests[index]
                                              .userId),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text('Decline',
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      223, 46, 46, 1),
                                                  fontSize: 15,
                                                )),
                                          ),
                                        ),
                                        SizedBox(width: 15),
                                        InkWell(
                                          onTap: () => AcceptRequest(snapshot
                                              .data
                                              .myAllFriendRequests[index]
                                              .userId),
                                          child: Container(
                                              // width: 90,
                                              // height: 35,
                                              width: 105,
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 8,
                                                      horizontal: 15),
                                              decoration: BoxDecoration(
                                                  color: Color.fromRGBO(
                                                      106, 101, 246, 0.93),
                                                  borderRadius:
                                                      BorderRadius.circular(5),
                                                  border: Border.all(
                                                      color: Color.fromRGBO(
                                                          112, 112, 112, 1))),
                                              child: Text('Accept',
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15,
                                                  ))),
                                        ),
                                        SizedBox(width: 20)
                                      ],
                                    )
                                  ],
                                ),
                              )));
                    } else {
                      return Center(
                        child: Text(
                          'No Friend Requests',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'RobotoBold',
                              color: Color.fromRGBO(71, 85, 100, 1)),
                        ),
                      );
                    }
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                })));
  }

  Future<void> AcceptRequest(String requester_id) async {
    final response = await http.post(Uri.parse(URL_Accept), body: {
      'requester_id': requester_id,
      'accepter_id': user_id,
      'accept_status': 'true',
    }, headers: {
      HttpHeaders.authorizationHeader: "Bearer $authorization"
    });
    EasyLoading.dismiss();
    String data = response.body;
    String status = jsonDecode(data)['status'].toString();
    print(data);

    if (status == '200') {
      String message = jsonDecode(data)['message'];
      showDialog(context: context, builder: (_) => FriendRequestAccept());
    } else if (status == '400') {
      String message = jsonDecode(data)['message'];
      EasyLoading.showToast(message);
    } else {
      EasyLoading.showToast("Something Happen Wrong");
    }
  }

  Future<void> DeleteRequest(String sender_id) async {
    final response = await http.post(Uri.parse(URL_Delete), body: {
      'sender_id': sender_id,
      'reciever_id': user_id,
    }, headers: {
      HttpHeaders.authorizationHeader: "Bearer $authorization"
    });
    EasyLoading.dismiss();
    String data = response.body;
    String status = jsonDecode(data)['status'].toString();
    print(data);

    if (status == '200') {
      String message = jsonDecode(data)['message'];
      EasyLoading.showInfo(message);
    } else if (status == '400') {
      String message = jsonDecode(data)['message'];
      EasyLoading.showToast(message);
    } else {
      EasyLoading.showToast("Something Happen Wrong");
    }
  }

  Future<FriendRequestListModel> friendRequestApi() async {
    var apiData;
    try {
      final response = await http.post(Uri.parse(URL_FriendRequest),
          headers: {HttpHeaders.authorizationHeader: "Bearer $authorization"},
          body: {'user_id': '61b99713e82d08473fe421a7'});
      print("dddk");
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;
        final jsonMap = jsonDecode(data);
        apiData = FriendRequestListModel.fromJson(jsonMap);
        setState(() {
          loading = false;
        });
        return apiData;
      } else {
        setState(() {
          loading = false;
        });
        // return [];
      }
    } catch (e) {
      print(e.toString());
      // return [];
    }
  }
}
