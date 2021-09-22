import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/Widgets/CustomTextFeild.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class GstIdentification extends StatefulWidget {
  GstIdentification({Key key}) : super(key: key);

  @override
  _GstIdentificationState createState() => _GstIdentificationState();
}

class _GstIdentificationState extends State<GstIdentification> {
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController invoiceName = TextEditingController();
  TextEditingController panAndhar = TextEditingController();
  bool gst = false;
  File panfront;
  File panback;
  File idfront;
  File idback;
  File croppedFile;
  File result;
  int imageType = 0;
  String sDoorStep="No";



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
          else if (imageType == 2) {
            idfront = compressedFile;
          }
          else if (imageType == 3) {
            idback = compressedFile;
          }
        });
      }
    }
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

  submit(){
    if( idfront!= null && idback!= null) {
      if (_formKey.currentState.validate()) {

          setState(() {
            Global.isLoading = true;
            Global.identifiationgst = true;
          });


          if (gst) {
            sDoorStep = "Yes";
          }
          else {
            sDoorStep = "No";
          }

          ApiServices.addGarageGSTImage(
              sDoorStep,
              invoiceName.text,
              panAndhar.text,
              panfront,
              panback,
              idfront,
              idback).then((value) {
            if (value != null) {
              setState(() {
                Global.isLoading = false;
              });
              if (value.message == "success") {
                Navigator.of(context).pushNamed('onboarddashboard');
              }
            }
          });

      }
    }
    else {
     Toast.show('Please Upload the Government Id Proof.', context,gravity: 1);
    }
    
  }
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // Global.isLoading = false;
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
                title: Text('GST and Identification'),
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
                             padding: EdgeInsets.all(8),
                             child: CustomTextfeild(
                               controller: invoiceName,
                               labeltext: 'Invoice Name*',
                               validator: (val){
                                 if (val.trim().isEmpty) {
                                   return 'Please enter Invoice Name';
                                 }
                                 return null;
                               },
                             ),
                             ),
                         ),
                        // Padding(
                        //       padding: EdgeInsets.only(top : 10,bottom: 10),
                        //       child: Card(
                        //         child: Padding(
                        //           padding: const EdgeInsets.all(8.0),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //             children: [
                        //               Text('Door Step : ',style: AppStyles.blackTextStyle.copyWith(
                        //                 fontWeight: FontWeight.w500,fontSize: 16
                        //               ),),
                        //               Row(
                        //                 children: [
                        //                   Text('No',style: AppStyles.blackTextStyle.copyWith(
                        //                 fontWeight: FontWeight.w500,fontSize: 16
                        //               ),),
                        //                   CupertinoSwitch(
                        //              value: gst,
                        //              onChanged: (bool value) { setState(() { gst = value; }); },
                        //              ),
                        //              Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                        //                 fontWeight: FontWeight.w500,fontSize: 16
                        //               ),),
                        //                 ],
                        //               ),
                        //             ],
                        //           ),
                        //         ),
                        //       ),
                        //
                        //       ),
                         Card(
                           child: Padding(
                             padding: EdgeInsets.all(8),
                             child: CustomTextfeild(
                               controller: panAndhar,
                               labeltext: 'PAN/AADHAAR*',
                               validator: (val){
                                 if (val.trim().isEmpty) {
                                   return 'Please enter Pan/Assdhaar';
                                 }
                                 return null;
                               },
                             ),
                             ),
                         ),
                         Padding(
                           padding: EdgeInsets.only(top : 10),
                           child: Card(
                             child: Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Column(
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 children: [
                                 Padding(
                                   padding:  EdgeInsets.only( top : 10,bottom: 10),
                                   child: Text('PAN CARD',style: AppStyles.blackTextStyle.copyWith(
                                     fontSize: 18,fontWeight: FontWeight.w600
                                   )),
                                 ),
                                 Row(
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
                                      Text('Front')
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
                                           Text('Back')
                                         ],
                                       ),
                                     ),
                                   ),
                                   ),
                                 ),
                                     ],
                                   ),

                                Padding(
                                   padding:  EdgeInsets.only( top : 10,bottom: 10),
                                   child: Text('GOVERNMENT ID CARD',style: AppStyles.blackTextStyle.copyWith(
                                     fontSize: 18,fontWeight: FontWeight.w600
                                   )),
                                 ),
                                 Row(
                                     children: [
                                       Expanded(
                                    child: GestureDetector(
                                  onTap: (){
                                    imageType = 2;
                                    imageModalBottomSheet(context);
                                  },
                                  child: idfront != null ? ClipRRect(
                                     borderRadius: BorderRadius.circular(10),
                                     child: Container(child: Image.file(idfront,height: 150,))) : 
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
                                      Text('Front')
                                    ],
                                  ),
                                         ),
                                         ),
                                       ),
                                       SizedBox(width: 10,),
                                 Expanded(
                                   child: GestureDetector(
                                     onTap: (){
                                      imageType = 3;
                                      imageModalBottomSheet(context);
                                     },
                                     child: idback != null ? ClipRRect(
                                     borderRadius: BorderRadius.circular(10),
                                     child: Container(child: Image.file(idback,height: 150,))) : 
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
                                           Text('Back')
                                         ],
                                       ),
                                     ),
                                   ),
                                   ),
                                 ),
                                     ],
                                   ),
                                 
                                 ],
                               ),
                             ),
                           ),
                         ),
                         Container(
                           height: 70,
                         )

                        ]))),
              );})))))
    );
  }
}