import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hagglex/util/strings.dart';
import 'package:hagglex/widgets/spacing.dart';

class Complete extends StatefulWidget {
  @override
  _CompleteState createState() => _CompleteState();
}

class _CompleteState extends State<Complete> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          body: SingleChildScrollView(
              child: Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.8, -0.6),
                colors: [
                  Color.fromRGBO(63, 42, 117, 1),
                  Color.fromRGBO(46, 25, 99, 1)
                ],
                radius: 0.7,
              ),
            ),
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                new Image.asset(
                  imagesDir + '/tickk.png',
                  repeat: ImageRepeat.noRepeat,
                ),
                addVerticalSpace(20),
                Text(
                  'Setup Complete',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
                addVerticalSpace(15),
                Text(
                  'Thank you for setting up your HaggleX account',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.normal),
                ),
                addVerticalSpace(230),
                Material(
                  color: Color.fromRGBO(62, 6, 6, 0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).pushNamed('/dashboard');
                    },
                    child: Container(
                      width: size.width,
                      padding: EdgeInsets.symmetric(vertical: 15),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Color.fromRGBO(255, 193, 117, 1)),
                      child: Text(
                        'START EXPLORING',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Color.fromRGBO(62, 6, 6, 1),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ));
  }
}
