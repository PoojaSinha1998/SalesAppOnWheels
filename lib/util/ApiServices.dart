
import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:SalesOnwheelss/response/BankList.dart';
import 'package:SalesOnwheelss/response/FinalStatusUpdateRes.dart';
import 'package:SalesOnwheelss/response/ResError.dart';
import 'package:SalesOnwheelss/response/addGarageFacilityInformation.dart';
import 'package:SalesOnwheelss/response/addGarageGSTInformation.dart';
import 'package:SalesOnwheelss/response/addGarageInformation.dart';
import 'package:SalesOnwheelss/response/addLocationDetails.dart';
import 'package:SalesOnwheelss/response/addPersonalDetails.dart';
import 'package:SalesOnwheelss/response/addServicelDetails.dart';
import 'package:SalesOnwheelss/response/addVehicleDetails.dart';
import 'package:SalesOnwheelss/response/garageBranding.dart';
import 'package:SalesOnwheelss/response/loginRes.dart';
import 'package:SalesOnwheelss/response/planList.dart';
import 'package:SalesOnwheelss/response/rechangeRes.dart';
import 'package:SalesOnwheelss/response/registerMobile.dart';
import 'package:SalesOnwheelss/response/shopList.dart';
import 'package:SalesOnwheelss/response/verifyPartner.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Globals.dart';

class ApiServices {
 static SharedPreferences preferences;

 static Future<void> initializePref()async{
    preferences = await SharedPreferences.getInstance();
  }

