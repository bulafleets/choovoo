import 'package:choovoo/constants/colors.dart';
import 'package:choovoo/constants/common_params.dart';
import 'package:choovoo/ui/final_getstart.dart';
import 'package:choovoo/ui/first_getstart.dart';
import 'package:choovoo/utils/Bouncing.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectAccount extends StatefulWidget {
  @override
  SelectAccountState createState() => new SelectAccountState();
}

class SelectAccountState extends State<SelectAccount>{
  bool isselect=false;
  bool iscustclicked=false;
  bool isbarbtclicked=false;

 // final ButtonStyle nextstyle =

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset(
          'assets/background.png',
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Scaffold(
          floatingActionButton: isselect?nextbutton():null,
          floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
          backgroundColor: Colors.transparent,
          body: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
               // SizedBox(height: 30,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text("User Type",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 23,color: Colors.white,fontFamily: "MontserratBold"),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height: 15,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text("Please Choose One Option For Continue This App",
                      style:
                      TextStyle(fontWeight: FontWeight.bold, fontSize: 15,color: Colors.white,fontFamily: "RobotoBold"),
                      textAlign: TextAlign.center),
                ),
                SizedBox(height:50,),
                Container(
                  width: MediaQuery.of(context).size.width,
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      SizedBox(
                        height: 30,
                      ),

                      Bouncing(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          height: 100,
                          margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child:
                          RaisedButton(
                              onPressed: () => {
                              setState(() {
                              AccountType="CUSTOMER";
                              isselect=true;
                              iscustclicked=true;
                              isbarbtclicked=false;
                              })
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 10 ),
                                child:Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child:iscustclicked? new Image.asset('assets/client.png',height: 50,width: 50,):new Image.asset('images/unclient.png',height: 50,width: 50,)
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only( left: 10.0 ),
                                        child: Text('Client',style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "RobotoRegular",fontWeight: FontWeight.bold))
                                    )
                                  ],
                                ),
                              ),
                              color: iscustclicked?Color(0xFF817353):Color(0xFF37495F).withOpacity(0.3),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(12.0)
                              )
                          ),
                         /* ElevatedButton.icon(
                            icon: new Image.asset('assets/client.png',),
                            label: Text('Client',style: TextStyle(color: Colors.white,fontSize: 18)),
                            onPressed: () {
                              setState(() {
                                AccountType="CUSTOMER";
                                isselect=true;
                                iscustclicked=true;
                                isbarbtclicked=false;
                              });
                             // print('Pressed');
                            },
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary: iscustclicked?Color(0xFF37495F):Color(0xFF817353),
                              minimumSize: Size(88, 36),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          )*/
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        margin: const EdgeInsets.only(left: 20.0, right: 20.0),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                          child:
                          RaisedButton(
                              onPressed: () => {
                                setState(() {
                                  AccountType="BARBER";
                                  isselect=true;
                                  iscustclicked=false;
                                  isbarbtclicked=true;
                                })
                              },
                              child: Container(
                                padding: const EdgeInsets.only(top: 10.0, bottom: 10 ),
                                child:Row(
                                  children: [
                                    Align(
                                        alignment: Alignment.centerLeft,
                                        child: isbarbtclicked?new Image.asset('assets/barber.png',height: 50,width: 50,):new Image.asset('images/unbarber.png',height: 50,width: 50,)
                                    ),
                                    Container(
                                        margin: const EdgeInsets.only( left: 10.0 ),
                                        child: Text('Barber',style: TextStyle(color: Colors.white,fontSize: 18,fontFamily: "RobotoRegular",fontWeight: FontWeight.bold))
                                    )
                                  ],
                                ),
                              ),
                              color: isbarbtclicked?Color(0xFF817353):Color(0xFF37495F).withOpacity(0.3),
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(12.0)
                              )
                          ),
                         /* ElevatedButton.icon(
                            icon: new Image.asset('assets/barber.png',),
                            label: Text('Barber',style: TextStyle(color: Colors.white,fontSize: 18)),
                            onPressed: () {
                              setState(() {
                                AccountType="BARBER";
                                isselect=true;
                                iscustclicked=false;
                                isbarbtclicked=true;
                              });
                            },
                            style: ElevatedButton.styleFrom(
                              onPrimary: Colors.white,
                              primary:isbarbtclicked?Color(0xFF37495F):Color(0xFF817353),
                              minimumSize: Size(88, 36),
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(8)),
                              ),
                            ),
                          )*/
                      ),
                      SizedBox(
                        height: 10,
                      ),


                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget nextbutton(){
   return Container(
      width: MediaQuery.of(context).size.width,
      height: 60,
      margin: const EdgeInsets.only(left: 20.0, right: 20.0),
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary:isselect?Color(0xFF1890d8):Colors.blue.shade300,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.symmetric(horizontal: 16),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          ),
        ),
        onPressed: () {
          if(isselect==false){
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Please Select Type"),
            ));
          }
          else{
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FirstGetStart()));
          }

        },
        child: Text(
          "Next",style: TextStyle(color: Colors.white,fontSize: 18),
        ),
      ),
    );
  }
}