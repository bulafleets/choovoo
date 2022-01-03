import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/ui/client_ui/book_appointment.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../navigationDrawer.dart';

class BarberProfileUser extends StatefulWidget {
  String shop_id;
  String shop_photo;
  String shop_loc;
  String shop_km;
  String shop_name;
  String minprice;
  String maxprice;

  BarberProfileUser({ Key key, this.shop_id, this.shop_photo, this.shop_loc,this.shop_km,this.shop_name,this.minprice,this.maxprice}) : super(key: key);

  @override
  _BarberProfileUserState createState() => _BarberProfileUserState();
}

class _BarberProfileUserState extends State<BarberProfileUser> {
  double _height;
  double _width;
  double _pixelRatio;
  bool _large;
  bool _medium;
  TextEditingController namecontroll = TextEditingController();
  GlobalKey<FormState> _formkey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    bool keyboardIsOpened = MediaQuery
        .of(context)
        .viewInsets
        .bottom != 0.0;
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;
    _pixelRatio = MediaQuery
        .of(context)
        .devicePixelRatio;

    return Scaffold(
            /*floatingActionButton: keyboardIsOpened ?
          null :nextbutton(),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,*/
            backgroundColor: Colors.transparent,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.Appbarcolor,
        title: Image.asset("assets/round_logo.png", height: 50,
          width: 50,),
        centerTitle: true,
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xff363636), //This will change the drawer background to blue.
            //other styles
          ),
          child: navigationDrawer()),
            body: Container(
              height: _height,
              width: _width,
              margin: EdgeInsets.only(bottom: 5),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(left: 15,right: 15),

                      child: titleRow(),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    shopimg(),
                    SizedBox(height: 10,),
                    topText(),
                    SizedBox(height: 5,),
                    midle(),
                    SizedBox(height: 5,),
                    last(),
                    SizedBox(height: 5,),
                    pricewidget(),
                    SizedBox(height:30,),
                    nextbutton(),
                    SizedBox(height: _height / 25,),
                    //nextbutton()

                    //signInTextRow(),
                  ],
                ),
              ),
            ),
    );
  }
Widget shopimg(){
    return CachedNetworkImage(
      width:double.infinity,
      height: 250,
      fit: BoxFit.cover,
      imageUrl: widget.shop_photo,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
      errorWidget: (context, url, error) => Icon(
        Icons.error,
        size: 100,
        color: Colors.red,
      ),
    );
}
  Widget midle(){
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15),
      child:
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              widget.shop_loc,
              style: TextStyle(
                color: Color(0xff4a578b),
                fontWeight: FontWeight.w400,
                fontSize: 16,
              ),
            ),
          ),
    );
  }
  Widget last(){
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15),
      child:
      Align(
        alignment: Alignment.topLeft,
        child: Text(
          widget.shop_km+" Km. away",
          style: TextStyle(
            color: Color(0xff4a578b),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  Widget pricewidget(){
    return Container(
      margin: EdgeInsets.only(left: 15,right: 15),
      child:
      Align(
        alignment: Alignment.topLeft,
        child: Text(
         "Prices from \$"+widget.minprice+"-"+"\$"+widget.maxprice,
          style: TextStyle(
            color: Color(0xff4a578b),
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
  Widget topText() {
    return Container(
    margin: EdgeInsets.only(left: 15,right: 15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  widget.shop_name,
                  style: TextStyle(
                    color: Color(0xff4a578b),
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ),
              Container(
                height: 30,
               alignment: Alignment.center,
               // margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(3.0),
                decoration: BoxDecoration(
                    border: Border.all(color:Color(0xffa9a9a9))
                ),
                child: Text('Friend Request',style: TextStyle(color: Color(0xffa9a9a9)),),
              )
            ],
          ),
         /*
          Text(
            widget.shop_km+" "+"Km. away",
            style: TextStyle(
              color: Color(0xff4a578b),
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
          ),*/
        ],
      ),
    );
  }
  Widget titleRow() {
    return Container(
      alignment: Alignment.topLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 15,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  Navigator.pop(context);
                },
                child: RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Icon(Icons.arrow_back_ios, size: 18,color: Color(0xff3e5c7e),),
                      ),
                      TextSpan(
                          text: "Back ",style: TextStyle(color: Color(0xff3e5c7e),fontSize: 18,fontWeight: FontWeight.w600)
                      ),
                    ],
                  ),
                ),
              ),
             //
              Text(widget.shop_name,style: TextStyle(color: Color(0xff3e5c7e),fontSize: 18,fontWeight: FontWeight.w600)),
              Icon(Icons.settings, size: 30.0,color:Color(0xff3e5c7e) ,)

            ],
          ),
        ],
      ),
    );
  }
  Widget nextbutton(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary:Color(0xFF2880f7),
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
        ),
        onPressed: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => BookAppointment(shop_id: widget.shop_id,))

          );

        },
        child: Text(
          "Book Appointment",style: TextStyle(color: Colors.white,fontSize: 18),
        ),
      ),
    );
  }

}