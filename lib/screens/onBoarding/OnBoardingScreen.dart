import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/response/shopList.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<ResultShop> shopresult= List();
  @override
  void initState() {
    setState(() {
      Global.isLoading = false;
    });
    // TODO: implement initState
    ApigetshopList();
    super.initState();
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
        }
        else{

        }
        setState(() {
          Global.isLoading = false;
        });
      }
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
                title: Text('On-Boarding'),
                flexibleSpace: AppColors.flexibleAppBar
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed:() => {
                Global.isLoading = false,
                Global.location = false,
                  Global. pInformation = false,
                  Global.services = false,
              Global.gInformation = false,
              Global.fInformation = false,
              Global.garagePhotos = false,
                  Global.identifiationgst = false,

                  Navigator.of(context).pushNamed('newonboard'),
                Global.GARAGEDETAILS='FALSE',
                },
                 label: Row(
                    children: [
                      Text('New',style: AppStyles.whiteTextStyle.copyWith(
                        fontSize: 18
                      ),),
                      Padding(
                        padding:  EdgeInsets.only(left : 8.0),
                        child: Icon(Icons.add),
                      )
                    ],
                  ),),
              body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
                return
                  Container(
                margin: EdgeInsets.only( top : 15 , left : 10, right : 10),
                width: double.infinity,   
                height: SizeConfig.screenHeight,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                       crossAxisAlignment: CrossAxisAlignment.center,
                       mainAxisSize: MainAxisSize.max,
                    children: [

                      shopresult.length!=0 ?
                      ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: shopresult.length,
                          itemBuilder: (context,index){


                            return shopresult[index].shopname!=null ? GestureDetector(
                              onTap: () => {

                                if  ( shopresult[index].locationStatus=="1" &&
                                    shopresult[index].personalStatus=="1" &&
                                    shopresult[index].servicesStatus=="1" &&
                                    shopresult[index].informationStatus=="1" &&
                                    shopresult[index].facilityStatus=="1" &&
                                    shopresult[index].photosStatus=="1" &&
                                    shopresult[index].gstStatus=="1" )
                                  {

                                  }
                                else
                                  {
                                    Navigator.of(context).pushNamed(
                                        'onboarddashboard'),
                                    setState(() {
                                      Global.GARAGEDETAILS = 'TRUE';
                                      Global.GARGEID = shopresult[index].id;
                                      Global.PartnerID = shopresult[index].id;
                                    }),
                                  }
                              },
                              child: Card(
                                shape:  new RoundedRectangleBorder(
                                    side: new BorderSide(color: Colors.white, width: 2.0),
                                    borderRadius: BorderRadius.circular(4.0)),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:10.0,top:10,bottom: 10),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding:  EdgeInsets.only(left : 10),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text('${shopresult[index].shopname }',style: AppStyles.blackTextStyle.copyWith(

                                                ),),
                                                Padding(
                                                  padding: EdgeInsets.only(top : 8.0,bottom : 5.0),
                                                  child:shopresult[index].ownername!=null ? Text('${shopresult[index].ownername}',style: AppStyles.greyTextStyle.copyWith(
                                                      fontSize: 16
                                                  ),):Container(),
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.only(top : 0.0,bottom : 8.0),
                                                  child: Container(
                                                    width: MediaQuery.of(context).size.width/1.2,
                                                    child: Text('${shopresult[index].locality}',

                                                      style: AppStyles.greyTextStyle.copyWith(
                                                        fontSize: 16
                                                    ),),
                                                  ),
                                                ),

                                              ],
                                            ),
                                          ),

                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          shopresult[index].locationStatus=="1" &&
                                              shopresult[index].personalStatus=="1" &&
                                              shopresult[index].servicesStatus=="1" &&
                                              shopresult[index].informationStatus=="1" &&
                                              shopresult[index].facilityStatus=="1" &&
                                              shopresult[index].photosStatus=="1" &&
                                              shopresult[index].gstStatus=="1" ?

                                          Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                border: Border.all(
                                                    color: Colors.green[700], // Set border color
                                                    width: 3.0),   // Set border width
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)), // Set rounded corner radius
                                                boxShadow: [BoxShadow(blurRadius: 10,color: Colors.white,offset: Offset(1,3))] // Make rounded corner of border
                                            ),
                                            child: Text("Completed",style: TextStyle(color: Colors.white),),
                                          ):
                                          Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(10),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.red,
                                                border: Border.all(
                                                    color: Colors.red[700], // Set border color
                                                    width: 3.0),   // Set border width
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(10.0)), // Set rounded corner radius
                                                boxShadow: [BoxShadow(blurRadius: 10,color: Colors.white,offset: Offset(1,3))] // Make rounded corner of border
                                            ),
                                            child: Text("Pending",style: TextStyle(color: Colors.white),),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ) : Container();
                          }):
                      Text('No Saved Drafts')
                    ])

                ));})))))
    );
  }
}