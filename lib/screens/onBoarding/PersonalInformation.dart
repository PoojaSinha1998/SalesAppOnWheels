import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/Widgets/CustomTextFeild.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/Validators.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class PesonalInformation extends StatefulWidget {
  PesonalInformation({Key key}) : super(key: key);

  @override
  _PesonalInformationState createState() => _PesonalInformationState();
}

class _PesonalInformationState extends State<PesonalInformation> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController ownername = TextEditingController();
  TextEditingController mobileNo = TextEditingController();
  TextEditingController email = TextEditingController();

  submit(){
    if (_formKey.currentState.validate()) {
      setState(() {
        Global.pInformation = true;
        Global.isLoading = true;
        ApiServices.fetchUserRegisterPersonalInformation(ownername.text,mobileNo.text,email.text).then((value) {
          if(value!=null) {
            setState(() {
              Global.isLoading = false;
            });
            if(value.message=="success") {
              Navigator.of(context).popAndPushNamed('onboarddashboard');
            }
            else{
              Toast.show('${value.result[0].discription}', context,gravity: 1);
            }
          }
        });

      });

    }
  }
  @override
  Widget build(BuildContext context) {
    Global.isLoading = false;
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
                            title: Text('Personal Information'),
                            flexibleSpace: AppColors.flexibleAppBar
                        ),
                        floatingActionButton: FloatingActionButton.extended(
                            onPressed: (){
                              submit();
                            },
                            label: Text('Submit')),
                        body: LayoutBuilder(builder:
                            (BuildContext context, BoxConstraints viewportConstraints) {
                          return Form(
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
                                              padding: const EdgeInsets.all(8.0),
                                              child: CustomTextfeild(
                                                controller: ownername,
                                                prefixicon: Icon(Icons.person_add_rounded,color: Colors.black,size: 30,),
                                                labeltext: 'Owner Name*',
                                                validator: (val){
                                                  if (val.trim().isEmpty) {
                                                    return 'Please enter the Owner Name';
                                                  }
                                                  return null;
                                                },
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top : 8.0),
                                            child: Card(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: CustomTextfeild(
                                                  controller: mobileNo,
                                                  prefixicon: Icon(Icons.phone_android,color: Colors.black,size: 30,),
                                                  labeltext: 'Secondary Phone Number',
                                                  textInputType: TextInputType.phone,
                                                  // validator: (val){
                                                  //   if (val.trim().isEmpty) {
                                                  //     return 'Please enter the Phone Number';
                                                  //   }
                                                  //   else if (val.trim().length > 10 || val.trim().length < 10) {
                                                  //     return 'Please enter a valid Number';
                                                  //   }
                                                  //   return null;
                                                  // },
                                                ),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top : 8.0),
                                            child: Card(
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: CustomTextfeild(
                                                  controller: email,
                                                  prefixicon: Icon(Icons.email,color: Colors.black,size: 30,),
                                                  labeltext: 'Email',
                                                  textInputType: TextInputType.emailAddress,
                                                  // validator: (val){
                                                  //   if (val.trim().isEmpty) {
                                                  //     return 'Please enter the Email';
                                                  //   }
                                                  //   return Validators.mustEmail(val);
                                                  // },
                                                ),
                                              ),
                                            ),
                                          ),

                                        ]))),
                          );})))))
    );
  }
}