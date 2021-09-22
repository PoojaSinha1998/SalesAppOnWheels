import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class FacilityInformation extends StatefulWidget {
  FacilityInformation({Key key}) : super(key: key);

  @override
  _FacilityInformationState createState() => _FacilityInformationState();
}

class _FacilityInformationState extends State<FacilityInformation> {
  
  int peakCapacity = 0;
  int workBays = 0;
  bool ramps = false;
  bool paintBooths = false;
  bool hr = false;
  bool washing = false;
  bool dentPuller = false;
  bool wheelAlignment = false;
  bool onLinepayment = false;
  bool neft = false;
  bool carswipe = false;
  bool creditcard = false;
  String sramps = '';
  String spaintBooths = '';
  String shr = '';
  String swashing = '';
  String sdentPuller = '';
  String swheelAlignment = '';
  String sonLinepayment = '';
  String sneft = '';
  String scarswipe = '';
  String screditcard = '';
  submit(){
    setState(() {
      setState(() {
        Global.fInformation = true;
      });
      if (ramps) {
        sramps = "Yes";
      }
      else {
        sramps = "No";
      }
      if (paintBooths) {
        spaintBooths = "Yes";
      }
      else {
        spaintBooths = "No";
      }
      if (hr) {
        shr = "Yes";
      }
      else {
        shr = "No";
      }
      if (washing) {
        swashing = "Yes";
      }
      else {
        swashing = "No";
      }
      if (dentPuller) {
        sdentPuller = "Yes";
      }
      else {
        sdentPuller = "No";
      }
      if (wheelAlignment) {
        swheelAlignment = "Yes";
      }
      else {
        swheelAlignment = "No";
      }
      if (onLinepayment) {
        sonLinepayment = "Yes";
      }
      else {
        sonLinepayment = "No";
      }
      if (neft) {
        sneft = "Yes";
      }
      else {
        sneft = "No";
      }
      if (carswipe) {
        scarswipe = "Yes";
      }
      else {
        scarswipe = "No";
      }
      if (creditcard) {
        screditcard = "Yes";
      }
      else {
        screditcard = "No";
      }
if(peakCapacity!=0){
  if(workBays!=0) {
    setState(() {
      Global.isLoading = true;
    });
    ApiServices.addFacilityforGarage(
        peakCapacity.toString(),
        workBays.toString(),
        sramps,
        spaintBooths,
        shr,
        swashing,
        sdentPuller,
        swheelAlignment,
        sonLinepayment,
        sneft,
        scarswipe,
        screditcard).then((value) {
      if (value != null) {
        setState(() {
          Global.isLoading = false;
        });
        if (value.message == "success") {
          Navigator.of(context).pushNamed('onboarddashboard');
        }
      }
    });
  }else{
    Toast.show('Please Provide the Work Bays.', context,gravity: 1);
  }
    }
else{
  Toast.show('Please Provide the Peak Capacity.', context,gravity: 1);
}
      // Navigator.of(context).pushNamed('onboarddashboard');
      
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
                title: Text('Facility Information'),
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

                        Card(
                          child: Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Peak Capacity : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color : Colors.black),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove,color: Colors.red), 
                                          onPressed: (){
                                            setState(() {
                                              if (peakCapacity != 0) {
                                                peakCapacity --;
                                              }
                                            });
                                          }),
                                          Text('$peakCapacity',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                          IconButton(
                                          icon: Icon(Icons.add,color: Colors.green,), 
                                          onPressed: (){
                                            setState(() {
                                              peakCapacity ++;
                                            });
                                          }),
                                      ],
                                    ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Work Bays : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Container(
                                      decoration: BoxDecoration(
                                        border: Border.all(color : Colors.black),
                                        borderRadius: BorderRadius.circular(5)
                                      ),
                                    child: Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove,color: Colors.red), 
                                          onPressed: (){
                                            setState(() {
                                              if (workBays != 0) {
                                                workBays --;
                                              }
                                            });
                                          }),
                                          Text('$workBays',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                          IconButton(
                                          icon: Icon(Icons.add,color: Colors.green,), 
                                          onPressed: (){
                                            setState(() {
                                              workBays ++;
                                            });
                                          }),
                                      ],
                                    ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Ramps : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: ramps,
                                   onChanged: (bool value) { setState(() { ramps = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Paint Booths : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: paintBooths,
                                   onChanged: (bool value) { setState(() { paintBooths = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('24*7 : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: hr,
                                   onChanged: (bool value) { setState(() { hr = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Wash Facility : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: washing,
                                   onChanged: (bool value) { setState(() { washing = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Dent Puller Machine : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: dentPuller,
                                   onChanged: (bool value) { setState(() { dentPuller = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Wheel Alignment Facility : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: wheelAlignment,
                                   onChanged: (bool value) { setState(() { wheelAlignment = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Online Payment (Paytm\nGoogle Pay) : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: onLinepayment,
                                   onChanged: (bool value) { setState(() { onLinepayment = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('NEFT/IMPS : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: neft,
                                   onChanged: (bool value) { setState(() { neft = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Card Swipe Mchine : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: carswipe,
                                   onChanged: (bool value) { setState(() { carswipe= value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                                Divider(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Credit Card Payments : ',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                    Row(
                                      children: [
                                        Text('No',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                        CupertinoSwitch(
                                   value: creditcard,
                                   onChanged: (bool value) { setState(() { creditcard = value; }); },
                                   ),
                                   Text('Yes',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            ),
                        ),
                        Container(
                          height: 70,
                        )
                      ])));})))))
    );
  }
}