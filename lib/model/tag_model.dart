class TagModel {
  String id;
  String tagname;
  int price;


  TagModel({this.id, this.tagname,this.price});

  factory TagModel.fromJson(Map<String, dynamic> json) {
    return TagModel(
      id: json["id"] as String,
      tagname: json["tag_name"] as String,
      price: json["__v"] as int,
    );
  }
  Map<String, dynamic> toJson() => {
    'tag_id': id,
    'tag_price': price,
  };
}