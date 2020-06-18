import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matimela/src/models/user.dart';
import 'package:matimela/src/services/auth.dart';
import 'package:matimela/src/services/my_livestock.dart';
import 'package:toast/toast.dart';

class RegisterLivestock extends StatefulWidget {
  @override
  _RegisterLivestockState createState() => _RegisterLivestockState();
}

class _RegisterLivestockState extends State<RegisterLivestock> with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  LivestockManager _livestockManager = LivestockManager();
  bool loading = false;
  bool isReplay = false;
  String _brand, _color, _location, _tagNumber = "";
  File file;
  AuthService _authService = new AuthService();
  Firestore _firestore = Firestore();
  User user;

  Future _choose() async {
    await ImagePicker.pickImage(source: ImageSource.gallery).then((temp) {
      setState(() {
        file = temp;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var spinkit = SpinKitCircle(
      color: Colors.white,
      size: 50.0,
      controller: AnimationController(vsync: this, duration: const Duration(milliseconds: 1200)),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text("Register Livestock"),
        backgroundColor: Colors.grey[700],
        actions: <Widget>[],
      ),
      body: SafeArea(
          child: Container(
        color: Colors.white,
        height: double.infinity,
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
            Text(
              "Fill the form below to add livestock",
              style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    FutureBuilder(
                        future: _authService.currentUser(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CupertinoActivityIndicator());
                          }

                          User user = snapshot.data;
                          return StreamBuilder(
                              stream:
                                  _firestore.collection('profile').document(user.id).snapshots(),
                              builder: (context, snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(child: CupertinoActivityIndicator());
                                }
                                Profile profile = Profile.fromJson(snapshot.data);
                                return TextFormField(
                                  initialValue: profile.brandName,
                                  decoration: new InputDecoration(
                                    prefixIcon: Icon(Icons.device_hub),
                                    labelText: "Enter Brand",
                                    fillColor: Colors.white,
                                    border: new OutlineInputBorder(
                                      borderRadius: new BorderRadius.circular(25.0),
                                      borderSide: new BorderSide(),
                                    ),
                                    //fillColor: Colors.green
                                  ),
                                  validator: (val) {
                                    if (val.length == 0) {
                                      return "Brand cannot be empty";
                                    } else {
                                      return null;
                                    }
                                  },
                                  onChanged: (val) => setState(() => this._brand = val),
                                  keyboardType: TextInputType.emailAddress,
                                  style: new TextStyle(
                                    fontFamily: "Poppins",
                                  ),
                                );
                              });
                        }),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Enter Color",
                        prefixIcon: Icon(Icons.color_lens),
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Color cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) => setState(() => this._color = val),
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Enter Location",
                        prefixIcon: Icon(Icons.location_on),
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Location cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) => setState(() => this._location = val),
                      keyboardType: TextInputType.emailAddress,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil.getInstance().setHeight(30),
                    ),
                    TextFormField(
                      decoration: new InputDecoration(
                        labelText: "Tag Number",
                        prefixIcon: Icon(Icons.bookmark_border),
                        fillColor: Colors.white,
                        border: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(25.0),
                          borderSide: new BorderSide(),
                        ),
                        //fillColor: Colors.green
                      ),
                      validator: (val) {
                        if (val.length == 0) {
                          return "Tag number cannot be empty";
                        } else {
                          return null;
                        }
                      },
                      onChanged: (val) => setState(() => this._tagNumber = val),
                      keyboardType: TextInputType.number,
                      style: new TextStyle(
                        fontFamily: "Poppins",
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(30),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                RaisedButton(
                  onPressed: _choose,
                  child: Text('Choose Image'),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            file == null
                ? Text('No Image Selected')
                : Image.file(
                    file,
                    height: 150,
                    width: 250,
                  ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(20),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20)),
                color: Colors.lightBlue,
              ),
              child: loading
                  ? spinkit
                  : FlatButton(
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          setState(() {
                            loading = true;
                          });

                          if (file != null)
                            _livestockManager
                                .registerLivestock(_brand, _color, file, _location, _tagNumber)
                                .whenComplete(() {
                              setState(() {
                                loading = false;
                                _formKey.currentState.reset();
                              });
                              Toast.show("Successfully registered livestock.", context,
                                  duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
                            });
                        }
                      },
                      child: Text(
                        "Register",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
            )
          ]),
        ),
      )),
    );
  }
}
