import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/Widgets/CustomTextFeild.dart';
import 'package:SalesOnwheelss/response/BankList.dart';
import 'package:SalesOnwheelss/response/garageBranding.dart';
import 'package:SalesOnwheelss/util/ApiServices.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:toast/toast.dart';

class GarageInformation extends StatefulWidget {
  GarageInformation({Key key}) : super(key: key);

  @override
  _GarageInformationState createState() => _GarageInformationState();
}

class _GarageInformationState extends State<GarageInformation> {

 TextEditingController area = TextEditingController();
 TextEditingController workingfrom = TextEditingController();
 TextEditingController workingto = TextEditingController();
 int noOfMechanics = 0;
 List<String> workigndays = [];
 String sworkingays;
 String establishedYear = '';
 
 String garageBranding;
 String bankName;
 List<Result> bankdetails=List();
 List<String> sbankdetails=List();
 String sbank ="Brand Details";
 String sBankid="" ;

 List<ResultBrand> branddetails = List();
 List<String> sbranddetails = List();
 String sbrand="Bank Details";
 String sBrandid="";
  submit() {
    for (Result s in bankdetails) {
      if (s.title == sbank) {
        sBankid = s.id;
      }
    }
    for (ResultBrand s in branddetails) {
      if (s.title == sbrand) {
        sBrandid = s.id;
      }
    }
    print("ESTABLISHED ${establishedYear}");
    sworkingays = workigndays.join(",");
    if(establishedYear!="") {
      if (area.text.length != 0) {
        if (noOfMechanics != 0) {
          if (workigndays.length != 0) {
         if  ( workingfrom.text.length!=0) {
           if(workingto.text.length!=0){
             if(sBrandid!=""){
               if(sBankid!="") {
                 Global.isLoading = true;
                 ApiServices.fetchOnBoardGarageInformationAdd(
                     "1",
                     establishedYear,
                     area.text,
                     noOfMechanics.toString(),
                     sworkingays,
                     workingfrom.text.toString(),
                     workingto.text.toString(),
                     sBrandid,
                     sBankid).then((value) {
                   if (value != null) {
                     setState(() {
                       Global.isLoading = false;
                     });
                     if (value.message == "success") {
                       setState(() {
                         Global.gInformation = true;
                       });
                       Navigator.of(context).pushNamed('onboarddashboard');
                     }
                   }
                 });
               }
               else{
                 Toast.show('Please Select the Bank.', context,gravity: 1);
               }
             } else{
               Toast.show('Please Select the Brand.', context,gravity: 1);
             }
         } else{
           Toast.show('Please provide the working time .', context,gravity: 1);
         }
         } else{
           Toast.show('Please provide the working time .', context,gravity: 1);
         }
          }
          else{
            Toast.show('Please provide the working days .', context,gravity: 1);
          }
        }
        else{
          Toast.show('Please provide the number of mechanics.', context,gravity: 1);
        }
      }
      else{
        Toast.show('Please provide the area.', context,gravity: 1);
      }
    }

    else{
      Toast.show('Please select Established year.', context,gravity: 1);
    }


      // Navigator.of(context).pushNamed('onboarddashboard');
  }

  TimeOfDay _time = TimeOfDay(hour: 7, minute: 15);

