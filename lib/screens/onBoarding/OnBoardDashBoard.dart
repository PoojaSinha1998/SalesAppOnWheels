import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/Widgets/CustomShadowButton.dart';
import 'package:SalesOnwheelss/response/shopList.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class OnBoardDashBoard extends StatefulWidget {
  OnBoardDashBoard({Key key}) : super(key: key);

  @override
  _OnBoardDashBoardState createState() => _OnBoardDashBoardState();
}

class _OnBoardDashBoardState extends State<OnBoardDashBoard> {
  List<ResultShop> shopresult= List();
  bool submitvisible= true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Global.location= false;
    Global.isLoading = false;
    print(" Global.GARAGEDETAILS ${Global.GARAGEDETAILS}");
    if(Global.GARAGEDETAILS=="TRUE") {
      ApigetshopList();
    }

  }
  void ApigetshopList() {
    setState(() {
      Global.isLoading = true;
    });
    ApiServices.getshopDetails(Global.GARGEID).then((value) {
      if(value!=null) {
        setState(() {
          Global.isLoading = false;
        });
        if(value.message=="success") {
          shopresult = value.result;

          if(shopresult[0].locationStatus=="1") {
            Global.location = true;
          }
          else{
            Global.location = false;
          }
          if(shopresult[0].personalStatus=="1") {
            Global.pInformation = true;
          }
          else{
            Global.pInformation = false;
          }
          if(shopresult[0].servicesStatus=="1") {
            Global.services = true;
          }
          else{
            Global.services = false;
          }
          if(shopresult[0].informationStatus=="1") {
            Global.gInformation = true;
          }
          else{
            Global.gInformation = false;
          }
          if(shopresult[0].facilityStatus=="1") {
            Global.fInformation = true;
          }
          else{
            Global.fInformation = false;
          }
          if(shopresult[0].photosStatus=="1") {
            Global.garagePhotos = true;
          }
          else{
            Global.garagePhotos = false;
          }
          if(shopresult[0].gstStatus=="1") {
            Global.identifiationgst = true;
          }
          else{
            Global.identifiationgst = false;
          }
          if(Global.location && Global.pInformation &&  Global.services && Global.gInformation && Global.fInformation &&  Global.garagePhotos &&  Global.identifiationgst)
            {
              // submitvisible = false;
            }

        }
        else{

        }
      }
    });
  }
  showAlertDialog(String id,BuildContext context) async {
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
                          "Your Garage Id is ${id}",
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
                                  // Navigator.pop(context);
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
  void ApipdateStatus() {

    setState(() {
      Global.isLoading = true;
    });
    ApiServices.fetchFinalStatusUpdate().then((value) {
      if(value!=null) {
        setState(() {
          Global.isLoading = false;
        });
        if(value.message=="success") {
          showAlertDialog(value.result[0].uniqueID,context);

        }
        else{
Toast.show("Something went wrong",context,gravity: 1);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    Global.isLoading = false;

     return ModalProgressHUD(
        inAsyncCall: Global.isLoading,
        color: AppColors.buttonBg,
        progressIndicator: Loader(),
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: WillPopScope(
             onWillPop: () async {
               Global.isLoading = false;
               return true;
             },
            child: SafeArea(
            child: Scaffold( 
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                centerTitle: true,
                title: Text('On-Boarding'),
                flexibleSpace: AppColors.flexibleAppBar
              ),
              
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
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            width: 150,
                            height: 150,
                            child: Card(
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () => Global.location ? null: Navigator.of(context).pushNamed('locationscreen'),
                                child: Padding(
                             padding:  EdgeInsets.all(15.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                                Image.asset( Global.location ? 'assets/images/checked.png':'assets/images/location.png',height: 60,),
                                Padding(
                                  padding:  EdgeInsets.only( top : 8.0),
                                  child: Text('Location',style: AppStyles.blackTextStyle.copyWith(
                                    fontSize: 18
                                  ),),
                                )
                               ],
                             ),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: 150,
                            height: 150,
                            child: Card(
                              
                              elevation: 5,
                              shape: RoundedRectangleBorder(
                             borderRadius: BorderRadius.circular(10)
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(10),
                                onTap: () => Global.pInformation ? null : Navigator.of(context).pushNamed('PesonalInformation'),
                                child: Padding(
                             padding:  EdgeInsets.all(15.0),
                             child: Column(
                               crossAxisAlignment: CrossAxisAlignment.center,
                               children: [
                               Global.pInformation ? Image.asset('assets/images/checked.png',height: 60,) : Image.asset('assets/images/person.png',height: 60,),
                                Padding(
                                  padding:  EdgeInsets.only( top : 8.0),
                                  child: Text('Personal Information',style: AppStyles.blackTextStyle.copyWith(
                                    fontSize: 18
                                  ),textAlign: TextAlign.center,),
                                )
                               ],
                             ),
                                ),
                              ),
                            ),
                          ),
                          
                        ],
                        ),
                        Padding(
                          padding:  EdgeInsets.only( top : 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Global.services ? null : Navigator.of(context).pushNamed('ServiceCapability'),
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset( Global.services ? 'assets/images/checked.png':'assets/images/service.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('Services',style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 18
                                      ),),
                                    )
                                   ],
                                 ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                child: Card(
                                  
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Global.gInformation ? null : Navigator.of(context).pushNamed('GarageInformation'),
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset(Global.gInformation ? 'assets/images/checked.png' :'assets/images/garage.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('Garage\nInformation',style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 17
                                      ),textAlign: TextAlign.center,),
                                    )
                                   ],
                                 ),
                                    ),
                                  ),
                                ),
                              ),
                              
                            ],
                            ),
                          
                        ),
                        Padding(
                          padding:  EdgeInsets.only( top : 8.0),
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Global.fInformation ? null : Navigator.of(context).pushNamed('FacilityInformation'),
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset(Global.fInformation ? 'assets/images/checked.png' :'assets/images/school.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('Facility\nInformation',style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 18
                                      ),textAlign: TextAlign.center,),
                                    )
                                   ],
                                 ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                width: 150,
                                height: 150,
                                child: Card(
                                  
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Global.garagePhotos ? null: Navigator.of(context).pushNamed('GaragePhotos'),
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset(Global.garagePhotos ? 'assets/images/checked.png' :'assets/images/gallery.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('Garage Photos',style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 17
                                      ),textAlign: TextAlign.center,),
                                    )
                                   ],
                                 ),
                                    ),
                                  ),
                                ),
                              ),
                              
                            ],
                            ),
                          
                        ),
                        Padding(
                          padding:  EdgeInsets.only( top : 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 150,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Global.identifiationgst ? null : Navigator.of(context).pushNamed('GstIdentification'),
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset(Global.identifiationgst ? 'assets/images/checked.png':'assets/images/id-card.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('Identification & GST',style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 18
                                      ),textAlign: TextAlign.center,),
                                    )
                                   ],
                                 ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: submitvisible,
                          child: Padding(
                            padding: EdgeInsets.only(top : 12.0,bottom: 12),
                            child: CustomShadowButtom(
                              text: 'Submit',
                              onTap: (){
                                if (Global.location && Global.pInformation && Global.services && Global.gInformation &&
                  Global.fInformation && Global.garagePhotos && Global.identifiationgst) {
                                  ApipdateStatus();

                  } else {
                    Toast.show('Please Fill all the Feilds', context,gravity: 1);
                  }
                              },
                            ),
                          ),
                        )
                      ])));})))))
    );
  }
}