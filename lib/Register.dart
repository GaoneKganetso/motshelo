import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          primary: true,
          backgroundColor: Colors.blue.withOpacity(0.8),
          leading:
              IconButton(icon: Icon(Icons.arrow_back_ios), onPressed: () => Navigator.pop(context)),
          title: Text("Matimela Registration"),
          actions: <Widget>[IconButton(icon: Icon(Icons.exit_to_app), onPressed: null)],
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
                width: double.infinity,
                margin: EdgeInsets.all(0),
                decoration: BoxDecoration(
                    image: DecorationImage(
                  image: AssetImage("assets/image/lost.png"),
                  repeat: ImageRepeat.noRepeat,
                  fit: BoxFit.cover,
                )),
                child: SingleChildScrollView(
                  child: Container(
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        color: Colors.black.withOpacity(0.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Text('Registration Form',
                                  style: TextStyle(
                                      fontSize: ScreenUtil.getInstance().setSp(45),
                                      fontFamily: 'Poppins-Bold',
                                      letterSpacing: .6,
                                      color: Colors.white.withOpacity(0.7))),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text('Username',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: ScreenUtil.getInstance().setSp(26),
                                    color: Colors.white)),
                            TextField(
                              decoration: InputDecoration(
                                  hintText: 'username',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text('Email',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: ScreenUtil.getInstance().setSp(26),
                                    color: Colors.white)),
                            TextField(
                              decoration: InputDecoration(
                                  hintText: 'email',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(30),
                            ),
                            Text('Phone Number',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: ScreenUtil.getInstance().setSp(26),
                                    color: Colors.white)),
                            TextField(
                              decoration: InputDecoration(
                                  hintText: '+267',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                            ),
                            Text('Password',
                                style: TextStyle(
                                    fontFamily: 'Poppins-Medium',
                                    fontSize: ScreenUtil.getInstance().setSp(26),
                                    color: Colors.white)),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                  hintText: 'password',
                                  hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                            ),
                            SizedBox(
                              height: ScreenUtil.getInstance().setHeight(35),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                Text('Forgot Password?',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: ScreenUtil.getInstance().setSp(28),
                                    ))
                              ],
                            ),
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
                                  'Already Member? ',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: 18,
                                      color: Colors.black),
                                ),
                                InkWell(
                                  onTap: () => Navigator.pop(context),
                                  child: Text('Login here',
                                      style: TextStyle(
                                          fontFamily: 'Poppins-Bold',
                                          color: Colors.white,
                                          fontSize: 18)),
                                )
                              ],
                            )
                          ],
                        ),
                      )),
                )),
          ],
        ));
  }
}
