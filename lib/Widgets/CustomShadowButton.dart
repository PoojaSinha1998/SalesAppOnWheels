import 'package:flutter/material.dart';
import 'package:SalesOnwheelss/util/theme.dart';


class CustomShadowButtom extends StatelessWidget {
  String text;
  Color bgcolor;
  final onTap;
  double fontSize;
   CustomShadowButtom({
     this.text = '',
     this.bgcolor,
     this.onTap,
     this.fontSize = 20
   });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
          child: Container(
            height: 45,
            margin: EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: bgcolor == null ? AppColors.primaryColor : bgcolor,
              borderRadius: BorderRadius.circular(5),
              boxShadow: [
              BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 2,
              blurRadius: 2,
              ),
             ],
            ),
            width: double.infinity,
        child: Center(child: Text(text,style: AppStyles.whiteTextStyle.copyWith(
          fontWeight : FontWeight.w600,fontSize: fontSize),)),
      ),
    );
  }
}