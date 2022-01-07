import 'dart:convert';
import 'dart:io';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/model/friendList_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:http/http.dart' as http;
import '../navigationDrawer.dart';

class FriendsList extends StatefulWidget {
  @override
  State<FriendsList> createState() => _FriendsListState();
}

class _FriendsListState extends State<FriendsList> {
  bool loading = true;
  Future<FriendListModel> _future;
  @override
  void initState() {
    _future = friendListApi();
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
      body: FutureBuilder<FriendListModel>(
          future: _future,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.myAllFriends.length > 0) {
                var snapdata = snapshot.data.myAllFriends;
                return Scaffold(
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
                    title: Text('${(snapdata.length - 1).toString()}  Friends',
                        style: TextStyle(
                            fontFamily: 'RobotoBold',
                            fontWeight: FontWeight.bold,
                            fontSize: 16)),
                    centerTitle: true,
                  ),
                  body: ListView.builder(
                      itemCount: snapdata.length - 1,
                      itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.only(top: 20.0, left: 20),
                          child: InkWell(
                            onTap: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                                    // 'https://media.istockphoto.com/photos/millennial-male-team-leader-organize-virtual-workshop-with-employees-picture-id1300972574?b=1&k=20&m=1300972574&s=170667a&w=0&h=2nBGC7tr0kWIU8zRQ3dMg-C5JLo9H2sNUuDjQ5mlYfo='),
                                                    snapdata[index].avatar)),
                                            if (snapdata[index].isBarber)
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
                                        snapdata[index].name,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontFamily: 'RobotoBold',
                                            color:
                                                Color.fromRGBO(71, 85, 100, 1)),
                                      ),
                                    ]),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () =>
                                          DeleteRequest(snapdata[index].userId),
                                      child: Container(
                                          // width: 90,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8, horizontal: 15),
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              border: Border.all(
                                                  color: Color.fromRGBO(
                                                      112, 112, 112, 1))),
                                          child: Text('Unfriend',
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: Color.fromRGBO(
                                                      112, 112, 112, 1)))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0),
                                      child: Icon(Icons.arrow_forward_ios,
                                          size: 15,
                                          color:
                                              Color.fromRGBO(112, 112, 112, 1)),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ))
                      //   ListTile(
                      //       leading: Stack(alignment: Alignment.bottomRight, children: [
                      //         CircleAvatar(radius: 25),
                      //         Icon(Icons.cut, size: 15)
                      //       ]),
                      //       title: Row(
                      //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //         children: [
                      //           Text(
                      //             'Name lastname',
                      //             style: TextStyle(fontSize: 18),
                      //           ),
                      //           InkWell(
                      //             onTap: () {},
                      //             child: Container(
                      //                 // width: 90,
                      //                 padding: const EdgeInsets.symmetric(
                      //                     vertical: 8, horizontal: 15),
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(5),
                      //                     border: Border.all(color: Colors.grey)),
                      //                 child: Text('Unfriend',
                      //                     textAlign: TextAlign.center,
                      //                     style: TextStyle(color: Colors.grey))),
                      //           ),
                      //         ],
                      //       ),
                      //       trailing: IconButton(
                      //           onPressed: () {}, icon: Icon(Icons.arrow_forward_ios))),
                      // ),
                      ),
                );
              } else {
                return Scaffold(
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
                  ),
                  body: Center(
                    child: Text(
                      'No Friends',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'RobotoBold',
                          color: Color.fromRGBO(71, 85, 100, 1)),
                    ),
                  ),
                );
              }
            } else {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }
          }),
    );
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

  Future<FriendListModel> friendListApi() async {
    var apiData;
    try {
      final response = await http.post(Uri.parse(URL_FriendsList),
          headers: {HttpHeaders.authorizationHeader: "Bearer $authorization"},
          body: {'user_id': user_id});
      print("dddk");
      print(response.body);
      if (response.statusCode == 200) {
        String data = response.body;
        final jsonMap = jsonDecode(data);
        apiData = FriendListModel.fromJson(jsonMap);
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
