class AppointmentModel {
  String id;
  String shop_name;
  String status;
  String appointment_date;
  String time;
  String shop_location;
  String shop_photo;
  int totalAmt;
 // AddedSevriceModel service;
  List<AddedSevriceModel>service_list;


  AppointmentModel({this.id, this.shop_name,this.status,this.appointment_date,this.shop_location,this.shop_photo,this.totalAmt,this.service_list,this.time});

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    if(json['service_tags']  != null){
      var tagObjsJson = json['service_tags'] as List;
      List<AddedSevriceModel> _tags = tagObjsJson.map((tagJson) => AddedSevriceModel.fromJson(tagJson)).toList();
    return AppointmentModel(
      id: json["_id"] as String,
      shop_name: json["shop_name"] as String,
        status: json["status"] as String,
        shop_location: json["shop_location"] as String,
        shop_photo: json["shop_photo"] as String,
        appointment_date: json["date"] as String,
        time: json["time"] as String,
        totalAmt: json["totalAmt"] as int,
       // service: json['service_tags'] != null ? new AddedSevriceModel.fromJson(json['service_tags']) : null
        service_list: _tags
    );
     }

  }
  Map<String, dynamic> toJson() => {
    'service_id': id,
  };
}

class AddedSevriceModel {
  String id;
  String tagname;
  int price;

  AddedSevriceModel({this.id, this.tagname,this.price});

  factory AddedSevriceModel.fromJson(Map<String, dynamic> json) {
    return AddedSevriceModel(
      id: json["service_id"] as String,
      tagname: json["tag_name"] as String,
      price: json["tag_price"] as int,
    );
  }
  Map<String, dynamic> toJson() => {
    'service_id': id,
  };
}