class ServiceModel {
  String id;
  String tagname;
  int price;
  bool ischecked;


  ServiceModel({this.id, this.tagname,this.price,this.ischecked});

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json["_id"] as String,
      tagname: json["tag_name"] as String,
      price: json["tag_price"] as int,
      ischecked: false,
    );
  }
  Map<String, dynamic> toJson() => {
    'service_id': id,
    'tag_price':price,
    'tag_name':tagname
  };
}