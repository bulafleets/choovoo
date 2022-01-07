import 'package:choovoo/constants/colors.dart';
import 'package:flutter/material.dart';

import 'navigationDrawer.dart';

class NotificationScreen extends StatelessWidget {
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
            backgroundColor: Color.fromRGBO(38, 38, 38, 1),
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back_ios)),
            ),
            title: Text('Notifications',
                style: TextStyle(
                    fontFamily: 'RobotoBold',
                    fontWeight: FontWeight.bold,
                    fontSize: 16)),
            centerTitle: true,
          ),
          body: Container(
              padding: const EdgeInsets.all(15),
              child: ListView(children: [
                SizedBox(height: 10),
                Card(
                  elevation: 5,
                  child: ListTile(
                      isThreeLine: true,
                      trailing:
                          IconButton(onPressed: () {}, icon: Icon(Icons.close)),
                      leading: SizedBox(
                          width: 40,
                          child: Row(children: [
                            Container(
                                height: 55, width: 4, color: Colors.green),
                            SizedBox(width: 5),
                            Icon(Icons.check_circle,
                                size: 30, color: Colors.green)
                          ])),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text('Payment Success',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'MontserratBold')),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                            'Congratulation! \$5400 release from choovoo wallet'),
                      )),
                )
              ])),
        ));
  }
}
