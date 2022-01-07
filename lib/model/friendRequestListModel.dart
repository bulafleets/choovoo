import 'dart:convert';

FriendRequestListModel friendRequestListModelFromJson(String str) =>
    FriendRequestListModel.fromJson(json.decode(str));

String friendRequestListModelToJson(FriendRequestListModel data) =>
    json.encode(data.toJson());

class FriendRequestListModel {
  FriendRequestListModel({
    this.status,
    this.myAllFriendRequests,
  });

  int status;
  List<MyAllFriendRequest> myAllFriendRequests;

  factory FriendRequestListModel.fromJson(Map<String, dynamic> json) =>
      FriendRequestListModel(
        status: json["status"],
        myAllFriendRequests: List<MyAllFriendRequest>.from(
            json["myAllFriendRequests"]
                .map((x) => MyAllFriendRequest.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "myAllFriendRequests":
            List<dynamic>.from(myAllFriendRequests.map((x) => x.toJson())),
      };
}

class MyAllFriendRequest {
  MyAllFriendRequest({
    this.userId,
    this.name,
    this.avatar,
    this.isBarber,
  });

  String userId;
  String name;
  String avatar;
  bool isBarber;

  factory MyAllFriendRequest.fromJson(Map<String, dynamic> json) =>
      MyAllFriendRequest(
        userId: json["user_id"],
        name: json["name"],
        avatar: json["avatar"],
        isBarber: json["isBarber"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId,
        "name": name,
        "avatar": avatar,
        "isBarber": isBarber,
      };
}