  //Login API
 static Future<LoginRes> fetchUserLoginData(String email, String password) async {
    initializePref();
    print("${Global.BASE_URL}${Global.api_login}");
    var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_login}'),
        headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
          'email': email,
          'password': password,
          'token':Global.token,
          'user_type':Global.UserType
        });
    print("${result.statusCode}");
    print("${result.body}");
    var decodedValue = jsonDecode(result.body);
    LoginRes teacherResponse = LoginRes.fromJson(decodedValue);
    print("${decodedValue}");
    if(result.statusCode == 200){
      // if(decodedValue is ResError) {
      //   preferences.setString(Global.UserName, teacherResponse.result[0].name);
      //   preferences.setString(Global.UserEmail, teacherResponse.result[0].email);
      //   preferences.setString(Global.UserContact, teacherResponse.result[0].phone);
        return teacherResponse;
      // }
    }
    else{
      return null;
    }




  }

  //Register Mobile API
 static Future<registerMobile> fetchUserRegisterMobile(String mobile) async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_onBoardingfirstStep}");
   print("${{
     'phone': mobile,
     'loggedinid': Global.UserId,
     'token':Global.token
   }}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_onBoardingfirstStep}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'phone': mobile,
         'loggedinid': Global.UserId,
         'token':Global.token
       });

   print("${Global.UserId}");
   print("${Global.token}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   registerMobile teacherResponse = registerMobile.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     // preferences.setString(Global.UserName, teacherResponse.result.name);
     // preferences.setString(Global.UserEmail, teacherResponse.result.email);
     // preferences.setString(Global.UserContact, teacherResponse.result.phone);
     return teacherResponse;
   }
   else{
     return null;
   }




 }


 //Verify Partner
 static Future<verifyPartner> fetchVerifyPartner(String otp) async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_userRegisterLoginOTP}");
   print("${{

     'userid': Global.PartnerID,
     'token':Global.token,
     'usertype':'partnersignup',
     'verification_token':otp,
   }}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_userRegisterLoginOTP}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {

         'userid': Global.PartnerID,
         'token':Global.token,
         'usertype':'partnersignup',
         'verification_token':otp,
       });

   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   verifyPartner teacherResponse = verifyPartner.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     // preferences.setString(Global.UserName, teacherResponse.result.name);
     // preferences.setString(Global.UserEmail, teacherResponse.result.email);
     // preferences.setString(Global.UserContact, teacherResponse.result.phone);
     return teacherResponse;
   }
   else{
     return null;
   }




 }

 //Register vehicle API

 static Future<addVehicleDetails> fetchUserRegisterVehicle(String shopname,String vehiclename) async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_onBoardingsecondStep}");
   print("${{
     'phone': Global.PartnerContact,
     'partnerid': Global.PartnerID,
     'loggedinid':Global.UserId,
     'token':Global.token,
     'shopname':shopname,
     'vehicletype':vehiclename
   }}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_onBoardingsecondStep}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'phone': Global.PartnerContact,
         'partnerid': Global.PartnerID,
         'loggedinid':Global.UserId,
         'token':Global.token,
         'shopname':shopname,
         'vehicletype':vehiclename
       });

   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   addVehicleDetails teacherResponse = addVehicleDetails.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     // preferences.setString(Global.UserName, teacherResponse.result.name);
     // preferences.setString(Global.UserEmail, teacherResponse.result.email);
     // preferences.setString(Global.UserContact, teacherResponse.result.phone);
     return teacherResponse;
   }
   else{
     return null;
   }




 }

 //Register Location API
 static Future<addLocationDetails> fetchUserRegisterLocation(String doorNo,String streetName,
     String landMark,String locality,
     String city,String pincode,
     String latitude,String longitude) async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_onBoardinglocationAdd}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_onBoardinglocationAdd}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'phone': Global.PartnerContact,
         'partnerid': Global.PartnerID,
         'loggedinid':Global.UserId,
         'token':Global.token,
         'doorNo':doorNo,
         'streetName':streetName,
         'landMark':landMark,
         'locality':locality,
         'city':city,
         'pincode':pincode,
         'latitude':latitude,
         'longitude':longitude


       });
   print("${{
   'phone': Global.PartnerContact,
   'partnerid': Global.PartnerID,
   'loggedinid':Global.UserId,
   'token':Global.token,
   'doorNo':doorNo,
   'streetName':streetName,
   'landMark':landMark,
   'locality':locality,
   'city':city,
   'pincode':pincode,
   'latitude':latitude,
   'longitude':longitude


   }}");
   print("${Global.PartnerID}");
   print("${Global.UserId}");
   print("${Global.token}");
   print("${doorNo}");
   print("${streetName}");
   print("${landMark}");
   print("${locality}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   addLocationDetails teacherResponse = addLocationDetails.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     // preferences.setString(Global.UserName, teacherResponse.result.name);
     // preferences.setString(Global.UserEmail, teacherResponse.result.email);
     // preferences.setString(Global.UserContact, teacherResponse.result.phone);
     return teacherResponse;
   }
   else{
     return null;
   }
 }

 //Register Personal API
 static Future<addPersonalDetails> fetchUserRegisterPersonalInformation(String ownername,String secondaryphone,
     String email) async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_onBoardingPersonalinformationAdd}");
   print("${{
     'partnerid': Global.PartnerID,
     'loggedinid':Global.UserId,
     'token':Global.token,
     'ownername':ownername,
     'secondaryphone':secondaryphone,
     'email':email
   }}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_onBoardingPersonalinformationAdd}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'partnerid': Global.PartnerID,
         'loggedinid':Global.UserId,
         'token':Global.token,
         'ownername':ownername,
         'secondaryphone':secondaryphone,
         'email':email
   });
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   addPersonalDetails teacherResponse = addPersonalDetails.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }




 }


 //Fetch service list
 static Future<addServicelDetails> fetchUserServiceGarage() async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_servicesGarage}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_servicesGarage}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'token':Global.token,
       });
   print("${Global.UserId}");
   print("${Global.token}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   addServicelDetails teacherResponse = addServicelDetails.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }
 }
 //Fetch service list
 static Future<addServicelDetails> fetchUserRegisterServiceGarage(List<String> ownername,String pickup,String doorstep) async {
   initializePref();

   print("${ownername}");
   print("${Global.UserId}");
   print("${Global.PartnerID}");

   print("${Global.BASE_URL}${Global.api_onBoardingServiceCapabilityAdd}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_onBoardingServiceCapabilityAdd}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'partnerid': Global.PartnerID,
         'loggedinid':Global.UserId,
         'token':Global.token,
         'service_id':ownername.toString(),
         'pickup':pickup,
         'doorstep':doorstep

       });
   print("${Global.UserId}");
   print("${Global.token}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   addServicelDetails teacherResponse = addServicelDetails.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }
 }

 //Fetch GarageBranding
 static Future<garageBranding> fetchUserGarageBranding() async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_garageBranding}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_garageBranding}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {

         'token':Global.token

       });
   print("${Global.UserId}");
   print("${Global.token}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   garageBranding teacherResponse = garageBranding.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }
 }


 //Fetch Bank Details List
 static Future<BankList> fetchUserBanklist() async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_bankList}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_bankList}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {

         'token':Global.token

       });
   print("${Global.UserId}");
   print("${Global.token}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   BankList teacherResponse = BankList.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }
 }


 //OnBoarde garage information
 static Future<addGarageInformation> fetchOnBoardGarageInformationAdd(
     String salesid,String establishyear,
     String areasqft,String noofmechanics,
     String workingdays,String workingfromtime,
     String workingtotime, String garagaebrandid,
     String banknameid ) async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_onBoardingGarageInformationAdd}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_onBoardingGarageInformationAdd}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
       'token':Global.token,
         'partnerid':Global.PartnerID,
         'loggedinid':Global.UserId,
         'establishyear':establishyear,
         'areasqft':areasqft,
         'noofmechanics':noofmechanics,
         'workingdays':workingdays,
         'workingfromtime':workingfromtime,
         'workingtotime':workingtotime,
         'garagaebrandid':garagaebrandid,
         'banknameid':banknameid



       });
   print("${Global.token}");
   print("${garagaebrandid}");
   print("${banknameid}");
   print("${workingtotime}");
   print("${salesid}");
   print("${establishyear}");
   print("${areasqft}");
   print("${noofmechanics}");
   print("${workingdays}");
   print("${workingfromtime}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   addGarageInformation teacherResponse = addGarageInformation.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }
 }

 //OnBoarde facility information
 static Future<addGarageFacilityInformation> addFacilityforGarage(String peakCapacity,
     String workBoys,String ramps,String paintBooths,String fulltime,String washfacility, String dentPullerMachine,
     String wheelAlignmentFacility,
     String onlinePayment,
     String neftImps,
     String cardSwipeMachine,
     String creditCardPayments) async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_onBoardingGarageFacilityInformationAdd}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_onBoardingGarageFacilityInformationAdd}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'token':Global.token,
         'partnerid':Global.PartnerID,
         'loggedinid':Global.UserId,
         'peakCapacity':peakCapacity,
         'workBoys':workBoys,
         'ramps':ramps,
         'paintBooths':paintBooths,
         'fulltime':fulltime,
         'washfacility':washfacility,
         'dentPullerMachine':dentPullerMachine,
         'wheelAlignmentFacility':wheelAlignmentFacility,
         'onlinePayment':onlinePayment,
         'neftImps':neftImps,
         'cardSwipeMachine':cardSwipeMachine,
         'creditCardPayments':creditCardPayments});
   print("${Global.UserId}");
   print("${Global.token}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   addGarageFacilityInformation teacherResponse = addGarageFacilityInformation.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }
 }

 //OnBoarde Garage image
 static Future<addGarageFacilityInformation> addGarageImage(File gfront, File ginterior, File ownerPhoto, File ramps, File paintbooth,
     File washFacility, File workbay, File wheelAlignmnt) async {
   initializePref();
   try {

     print("${Global.BASE_URL}${Global.api_onBoardingGarageImagesAdd}");
    String name_gzFront = basename(gfront.path);
    String name_ginterior = basename(ginterior.path);
    String name_ownerPhoto = basename(ownerPhoto.path);
    String name_ramps = basename(ramps.path);
    String name_paintbooth = basename(paintbooth.path);
    String name_washFacility = basename(washFacility.path);
    String name_workbay = basename(workbay.path);
    String name_wheelAlignmnt = basename(wheelAlignmnt.path);
     FormData formData = new FormData.fromMap({
       'token':Global.token,
       'partnerid':Global.PartnerID,
       'loggedinid':Global.UserId,
       "garageFront": await MultipartFile.fromFile(gfront.path, filename: name_gzFront),
       "garageInterior": await MultipartFile.fromFile(ginterior.path, filename: name_ginterior),
       "ownersImage": await MultipartFile.fromFile(ownerPhoto.path, filename: name_ownerPhoto),
       "photoOfRamps": await MultipartFile.fromFile(ramps.path, filename: name_ramps),
       "paintBooth": await MultipartFile.fromFile(paintbooth.path, filename: name_paintbooth),
       "washFacility":await MultipartFile.fromFile(washFacility.path, filename: name_washFacility),
       "workBay":await MultipartFile.fromFile(workbay.path, filename: name_workbay),
       "wheelAlignment":await MultipartFile.fromFile(wheelAlignmnt.path, filename: name_wheelAlignmnt),
     });
     print("File upload request: ${formData.fields}");
     print("File upload request: ${formData.files}");
     Response result =
     await Dio().post('${Global.BASE_URL}${Global.api_onBoardingGarageImagesAdd}', data: formData);
     print("File upload response: $result");
     if (result.statusCode == 200) {

       var decodedValue = jsonDecode(result.data);
       addGarageFacilityInformation _addGarageFacilityInformation = addGarageFacilityInformation.fromJson(decodedValue);

       return _addGarageFacilityInformation;
     }
     return null;
     // _showSnackBarMsg(response.data['message']);
   } catch (e) {
     print("expectation Caugch: $e");
   }

 }

 //OnBoarde Garage GST image
 static Future<addGarageGSTInformation> addGarageGSTImage(String doorstep,String invoicename,String panadhar,File gfront,
     File ginterior, File ownerPhoto, File ramps) async {
   initializePref();
   try {

     print("File upload request: ${doorstep}");
     print("File upload request: ${invoicename}");
     print("File upload request: ${panadhar}");
     print("File upload request: ${gfront}");
     print("File upload request: ${ginterior}");
     print("File upload request: ${ownerPhoto}");
     print("File upload request: ${ramps}");



     FormData formData;
     print("${Global.BASE_URL}${Global.api_onBoardingGarageGSTAdd}");
     if(gfront==null && ginterior==null)
     {
       String name_ownerPhoto = basename(ownerPhoto.path);
       String name_ramps = basename(ramps.path);

       formData = new FormData.fromMap({
         'token':Global.token,
         'partnerid':Global.PartnerID,
         'loggedinid':Global.UserId,
         'doorstep':doorstep,
         'invoicename':invoicename,
         'panadhar':panadhar,
         "govidf": await MultipartFile.fromFile(ownerPhoto.path, filename: name_ownerPhoto),
         "govidb": await MultipartFile.fromFile(ramps.path, filename: name_ramps)
       });
     }
     if(gfront!=null && ginterior!=null)
       {
         String name_gzFront = basename(gfront.path);
         String name_ginterior = basename(ginterior.path);
         String name_ownerPhoto = basename(ownerPhoto.path);
         String name_ramps = basename(ramps.path);

         formData = new FormData.fromMap({
           'token':Global.token,
           'partnerid':Global.PartnerID,
           'loggedinid':Global.UserId,
           'doorstep':doorstep,
           'invoicename':invoicename,
           'panadhar':panadhar,
           "pancardf": await MultipartFile.fromFile(gfront.path, filename: name_gzFront),
           "pancardb": await MultipartFile.fromFile(ginterior.path, filename: name_ginterior),
           "govidf": await MultipartFile.fromFile(ownerPhoto.path, filename: name_ownerPhoto),
           "govidb": await MultipartFile.fromFile(ramps.path, filename: name_ramps)
         });
       }
     if(gfront!=null && ginterior==null)
       {
         String name_gzFront = basename(gfront.path);

         String name_ownerPhoto = basename(ownerPhoto.path);
         String name_ramps = basename(ramps.path);

         formData = new FormData.fromMap({
           'token':Global.token,
           'partnerid':Global.PartnerID,
           'loggedinid':Global.UserId,
           'doorstep':doorstep,
           'invoicename':invoicename,
           'panadhar':panadhar,
           "pancardf": await MultipartFile.fromFile(gfront.path, filename: name_gzFront),

           "govidf": await MultipartFile.fromFile(ownerPhoto.path, filename: name_ownerPhoto),
           "govidb": await MultipartFile.fromFile(ramps.path, filename: name_ramps)
         });
       }
     if(gfront==null && ginterior!=null)
     {
       String name_ginterior = basename(ginterior.path);
       String name_ownerPhoto = basename(ownerPhoto.path);
       String name_ramps = basename(ramps.path);

       formData = new FormData.fromMap({
         'token':Global.token,
         'partnerid':Global.PartnerID,
         'loggedinid':Global.UserId,
         'doorstep':doorstep,
         'invoicename':invoicename,
         'panadhar':panadhar,
         "pancardb": await MultipartFile.fromFile(ginterior.path, filename: name_ginterior),
         "govidf": await MultipartFile.fromFile(ownerPhoto.path, filename: name_ownerPhoto),
         "govidb": await MultipartFile.fromFile(ramps.path, filename: name_ramps)
       });
     }



     print("File upload request: ${formData.fields}");
     print("File upload request: ${formData.files}");
     Response result =
     await Dio().post('${Global.BASE_URL}${Global.api_onBoardingGarageGSTAdd}', data: formData);
     print("File upload response: $result");
     if (result.statusCode == 200) {

       var decodedValue = jsonDecode(result.data);
       addGarageGSTInformation _addGarageFacilityInformation = addGarageGSTInformation.fromJson(decodedValue);

       return _addGarageFacilityInformation;
       // var decodedValue = jsonDecode(response.data);
       // var syllabusUploadRes = SyllabusUploadRes.fromJson(decodedValue);
       return null;
     }
     return null;
     // _showSnackBarMsg(response.data['message']);
   } catch (e) {
     print("expectation Caugch: $e");
   }

 }

 //OnBoarde get Shop List
 static Future<shopList> getshopList() async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_shopList}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_shopList}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
       'token':Global.token
        });
   print("${Global.UserId}");
   print("${Global.token}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   shopList teacherResponse = shopList.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }

 }
 //OnBoarde get Plan List
 static Future<planList> getPlanList() async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_planList}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_planList}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'token':Global.token
       });
   print("${Global.UserId}");
   print("${Global.token}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   planList teacherResponse = planList.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }

 }


 //OnBoarde get PerticularShop Details
 static Future<shopList> getshopDetails(String shopid) async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_shopList}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_shopList}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'token':Global.token,
         'shopid':shopid
       });
   print("${Global.UserId}");
   print("${Global.token}");
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   shopList teacherResponse = shopList.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }

 }

 //OnBoarde get PerticularShop Details
 static Future<rechangeRes> rechargeShop(String plantype,String partnerid,String city,String vehicelType,
     String shopName,String reciptNumber, String name,String mobile
     ,String address,String revenueDate,String payMethod, String shopid,String upiid, File panfront, File panback) async {
   initializePref();
 String name_gzFront = basename(panfront.path);
 String name_ginterior = basename(panback.path);

 FormData formData = new FormData.fromMap({
     'token':Global.token,
   'loggedinid':Global.UserId,
     'city':city,
     'vehicelType':vehicelType,
     'shopName':shopName,
     'reciptNumber':reciptNumber,
     'name':name,
     'mobile':mobile,
     'address':address,
     'revenueDate':revenueDate,
     'payMethod':payMethod,
     'shopid':shopid,
     'upiid':upiid,
   'partnerid':partnerid,
   'planid':plantype,
     'receiptImage': await MultipartFile.fromFile(panfront.path, filename: name_gzFront),
     'transactionImage': await MultipartFile.fromFile(panback.path, filename: name_ginterior),
   });

   print("${Global.BASE_URL}${Global.api_onBoardingGarageRecharge}");
   print("File upload request: ${formData.fields}");
   print("File upload request: ${formData.files}");
   // Response result;
   Response result
   =
   await Dio().post('${Global.BASE_URL}${Global.api_onBoardingGarageRecharge}', data: formData);
   print("File upload response: $result");
   if (result.statusCode == 200) {

     var decodedValue = jsonDecode(result.data);
     rechangeRes _result = rechangeRes.fromJson(decodedValue);

     return _result;
     // var decodedValue = jsonDecode(response.data);
     // var syllabusUploadRes = SyllabusUploadRes.fromJson(decodedValue);
     return null;
   }

   //
   // print("${Global.BASE_URL}${Global.api_onBoardingGarageRecharge}");
   // var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_onBoardingGarageRecharge}'),
   //     headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
   //       'token':Global.token,
   //       'city':city,
   //       'vehicelType':vehicelType,
   //       'shopName':shopName,
   //       'reciptNumber':reciptNumber,
   //       'name':name,
   //       'mobile':mobile,
   //       'address':address,
   //       'revenueDate':revenueDate,
   //       'payMethod':payMethod,
   //       'shopid':shopid,
   //     "receiptImage": await MultipartFile.fromFile(panfront.path, filename: name_gzFront),
   //     "transactionImage": await MultipartFile.fromFile(panback.path, filename: name_ginterior),
   //     });
   // print("${Global.UserId}");
   // print("${Global.token}");
   // print("${result.statusCode}");
   // print("${result.body}");
   // var decodedValue = jsonDecode(result.body);
   // shopList teacherResponse = shopList.fromJson(decodedValue);
   // print("${decodedValue}");
   // if(result.statusCode == 200){
   //   return teacherResponse;
   // }
   // else{
   //   return null;
   // }

 }


 //Login API
 static Future<FinalStatusUpdateRes> fetchFinalStatusUpdate() async {
   initializePref();
   print("${Global.BASE_URL}${Global.api_onBoardingFinalStatus}");
   print("${{
     'partnerid': Global.PartnerID,
     'loggedinid': Global.UserId,
     'token':Global.token
   }}");
   var result = await http.post(Uri.parse('${Global.BASE_URL}${Global.api_onBoardingFinalStatus}'),
       headers: {"Content-Type": "application/x-www-form-urlencoded",}, body: {
         'partnerid': Global.PartnerID,
         'loggedinid': Global.UserId,
         'token':Global.token
       });
   print("${result.statusCode}");
   print("${result.body}");
   var decodedValue = jsonDecode(result.body);
   FinalStatusUpdateRes teacherResponse = FinalStatusUpdateRes.fromJson(decodedValue);
   print("${decodedValue}");
   if(result.statusCode == 200){
     return teacherResponse;
   }
   else{
     return null;
   }




 }

}

