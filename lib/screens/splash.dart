import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hagglex/util/strings.dart';
import 'package:hagglex/widgets/spacing.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    animationController = new AnimationController(
        duration: Duration(seconds: 3), vsync: this)
      ..forward()
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          Navigator.pushReplacementNamed(context, '/login'); //routeDefaultLogin
        }
      });
    super.initState();
  }

  AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: AnimatedBuilder(
            animation: animationController,
            builder: (context, _) {
              return Container(
                width: size.width,
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Image.asset(
                        imagesDir + '/logo.png',
                        repeat: ImageRepeat.noRepeat,
                      ),
                      addVerticalSpace(20),
                      Text(
                        'HaggleX',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
