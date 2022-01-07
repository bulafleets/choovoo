import 'dart:convert';

FriendListModel friendListModelFromJson(String str) =>
    FriendListModel.fromJson(json.decode(str));

String friendListModelToJson(FriendListModel data) =>
    json.encode(data.toJson());

class FriendListModel {
  FriendListModel({
    this.status,
    this.myAllFriends,
  });

  int status;
  List<MyAllFriend> myAllFriends;

  factory FriendListModel.fromJson(Map<String, dynamic> json) =>
      FriendListModel(
        status: json["status"],
        myAllFriends: List<MyAllFriend>.from(
            json["myAllFriends"].map((x) => MyAllFriend.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "myAllFriends": List<dynamic>.from(myAllFriends.map((x) => x.toJson())),
      };
}

class MyAllFriend {
  MyAllFriend({
    this.userId,
    this.name,
    this.avatar,
    this.isBarber,
  });

  String userId;
  String name;
  String avatar;
  bool isBarber;

  factory MyAllFriend.fromJson(Map<String, dynamic> json) => MyAllFriend(
        userId: json["user_id"] == null ? null : json["user_id"],
        name: json["name"] == null ? null : json["name"],
        avatar: json["avatar"] == null ? null : json["avatar"],
        isBarber: json["isBarber"] == null ? null : json["isBarber"],
      );

  Map<String, dynamic> toJson() => {
        "user_id": userId == null ? null : userId,
        "name": name == null ? null : name,
        "avatar": avatar == null ? null : avatar,
        "isBarber": isBarber == null ? null : isBarber,
      };
}
