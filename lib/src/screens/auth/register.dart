import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:matimela/src/services/auth.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> with TickerProviderStateMixin {
  String _email, _username, _phoneNumber, _password = '';
  final _formKey = GlobalKey<FormState>();
  final _phonePattern = RegExp(r"^7[1-7]{1}[0-9]{6}$");
  final _alphanumeric = RegExp(r'^[a-zA-Z0-9]+$');
  final _emailPattern = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\"
      r".[a-zA-Z]+");
  final _auth = AuthService();
  bool loading = false;

  String error = '';

  @override
  Widget build(BuildContext context) {
    var spinkit = SpinKitCircle(
      color: Colors.white,
      size: 50.0,
      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
    );
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
                        child: Form(
                          key: _formKey,
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
//                              Text('Username',
//                                  style: TextStyle(
//                                      fontFamily: 'Poppins-Medium',
//                                      fontSize: ScreenUtil.getInstance().setSp(26),
//                                      color: Colors.white)),
//                              TextFormField(
//                                keyboardType: TextInputType.text,
//                                style: TextStyle(color: Colors.white),
//                                decoration: InputDecoration(
//                                    hintText: 'username',
//                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
//                                onChanged: (val) => setState(() => this._username = val),
//                                validator: (value) {
//                                  return value.isEmpty ? 'Enter a Username' : null;
//                                },
//                              ),
//                              SizedBox(
//                                height: ScreenUtil.getInstance().setHeight(30),
//                              ),
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
                                keyboardType: TextInputType.emailAddress,
                                decoration: InputDecoration(
                                    hintText: 'email',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
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
//                              Text('Contact',
//                                  style: TextStyle(
//                                      fontFamily: 'Poppins-Medium',
//                                      fontSize: ScreenUtil.getInstance().setSp(26),
//                                      color: Colors.white)),
//                              TextFormField(
//                                style: TextStyle(color: Colors.white),
//                                keyboardType: TextInputType.phone,
//                                decoration: InputDecoration(
//                                    hintText: '+267',
//                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
//                                onChanged: (val) => setState(() => this._phoneNumber = val),
//                                validator: (value) {
//                                  return value.isEmpty
//                                      ? 'Enter Phone Number'
//                                      : value.length != 8
//                                          ? 'Please enter 8 digit'
//                                          : _phonePattern.hasMatch(value)
//                                              ? null
//                                              : 'Enter a valid Phone '
//                                                  'number';
//                                },
//                              ),
                              Text('Password',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: ScreenUtil.getInstance().setSp(26),
                                      color: Colors.white)),
                              TextFormField(
                                keyboardType: TextInputType.visiblePassword,
                                style: TextStyle(color: Colors.white),
                                obscureText: true,
                                decoration: InputDecoration(
                                    hintText: 'password',
                                    hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                                onChanged: (val) => setState(() => this._password = val),
                                validator: (value) {
                                  return value.isEmpty
                                      ? 'Enter a Password'
                                      : value.length < 8
                                          ? 'Enter alpha-numeric password 8+ character long'
                                          : !_alphanumeric.hasMatch(value)
                                              ? 'Password should '
                                                  'contain aplha-numeric '
                                                  'characters '
                                              : null;
                                },
                              ),
                              Text('Confirm Password',
                                  style: TextStyle(
                                      fontFamily: 'Poppins-Medium',
                                      fontSize: ScreenUtil.getInstance().setSp(26),
                                      color: Colors.white)),
                              TextFormField(
                                  keyboardType: TextInputType.visiblePassword,
                                  style: TextStyle(color: Colors.white),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                      hintText: 'password',
                                      hintStyle: TextStyle(color: Colors.grey, fontSize: 12.0)),
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Enter alpha-numeric password 8+ character long';
                                    }
                                    return value == _password ? null : 'Password does not match!';
                                  }),
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
                                                onTap: () async {
                                                  if (_formKey.currentState.validate()) {
                                                    print(_email + _password);
                                                    setState(() {
                                                      loading = true;
                                                    });
                                                    dynamic result =
                                                        await _auth.registerWithEmailAndPassword(
                                                            _email, _password);

                                                    if (result == null) {
                                                      setState(() {
                                                        error = 'Please supply a valid email';
                                                        loading = false;
                                                      });
                                                    }
                                                    setState(() {
                                                      loading = false;
                                                    });
                                                    Navigator.pop(context);
                                                  }
                                                },
                                                child: Center(
                                                    child: loading
                                                        ? spinkit
                                                        : Text('SIGNIN',
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
                                            fontSize: 14)),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      )),
                )),
          ],
        ));
  }

  bool verifyPhoneNumber(String phone) {}
}
