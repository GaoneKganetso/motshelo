import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matimela/src/services/auth.dart';

import 'register.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> with TickerProviderStateMixin {
  bool _isSelected, loading = false;
  final AuthService _authService = AuthService();
  final _formKey = GlobalKey<FormState>();
  String _email, _password = "";
  final _emailPattern = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\"
      r".[a-zA-Z]+");
  String error = '';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil(width: 750, height: 1334, allowFontScaling: true)
      ..init(context);
    var spinkit = SpinKitCircle(
      color: Colors.white,
      size: 50.0,
      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
    );
    return Scaffold(
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
                          Container(
                              width: double.infinity,
                              height: ScreenUtil.getInstance().setHeight(575),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.black.withOpacity(0.45),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 15.0),
                                    blurRadius: 15.0,
                                  ),
                                  BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, -10.0),
                                    blurRadius: 10.0,
                                  ),
                                ],
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(left: 16.0, top: 16.0, right: 16.0),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Align(
                                        alignment: Alignment.center,
                                        child: Text('Login Credentials',
                                            style: TextStyle(
                                                fontSize: ScreenUtil.getInstance().setSp(45),
                                                fontFamily: 'Poppins-Bold',
                                                letterSpacing: .6,
                                                color: Colors.white.withOpacity(0.7))),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance().setHeight(30),
                                      ),
                                      Text('Email',
                                          style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                              fontSize: ScreenUtil.getInstance().setSp(26),
                                              color: Colors.white)),
                                      TextFormField(
                                        style: TextStyle(color: Colors.white),
                                        decoration: InputDecoration(
                                            hintText: 'email',
                                            hintStyle:
                                                TextStyle(color: Colors.grey, fontSize: 12.0)),
                                        onChanged: (val) => setState(() => this._email = val),
                                        validator: (value) {
                                          return value.isEmpty
                                              ? 'Enter an Email'
                                              : !_emailPattern.hasMatch(value)
                                                  ? 'Enter a valid email'
                                                  : null;
                                        },
                                      ),
                                      SizedBox(
                                        height: ScreenUtil.getInstance().setHeight(30),
                                      ),
                                      Text('Password',
                                          style: TextStyle(
                                              fontFamily: 'Poppins-Medium',
                                              fontSize: ScreenUtil.getInstance().setSp(26),
                                              color: Colors.white)),
                                      TextFormField(
                                          style: TextStyle(color: Colors.white),
                                          obscureText: true,
                                          decoration: InputDecoration(
                                              hintText: 'password',
                                              hintStyle:
                                                  TextStyle(color: Colors.grey, fontSize: 12.0)),
                                          onChanged: (val) => setState(() => this._password = val),
                                          validator: (value) {
                                            if (value.isEmpty) {
                                              return 'Enter alpha-numeric password 8+ character long';
                                            }
                                            return value == _password
                                                ? null
                                                : 'Password does not match!';
                                          }),
                                      SizedBox(
                                        height: ScreenUtil.getInstance().setHeight(35),
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          InkWell(
                                            child: Container(
                                                width: MediaQuery.of(context).size.width / 3,
                                                height: ScreenUtil.getInstance().setHeight(50),
                                                margin: EdgeInsets.all(7),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(6.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(.4),
                                                      offset: Offset(0.0, 8.0),
                                                      blurRadius: 8.0,
                                                    )
                                                  ],
                                                ),
                                                child: FlatButton(
                                                  color: Colors.transparent,
                                                  child: Text('Guest',
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 16.0,
                                                          letterSpacing: 1.0)),
                                                  onPressed: () async {
                                                    dynamic result =
                                                        await _authService.signInAnon();
                                                    result == null
                                                        ? print("error signing in..")
                                                        : print(result);
                                                  },
                                                )),
                                          ),
                                          Text('Forgot Password?',
                                              style: TextStyle(
                                                color: Colors.blue,
                                                fontFamily: 'Poppins-Medium',
                                                fontSize: ScreenUtil.getInstance().setSp(28),
                                              ))
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )),
                          SizedBox(
                            height: ScreenUtil.getInstance().setHeight(45),
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
                                            onTap: () async {
                                              if (_formKey.currentState.validate()) {
                                                setState(() {
                                                  loading = true;
                                                });
                                                dynamic result = await _authService
                                                    .signInWithEmailAndPassword(_email, _password);

                                                if (result == null) {
                                                  setState(() {
                                                    loading = false;
                                                    error = 'Email or Password is incorrect!'
                                                        'Please check your credentials again';
                                                  });
                                                }
                                              }
                                            },
                                            child: loading
                                                ? spinkit
                                                : Center(
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
                          ),
                        ],
                      ))),
            ),
          ],
        ));
  }
}
