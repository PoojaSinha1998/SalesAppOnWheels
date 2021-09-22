import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/Widgets/CustomShadowButton.dart';
import 'package:SalesOnwheelss/Widgets/CustomTextFeild.dart';
import 'package:SalesOnwheelss/screens/onBoarding/LocationMap.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({Key key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  TextEditingController dootNo = TextEditingController();
  TextEditingController streetName = TextEditingController();
  TextEditingController landMark = TextEditingController();
  TextEditingController locality = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController pinCode = TextEditingController();
  TextEditingController latitude = TextEditingController();
  TextEditingController longitude = TextEditingController();
  String sLocality='';
  final _formKey = GlobalKey<FormState>();
  submit(){
      if (_formKey.currentState.validate()) {
        setState(() {
        Global.location = true;
        Global.isLoading = true;
      });
        if(locality.text.length!=0)
          {
            sLocality =locality.text;
          }
        ApiServices.fetchUserRegisterLocation(dootNo.text,streetName.text,landMark.text,sLocality,city.text,pinCode.text,latitude.text,longitude.text).then((value) {
          if(value!=null) {
            setState(() {
              Global.isLoading = false;
            });
            if(value.message=="success") {
              Navigator.of(context).pushNamed('onboarddashboard');
            }
          }
        });

      }
      else{
        Toast.show('Please provide the location', context,gravity: 1);
      }
  }
  Future onGoBack(dynamic value) {
    
    setState(() {
      latitude.text = Global.lat;
      longitude.text = Global.lon;
      locality.text = Global.address;
    });
  }
  @override
  Widget build(BuildContext context) {
     SizeConfig().init(context);
     return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.buttonBg,
        progressIndicator: Loader(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: WillPopScope(
             onWillPop: () async => true,
            child: SafeArea(
            child: Scaffold( 
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                centerTitle: true,
                title: Text('Location'),
                flexibleSpace: AppColors.flexibleAppBar
              ),
              
                 
              body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Form(
                   key: _formKey,
                   child: Container(
                  margin: EdgeInsets.only( top : 15 , left : 10, right : 10),
                  width: double.infinity,   
                  height: SizeConfig.screenHeight,
                  child: SingleChildScrollView(
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                               crossAxisAlignment: CrossAxisAlignment.start,
                               mainAxisSize: MainAxisSize.max,
                            children: [

                              GestureDetector(
                                onTap: () {
                                 Route route = MaterialPageRoute(builder: (context) => LocationMapScreen());
                                     Navigator.push(context, route).then(onGoBack);
                                } ,
                                //Navigator.of(context).pushNamed('locationmapscreen'),
                                child: Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.location_searching,color : Colors.black),
                                          Padding(
                                            padding:  EdgeInsets.only(left : 8.0),
                                            child: Text('Fetch Location using GPS'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Divider(),
                              CustomTextfeild(
                                controller: dootNo,
                                labeltext: 'Door No*',
                                validator: (val){
                                  print("val ${val}");
                                  if (val=="") {
                                    return 'Please enter the Door No.';
                                  }
                                  return null;
                                },
                              ),
                              Divider(),
                              CustomTextfeild(
                                controller: streetName,
                                labeltext: 'Street Name*',
                                validator: (val){
                                  print("val ${val}");
                                  if (val=="") {
                                    return 'Please enter Street Name';
                                  }
                                  return null;
                                },
                              ),
                              Divider(),
                              CustomTextfeild(
                                controller: landMark,
                                labeltext: 'LandMark',
                              ),
                              Divider(),
                              CustomTextfeild(
                                controller: locality,
                                labeltext: 'Locality',
                                // validator: (val){
                                //   if (val=="") {
                                //     return 'Please enter Locality';
                                //   }
                                //   return null;
                                // },
                              ),
                              Divider(),
                              CustomTextfeild(
                                controller: city,
                                labeltext: 'City*',
                                validator: (val){
                                  if (val=="") {
                                    return 'Please enter City Name';
                                  }
                                  return null;
                                },
                              ),
                              Divider(),
                              CustomTextfeild(
                                controller: pinCode,
                                labeltext: 'Pincode*',
                                textInputType: TextInputType.phone,
                                validator: (val){
                                  if (val=="") {
                                    return 'Please enter Pincode';
                                  }
                                  return null;
                                },
                              ),
                              Divider(),
                              CustomTextfeild(
                                controller: latitude,
                                labeltext: 'Latitude*',
                                textInputType: TextInputType.phone,
                                validator: (val){
                                  if (val=="") {
                                    return 'Please enter Latitude';
                                  }
                                  return null;
                                },
                              ),
                              Divider(),
                              CustomTextfeild(
                                controller: longitude,
                                labeltext: 'Longitude*',
                                textInputType: TextInputType.phone,
                                validator: (val){
                                  if (val=="") {
                                    return 'Please enter Longitude';
                                  }
                                  return null;
                                },
                              ),
                              Padding(
                                padding: EdgeInsets.only(top : 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: CustomShadowButtom(
                                        text: 'Save as Draft',
                                        onTap: (){},
                                      ),
                                    ),
                                    Expanded(
                                      child: CustomShadowButtom(
                                        text: 'Submit',
                                        onTap: (){
                                          submit();
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                
                                )
                              
                            ]))))),
              );})))))
    );
  }
}