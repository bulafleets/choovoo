import 'package:cached_network_image/cached_network_image.dart';
import 'package:choovoo/constants/colors.dart';
import 'package:flutter/material.dart';
import '../navigationDrawer.dart';

class BarberProfileForFeed extends StatefulWidget {
  @override
  _BarberProfileForFeedState createState() => _BarberProfileForFeedState();
}

class _BarberProfileForFeedState extends State<BarberProfileForFeed> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.Appbarcolor,
        actions: [
          Icon(
            Icons.notifications,
            color: Colors.white,
          ),
        ],
        title: Image.asset(
          "assets/round_logo.png",
          height: 50,
          width: 50,
        ),
        centerTitle: true,
      ),
      drawer: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(
                0xff363636), //This will change the drawer background to blue.
            //other styles
          ),
          child: navigationDrawer()),
      body: Scaffold(
          appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios, color: Colors.black)),
              centerTitle: true,
              title: Text('Barber shop name',
                  style: TextStyle(
                      color: Color.fromRGBO(4, 33, 77, 1),
                      fontWeight: FontWeight.bold))),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(25.0),
                  child: Image.network(
                    'https://st2.depositphotos.com/2931363/9695/i/950/depositphotos_96952028-stock-photo-young-handsome-man-in-barbershop.jpg',
                    fit: BoxFit.cover,
                  )),
              SizedBox(height: 10),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('Barber shop name',
                        style: TextStyle(
                            color: Color.fromRGBO(4, 33, 77, 1),
                            fontWeight: FontWeight.bold,
                            fontSize: 22)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text('10.4 mil away',
                        style: TextStyle(color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Text(
                      'Price from \$5 to \$15',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                  Row(
                    children: [
                      Icon(Icons.star_rate, color: Colors.yellow[700]),
                      Icon(Icons.star_rate, color: Colors.yellow[700]),
                      Icon(Icons.star_rate, color: Colors.yellow[700]),
                      Icon(Icons.star_half, color: Colors.yellow[700]),
                    ],
                  )
                  // Text(
                  //   '***',
                  //   style: TextStyle(color: Colors.grey),
                  // ),
                ]),
                Column(children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                        width: 140,
                        height: 50,
                        alignment: Alignment.center,
                        // padding: const EdgeInsets.symmetric(
                        //     vertical: 11, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey),
                            color: Colors.blue),
                        child: Text('Chat',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.white, fontSize: 18))),
                  ),
                  SizedBox(height: 10),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        width: 140,
                        height: 50,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.grey)),
                        child: Text('Unfriend',
                            textAlign: TextAlign.center,
                            style:
                                TextStyle(color: Colors.grey, fontSize: 18))),
                  ),
                ])
              ]),
              SizedBox(height: 15),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hearcut',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text('888\$',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Beard',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text('788\$',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ]),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Hearcut & Beard',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                      Text('988\$',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20)),
                    ]),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Special Hearcut',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                        Text('588\$',
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)),
                      ])),
              SizedBox(height: 10.0),
              ElevatedButton(
                  onPressed: () {},
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text('Book Appointment',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18)),
                  )),
              SizedBox(height: 20.0)
            ]),
          )),
    );
  }
}
