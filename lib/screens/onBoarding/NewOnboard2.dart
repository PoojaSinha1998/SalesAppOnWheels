import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/Widgets/CustomTextFeild.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class NewBoard2 extends StatefulWidget {
  NewBoard2({Key key}) : super(key: key);
  @override
  _NewBoard2State createState() => _NewBoard2State();
}

class _NewBoard2State extends State<NewBoard2> {
  
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneNo = TextEditingController();
  TextEditingController shopName = TextEditingController();
  String whellers = '';
  String whellerName='';

  @override
  void initState() {
    super.initState();
    phoneNo.text = Global.PartnerContact;
  }

  nextFunc(){
    if (_formKey.currentState.validate() && whellers.isNotEmpty) {

      setState(() {
        Global.isLoading = true;
      });
      ApiServices.fetchUserRegisterVehicle(shopName.text,whellerName).then((value) {
        if(value!=null) {
          setState(() {
            Global.isLoading = false;
          });
          if(value.message=="success") {
            Navigator.of(context).pushNamed('onboarddashboard');
          }
        }
      });

      // Navigator.of(context).pushNamed('onboarddashboard');
    }
    else if (whellers.isEmpty) {
      Toast.show('Please Select Vehicle Type', context,gravity: 1);
    }
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
             onWillPop: () async => true,
            child: SafeArea(
            child: Scaffold( 
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                centerTitle: true,
                title: Text('New On-Boarding'),
                flexibleSpace: AppColors.flexibleAppBar
              ),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: (){
                  nextFunc();
                },
               label: Row(
                 children: [
                   Text('Next'),
                   Padding(
                     padding:  EdgeInsets.only(left : 8.0),
                     child: Icon(Icons.arrow_forward),
                   )
                 ],
               )),
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
                            padding: const EdgeInsets.all(8.0),
                            child: CustomTextfeild(
                              controller: phoneNo,
                              labeltext: 'Phone Number',
                              prefixicon: Icon(Icons.phone_android),
                              readOnly: true,
                              suffixIcon: Icon(Icons.check_circle,color: Colors.green,size: 30),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top : 15.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomTextfeild(
                                controller: shopName,
                                labeltext: 'Shop Name*',
                                prefixicon: Icon(Icons.shopping_bag),
                                validator: (val){
                                  if (val.trim().isEmpty) {
                                    return 'Please enter Shop Name';
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top : 15.0),
                          child: Container(
                            width: double.infinity,
                            child: Card(
                              
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Vehicle Type*',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600
                                    ),),
                                    Padding(
                                      padding: EdgeInsets.only(top : 10),
                                      child: Row(
                                        children: [
                                          Expanded(child: GestureDetector(
                                            onTap: (){
                                              setState(() {
                                                whellers = '2';
                                                whellerName = '2W';
                                              });
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.black,
                                                ),
                                                color: whellers == '2' ? Colors.green : Colors.white,
                                                borderRadius: BorderRadius.circular(5)
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.only(left : 15 , right: 15,top: 10,bottom: 10),
                                                child: Center(child: Text('2W',style: AppStyles.blackTextStyle,)),
                                              ),
                                            ),
                                          ),),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left : 8.0),
                                              child: GestureDetector(
                                              onTap: (){
                                                setState(() {
                                                  whellers = '4';
                                                  whellerName ='4W';
                                                });
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  border: Border.all(
                                                    color: Colors.black,
                                                  ),
                                                  color: whellers == '4' ? Colors.green : Colors.white,
                                                  borderRadius: BorderRadius.circular(5)
                                                ),
                                                child: Padding(
                                                  padding: const EdgeInsets.only(left : 15 , right: 15,top: 10,bottom: 10),
                                                  child: Center(child: Text('4W',style: AppStyles.blackTextStyle,)),
                                                ),
                                              ),
                                          ),
                                            ),),
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(left : 8.0),
                                              child: TextField(
                                              keyboardType: TextInputType.number,
                                              
                                              decoration: InputDecoration(
                                                isCollapsed: true,
                                                labelText: 'Tyres',
                                                contentPadding: EdgeInsets.only(left : 15 , right: 15,top: 12,bottom: 12),
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                  borderSide: BorderSide(
                                                    color: Colors.black
                                                  )
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                  borderSide: BorderSide(
                                                    color: Colors.black
                                                  )
                                                ),
                                                enabledBorder: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(5),
                                                  borderSide: BorderSide(
                                                    color: Colors.black
                                                  )
                                                ),
                                                isDense: true
                                              ),  
                                              onChanged: (val){
                                                setState(() {
                                                  whellers = val;
                                                  whellerName = val;
                                                });
                                              },
                                              ),
                                            ))
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ]))),
                   );})))))
    );
  }
}