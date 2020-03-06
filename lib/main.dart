import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:matimela/Register.dart';

import 'FormCard.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: 2.0, color: Colors.black),
        ),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
      ..init(context);

    return new Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/lost.png"),
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                ),
              ),
              child: SingleChildScrollView(
                  child: Padding(
                      padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 60.0),
                      child: Column(
                        children: <Widget>[
                          Column(
                            children: <Widget>[
                              Image.asset(
                                'assets/image/coat.png',
                                width: ScreenUtil.getInstance().setWidth(210),
                                height: ScreenUtil.getInstance().setHeight(210),
                              ),
                              Text('Matimela Application',
                                  style: TextStyle(
                                    fontFamily: 'Poppins-Bold',
                                    fontSize: ScreenUtil.getInstance().setSp(46),
                                    letterSpacing: .6,
                                    color: Colors.blue.withOpacity(0.9),
                                    fontWeight: FontWeight.bold,
                                  ))
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(10),
                          ),
                          FormCard(),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(35),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              InkWell(
                                child: Container(
                                    width: MediaQuery.of(context).size.width - 100,
                                    height: ScreenUtil.getInstance().setHeight(100),
                                    margin: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [Color(0xFF17ead9), Color(0xFF6078ea)]),
                                      borderRadius: BorderRadius.circular(6.0),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Color(0xFF6078ea).withOpacity(.3),
                                          offset: Offset(0.0, 8.0),
                                          blurRadius: 8.0,
                                        )
                                      ],
                                    ),
                                    child: Material(
                                        color: Colors.transparent,
                                        child: InkWell(
                                            onTap: () {},
                                            child: Center(
                                                child: Text('SIGNIN',
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'Poppins-Bold',
                                                        fontSize: 18.0,
                                                        letterSpacing: 1.0)))))),
                              )
                            ],
                          ),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(30),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'New User? ',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: 18,
                                    color: Colors.black),
                              ),
                              InkWell(
                                onTap: () => Navigator.push(context,
                                    new MaterialPageRoute(builder: (context) => Register())),
                                child: Text('SignUp',
                                    style: TextStyle(
                                        fontFamily: 'Poppins-Bold',
                                        color: Color(0xFF5d74e3),
                                        fontSize: 18)),
                              )
                            ],
                          )
                        ],
                      ))),
            ),
          ],
        ));
  }
}
