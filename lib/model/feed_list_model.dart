class FeedlistModel {
  String id;
  String userid;
  String date;
  String name;
  String photo;
  String title;
  int totallike;
  int totalcomment;
  bool isfriend;
  bool isbarber;
  bool isLike;
  // AddedSevriceModel service;
  List<ImageModel>img_list;


  FeedlistModel({this.id, this.userid,this.date,this.name,this.photo,this.title,this.totallike,this.totalcomment,this.isbarber,this.isfriend,this.isLike,this.img_list});

  factory FeedlistModel.fromJson(Map<String, dynamic> json) {
    if(json['media']  != null){
      var tagObjsJson = json['media'] as List;
      List<ImageModel> _tags = tagObjsJson.map((tagJson) => ImageModel.fromJson(tagJson)).toList();
      return FeedlistModel(
          id: json["_id"] as String,
          userid: json["user_id"] as String,
          date: json["created_at"] as String,
          name: json["username"] as String,
          photo: json["avatar"] as String,
          title: json["title"] as String,
          totallike: json["totalFeedLikesCount"] as int,
          totalcomment: json["totalFeedCommentsCount"] as int,
          isfriend: json["isFriend"] as bool,
          isbarber: json["isBarber"] as bool,
          isLike: json["isLike"] as bool,
          // service: json['service_tags'] != null ? new AddedSevriceModel.fromJson(json['service_tags']) : null
          img_list: _tags
      );
    }

  }
  Map<String, dynamic> toJson() => {
    'service_id': id,
  };
}

class ImageModel {
  String feedphoto;

  ImageModel({this.feedphoto,});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      feedphoto: json["location"] as String,

    );
  }

}