import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/response/addServicelDetails.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class ServiceCapability extends StatefulWidget {
  ServiceCapability({Key key}) : super(key: key);

  @override
  _ServiceCapabilityState createState() => _ServiceCapabilityState();
}

class _ServiceCapabilityState extends State<ServiceCapability> {
  List<Result> servicedetails = List();
List<String> servieList = [];
List<String> servieListRE = [];
bool pickup = false;
bool doorstep = false;
String sPickup;
String sDrop;
  submit(){
    // if (servieList.isEmpty || servieListRE.isEmpty) {
    if (servieList.isEmpty) {
      Toast.show('Please Select atlest 1 service', context,gravity: 1);
    }
    else{
      setState(() {
        Global.services = true;
        Global.isLoading = false;
        print("pickup ${pickup}");
        print("doorstep ${doorstep}");
        if(pickup)
          {
            sPickup ="Yes";
          }
        else{
          sPickup ="No";
        }
        if(doorstep)
        {
          sDrop ="Yes";
        }
        else{
          sDrop ="No";
        }
        ApiServices.fetchUserRegisterServiceGarage(servieListRE,sPickup,sDrop).then((value) {
          if(value!=null) {
            setState(() {
              Global.isLoading = false;
            });
            if(value.message=="success") {
              Navigator.of(context).pushNamed('onboarddashboard');
            }
          }
        });

      });

    }
  }
@override
void initState() {
    getServiceList();
}
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 7;
    final double itemWidth = size.width ;
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
                title: Text('Service Capability'),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisSize: MainAxisSize.max,
                        children: [
                          Card(
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                 mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Services Offered*',style: AppStyles.blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w600
                                  ),),
//todo
                                GridView.count(
                                  childAspectRatio: (itemWidth / itemHeight),
                                  controller: new ScrollController(keepScrollOffset: false),
                                  shrinkWrap: true,
                                  crossAxisCount: 1,
                                  children: List.generate(servicedetails.length, (index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Center(
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {

                                              servieListRE.contains(servicedetails[index].id) ? servieListRE.remove(servicedetails[index].id) :
                                              servieListRE.add(servicedetails[index].id);

                                              servieList.contains(servicedetails[index].title) ? servieList.remove(servicedetails[index].title) :
                                              servieList.add(servicedetails[index].title);
                                            });
                                          },
                                          child: Container(

                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.black
                                                ),
                                                color: servieList.contains(servicedetails[index].title) ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(11.0),
                                              child: Row(
                                                children: [
                                                  Image.asset('assets/images/snowflake.png',height: 25,),
                                                  Padding(
                                                    padding:  EdgeInsets.only(left : 8.0),
                                                    child: Container(
                                                      width: MediaQuery.of(context).size.width-150,
                                                      child: Text('${servicedetails[index].title}'
                                                        ,style: AppStyles.blackTextStyle.copyWith(
                                                          fontSize: 16
                                                      ),),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                                ),
                          /*        Padding(
                                    padding: EdgeInsets.only(top : 8.0),
                                    child: Text('NRE',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieList.contains('Repair Job') ? servieList.remove('Repair Job') : 
                                              servieList.add('Repair Job');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieList.contains('Repair Job') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(11.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Repair Job',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          SizedBox(width : 10),
                                          Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieList.contains('Breakdowm Assistance') ? servieList.remove('Breakdowm Assistance') : 
                                              servieList.add('Breakdowm Assistance');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieList.contains('Breakdowm Assistance') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.5),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Breakdowm\nAssistance',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                  ),
                                  ///////////////////// 
                                  Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieList.contains('Service & Polish 1299') ? servieList.remove('Service & Polish 1299') : 
                                              servieList.add('Service & Polish 1299');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieList.contains('Service & Polish 1299') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Service &\nPolish 1299',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          SizedBox(width : 10),
                                          Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieList.contains('Ceramic Coating') ? servieList.remove('Ceramic Coating') : 
                                              servieList.add('Ceramic Coating');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieList.contains('Ceramic Coating') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Ceramic\nCoating',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                  ),
                                  /////////////  
                                   Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieList.contains('Engine Repair') ? servieList.remove('Engine Repair') : 
                                              servieList.add('Engine Repair');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieList.contains('Engine Repair') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.5),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Engine\nRepair',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          SizedBox(width : 10),
                                          Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieList.contains('Full Body Painting') ? servieList.remove('Full Body Painting') : 
                                              servieList.add('Full Body Painting');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieList.contains('Full Body Painting') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.5),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Full Body\nPainting',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                  ),
                                  ////// 
                                    Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieList.contains('General Service 999') ? servieList.remove('General Service 999') : 
                                              servieList.add('General Service 999');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieList.contains('General Service 999') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('General\nService 999',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          SizedBox(width : 10),
                                          Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieList.contains('General Service 1199') ? servieList.remove('General Service 1199') : 
                                              servieList.add('General Service 1199');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieList.contains('General Service 1199') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('General\nService 1199',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              servieList.contains('Bike Inspection') ? servieList.remove('Bike Inspection') : 
                                            servieList.add('Bike Inspection');
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black
                                              ),
                                              color: servieList.contains('Bike Inspection') ? Colors.green : Colors.white,
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Image.asset('assets/images/snowflake.png',height: 25,),
                                                  Padding(
                                                    padding:  EdgeInsets.only(left : 8.0,right : 30),
                                                    child: Text('Bike\nInspection',style: AppStyles.blackTextStyle.copyWith(
                                                      fontSize: 16
                                                    ),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                         
                                          
                                      ],
                                    ),
                                  ),

                                  ///////////////////////////////////////////////////////////////// 
                                  Padding(
                                    padding: EdgeInsets.only(top : 8.0),
                                    child: Text('RE',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600
                                    ),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieListRE.contains('RE Service & Polish 1999') ? 
                                                servieListRE.remove('RE Service & Polish 1999') : 
                                              servieListRE.add('RE Service & Polish 1999');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieListRE.contains('RE Service & Polish 1999') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(11.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('RE Service\n& Polish 1999',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 14
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          SizedBox(width : 10),
                                          Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieListRE.contains('RE Service 1999') ? servieListRE.remove('RE Service 1999') : 
                                              servieListRE.add('RE Service 1999');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieListRE.contains('RE Service 1999') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(7),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('RE Service\n1999',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                  ),
                                  ///////////////////// 
                                  Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieListRE.contains('General Service 1499') ? servieListRE.remove('General Service 1499') : 
                                              servieListRE.add('General Service 1499');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieListRE.contains('General Service 1499') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('General\nService 1499',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          SizedBox(width : 10),
                                          Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieListRE.contains('Repair Job RE') ? servieListRE.remove('Repair Job RE') : 
                                              servieListRE.add('Repair Job RE');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieListRE.contains('Repair Job RE') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Repair Job RE',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 15
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                  ),
                                  /////////////  
                                   Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieListRE.contains('Engine Repair') ? servieListRE.remove('Engine Repair') : 
                                              servieListRE.add('Engine Repair');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieListRE.contains('Engine Repair') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.5),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Engine\nRepair',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          SizedBox(width : 10),
                                          Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieListRE.contains('Full Body Painting') ? servieListRE.remove('Full Body Painting') : 
                                              servieListRE.add('Full Body Painting');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieListRE.contains('Full Body Painting') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(4.5),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Full Body\nPainting',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                  ),
                                  ////// 
                                    Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieListRE.contains('Breakdown Assistance') ? servieListRE.remove('Breakdown Assistance') : 
                                              servieListRE.add('Breakdown Assistance');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieListRE.contains('Breakdown Assistance') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Breakdown\nAssistance',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                          SizedBox(width : 10),
                                          Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieListRE.contains('Ceramic Coating') ? servieListRE.remove('Ceramic Coating') : 
                                              servieListRE.add('Ceramic Coating');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieListRE.contains('Ceramic Coating') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Ceramic\nCoating',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top  : 8.0),
                                    child: Row(
                                      children: [
                                        GestureDetector(
                                          onTap: (){
                                            setState(() {
                                              servieListRE.contains('Bike Inspection') ? servieListRE.remove('Bike Inspection') : 
                                            servieListRE.add('Bike Inspection');
                                            });
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black
                                              ),
                                              color: servieListRE.contains('Bike Inspection') ? Colors.green : Colors.white,
                                              borderRadius: BorderRadius.circular(5)
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(5.0),
                                              child: Row(
                                                children: [
                                                  Image.asset('assets/images/snowflake.png',height: 25,),
                                                  Padding(
                                                    padding:  EdgeInsets.only(left : 8.0,right : 30),
                                                    child: Text('Bike\nInspection',style: AppStyles.blackTextStyle.copyWith(
                                                      fontSize: 16
                                                    ),),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),

                                        SizedBox(width : 10),
                                          Expanded(
                                          child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                servieListRE.contains('Premium Bike Detailing 1499') ? servieListRE.remove('Premium Bike Detailing 1499') : 
                                              servieListRE.add('Premium Bike Detailing 1499');
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black
                                                ),
                                                color: servieListRE.contains('Premium Bike Detailing 1499') ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(5.0),
                                                child: Row(
                                                  children: [
                                                    Image.asset('assets/images/snowflake.png',height: 25,),
                                                    Padding(
                                                      padding:  EdgeInsets.only(left : 8.0),
                                                      child: Text('Premium Bike\nDetailing 1499',style: AppStyles.blackTextStyle.copyWith(
                                                        fontSize: 16
                                                      ),),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )),
                                         
                                          
                                      ],
                                    ),
                                  ),*/
                                
                                ],
                              ),
                              ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top : 10),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Pick-Up : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: pickup,
                                   onChanged: (bool value) { setState(() { pickup = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            
                            ),
                            
                            Padding(
                            padding: EdgeInsets.only(top : 10),
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Door Step : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: doorstep,
                                   onChanged: (bool value) { setState(() { doorstep = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
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
                        ])));})))))
    );
  }

  void getServiceList() {
    ApiServices.fetchUserServiceGarage().then((value) {
      if(value!=null) {
        setState(() {
          Global.isLoading = false;
        });
        if(value.message=="success") {
           servicedetails = value.result;
        }
      }
    });
  }
}