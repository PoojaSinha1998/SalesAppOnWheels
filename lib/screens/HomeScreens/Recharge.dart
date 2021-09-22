import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomTextFeild.dart';
import 'package:SalesOnwheelss/response/planList.dart';
import 'package:SalesOnwheelss/response/shopList.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class RechargeScreen extends StatefulWidget {
  @override
  _RechargeScreenState createState() => _RechargeScreenState();
}

class _RechargeScreenState extends State<RechargeScreen> {
  List<GlobalKey<FormState>> _formKeys = [GlobalKey<FormState>(), GlobalKey<FormState>() , GlobalKey<FormState>()];
  int _currentStep = 0;
  StepperType stepperType = StepperType.horizontal;
  TextEditingController city = TextEditingController();
  String vehicleType = '';
  String shopname = 'shop Name';
  TextEditingController shopName = TextEditingController();
  TextEditingController receiptNumber = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController address = TextEditingController();
  DateTime selectedDate = DateTime.now();
  String paymentType;
  String planType='';

  String selectedShopid='';
  TextEditingController revenueMonth = TextEditingController();
  TextEditingController upiTransactionId = TextEditingController();
  TextEditingController receiptno = TextEditingController();
  List<ResultShop> shopresult= List();
  List<ResultPlan> planresult= List();
  List<ResultShop> shopDetailsresult= List();
  List<String> sshopdetails = List();
  List<String> splandetails = List();
  String planid='';
  int imageType = 0;
  File panfront;
  File panback;
  File idfront;
  File idback;
  File croppedFile;
  File result;
   _selectDate(BuildContext context,String from) async {
  final DateTime picked = await showDatePicker(
    context: context,
    initialDate: selectedDate, // Refer step 1
    firstDate: DateTime(1915),
    lastDate: DateTime.now(),
    )
   .then((selectedDate) {
     if(selectedDate!=null){
       setState(() {
      
        revenueMonth.text = DateFormat('yyyy-MM-dd').format(selectedDate);
        
    });
     }}
  ); 
}
  @override
  void initState() {
    ApigetshopList();
    ApigetPaymentPlanList();
  }
  void ApigetPaymentPlanList() {
    setState(() {
      Global.isLoading = true;
    });
    ApiServices.getPlanList().then((value) {
      if (value != null) {
        setState(() {
          Global.isLoading = false;
        });
        if (value.message == "success") {
          planresult = value.result;
          for (ResultPlan b in planresult) {
            splandetails.add(b.credits);


            // str1 = sbankdetails.join(",");
            print("BANK ${sshopdetails}");
          }
        }
      }
    });
  }
  void ApigetshopList() {
    setState(() {
      Global.isLoading = true;
    });
    ApiServices.getshopList().then((value) {
      if(value!=null) {
        setState(() {
          Global.isLoading = false;
        });
        if(value.message=="success") {
          shopresult = value.result;
          for(ResultShop b in shopresult)
          {
            if(b.shopname!=null)
            sshopdetails.add(b.shopname);
          }

          // str1 = sbankdetails.join(",");
          print("BANK ${sshopdetails}");
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
     // Global.isLoading= false;
    return  ModalProgressHUD(
      inAsyncCall: Global.isLoading,
      child: GestureDetector(
         onTap: () => FocusScope.of(context).unfocus(),
            child: Scaffold(
          resizeToAvoidBottomInset: true,
            appBar: AppBar(
                title: Text('Recharge'),
              centerTitle: true,
            ),
            body:  Container(
              child: Column(
                children: [

                  Expanded(
                    child: Stepper(

                      type: stepperType,
                      physics: ClampingScrollPhysics(),
                      currentStep: _currentStep,
                      onStepTapped: (step) => tapped(step),
                      onStepContinue:  continued,
                      onStepCancel: cancel,
        controlsBuilder: (BuildContext context,{VoidCallback onStepContinue, VoidCallback onStepCancel})
             {
       return  _currentStep == 0 ?  Row(
            mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: onStepContinue,
                child: Container(
                margin: EdgeInsets.only(top : SizeConfig.safeBlockVertical * 32),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                 color: AppColors.primaryColor,
                 borderRadius: BorderRadius.circular(2)
                ),
                child: Text('NEXT',style: AppStyles.whiteTextStyle.copyWith(fontSize: 18),),

                ),
              ),

            ],
          ) : _currentStep == 1 ? Container(
            margin: EdgeInsets.only(top : SizeConfig.safeBlockVertical * 30),
            child: Row(
              //mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: TextButton(onPressed: onStepCancel,
                  child: Text('PREVIOUS',style: AppStyles.primaryTextStyle,)),
                ),
                GestureDetector(
                  onTap: onStepContinue,
                  child: Container(
                  margin: EdgeInsets.only(top : 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                   color: AppColors.primaryColor,
                   borderRadius: BorderRadius.circular(2)
                  ),
                  child: Text('PROCEED TO RECHARGE',
                  style: AppStyles.whiteTextStyle.copyWith(fontSize: 16),),

                  ),
                ),

              ],
            ),
          ) : _currentStep == 2 ?  Container(
            margin: EdgeInsets.only(top : SizeConfig.safeBlockVertical * 12),
            child: Row(
              //mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Center(
                  child: TextButton(onPressed: onStepCancel,
                  child: Text('PREVIOUS',style: AppStyles.primaryTextStyle,)),
                ),
                GestureDetector(
                  onTap: onStepContinue,
                  child: Container(
                  margin: EdgeInsets.only(top : 10),
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                   color: AppColors.primaryColor,
                   borderRadius: BorderRadius.circular(2)
                  ),
                  child: Text('CONFIRM RECHARGE',
                  style: AppStyles.whiteTextStyle.copyWith(fontSize: 16),),

                  ),
                ),

              ],
            ),
          ) : Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  callAPIToRecharge();
                  // Navigator.of(context).popAndPushNamed('homescreen');
                },
                child: Container(
                margin: EdgeInsets.only(top : SizeConfig.safeBlockVertical * 5),
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                 color: AppColors.primaryColor,
                 borderRadius: BorderRadius.circular(2)
                ),
                child: Text('Done',style: AppStyles.whiteTextStyle.copyWith(fontSize: 18),),

                ),
              ),

            ],
          );
        },
                      steps: <Step>[
                         Step(

                          title: new Text(''),
                          content: Form(
                              key: _formKeys[0],
                              child: Column(
                              children: <Widget>[
                                CustomTextfeild(
                                 controller: city,
                                 labeltext: 'City',
                                 validator: (val) {
                                   if (val.trim().isEmpty) {
                                     return 'Please enter City.';
                                   }
                                 },
                                ),
                                Padding(
                                  padding:  EdgeInsets.only( top : 8.0),
                                  child: Theme(
                                                    data: ThemeData(
                                                        canvasColor: Colors.white),
                                                    child: new DropdownButtonFormField<
                                                            String>(
                                                        isExpanded: true,
                                                        //value: Global.rechargeSaveModel.vehicleType != null ? Global.rechargeSaveModel.vehicleType : '2W',
                                                        hint: Text('Choose Vehicle Type'),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(
                                                              color: AppColors.textFeildBorder
                                                            )
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(
                                                              color: AppColors.textFeildBorder
                                                            )
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(
                                                              color: AppColors.textFeildBorder
                                                            )
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(
                                                              color: Colors.red
                                                            )
                                                          ),
                                                          isDense: true,
                                                        ),
                                                        onChanged:
                                                            (String changedValue) {
                                                          setState(() {
                                                            vehicleType = changedValue;
                                                          });
                                                        },
                                                        // dropdownColor: Colors.white,
                                                        //value: jobStatus,
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'feildRequired'
                                                                : null,

                                                        items: <String>[ '2W','4W'
                                                        ].map<DropdownMenuItem<String>>((String value)  {
                                                          return new DropdownMenuItem<
                                                              String>(
                                                            value:
                                                                value,
                                                            child: new Text(
                                                                value),
                                                          );
                                                        }).toList()),
                                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only( top : 8.0),
                                  child: Theme(
                                    data: ThemeData(
                                        canvasColor: Colors.white),
                                    child: new DropdownButtonFormField<
                                        String>(
                                        isExpanded: true,
                                        //value: Global.rechargeSaveModel.vehicleType != null ? Global.rechargeSaveModel.vehicleType : '2W',
                                        hint: Text('Shop Name'),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: AppColors.textFeildBorder
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: AppColors.textFeildBorder
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: AppColors.textFeildBorder
                                              )
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: Colors.red
                                              )
                                          ),
                                          isDense: true,
                                        ),
                                        onChanged:
                                            (String changedValue) {
                                          setState(() {
                                            shopname = changedValue;
                                            getCityName(shopname);
                                          });
                                        },
                                        // dropdownColor: Colors.white,
                                        //value: jobStatus,
                                        validator: (value) =>
                                        value == null
                                            ? 'feildRequired'
                                            : null,

                                        items: sshopdetails.map<DropdownMenuItem<String>>((String value)  {
                                          return new DropdownMenuItem<
                                              String>(
                                            value: value,
                                            child: new Text(value),
                                          );
                                        }).toList()),
                                  ),
                                ),

                                // Padding(
                                //   padding: const EdgeInsets.only(top : 10.0),
                                //   child: CustomTextfeild(
                                //    controller: shopName,
                                //    labeltext: 'Shop Name',
                                //    validator: (val) {
                                //    if (val.trim().isEmpty) {
                                //      return 'Please enter Shop Name.';
                                //    }
                                //  },
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.only(top : 10.0),
                                  child: CustomTextfeild(
                                   controller: receiptNumber,
                                   labeltext: 'Receipt Number',
                                   textInputType: TextInputType.phone,
                                   validator: (val) {
                                   if (val.trim().isEmpty) {
                                     return 'Please enter Receipt Number.';
                                   }
                                 },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 0 ?
                          StepState.complete : StepState.disabled,
                        ),
                         Step(
                          title: new Text(''),
                          content: Form(
                              key: _formKeys[1],
                              child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top : 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Expanded(
                                        child: CustomTextfeild(
                                          prefixicon: Container(
                                        margin: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color : Colors.black)
                                        ),
                                        child: Icon(Icons.person,color: Colors.black,size: 25,)),
                                         controller: name,
                                         labeltext: 'Name',
                                         validator: (val) {
                                         if (val.trim().isEmpty) {
                                           return 'Please enter Name.';
                                         }
                                 },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.only(top : 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Expanded(
                                        child: CustomTextfeild(
                                          prefixicon: Container(
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color : Colors.black)
                                        ),
                                        child: Icon(Icons.call,color: Colors.black,size: 25,)),
                                         controller: number,
                                         labeltext: 'Mobile Number',
                                         textInputType : TextInputType.phone,
                                         validator: (val) {
                                         if (val.trim().isEmpty) {
                                           return 'Please enter Mobile Number.';
                                         }
                                         else if (val.trim().length > 10 || val.trim().length < 10){
                                           return 'Please enter valid Mobile Number';
                                         }
                                       },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                 Padding(
                                  padding: const EdgeInsets.only(top : 10.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      Expanded(
                                        child: CustomTextfeild(
                                          prefixicon: Container(
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(2),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          border: Border.all(color : Colors.black)
                                        ),
                                        child: Icon(Icons.pin_drop,color: Colors.black,size: 25,)),
                                         controller: address,
                                         labeltext: 'Address',
                                         validator: (val) {
                                         if (val.trim().isEmpty) {
                                           return 'Please enter Address.';
                                         }
                                 },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 1 ?
                          StepState.complete : StepState.disabled,
                        ),
                         Step(
                          title: new Text(''),
                          content: Form(
                              key: _formKeys[2],
                              child: Column(
                              children: <Widget>[
                                CustomTextfeild(
                                   controller: revenueMonth,
                                   onTap: (){
                                     FocusScope.of(context).unfocus();
                                      _selectDate(context,'sd');
                                   },
                                   labeltext: 'Revenue Date',
                                   validator: (value) {
                                            if (value.trim().isEmpty) {
                                              return 'Please enter Revenue Date.';
                                            }

                                            return null;
                                          },
                                      ),
                               Padding(
                                  padding:  EdgeInsets.only( top : 12.0),
                                  child: Theme(
                                                    data: ThemeData(
                                                        canvasColor: Colors.white),
                                                    child: new DropdownButtonFormField<
                                                            String>(
                                                        isExpanded: true,
                                                        //value: Global.rechargeSaveModel.vehicleType != null ? Global.rechargeSaveModel.vehicleType : '2W',
                                                        hint: Text('Payment Method*'),
                                                        decoration: InputDecoration(
                                                          border: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(
                                                              color: AppColors.textFeildBorder
                                                            )
                                                          ),
                                                          enabledBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(
                                                              color: AppColors.textFeildBorder
                                                            )
                                                          ),
                                                          focusedBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(
                                                              color: AppColors.textFeildBorder
                                                            )
                                                          ),
                                                          errorBorder: OutlineInputBorder(
                                                            borderRadius: BorderRadius.circular(5),
                                                            borderSide: BorderSide(
                                                              color: Colors.red
                                                            )
                                                          ),
                                                          isDense: true,
                                                        ),
                                                        onChanged:
                                                            (String changedValue) {
                                                          setState(() {
                                                            paymentType = changedValue;
                                                          });
                                                        },
                                                        // dropdownColor: Colors.white,
                                                        //value: jobStatus,
                                                        validator: (value) =>
                                                            value == null
                                                                ? 'feildRequired'
                                                                : null,

                                                        items: <String>[ 'UPI','Net Banking','Cash','Check'
                                                        ].map<DropdownMenuItem<String>>((String value)  {
                                                          return new DropdownMenuItem<
                                                              String>(
                                                            value:
                                                                value,
                                                            child: new Text(
                                                                value),
                                                          );
                                                        }).toList()),
                                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only( top : 12.0),
                                  child: Theme(
                                    data: ThemeData(
                                        canvasColor: Colors.white),
                                    child: new DropdownButtonFormField<
                                        String>(
                                        isExpanded: true,
                                        //value: Global.rechargeSaveModel.vehicleType != null ? Global.rechargeSaveModel.vehicleType : '2W',
                                        hint: Text('Payment Plan*'),
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: AppColors.textFeildBorder
                                              )
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: AppColors.textFeildBorder
                                              )
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: AppColors.textFeildBorder
                                              )
                                          ),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius: BorderRadius.circular(5),
                                              borderSide: BorderSide(
                                                  color: Colors.red
                                              )
                                          ),
                                          isDense: true,
                                        ),
                                        onChanged:
                                            (String changedValue) {
                                          setState(() {
                                            planType = changedValue;
                                            getPlanId(planType);
                                          });
                                        },
                                        // dropdownColor: Colors.white,
                                        //value: jobStatus,
                                        validator: (value) =>
                                        value == null
                                            ? 'feildRequired'
                                            : null,

                                        items:splandetails.map<DropdownMenuItem<String>>((String value)  {
                                          return new DropdownMenuItem<
                                              String>(
                                            value:
                                            value,
                                            child: new Text(
                                                value),
                                          );
                                        }).toList()),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only( top : 12.0),
                                  child: CustomTextfeild(
                                     controller: upiTransactionId,

                                     labeltext: 'UPI Transaction ID*',
                                     validator: (value) {
                                              if (value.trim().isEmpty) {
                                                return 'Please enter Revenue Date.';
                                              }

                                              return null;
                                            },
                                        ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top : 10.0),
                                  child: CustomTextfeild(
                                   controller: receiptno,
                                   labeltext: 'Receipt No*',
                                   textInputType: TextInputType.phone,
                                   validator: (val) {
                                   if (val.trim().isEmpty) {
                                     return 'Please enter Receipt Number.';
                                   }
                                 },
                              ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(top : 20),
                                //   child: Container(
                                //     width: double.infinity,
                                //     padding: EdgeInsets.all(12),
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(5),
                                //       gradient: LinearGradient(
                                //           begin: Alignment.topLeft,
                                //           end: Alignment(2, 0.0),
                                //           colors: <Color>[
                                //           Color(0xFF816E52),
                                //           Colors.white
                                //          ])
                                //     ),
                                //     child: Row(
                                //       children: [
                                //         Expanded(
                                //           child: Text('VIEW RECEIPT IMAGE',style: AppStyles.whiteTextStyle.copyWith(
                                //             fontSize: 18
                                //           ),),
                                //         ),
                                //         Icon(Icons.camera_alt)
                                //       ],
                                //     ),
                                //   ),
                                // ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            imageType = 0;
                                            imageModalBottomSheet(context);
                                          },
                                          child: panfront != null ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Container(child: Image.file(panfront,height: 150,))) :
                                          Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black
                                                ),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Icon(Icons.image,color: Colors.black,size: 50,),
                                                Text('Receipt Image')
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            imageType = 1;
                                            imageModalBottomSheet(context);
                                          },
                                          child: panback != null ? ClipRRect(
                                              borderRadius: BorderRadius.circular(10),
                                              child: Container(child: Image.file(panback,height: 150,))) :
                                          Container(
                                            height: 150,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black
                                                ),
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Icon(Icons.image,color: Colors.black,size: 50,),
                                                  Text('Payment Proof')
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                // Padding(
                                //   padding: EdgeInsets.only(top : 20),
                                //   child: Container(
                                //     width: double.infinity,
                                //     padding: EdgeInsets.all(12),
                                //     decoration: BoxDecoration(
                                //       borderRadius: BorderRadius.circular(5),
                                //       gradient: LinearGradient(
                                //           begin: Alignment.topLeft,
                                //           end: Alignment(2, 0.0),
                                //           colors: <Color>[
                                //           Color(0xFF816E52),
                                //           Colors.white
                                //          ])
                                //     ),
                                //     child: Row(
                                //       children: [
                                //         Expanded(
                                //           child: Text('VIEW PAYMENT PROOF',style: AppStyles.whiteTextStyle.copyWith(
                                //             fontSize: 18
                                //           ),),
                                //         ),
                                //
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          ),
                          isActive:_currentStep >= 0,
                          state: _currentStep >= 2 ?
                          StepState.complete : StepState.disabled,
                        ),
                         Step(

                          title: new Text(''),
                          content: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Your request for recharge has been submitted.Please verify the details before proceeding with recahrge.',
                            textAlign: TextAlign.center,style: AppStyles.blackTextStyle.copyWith(
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 15),
                            child: Text('Service Center Details',style: AppStyles.blackTextStyle.copyWith(
                              color: Colors.yellow[800],fontSize: 18,fontWeight: FontWeight.w500
                            ),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Service Center',style: AppStyles.blackTextStyle.copyWith(
                                  color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.w500
                                ),),
                                Text(Global.rechargeSaveModel.shopName != null ? Global.rechargeSaveModel.shopName : '',
                                style: AppStyles.blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Address',style: AppStyles.blackTextStyle.copyWith(
                                  color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.w500
                                ),),
                                Container(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(Global.rechargeSaveModel.address != null ?
                                  Global.rechargeSaveModel.address: '',
                                  textAlign: TextAlign.end,style: AppStyles.blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w600
                                  ),),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Mobile',style: AppStyles.blackTextStyle.copyWith(
                                  color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.w500
                                ),),
                                Text(Global.rechargeSaveModel.number != null ? Global.rechargeSaveModel.number : '',
                                style: AppStyles.blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 15),
                            child: Text('Payment Details',style: AppStyles.blackTextStyle.copyWith(
                              color: Colors.yellow[800],fontSize: 18,fontWeight: FontWeight.w500
                            ),),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Date of Payment',style: AppStyles.blackTextStyle.copyWith(
                                  color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.w500
                                ),),
                                Text(DateFormat('yyyy-MM-dd').format(DateTime.now()),
                                style: AppStyles.blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Revenue Month',style: AppStyles.blackTextStyle.copyWith(
                                  color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.w500
                                ),),
                                Text(Global.rechargeSaveModel.revenueMonth != null ? Global.rechargeSaveModel.revenueMonth : '',
                                style: AppStyles.blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Payment Mode',style: AppStyles.blackTextStyle.copyWith(
                                  color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.w500
                                ),),
                                Text(Global.rechargeSaveModel.paymentMethod != null ? Global.rechargeSaveModel.paymentMethod : '',
                                style: AppStyles.blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                          ),
                            Padding(
                              padding: EdgeInsets.only(top : 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Selected Plan',style: AppStyles.blackTextStyle.copyWith(
                                      color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.w500
                                  ),),
                                  Text(planType,
                                    style: AppStyles.blackTextStyle.copyWith(
                                        fontWeight: FontWeight.w600
                                    ),)
                                ],
                              ),
                            ),
                          Padding(
                            padding: EdgeInsets.only(top : 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Transaction ID',style: AppStyles.blackTextStyle.copyWith(
                                  color: Colors.grey[600],fontSize: 18,fontWeight: FontWeight.w500
                                ),),
                                Text(Global.rechargeSaveModel.upiid != null ? Global.rechargeSaveModel.upiid : '',
                                style: AppStyles.blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600
                                ),)
                              ],
                            ),
                          ),
                          Divider()

                          ],
                            ),
                          isActive: _currentStep >= 0,
                          state: _currentStep >= 3 ?
                          StepState.complete : StepState.disabled,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),


        ),
      ),
    );
  }
  //Bottom Sheet
  void imageModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            height: 150.0,
            color: Colors.white,
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    label:
                    Text('Camera'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();
                      //image = "";
                      getImageFile(ImageSource.camera);
                    },
                    heroTag: UniqueKey(),
                    icon: Icon(Icons.camera),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FloatingActionButton.extended(
                    label:
                    Text('Gallery'),
                    onPressed: () {
                      Navigator.of(context, rootNavigator: true).pop();

                      getImageFile(ImageSource.gallery);
                    },
                    heroTag: UniqueKey(),
                    icon: Icon(Icons.photo_library),
                  ),
                )
              ],
            ),
          );
        });
  }

  getImageFile(ImageSource source) async {
    //pickImage(source: source);
    final picker = ImagePicker();
    var selectedimage = await picker.getImage(source: source);

    if (selectedimage != null) {
      croppedFile = await ImageCropper.cropImage(
          sourcePath: selectedimage.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.square,
            CropAspectRatioPreset.ratio3x2,
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.ratio4x3,
            CropAspectRatioPreset.ratio16x9
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: 'Cropper',
              toolbarColor: Colors.deepOrange,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.square,
              lockAspectRatio: false),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));

      if (croppedFile != null) {
        File compressedFile = await FlutterNativeImage.compressImage(
            croppedFile.path,
            quality: 88,
            percentage: 80);
        print(compressedFile.lengthSync());
        setState(() {
          if (imageType == 0) {
            panfront = compressedFile;
          }
          else if (imageType == 1) {
            panback = compressedFile;
          }
          // else if (imageType == 2) {
          //   idfront = compressedFile;
          // }
          // else if (imageType == 3) {
          //   idback = compressedFile;
          // }
        });
      }
    }
  }
  switchStepsType() {
    setState(() => stepperType == StepperType.vertical
        ? stepperType = StepperType.horizontal
        : stepperType = StepperType.vertical);
  }

  tapped(int step){
    setState(() => _currentStep = step);
  }

  continued(){
    if (_formKeys[_currentStep].currentState.validate()){
      if (_currentStep == 0) {
        for(ResultShop s in shopresult)
          {
            if(s.shopname==shopname)
              {
                selectedShopid = s.id;
              }
          }
        callAPIToGetPerticularShopDetails(selectedShopid);
        Global.rechargeSaveModel.city = city.text;
        Global.rechargeSaveModel.vehicleType = vehicleType;
        Global.rechargeSaveModel.shopName = shopname;
        Global.rechargeSaveModel.receiptNo = receiptNumber.text;
      }
      else if (_currentStep == 1) {
        Global.rechargeSaveModel.name = name.text;
        Global.rechargeSaveModel.number = number.text;
        Global.rechargeSaveModel.address = address.text;
      }
      else if (_currentStep == 2) {
        Global.rechargeSaveModel.revenueMonth = revenueMonth.text;
        Global.rechargeSaveModel.paymentMethod = paymentType;
        Global.rechargeSaveModel.upiid = upiTransactionId.text;
        Global.rechargeSaveModel.receiptNo = receiptno.text;
      }
      _currentStep < 3 ?
        setState(() => _currentStep += 1): null;
    }
    
  }
  cancel(){
    _currentStep > 0 ?
        setState(() => _currentStep -= 1) : null;
  }

  void callAPIToGetPerticularShopDetails(String selectedShopid) {

    ApiServices.getshopDetails(selectedShopid).then((value) {
      if(value!=null) {
        setState(() {
          Global.isLoading = false;
        });
        if(value.message=="success") {
          shopDetailsresult = value.result;
          name.text=shopDetailsresult[0].ownername;
          number.text= shopDetailsresult[0].phone;
          address.text = shopDetailsresult[0].locality.trim();

          // for(ResultShop b in shopresult)
          // {
          //   if(b.shopname!=null)
          //     sshopdetails.add(b.shopname);
          // }

          // str1 = sbankdetails.join(",");
          print("BANK ${sshopdetails}");
        }
      }
    });
  }

  showAlertDialog(BuildContext context) async {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Dialog(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              elevation: 5,
              backgroundColor: Colors.transparent,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.all(
                    Radius.circular(5),
                  ),
                  color: Colors.white,
                ),
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Center(
                        child: Text(
                          "Your Recharge is pending from the Admin side",
                          textAlign: TextAlign.left,
                          style: TextStyle(color: Colors.black,fontSize: 15),
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  // Navigator.of(context).pushNamed('homescreen');
                                  Navigator.of(context).popAndPushNamed('homescreen');
                                },
                                child: Text(
                                  'Ok',
                                  style: TextStyle(
                                      color: AppColors.primaryColor, fontSize: 15, fontWeight: FontWeight.w600),
                                )),

                          ],
                        )
                      ],
                    )
                  ],
                ),
              ));
        });
  }
  void callAPIToRecharge() {
    setState(() {
      Global.isLoading = true;
    });
    ApiServices.rechargeShop(
        planid,
        selectedShopid,
        Global.rechargeSaveModel.city,
        Global.rechargeSaveModel.vehicleType,
        Global.rechargeSaveModel.shopName,
        Global.rechargeSaveModel.receiptNo,
        Global.rechargeSaveModel.name,
        Global.rechargeSaveModel.number,
        Global.rechargeSaveModel.address,
        Global.rechargeSaveModel.revenueMonth,
        Global.rechargeSaveModel.paymentMethod ,
        shopDetailsresult[0].id,upiTransactionId.text,panfront,panback).then((value) {
      if (value != null) {
        setState(() {
          print("DATA ${value}");
          Global.isLoading = false;

          // Toast.show("Recharge done successfully.",context);


        });
        if (value.message == "success") {
          showAlertDialog(context);
          // Navigator.of(context).pushNamed('homescreen');
        }
      }
    });
  }

  void getCityName(String shopname) {

    for(ResultShop b in shopresult)
    {
      if(b.shopname==shopname)
      city.text= b.city;
      // selectedPartnerid = b.id;
      setState(() {

      });
    }
  }


  void getPlanId(String planName){
    for(ResultPlan b in planresult)
    {
      if(b.credits==planName)
        planid = b.id;

      setState(() {

      });
    }
  }

}