import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ReportDetails extends StatefulWidget {
  ReportDetails({Key key}) : super(key: key);

  @override
  _ReportDetailsState createState() => _ReportDetailsState();
}

class _ReportDetailsState extends State<ReportDetails> {


  launchMap({String lat = "19.0522", String long = "72.9005"}) async{
  final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
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
                backgroundColor: Colors.white,
                elevation: 1,
                title: Text('JMJ MOTORS (401918)',style: TextStyle(
                  color: Colors.black
                ),),
                iconTheme: IconThemeData(
                  color: Colors.black
                ),
              ),
              body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return 
                   Container(
                
                width: double.infinity,   
                height: SizeConfig.screenHeight,
                child: SingleChildScrollView(
                  child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: viewportConstraints.maxHeight,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only( top : 15 , left : 15, right : 15),
                                                      child: Column(
                              //mainAxisAlignment: MainAxisAlignment.spaceAround,
                                 crossAxisAlignment: CrossAxisAlignment.start,
                                 mainAxisSize: MainAxisSize.max,
                              children: [
                                Row(
                                  children: [
                                    Text('Type                 ',style: AppStyles.blackTextStyle.copyWith(
                                      fontSize: 18,
                                      color: Colors.yellow[800]
                                    )),
                                    Text('4w',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,fontSize: 18
                                    ))
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top : 10),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Address           ',style: AppStyles.blackTextStyle.copyWith(
                                      fontSize: 18,
                                      color: Colors.yellow[800]
                                    )),
                                    Expanded(
                                         child: Row(
                                           children: [
                                             Expanded(
                                               child: Text('Chauhan Apartment, V N Purav Marg, Sion Trombay Road, Chembur Naka, Chembur, Mumbai - 400071, Maharashtra.',style: AppStyles.blackTextStyle.copyWith(
                                        fontWeight: FontWeight.w600,fontSize: 18
                                      ),textAlign: TextAlign.start,),
                                             ),
                                      GestureDetector(
                                        onTap: (){
                                          launchMap();
                                        },
                                        child: Image.asset('assets/images/map.png',width: 50,))
                                           ],
                                         ),
                                    ),
                                  ],
                                ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top : 10),
                                  child: Row(
                                  children: [
                                    Text('Phone              ',style: AppStyles.blackTextStyle.copyWith(
                                      fontSize: 18,
                                      color: Colors.yellow[800]
                                    )),
                                    
                                    Expanded(
                                         child: Row(
                                           children: [
                                             Expanded(
                                               child: Text('9218104080',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,fontSize: 18
                                    ))
                                             ),
                                      GestureDetector(
                                        onTap: (){
                                        launch('tel:9218104080');
                                        },
                                        child: Image.asset('assets/images/phone.png',width: 30,))
                                           ],
                                         ),
                                    ),
                                  ],
                                ),
                                  ),
                             /*     Padding(
                                    padding: EdgeInsets.only(top : 10),
                                    child: Row(
                                  children: [
                                    Text('Current\nPackage          ',style: AppStyles.blackTextStyle.copyWith(
                                      fontSize: 18,
                                      color: Colors.yellow[800]
                                    )),
                                    Text('Pre Credit',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,fontSize: 18
                                    ))
                                  ],
                                ),
                              ),*/
                              Padding(
                                    padding: EdgeInsets.only(top : 10),
                                    child: Row(
                                  children: [
                                    Text('Credits Left     ',style: AppStyles.blackTextStyle.copyWith(
                                      fontSize: 18,
                                      color: Colors.yellow[800]
                                    )),
                                    Text('7',style: AppStyles.blackTextStyle.copyWith(
                                      fontWeight: FontWeight.w600,fontSize: 18
                                    ))
                                  ],
                                ),
                              ),
                              Padding(
                                    padding: EdgeInsets.only(top : 10),
                                    child: Row(
                                  children: [
                                    Text('Availability      ',style: AppStyles.blackTextStyle.copyWith(
                                      fontSize: 18,
                                      color: Colors.yellow[800]
                                    )),
                                    Icon(Icons.cancel_outlined,color: Colors.red,size: 30,)
                                  ],
                                ),
                              ),
                              
                              ]),
                          ),
                        Padding(
                          padding: EdgeInsets.only(top : 10),
                          child: Card(
                            elevation: 1,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text('Last Recharge Report',style: AppStyles.blackTextStyle.copyWith(
                                        fontSize: 18,fontWeight: FontWeight.w600
                                      ),)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top : 8.0),
                                    child: Table(
                                      border: TableBorder.all(width : 1.0,color: Colors.black),
                                      children: [
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Row(
                                                children: [
                                                  Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                            children: [
                              Text('Model                  ',style: AppStyles.blackTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.yellow[800]
                              )),
                              Text('7',style: AppStyles.blackTextStyle.copyWith(
                                fontWeight: FontWeight.w600,fontSize: 18
                              ))
                            ],
                          ),
                        ),
                                                ],
                                              ))
                                          ]
                                        ),
                      TableRow(
                                          children: [
                                            TableCell(
                                              child: Row(
                                                children: [
                                                  Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Last Recharge\nDate',style: AppStyles.blackTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.yellow[800]
                              )),
                              Text('   05-Aug-2019',style: AppStyles.blackTextStyle.copyWith(
                                fontWeight: FontWeight.w600,fontSize: 18
                              ))
                            ],
                          ),
                        ),
                                                ],
                                              ))
                                          ]
                                        ),
                          TableRow(
                                          children: [
                                            TableCell(
                                              child: Row(
                                                children: [
                                                  Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                            children: [
                              Text('Price                   ',style: AppStyles.blackTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.yellow[800]
                              )),
                              Text('₹5000',style: AppStyles.blackTextStyle.copyWith(
                                fontWeight: FontWeight.w600,fontSize: 18
                              ))
                            ],
                          ),
                        ),
                                                ],
                                              ))
                                          ]
                                        ),
                          TableRow(
                                          children: [
                                            TableCell(
                                              child: Row(
                                                children: [
                                                  Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                            children: [
                              Text('Credits Types    ',style: AppStyles.blackTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.yellow[800]
                              )),
                              Text('50',style: AppStyles.blackTextStyle.copyWith(
                                fontWeight: FontWeight.w600,fontSize: 18
                              ))
                            ],
                          ),
                        ),
                                                ],
                                              ))
                                          ]
                                        ),
                                        TableRow(
                                          children: [
                                            TableCell(
                                              child: Row(
                                                children: [
                                                  Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                            children: [
                              Text('Aggregate\nRating                  ',style: AppStyles.blackTextStyle.copyWith(
                                fontSize: 18,
                                color: Colors.yellow[800]
                              )),
                              Text('5',style: AppStyles.blackTextStyle.copyWith(
                                fontWeight: FontWeight.w600,fontSize: 18
                              )),
                              Icon(Icons.star_border,color: Colors.black,)
                            ],
                          ),
                        ),
                                                ],
                                              ))
                                          ]
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              ),
                             
                          ),
                          ),
                          
         /* Center(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              Container(
                margin: EdgeInsets.all(10),
                child: Table(
                  border: TableBorder.all(),
                  children: [
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Sent', textAlign: TextAlign.center, 
                        style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Accepted', textAlign: TextAlign.center, 
                        style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Converted', textAlign: TextAlign.center, 
                        style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Denied\nDuty', textAlign: TextAlign.center, 
                        style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('Rejected/\nSwapped', textAlign: TextAlign.center, 
                        style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                    ]),
                    TableRow(children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('53', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('11', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('4', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('2', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Text('3', textAlign: TextAlign.center),
                      ),
                    ]),
                  ],
                ),
              ),
            ])),*/
            Padding(
              padding: EdgeInsets.only(top : 10,left: 10,right: 10,bottom: 10),
              child: Row(
                children: [
                  Text('EBM Credits Deducted',style: AppStyles.blackTextStyle,),
                  Padding(
                    padding: EdgeInsets.only(left : 10),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.red)
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Text('0'),
                        ),
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left : 15, right : 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top : 10),
                    child: Text('Conerted Leads(16)',style: AppStyles.blackTextStyle.copyWith(
                      fontWeight: FontWeight.w600
                    ),),
                    ),
                  Padding(
                    padding: EdgeInsets.only(top : 10),
                    child: ListView.builder(
                      itemCount: 5,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,index){
                        return Padding(
                          padding: const EdgeInsets.only( bottom : 8.0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text('Yamaha FZ S',style: AppStyles.blackTextStyle.copyWith(
                                        fontWeight: FontWeight.w600
                                      ),),
                                      Text('07-Feb-2021',style: AppStyles.greyTextStyle.copyWith(
                                        fontSize: 15
                                      ),)
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top : 10),
                                    child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment(2.5, 0.0), 
                colors: <Color>[
              Color(0xFF816E52),
              Colors.white
            ]) 
                                        ),
                                        child: Text('General Service 999',style: AppStyles.whiteTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                        ),),
                                      ),
                                      Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment(2.5, 0.0), 
                colors: <Color>[
              Colors.green,
              Colors.white
            ]) 
                                        ),
                                        child: Text('Completed',style: AppStyles.whiteTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                        ),),
                                      ),
                                    ],
                                  ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(top : 10),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.end,
                                        children: [
                                          Container(
                                        padding: EdgeInsets.all(6),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          gradient: LinearGradient(
              begin: Alignment.topLeft,
                end: Alignment(2.5, 0.0), 
                colors: <Color>[
              Color(0xFF816E52),
              Colors.white
            ]) 
                                        ),
                                        child: Text('₹1149',style: AppStyles.whiteTextStyle.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16
                                        ),),
                                      ),
                                        ],
                                      ),
                                      )
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                  )
                ],
              ),
            ),
                        ],
                      ))));})))))
    );
  }
}