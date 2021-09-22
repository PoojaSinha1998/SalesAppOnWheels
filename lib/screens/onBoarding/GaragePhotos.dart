import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class GaragePhotos extends StatefulWidget {
  GaragePhotos({Key key}) : super(key: key);

  @override
  _GaragePhotosState createState() => _GaragePhotosState();
}

class _GaragePhotosState extends State<GaragePhotos> {

  File gfront ;
  File ginterior;
  File ownerPhoto;
  File ramps;
  File paintbooth;
  File washFacility;
  File workbay;
  File wheelAlignmnt;
  int imageType = 0;
  File croppedFile;
  File result;
initState(){
  Global.isLoading = false;
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
            gfront = compressedFile;
          }
          else if (imageType == 1) {
            ginterior = compressedFile;
          }
          else if (imageType == 2) {
            ownerPhoto = compressedFile;
          }
          else if (imageType == 3) {
            ramps = compressedFile;
          }
          else if (imageType == 4) {
            paintbooth = compressedFile;
          }
          else if (imageType == 5) {
            washFacility = compressedFile;
          }
          else if (imageType == 6) {
            workbay = compressedFile;
          }
          else if (imageType == 7) {
            wheelAlignmnt = compressedFile;
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
    setState(() {
      Global.isLoading = true;
    });

    if (gfront != null && ginterior != null && ownerPhoto != null) {
      setState(() {
        ApiServices.addGarageImage(
            gfront,
            ginterior,
            ownerPhoto,
            ramps,
            paintbooth,
            washFacility,
            workbay,
            wheelAlignmnt).then((value) {
          if (value != null) {
            setState(() {
              Global.isLoading = false;
            });
            if (value.message == "success") {
              Navigator.of(context).pushNamed('onboarddashboard');
            }
            else{
              Toast.show("Something went wrong", context,gravity: 1);
            }
          }
        });

       setState(() {
        Global.garagePhotos = true;
      });

      
    });
    } else {
      Toast.show('Please Uplaod Required Photos', context,gravity: 1);
    }
  }
  @override
  Widget build(BuildContext context) {
    // Global.isLoading = false;
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
                title: Text('Garage Photos'),
                flexibleSpace: AppColors.flexibleAppBar
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: (){
                  submit();
                },
                 label: Text('Submit')),
              body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Container(
                margin: EdgeInsets.only( top : 15 , left : 10, right : 10),
                width: double.infinity,   
                height: SizeConfig.screenHeight,
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                         mainAxisSize: MainAxisSize.max,
                      children: [
                         Row(
                                     children: [
                                       Expanded(
                                    child: GestureDetector(
                                  onTap: (){
                                    imageType = 0;
                                    imageModalBottomSheet(context);
                                  },
                                  child: gfront != null ? ClipRRect(
                                     borderRadius: BorderRadius.circular(10),
                                     child: Container(child: Image.file(gfront,height: 150,))) : 
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
                                      Text('Garage Front*')
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
                                     child: ginterior != null ? ClipRRect(
                                     borderRadius: BorderRadius.circular(10),
                                     child: Container(child: Image.file(ginterior,height: 150,))) : 
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
                                           Text('Grage Interior*')
                                         ],
                                       ),
                                     ),
                                   ),
                                   ),
                                 ),
                                     ],
                                ),

                        ////// 
                         Padding(
                           padding: const EdgeInsets.only(top : 10.0),
                           child: Row(
                                       children: [
                                         Expanded(
                                      child: GestureDetector(
                                    onTap: (){
                                      imageType = 2;
                                      imageModalBottomSheet(context);
                                    },
                                    child: ownerPhoto != null ? ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                       child: Container(child: Image.file(ownerPhoto,height: 150,))) : 
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
                                        Text("Owner's Photo*")
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
                                       child: ramps != null ? ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                       child: Container(child: Image.file(ramps,height: 150,))) : 
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
                                             Text('Photo of Ramps')
                                           ],
                                         ),
                                       ),
                                     ),
                                     ),
                                   ),
                                       ],
                                  ),
                         ),
                         /////
                         Padding(
                           padding: const EdgeInsets.only(top : 10.0),
                           child: Row(
                                       children: [
                                         Expanded(
                                      child: GestureDetector(
                                    onTap: (){
                                      imageType = 4;
                                      imageModalBottomSheet(context);
                                    },
                                    child: paintbooth != null ? ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                       child: Container(child: Image.file(paintbooth,height: 150,))) : 
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
                                        Text("Paint Booth")
                                      ],
                                    ),
                                           ),
                                           ),
                                         ),
                                         SizedBox(width: 10,),
                                   Expanded(
                                     child: GestureDetector(
                                       onTap: (){
                                        imageType = 5;
                                        imageModalBottomSheet(context);
                                       },
                                       child: washFacility != null ? ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                       child: Container(child: Image.file(washFacility,height: 150,))) : 
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
                                             Text('Wash Facility')
                                           ],
                                         ),
                                       ),
                                     ),
                                     ),
                                   ),
                                       ],
                                  ),
                         ),
                         /////////// 
                        Padding(
                           padding: const EdgeInsets.only(top : 10.0),
                           child: Row(
                                       children: [
                                         Expanded(
                                      child: GestureDetector(
                                    onTap: (){
                                      imageType = 6;
                                      imageModalBottomSheet(context);
                                    },
                                    child: workbay != null ? ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                       child: Container(child: Image.file(workbay,height: 150,))) : 
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
                                        Text("Work Bay")
                                      ],
                                    ),
                                           ),
                                           ),
                                         ),
                                         SizedBox(width: 10,),
                                   Expanded(
                                     child: GestureDetector(
                                       onTap: (){
                                        imageType = 7;
                                        imageModalBottomSheet(context);
                                       },
                                       child: wheelAlignmnt != null ? ClipRRect(
                                       borderRadius: BorderRadius.circular(10),
                                       child: Container(child: Image.file(wheelAlignmnt,height: 150,))) : 
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
                                             Text('Wheel Alignment')
                                           ],
                                         ),
                                       ),
                                     ),
                                     ),
                                   ),
                                       ],
                                  ),
                         ),
                         Container(
                           height: 70,
                         )
                      ])));})))))
    );
  }
}