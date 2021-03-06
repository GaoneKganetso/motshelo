import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:matimela/src/services/report.dart';
import 'package:toast/toast.dart';

class ReportMatimela extends StatefulWidget {
  @override
  _ReportMatimelaState createState() => _ReportMatimelaState();
}

class _ReportMatimelaState extends State<ReportMatimela>
    with TickerProviderStateMixin {
  File file = null;
  bool isReplay = false;
  bool loading = false;

  final _formKey = GlobalKey<FormState>();
  ReportService _reportService = ReportService();
  String _brand, _color, _location, _description, _tagNumber;

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
      controller: AnimationController(
          vsync: this, duration: const Duration(milliseconds: 1200)),
    );

    return Scaffold(
            appBar: AppBar(
              title: Text("Report Matimela"),
              backgroundColor: Colors.grey[700],
              actions: <Widget>[],
            ),
            body: SafeArea(
                child: Container(
              color: Colors.white,
              height: double.infinity,
              padding: EdgeInsets.all(10),
              child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Fill the form below for Matimela",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(30),
                      ),
                      Form(
                          key: _formKey,
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration: new InputDecoration(
                                  prefixIcon: Icon(Icons.device_hub),
                                  labelText: "Enter Brand",
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
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
                                onChanged: (val) =>
                                    setState(() => this._brand = val),
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
                                  labelText: "Enter Color",
                                  prefixIcon: Icon(Icons.color_lens),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
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
                                onChanged: (val) =>
                                    setState(() => this._color = val),
                                keyboardType: TextInputType.emailAddress,
                                style: new TextStyle(
                                  fontFamily: "Poppins",
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              SizedBox(
                                height: ScreenUtil.getInstance().setHeight(30),
                              ),
                              TextFormField(
                                decoration: new InputDecoration(
                                  labelText: "Description (optional)",
                                  prefixIcon: Icon(Icons.home),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  ),
                                  //fillColor: Colors.green
                                ),
                                onChanged: (val) =>
                                    setState(() => this._description = val),
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
                                  labelText: "Tag Number ",
                                  prefixIcon: Icon(Icons.bookmark_border),
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
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
                                onChanged: (val) =>
                                    setState(() => this._tagNumber = val),
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
                                    print("brand $_brand && $_color");
                                      _reportService
                                          .submitReport(
                                              _brand,
                                              _color,
                                              file,
                                              _description,
                                              _tagNumber,
                                              context)
                                          .whenComplete(() {
                                        setState(() {
                                          loading = false;
                                          _formKey.currentState.reset();
                                        });
                                        Toast.show(
                                            "Successfully added matimela case.",
                                            context,
                                            duration: Toast.LENGTH_SHORT,
                                            gravity: Toast.BOTTOM);
                                      });
                                  }
                                },
                                child: Text(
                                  "Submit report",
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