  void _selectTime(String from) async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
    );
    if (newTime != null) {
      
        _time = newTime;
        if (from == 'from') {
          setState(() {
            workingfrom.text = _time.format(context);
          });
        } else {
          setState(() {
            workingto.text = _time.format(context);
          });
        }
      
    }
  }

 void getGarageBranding() {
   ApiServices.fetchUserGarageBranding().then((value) {
     if(value!=null) {
       setState(() {
         Global.isLoading = false;
       });
       if(value.message=="success") {
         branddetails = value.result;
         for(ResultBrand b in branddetails)
         {
           sbranddetails.add(b.title);
         }

         // str2 = sbranddetails.join(",");
         // print("BANK ${str1}");
       }
     }
   });
 }
 void getBankNames() {
   ApiServices.fetchUserBanklist().then((value) {
     if(value!=null) {
       setState(() {
         Global.isLoading = false;
       });
       if(value.message=="success") {
         bankdetails = value.result;
         for(Result b in bankdetails)
           {
             sbankdetails.add(b.title);
           }

         // str1 = sbankdetails.join(",");
         // print("BANK ${str1}");
       }
     }
   });
 }
 @override
 void initState() {
   getGarageBranding();
   getBankNames();
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
                title: Text('Garage Information'),
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
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisSize: MainAxisSize.max,
                          children: [
                            DropdownButtonFormField<String>(
                              
                              style: TextStyle(color: Colors.black),
                               decoration: InputDecoration(
                                 labelText: 'Established Year',
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(5)
                                 )
                               ),
                              items: <String>[
                                '1990',
                                '1991',
                                '1992',
                                '1993',
                                '1994',
                                '1995',
                                '1996',
                                '1997',
                                '1998','1999','2000',
                                '2001','2002','2003','2004','2005','2006','2007','2008',
                                '2009',
                                '2010','2011','2012','2013','2014','2015','2016','2017','2018','2019','2020','2021',
                              ].map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              isDense: true,
                              onChanged: (String value) {
                                setState(() {
                                  establishedYear =value;
                                });
                              },
                            ),
                            Divider(),
                            CustomTextfeild(
                              controller: area,
                              labeltext: 'Area (sq.ft)',

                            ),
                            Divider(),
                            Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('No. of Mechanics : ',style: AppStyles.blackTextStyle.copyWith(
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
                                              if (noOfMechanics != 0) {
                                                noOfMechanics --;
                                              }
                                            });
                                          }),
                                          Text('$noOfMechanics',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w500,fontSize: 16
                                    ),),
                                          IconButton(
                                          icon: Icon(Icons.add,color: Colors.green,), 
                                          onPressed: (){
                                            setState(() {
                                              noOfMechanics ++;
                                            });
                                          }),
                                      ],
                                    ),
                                    ),
                                  ],
                                ),
                                Divider(),
                                Padding(
                                  padding:  EdgeInsets.only(top : 5.0),
                                  child: Text('Working Days : ',style: AppStyles.blackTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,fontSize: 16
                                      ),),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top : 10.0,bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {

                                            });
                                            workigndays.contains('S') ? workigndays.remove('S') : workigndays.add('S');
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border:workigndays.contains('S') ? Border.all(color : Colors.red) :
                                              Border.all(color : Colors.black)
                                            ),
                                            child: Center(child: Text('S')),
                                          ),
                                        )),
                                        SizedBox(width : 5),
                                        Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {

                                            });
                                            workigndays.contains('M') ? workigndays.remove('M') : workigndays.add('M');
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border:workigndays.contains('M') ? Border.all(color : Colors.red) : Border.all(color : Colors.black)
                                            ),
                                            child: Center(child: Text('M')),
                                          ),
                                        )),
                                        SizedBox(width : 5),
                                        Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {

                                            });
                                            workigndays.contains('Tu') ? workigndays.remove('Tu') : workigndays.add('Tu');
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border:workigndays.contains('Tu') ? Border.all(color : Colors.red) : Border.all(color : Colors.black)
                                            ),
                                            child: Center(child: Text('TU')),
                                          ),
                                        )),
                                        SizedBox(width : 5),
                                        Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {

                                            });
                                            workigndays.contains('W') ? workigndays.remove('W') : workigndays.add('W');
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border:workigndays.contains('W') ? Border.all(color : Colors.red) : Border.all(color : Colors.black)
                                            ),
                                            child: Center(child: Text('W')),
                                          ),
                                        )),
                                        SizedBox(width : 5),
                                        Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {

                                            });
                                            workigndays.contains('T') ? workigndays.remove('T') : workigndays.add('T');
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border:workigndays.contains('T') ? Border.all(color : Colors.red) : Border.all(color : Colors.black)
                                            ),
                                            child: Center(child: Text('T')),
                                          ),
                                        )),
                                        SizedBox(width : 5),
                                        Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {

                                            });
                                            workigndays.contains('F') ? workigndays.remove('F') : workigndays.add('F');
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border:workigndays.contains('F') ? Border.all(color : Colors.red) : Border.all(color : Colors.black)
                                            ),
                                            child: Center(child: Text('F')),
                                          ),
                                        )),
                                        SizedBox(width : 5),
                                        Expanded(
                                        child: GestureDetector(
                                          onTap: (){
                                            setState(() {

                                            });
                                            workigndays.contains('SA') ? workigndays.remove('SA') : workigndays.add('SA');
                                          },
                                          child: Container(
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              border:workigndays.contains('SA') ? Border.all(color : Colors.red) : Border.all(color : Colors.black)
                                            ),
                                            child: Center(child: Text('SA')),
                                          ),
                                        )),
                                        SizedBox(width : 5),
                                    ],
                                  ),
                                ),
                                Divider(),
                                Padding(
                                  padding:  EdgeInsets.only(top : 5.0),
                                  child: Text('Working Time : ',style: AppStyles.blackTextStyle.copyWith(
                                        fontWeight: FontWeight.w500,fontSize: 16
                                      ),),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top : 8.0),
                                  child: CustomTextfeild(
                                    controller : workingfrom,
                                    labeltext: 'From',
                                    onTap: (){
                                      _selectTime('from');
                                    },
                                  ),
                                ),
                                Padding(
                                  padding:  EdgeInsets.only(top : 8.0),
                                  child: CustomTextfeild(
                                    controller : workingto,
                                    labeltext: 'To',
                                    onTap: (){
                                      _selectTime('to');
                                    },
                                  ),
                                ),
                                Divider(),
                                DropdownButtonFormField<String>(
                              
                              style: TextStyle(color: Colors.black),
                               decoration: InputDecoration(
                                 labelText: 'Garage Branding',
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(5)
                                 )
                               ),
                              items: sbranddetails.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              isDense: true,
                              onChanged: (String value) {
                                setState(() {
                                  sbrand = value;
                                });
                              },
                            ),
                            Divider(),
                            DropdownButtonFormField<String>(
                              style: TextStyle(color: Colors.black),
                               decoration: InputDecoration(
                                 labelText: 'Bank Name',
                                 border: OutlineInputBorder(
                                   borderRadius: BorderRadius.circular(5)
                                 )
                               ),
                              items: sbankdetails.map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              isDense: true,
                              onChanged: (String value) {
                                setState(() {
                                  sbank = value;
                                });
                              },
                            ),
                            Divider(),
                            Container(
                              height: 60,
                            )
                          ]),
                    ),
                  
                  ),
                  
                  ));})))))
    );
  }
}