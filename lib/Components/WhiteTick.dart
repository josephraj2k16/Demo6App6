import 'package:flutter/material.dart';

class Tick extends StatelessWidget {
  final DecorationImage image;
  Tick({this.image});
  @override
  Widget build(BuildContext context) {
    return (new Container(
      width: 220.0,
      height: 130.0,
      alignment: Alignment.center,
      decoration: new BoxDecoration(

        //fit: BoxFit.fill,
        image:image, //new DecorationImage(image: image,fit: BoxFit.fill),

      ),
    ));
  }
}
