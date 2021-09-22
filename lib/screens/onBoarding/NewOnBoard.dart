import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/Widgets/CustomShadowButton.dart';
import 'package:SalesOnwheelss/Widgets/CustomTextFeild.dart';
import 'package:SalesOnwheelss/Widgets/OtpTextfeild.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:SalesOnwheelss/response/registerMobile.dart';
import 'package:toast/toast.dart';

class NewOnBoard extends StatefulWidget {
  NewOnBoard({Key key}) : super(key: key);

  @override
  _NewOnBoardState createState() => _NewOnBoardState();
}

class _NewOnBoardState extends State<NewOnBoard> {
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController otp = TextEditingController();
  bool otpSent = false;

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
                title: Text('New On-Boarding'),
                flexibleSpace: AppColors.flexibleAppBar
              ),
              
              body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return 
                   Form(
                     key: _formKey,
                child: Container(
                margin: EdgeInsets.only( top : 15 , left : 10, right : 10),
                width: double.infinity,   
                height: SizeConfig.screenHeight,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisSize: MainAxisSize.max,
                      children: [
                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              children: [
                                CustomTextfeild(
                                  controller: phoneNo,
                                  readOnly: otpSent,
                                  labeltext: 'Phone Number',
                                  textInputType: TextInputType.phone,
                                  prefixicon: Icon(Icons.phone_android),
                                  validator: (val){
                                    if (val.trim().isEmpty) {
                                      return 'Please enter Phone Number';
                                    }
                                    else if (val.trim().length > 10 || val.trim().length < 10 ) {
                                      return 'Please enter a valid Number';
                                    }
                                  },
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top : 10),
                                  child:  Visibility(
                                    visible: !otpSent,
                                      child:
                                      Container(
                                      width: 100,
                                      child: CustomShadowButtom(
                                        onTap: (){
                                          if (_formKey.currentState.validate()) {
                                            setState(() {
                                              sendOTP(phoneNo.text);

                                          });
                                          }
                                        },
                                        fontSize: 16,
                                        text: 'SEND',
                                      ),
                                    ),


                                  ),
                                  ),
                                Visibility(
                                  visible: otpSent,
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              onPressed: (){
                                                ResendOTP(phoneNo.text);
                                              },
                                              child: Text('RESEND OTP')),
                                        ],
                                      ),
                                      CustomTextfeild(
                                        controller: otp,
                                        labeltext: 'OTP',
                                        textInputType: TextInputType.phone,
                                        validator: (val){
                                          if (val.trim().isEmpty) {
                                            return 'Please Enter otp';
                                          }
                                        },
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 80,
                                          child: CustomShadowButtom(
                                            onTap: (){

                                              if(_formKey.currentState.validate()) {

                                                verifyOTP(phoneNo.text);
                                                // Navigator.of(context).pushNamed('newboard2');
                                                setState(() {
                                                  Global.mobileNo = phoneNo.text;
                                                });
                                              }

                                            },
                                            fontSize: 16,
                                            text: 'VERIFY',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            ),
                        )
                      ]))),
                   );})))))
    );
  }

  void sendOTP(String mobilenumber) {

setState(() {
  Global.isLoading = true;
});
    ApiServices.fetchUserRegisterMobile(mobilenumber).then((value) {
      if(value!=null) {
        setState(() {
          Global.isLoading = false;
        });
        if(value.message=="success") {
          otpSent = true;
          Global.PartnerID=value.result[0].id;
          Global.PartnerContact = mobilenumber;
          Toast.show(value.result[0].verificationToken, context,gravity: 1);
          // Navigator.of(context).pushNamed('newboard2');
        }
        else{
          otpSent = false;
          Toast.show(value.result[0].description, context,gravity: 1);
        }
        // Navigator.of(context).pushNamed('newboard2');
      }
    });
  }
  void ResendOTP(String mobilenumber) {
    print("HERE");

    setState(() {
      Global.isLoading = true;
    });
    ApiServices.fetchUserRegisterMobile(mobilenumber).then((value) {
      if(value!=null) {
        setState(() {
          Global.isLoading = false;
        });
        if(value.message=="success") {
          Toast.show(value.result[0].verificationToken, context,gravity: 1);
          // Navigator.of(context).pushNamed('newboard2');
        }
        else{
          Toast.show(value.result[0].description, context,gravity: 1);
        }
        // Navigator.of(context).pushNamed('newboard2');
      }
    });
  }
  void verifyOTP(String mobilenumber) {

    setState(() {
      Global.isLoading = true;
    });
    ApiServices.fetchVerifyPartner(otp.text).then((value) {
      if(value!=null) {
        setState(() {
          Global.isLoading = false;
        });
        if(value.message=="success") {
          Global.PartnerID=value.result[0].id;
          Global.PartnerContact = mobilenumber;
          Toast.show("Your Unique ID is ${value.result[0].uniqueID}", context,gravity: 1);
          Navigator.of(context).pushNamed('newboard2');
          if(value.result[0].locationStatus=="1") {
            Global.location = true;
          }
          else{
            Global.location = false;
          }
          if(value.result[0].personalStatus=="1") {
            Global.pInformation = true;
          }
          else{
            Global.pInformation = false;
          }
          if(value.result[0].servicesStatus=="1") {
            Global.services = true;
          }
          else{
            Global.services = false;
          }
          if(value.result[0].informationStatus=="1") {
            Global.gInformation = true;
          }
          else{
            Global.gInformation = false;
          }
          if(value.result[0].facilityStatus=="1") {
            Global.fInformation = true;
          }
          else{
            Global.fInformation = false;
          }
          if(value.result[0].photosStatus=="1") {
            Global.garagePhotos = true;
          }
          else{
            Global.garagePhotos = false;
          }
          if(value.result[0].gstStatus=="1") {
            Global.identifiationgst = true;
          }
          else{
            Global.identifiationgst = false;
          }


        }
        else{
          Toast.show(value.result[0].description, context,gravity: 1);
        }
        // Navigator.of(context).pushNamed('newboard2');
      }
    });
  }
}