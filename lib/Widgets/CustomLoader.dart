import 'package:flutter/material.dart';


class Loader extends StatelessWidget {
  const Loader({Key key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset('assets/images/mainlogo.jpg',height: 30,width: 30,),
        CircularProgressIndicator(strokeWidth: 2,)
      ],
    );
  }
}