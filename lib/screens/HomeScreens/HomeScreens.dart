import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

   SharedPreferences pref;
   String userName,userPhone,userEmail;

   @override
   void initState() {
     // TODO: implement initState
     super.initState();
     initializePref();

   }
  Future<bool> _exitApp(BuildContext context) {
    return showDialog(
          context: context,
          builder: (context){
            return AlertDialog(
            title: Text('Do you want to Logout'),
            
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  print("you choose no");
                  Navigator.of(context).pop(false);
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () {
                  pref.setString("REMEMBER","FALSE");
                  Navigator.of(context).pop();
                  Navigator.of(context).popAndPushNamed('signin');
                },
                child: Text('Yes'),
              ),
            ],
          );
          },
        ) ??
        false;
  }
  Future<void> initializePref()async{
    pref = await SharedPreferences.getInstance();
    // userName = preferences.getString(Global.UserName);
    // userPhone =preferences.getString(Global.UserContact);
    // userEmail =preferences.getString(Global.UserEmail);
    userName = (Global.UserName);
    userPhone =(Global.UserContact);
    userEmail =(Global.UserEmail);
    setState(() {

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
             onWillPop: () async => false,
            child: SafeArea(
            child: Scaffold( 
              resizeToAvoidBottomInset: true,
              appBar: AppBar(
                automaticallyImplyLeading: false,
                centerTitle: true,
                title: Text('Sales OnWheelss'),
                flexibleSpace: AppColors.flexibleAppBar
              ),
              body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return 
                   Container(
                margin: EdgeInsets.only( top : 15 , left : 10, right : 10),
                width: double.infinity,   
                height: SizeConfig.screenHeight,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        //mainAxisAlignment: MainAxisAlignment.spaceAround,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding:  EdgeInsets.only(top : 8.0,bottom: 8.0),
                                child: Text('Hi ${userName}!',style: AppStyles.blackTextStyle.copyWith(
                                  fontWeight: FontWeight.w600,fontSize: 22
                                )),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top : 2.0,bottom: 2.0),
                                child: Text('${userPhone}',style: AppStyles.blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w600,fontSize: 18
                                )),
                              ),
                              Padding(
                                padding:  EdgeInsets.only(top : 2.0,bottom: 8.0),
                                child: Text('${userEmail}',style: AppStyles.blackTextStyle.copyWith(
                                    fontWeight: FontWeight.w600,fontSize: 18
                                )),
                              ),
                            ],
                          ),
                          Padding(
                            padding:  EdgeInsets.only(top  : SizeConfig.safeBlockVertical * 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 150,
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Navigator.of(context).pushNamed('onboardingscreen'),
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset('assets/images/onboard.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('On-Boarding',style: AppStyles.blackTextStyle.copyWith(
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
                                child: Card(
                                  
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Navigator.of(context).pushNamed('reports'),
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset('assets/images/report.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('Report',style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 18
                                      ),),
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
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => Navigator.of(context).pushNamed('rechargescreen'),
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset('assets/images/recharge.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('Recharge',style: AppStyles.blackTextStyle.copyWith(
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
                                child: Card(
                                  
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: (){
                                      Navigator.of(context).pushNamed('rechargealert');
                                    },
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset('assets/images/alert.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('Recharge Alert',style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 17
                                      ),),
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
                                child: Card(
                                  elevation: 5,
                                  shape: RoundedRectangleBorder(
                                 borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10),
                                    onTap: () => _exitApp(context),
                                    child: Padding(
                                 padding:  EdgeInsets.all(15.0),
                                 child: Column(
                                   crossAxisAlignment: CrossAxisAlignment.center,
                                   children: [
                                    Image.asset('assets/images/logout.png',height: 60,),
                                    Padding(
                                      padding:  EdgeInsets.only( top : 8.0),
                                      child: Text('Logout',style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 18
                                      ),),
                                    )
                                   ],
                                 ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                        ]))));})))))
    );
  }
}