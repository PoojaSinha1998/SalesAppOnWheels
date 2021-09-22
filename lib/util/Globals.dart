import 'package:SalesOnwheelss/data/Models/RechargeSaveModel.dart';

class Global {
  static bool isLoading = false;
  static RechargeSaveModel rechargeSaveModel = RechargeSaveModel();
  static String mobileNo = '';
  static bool location = false;
  static bool pInformation = false;
  static bool services = false;
  static bool gInformation = false;
  static bool fInformation = false;
  static bool garagePhotos = false;
  static bool identifiationgst = false;
  static String key = 'AIzaSyB_CJf5Vcnzjke3GBLX2RkAlssnwGQEe58';
  static String lat = '';
  static String lon = '';
  static String address = '';
  static String token ='x9KWtG7De7HaBGpv';
  static String UserType='sales';
  static String BASE_URL = 'http://onwheelss.com/webservice/';
  static String UserName='';
  static String UserContact='';
  static String UserEmail='';
  static String UserId='';
  static String PartnerID ="";
  static String PartnerContact ='';
  static String api_login ='login';

  static String GARAGEDETAILS ='FALSE';
  static String GARGEID ='';


  static String api_onBoardingfirstStep ='onBoardingfirstStep';
  static String api_userRegisterLoginOTP ='userRegisterLoginOTP';
  static String api_onBoardingsecondStep='onBoardingsecondStep';
  static String api_onBoardinglocationAdd ='onBoardinglocationAdd';
  static String api_onBoardingPersonalinformationAdd='onBoardingPersonalinformationAdd';
  static String api_servicesGarage = 'servicesGarage';
  static String api_onBoardingServiceCapabilityAdd ='onBoardingServiceCapabilityAdd';
  static String api_garageBranding='garageBranding';
  static String api_bankList='bankList';
  static String api_onBoardingGarageInformationAdd='onBoardingGarageInformationAdd';
  static String api_onBoardingGarageFacilityInformationAdd='onBoardingGarageFacilityInformationAdd';
  static String api_onBoardingGarageImagesAdd='onBoardingGarageImagesAdd';
  static String api_onBoardingGarageGSTAdd='onBoardingGarageGSTAdd';
  static String api_shopList='shopList';
  static String api_planList ='planList';
  static String api_onBoardingGarageRecharge ='onBoardingGarageRecharge';
  static String api_onBoardingFinalStatus ='onBoardingFinalStatus';


}