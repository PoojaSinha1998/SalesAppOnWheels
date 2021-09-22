import 'package:flutter/material.dart';
import 'package:SalesOnwheelss/screens/Auth/SignIn.dart';
import 'package:SalesOnwheelss/screens/HomeScreens/HomeScreens.dart';
import 'package:SalesOnwheelss/screens/HomeScreens/Recharge.dart';
import 'package:SalesOnwheelss/screens/HomeScreens/RechargeAlert.dart';
import 'package:SalesOnwheelss/screens/HomeScreens/ReportDetails.dart';
import 'package:SalesOnwheelss/screens/HomeScreens/Reports.dart';
import 'package:SalesOnwheelss/screens/onBoarding/FacilityInformation.dart';
import 'package:SalesOnwheelss/screens/onBoarding/GarageInformation.dart';
import 'package:SalesOnwheelss/screens/onBoarding/GaragePhotos.dart';
import 'package:SalesOnwheelss/screens/onBoarding/GstIdentification.dart';
import 'package:SalesOnwheelss/screens/onBoarding/Location.dart';
import 'package:SalesOnwheelss/screens/onBoarding/LocationMap.dart';
import 'package:SalesOnwheelss/screens/onBoarding/NewOnBoard.dart';
import 'package:SalesOnwheelss/screens/onBoarding/NewOnboard2.dart';
import 'package:SalesOnwheelss/screens/onBoarding/OnBoardDashBoard.dart';
import 'package:SalesOnwheelss/screens/onBoarding/OnBoardingScreen.dart';
import 'package:SalesOnwheelss/screens/onBoarding/PersonalInformation.dart';
import 'package:SalesOnwheelss/screens/onBoarding/ServiceCapability.dart';
import 'package:SalesOnwheelss/util/theme.dart';

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget _defaultHome = SignIn();
  @override
  Widget build(BuildContext context) {
   return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'OnWheelsSales',
        theme: appTheme(),
        routes: <String,WidgetBuilder>{
          'signin' : (BuildContext context) => SignIn(),
          'homescreen' : (BuildContext context) => HomeScreen(),
          'reports' : (BuildContext context) => Reports(),
          'reportdetails' : (BuildContext context) => ReportDetails(),
          'rechargealert' : (BuildContext context) => RechargeAlert(),
          'rechargescreen': (BuildContext context) => RechargeScreen(),
          'onboardingscreen' : (BuildContext context) => OnBoardingScreen(),
          'newonboard' : (BuildContext context) => NewOnBoard(),
          'newboard2' : (BuildContext context) => NewBoard2(),
          'onboarddashboard' : (BuildContext context) => OnBoardDashBoard(),
          'PesonalInformation' : (BuildContext context) => PesonalInformation(),
          'ServiceCapability' : (BuildContext context) => ServiceCapability(),
          'GstIdentification' : (BuildContext context) => GstIdentification(),
          'FacilityInformation' : (BuildContext context) => FacilityInformation(),
          'GaragePhotos' : (BuildContext context) => GaragePhotos(),
          'GarageInformation' : (BuildContext context) => GarageInformation(),
          'locationscreen' : (BuildContext context) => LocationScreen(),
          'locationmapscreen' : (BuildContext context) => LocationMapScreen(),
        },
        home: _defaultHome,
      );
  }
}