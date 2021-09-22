import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:SalesOnwheelss/Widgets/CustomLoader.dart';
import 'package:SalesOnwheelss/util/Globals.dart';
import 'package:SalesOnwheelss/util/Size_Config.dart';
import 'package:SalesOnwheelss/util/theme.dart';

class Reports extends StatefulWidget {
  Reports({Key key}) : super(key: key);

  @override
  _ReportsState createState() => _ReportsState();
}

class _ReportsState extends State<Reports> {
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
                title: Text('Reports'),
                flexibleSpace: AppColors.flexibleAppBar
              ),
              body: LayoutBuilder(builder:
                (BuildContext context, BoxConstraints viewportConstraints) {
              return 
                   Container(
                margin: EdgeInsets.only( top : 5 , left : 10, right : 10),
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
                          Card(
                            child: Padding(
                              padding:  EdgeInsets.all(5.0),
                              child: TextField(
                                decoration: InputDecoration(
                                  prefixIcon : Icon(Icons.search),
                                  hintText: 'Search',
                                  isDense: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  errorBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                ),
                              ),
                            ),
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            itemCount: 10,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context,index) {
                              return Padding(
                                padding:  EdgeInsets.only( bottom : 8.0),
                                child: GestureDetector(
                                    onTap: () => Navigator.of(context).pushNamed('reportdetails'),
                                    child: Container(
                                    width: double.infinity,
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Expanded(
                                              child: Text('Royal Enfiled garage'.toUpperCase(),style: AppStyles.blackTextStyle.copyWith(
                                              fontWeight: FontWeight.w600
                                            ),),
                                          ),
                                          Text('2W'.toUpperCase(),style: AppStyles.blackTextStyle.copyWith(
                                              fontWeight: FontWeight.w600
                                            ),),
                                            ],

                                          ),
                                          Text('Mec ID : 202190'.toUpperCase(),style: AppStyles.blackTextStyle.copyWith(
                                            fontSize: 16
                                          ),),
                                          Padding(
                                            padding: EdgeInsets.only(top: 15),
                                            child: Row(
                                              children: [
                                            Expanded(
                                                  child: Text('Jeedimetla,Hydrabad',
                                                  style: AppStyles.greyTextStyle.copyWith(
                                              fontSize: 16
                                          ),),
                                            ),
                                            // Container(
                                            //   decoration: BoxDecoration(
                                            //     borderRadius: BorderRadius.circular(6),
                                            //     gradient: LinearGradient(
                                            //     begin: Alignment.topLeft,
                                            //     end: Alignment(2.5, 0.0),
                                            //     colors: <Color>[
                                            //     Colors.green,
                                            //     Colors.white
                                            //     ])
                                            //   ),
                                            //   child: Padding(
                                            //     padding:  EdgeInsets.all(5.0),
                                            //     child: Text('Pre Credit',style: AppStyles.whiteTextStyle.copyWith(
                                            //       fontSize: 16,fontWeight: FontWeight.w600
                                            //     ),),
                                            //   ),
                                            // )

                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )),
                          ),
                                ),
                              );})
                        ]))));})))))
    );
  }
}