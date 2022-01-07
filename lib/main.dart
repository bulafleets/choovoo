
import 'package:choovoo/ui/LoginScreen.dart';
import 'package:choovoo/ui/Signup_screen.dart';
import 'package:choovoo/ui/barber_ui/barber_shoap.dart';
import 'package:choovoo/ui/client_ui/appointment_list.dart';
import 'package:choovoo/ui/final_getstart.dart';
import 'package:choovoo/ui/first_getstart.dart';
import 'package:choovoo/ui/forgot_password.dart';
import 'package:choovoo/ui/otp_screen.dart';
import 'package:choovoo/ui/profile_screen.dart';
import 'package:choovoo/ui/select_account.dart';
import 'package:choovoo/ui/set_newpassword.dart';
import 'package:choovoo/ui/splash_screen.dart';
import 'package:choovoo/utils/LocationProvider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants/common_params.dart';
GetIt getIt = GetIt.instance;
Future<void> main() async {
 /* AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
            channelKey: 'basic_channel',
            channelName: 'Basic notifications',
            channelDescription: 'Notification channel for basic tests',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white
        )
      ]
  );*/
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // initialize firebase before actual app get start.
 // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  getIt.registerSingleton(LocationProvider());
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.black
    ..backgroundColor = Colors.black
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = false
    ..dismissOnTap = false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login",
      theme: ThemeData(primaryColor: Colors.green[400]),
      routes: <String, WidgetBuilder>{
        SPLASH_SCREEN: (BuildContext context) =>  SplashScreen(),
        First_GetStart: (BuildContext context) =>  FirstGetStart(),
        FINAL_GET_START: (BuildContext context) =>  FinalGetStart(),
        SELECT_ACCOUNT: (BuildContext context) =>  SelectAccount(),
        SIGNUP: (BuildContext context) =>  SignUpScreen(),
        LOGIN: (BuildContext context) =>  LoginScreen(),
        FORGOTPASS: (BuildContext context) =>  ForgotScreen(),
        BARBER_DASHBOARD: (BuildContext context) =>  BarberDashboard(),
        SETPASSWORD: (BuildContext context) =>  SetPassword(),

      },
      initialRoute: SPLASH_SCREEN,
      builder: EasyLoading.init(),
    );
  }
}


