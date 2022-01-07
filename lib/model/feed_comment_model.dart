class FeedCommentModel {
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
  List<AllCommentModel>comment_list;


  FeedCommentModel({this.id, this.userid,this.date,this.name,this.photo,this.title,this.totallike,this.totalcomment,this.isbarber,this.isfriend,this.isLike,this.img_list,this.comment_list});

  factory FeedCommentModel.fromJson(Map<String, dynamic> json) {
    List<AllCommentModel> comments=[];
    if(json['media']  != null){
      var tagObjsJson = json['media'] as List;
      List<ImageModel> _tags = tagObjsJson.map((tagJson) => ImageModel.fromJson(tagJson)).toList();
      var feedJson = json['feed_comments'] as List;
      print("feeddddd${feedJson.length}");
      if(feedJson.length!=0){
        comments = feedJson.map((tagJson) => AllCommentModel.fromJson(tagJson)).toList();
      }
      return FeedCommentModel(
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
          img_list: _tags,
          comment_list: comments,
      );
    }

  }
  Map<String, dynamic> toJson() => {
    'service_id': id,
  };
}

class AllCommentModel {
  String id;
  String name;
  String userid;
  String comment;
  String userphoto;
  bool islike;

  AllCommentModel({this.id,this.name,this.userid,this.comment,this.islike,this.userphoto});

  factory AllCommentModel.fromJson(Map<String, dynamic> json) {
    return AllCommentModel(
      id: json["_id"] as String,
      name: json["username"] as String,
      userid: json["user_id"] as String,
      comment: json["comment"] as String,
      userphoto: json["avatar"] as String,
      islike: json["isLike"] as bool,

    );
  }

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