import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/ui/barber_ui/barber_profile_forFeed.dart';
import 'package:flutter/material.dart';

class FriendRequestAccept extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FriendRequestAcceptState();
}

class FriendRequestAcceptState extends State<FriendRequestAccept>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return
        // Scaffold(
        //   backgroundColor: Color.fromRGBO(250, 255, 252, 0.9),
        //   body:
        Center(
      child: Container(
        child: Material(
          color: Colors.transparent,
          child: ScaleTransition(
            scale: scaleAnimation,
            child: Container(
                margin: EdgeInsets.all(10.0),
                padding: EdgeInsets.all(10.0),
                height: 218.0,
                width: 320,
                decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                        side: BorderSide(
                            color: Color.fromRGBO(151, 151, 151, 1)))),
                child: Column(
                  children: <Widget>[
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Icon(Icons.check_circle_outline,
                          color: Color.fromRGBO(58, 255, 11, 1)),
                    ),
                    Text(
                      "Brenda Mills & you are friend\'s now.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16.0,
                          fontFamily: 'RobotoBold'),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: ButtonTheme(
                              child: RaisedButton(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                side: BorderSide(
                                    color: Color.fromRGBO(151, 151, 151, 1))),
                            splashColor: AppColors.Appbarcolor,
                            child: Text(
                              'OK',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.0),
                            ),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )),
                        ),
                        Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, right: 10.0),
                            child: ButtonTheme(
                                child: RaisedButton(
                              color: Color.fromRGBO(91, 91, 214, 1),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                  side: BorderSide(
                                      color: Color.fromRGBO(151, 151, 151, 1))),
                              splashColor: Colors.red,
                              child: Text(
                                'See Profile',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        BarberProfileForFeed()));
                              },
                            ))),
                      ],
                    )
                  ],
                )),
          ),
        ),
      ),
      // ),
    );
  }
}
