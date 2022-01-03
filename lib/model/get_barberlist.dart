class GetBarber {
  String id;
  String shoapname;
  String shoaploc;
  String shop_photo;
  bool isappointment;
  bool locacess;
  double shoplat;
  double shoplng;
  int minprice;
  int maxprice;


  GetBarber({this.id, this.shoapname, this.shoaploc,this.shop_photo,this.isappointment,this.locacess,this.shoplat,this.shoplng,this.minprice,this.maxprice});

  factory GetBarber.fromJson(Map<String, dynamic> json) {
    return GetBarber(
      id: json["_id"] as String,
      shoapname: json["shop_name"] as String,
      shoaploc: json["shop_location"] as String,
      shop_photo: json["shop_photo"] as String,
      isappointment: json["is_mobile_appointment"] as bool,
      locacess: json["is_location_access"] as bool,
      shoplat: json["lattitude"] as double,
      shoplng: json["longitude"] as double,
      minprice: json["min_price"] as int,
      maxprice: json["max_price"] as int,
    );
  }
}