import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/Widgets/CustomShadowButton.dart';
import 'package:SalesOnwheelss/Widgets/CustomTextFeild.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/Validators.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';


class SignIn extends StatefulWidget {
  SignIn({Key key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  bool remember = true;
  TextEditingController password = TextEditingController();
  bool obscueText = true;
  SharedPreferences prefs;
  TextEditingController emailId = TextEditingController();
  signIn(){
    if (_formKey.currentState.validate()) {
      LoginAPI(emailId.text,password.text);

    }
  }
   Future<void> initializePref()async{
     prefs = await SharedPreferences.getInstance();
     String mobile =  prefs.getString("MOBILE");
     String password =  prefs.getString("PASS");
     var remem=  prefs.getString("REMEMBER");

     print("${mobile}");
     if(remem == "TRUE") {
       LoginAPI(mobile,password);
     }

  }

  AutoLoginAPI(String mobile)  {

    setState(() {
      Global.isLoading= false;
    });
    Global.UserContact = prefs.getString("UserContact");
    // Global.UserEmail = value.result.email;
    prefs.setString("MOBILE", mobile);

    Global.UserName=  prefs.getString("UserName");
    Global.UserEmail= prefs.getString("UserEmail");
    Global.UserId = prefs.getString("UserId");



    // REMEMBER
    var remem=  prefs.getString("REMEMBER");

    Navigator.of(context).pushNamed('homescreen');
    print("Remember ${remem}");

    // ApiServices.fetchUserLoginData(mobile, "123456").then((value) {
    //   if(value!=null) {
    //     setState(() {
    //       Global.isLoading = false;
    //     });
    //     if(value.message=="success"){
    //       // Global.UserName = value.result.usertype;
    //       Global.UserMobile = mobile;
    //       // Global.UserEmail = value.result.email;
    //       Global.UserId = value.result[0].userId;
    //       prefs.setString("MOBILE", mobile);
    //       // REMEMBER
    //       var remem=  prefs.getString("REMEMBER");
    //
    //       Navigator.of(context).pushNamed('homescreen');
    //       print("Remember ${remem}");
    //     }
    //     else{
    //       Toast.show(value.result[0].description, context);
    //     }
    //   }
    // });
    // => Navigator.of(context).pushNamed('forgotpassword')
  }

  LoginAPI(String emailId, String password) {
setState(() {
  Global.isLoading= true;
});
    ApiServices.fetchUserLoginData(emailId, password).then((value) {
      if(value!=null) {
        setState(() {
          Global.isLoading= false;
        });

        // preferences.setString(Global.UserName, value.result[0].name);
        // preferences.setString(Global.UserEmail, value.result[0].email);
        // preferences.setString(Global.UserContact, value.result[0].phone);
        //
        // print("DATA ${preferences.getString(Global.UserContact)}");
          if(value.message=="success")  {

            prefs.setString("MOBILE", emailId);
            prefs.setString("PASS", password);
            // REMEMBER
            var remem=  prefs.getString("REMEMBER");
            // if(remem!="TRUE"){
              if(remember) {
                prefs.setString("REMEMBER","TRUE");
              }
              else{
                prefs.setString("REMEMBER","FALSE");
              }
              Global.UserName = value.result[0].name;
              Global.UserContact = value.result[0].phone;
              Global.UserEmail = value.result[0].email;
              Global.UserId = value.result[0].id;

            prefs.setString("UserId",value.result[0].id);
            prefs.setString("UserEmail",value.result[0].email);
            prefs.setString("UserContact",value.result[0].phone);
            prefs.setString("UserName",value.result[0].name);
              print("DATA ${prefs.getString(Global.UserContact)}");
              setData();
              Navigator.of(context).pushNamed('homescreen');
              // Navigator.of(context).pushNamed('homescreen');
            // }

        }
          else{
            Toast.show('${value.result[0].description}', context,gravity: 1);
          }
      }
    });

    // => Navigator.of(context).pushNamed('forgotpassword')
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializePref();

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
              body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return Form(
              key: _formKey,
              child: Container(
                margin: EdgeInsets.only( top : 5 , left : 15, right : 15),
                width: double.infinity,   
                height: SizeConfig.screenHeight,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(

                        children: [
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                             Padding(
                               padding:  EdgeInsets.only(top : SizeConfig.safeBlockVertical * 10),
                               child: Text('Welcome to Sales OnWheelss ',style: AppStyles.blackTextStyle.copyWith(fontSize: 24),),
                             ),
                             Padding(
                               padding:  EdgeInsets.only(top : 20.0),
                               child: Image.asset('assets/images/mainlogo.jpg'),
                             ),
                             Padding(
                             padding:  EdgeInsets.only(top : 40.0),
                               child: CustomTextfeild(
                                 controller: emailId,
                                 labeltext: 'Email',
                                 textInputType: TextInputType.emailAddress,
                                 validator: (value) {
                                          if (value.trim().isEmpty) {
                                            return 'Please enter your EmailId.';
                                          }
                                          return Validators.mustEmail(value.trim());
                                        },
                               ),
                             ),
                              Padding(
                         padding:  EdgeInsets.only(top : 20.0),
                           child: CustomTextfeild(
                             controller: password,
                             labeltext: 'Password',
                             obscureText: obscueText,
                             validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return 'Please enter your password.';
                                      }
                                      return null;
                                    },
                             suffixIcon: IconButton(
                                          icon: obscueText
                                              ? Icon(Icons.visibility_off,
                                                  color: AppColors.greyColor,)
                                              : Icon(Icons.visibility,
                                                  color: AppColors.greyColor,),
                                          onPressed: () {
                                            setState(() {
                                              obscueText = !obscueText;
                                            });
                                          }),
                           ),
                         ),
                              Padding(
                               padding:  EdgeInsets.only( top : 15.0),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                 children: [
                                   Row(
                                     children: [
                                        ClipRRect(
                                    clipBehavior: Clip.hardEdge,
                                    borderRadius: BorderRadius.all(Radius.circular(5)),
                                    child: SizedBox(
                                      width: Checkbox.width,
                                      height: Checkbox.width,
                                      child: Container(
                                        decoration: new BoxDecoration(
                                          border: Border.all(
                                              width: 1,
                                          ),
                                          borderRadius: new BorderRadius.circular(5),
                                        ),
                                        child: Theme(
                                          data: ThemeData(
                                              unselectedWidgetColor: Colors.transparent,
                                          ),
                                          child: Checkbox(
                                              value: remember,
                                              onChanged: (state) =>
                                                  setState(() => remember = !remember),
                                              activeColor: Colors.black,
                                              checkColor: Colors.white,
                                              materialTapTargetSize: MaterialTapTargetSize.padded,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                 Padding(
                                         padding: const EdgeInsets.only(left : 5.0),
                                         child: Text('Remember',style: AppStyles.blackTextStyle.copyWith(
                                           fontSize : 14,fontWeight : FontWeight.w500),),
                                       )
                                     ],
                                   ),
                                   GestureDetector(
                                     onTap: () {
                                           Navigator.of(context).pushNamed(
                                               'forgotpassword');


                                     },
                                     child: Text('Forgot Password ?',style: AppStyles.greyTextStyle.copyWith(fontSize : 14),),
                                   )
                                 ],
                               ),
                             ),
                           ]),
                           SizedBox(
                             height: 50,
                           ),
                           CustomShadowButtom(
                             text: 'LOGIN',
                             onTap: signIn
                              ),
                        ],
                      )))));})))))
    );
  }

  void setData() {


  }
}

