class BarberAppointmentModel {
  String id;
  String shop_name;
  String status;
  String appointment_date;
  String time;
  String shop_location;
  String shop_photo;
  int totalAmt;
  // AddedSevriceModel service;
  List<BarberSevriceModel>service_list;


  BarberAppointmentModel({this.id, this.shop_name,this.status,this.appointment_date,this.shop_location,this.shop_photo,this.totalAmt,this.service_list,this.time});

  factory BarberAppointmentModel.fromJson(Map<String, dynamic> json) {
    if(json['service_tags']  != null){
      var tagObjsJson = json['service_tags'] as List;
      List<BarberSevriceModel> _tags = tagObjsJson.map((tagJson) => BarberSevriceModel.fromJson(tagJson)).toList();
      return BarberAppointmentModel(
          id: json["_id"] as String,
          shop_name: json["user_name"] as String,
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

class BarberSevriceModel {
  String id;
  String tagname;
  int price;

  BarberSevriceModel({this.id, this.tagname,this.price});

  factory BarberSevriceModel.fromJson(Map<String, dynamic> json) {
    return BarberSevriceModel(
      id: json["service_id"] as String,
      tagname: json["tag_name"] as String,
      price: json["tag_price"] as int,
    );
  }
  Map<String, dynamic> toJson() => {
    'service_id': id,
  };
}