import 'package:google_maps_flutter/google_maps_flutter.dart';

final String SPLASH_SCREEN ='splashscreen';
final String First_GetStart ='firstgetstart';
final String SELECT_ACCOUNT ='selectaccount';
final String SIGNUP ='signup';
final String LOGIN ='login';
final String OTPSCREEn ='otp';
final String FORGOTPASS ='forgotpass';
final String PROFILESCREEN ='profile';
final String FINAL_GET_START ='finalgetstrat';
final String BARBER_DASHBOARD ='barberdashboard';
final String APPointment_List ='appointmentlist';
final String SETPASSWORD ='setpassword';
 String AccountType ='';

String name="";
String email="";
String phoneno="";
String user_id="";
String gender="";
String dob="";
String profileimg="";
String password="";
String authorization="";
LatLng currentaddress = null;

final String BASE = "http://13.234.31.171/api/";
final String URL_Login = BASE + "user/login";
final String URL_OTP = BASE + "send-otp";
final String URL_Signup = BASE + "signup";
final String URL_ResetPassword = BASE + "resetPassword/mobile";
final String URL_GetAllTag = BASE + "get/tag-list";
final String URL_CreateShoap = BASE + "create/shop";
final String URL_GetShoapByLoc = BASE + "get-barber-by-loc/shop";
final String URL_GetShoapDetail = BASE + "get-barber-shop/id";
final String URL_CreateAppointment = BASE + "create/user-appointment";
final String URL_SetPassword = BASE + "user/resetPassword";
final String URL_GetUserAppointment = BASE + "get-appointment/user/list";
final String URL_GetBarberAppointment = BASE + "get-appointment/barber/list";
final String URL_UpdateStatus = BASE + "update/appointment-status";
final String URL_UpdateUserProfile = BASE + "user/updateprofile";
final String URL_GetBarberShop = BASE + "get-barber-info/shop";
final String URL_CreateShopReview = BASE + "create/shop/review";

