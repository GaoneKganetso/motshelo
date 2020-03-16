import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class SearchAnimal extends StatefulWidget {
  @override
  _SearchAnimalState createState() => _SearchAnimalState();
}

class _SearchAnimalState extends State<SearchAnimal> {
  final SearchBarController<Post> _searchBarController = SearchBarController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isReplay = false;
  String _brand, _color, _picture;
  File file;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Search Matimela"),
        backgroundColor: Colors.grey,
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => _showModalBottomSheet())
        ],
      ),
      body: SafeArea(
        child: SearchBar<Post>(
          searchBarPadding: EdgeInsets.symmetric(horizontal: 10),
          headerPadding: EdgeInsets.symmetric(horizontal: 10),
          listPadding: EdgeInsets.symmetric(horizontal: 10),
          onSearch: _getALlPosts,
          searchBarController: _searchBarController,
          placeHolder: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "List of Matimela Cases",
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
            ),
          ),
          cancellationText: Text("Cancel"),
          emptyWidget: Text("empty"),
          indexedScaledTileBuilder: (int index) => ScaledTile.count(1, index.isEven ? 2 : 1),
          header: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RaisedButton(
                child: Text("sort"),
                onPressed: () {
                  _searchBarController.sortList((Post a, Post b) {
                    return a.body.compareTo(b.body);
                  });
                },
              ),
              RaisedButton(
                child: Text("Desort"),
                onPressed: () {
                  _searchBarController.removeSort();
                },
              ),
              RaisedButton(
                child: Text("Replay"),
                onPressed: () {
                  isReplay = !isReplay;
                  _searchBarController.replayLastSearch();
                },
              ),
            ],
          ),
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          crossAxisCount: 2,
          onItemFound: (Post post, int index) {
            return Container(
              color: Colors.lightBlue,
              child: ListTile(
                title: Text(post.title),
                isThreeLine: true,
                subtitle: Text(post.body),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  Future<List<Post>> _getALlPosts(String text) async {
    await Future.delayed(Duration(seconds: text.length == 4 ? 10 : 1));
    if (isReplay) return [Post("Replaying !", "Replaying body")];
    if (text.length == 5) throw Error();
    if (text.length == 6) return [];
    List<Post> posts = [];

    var random = new Random();
    for (int i = 0; i < 10; i++) {
      posts.add(Post("$text $i", "body random number : ${random.nextInt(100)}"));
    }
    return posts;
  }

  void showModalDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return RichAlertDialog(
            alertTitle: richTitle("Success"),
            alertSubtitle: richSubtitle("This is a Sucess alert"),
            alertType: RichAlertType.SUCCESS,
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              FlatButton(
                child: Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          );
        });
  }

  void _showModalBottomSheet() {
    showModalBottomSheet(
        context: context,
        isDismissible: true,
        builder: (context) {
          return Container(
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
              Text(
                "Fill the form below for Matimela",
                style: TextStyle(color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              TextFormField(
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
                    return "Email cannot be empty";
                  } else {
                    return null;
                  }
                },
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
                keyboardType: TextInputType.emailAddress,
                style: new TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    onPressed: () => _choose(),
                    child: Text('Choose Image'),
                  ),
                  SizedBox(width: 10.0),
                  RaisedButton(
                    onPressed: _upload,
                    child: Text('Upload Image'),
                  )
                ],
              ),
//              SizedBox(
//                height: ScreenUtil.getInstance().setHeight(20),
//              ),
              //file == null ? Text('No Image Selected') : Image.file(file),
              SizedBox(
                height: ScreenUtil.getInstance().setHeight(20),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.lightBlue,
                ),
                child: FlatButton(
                  onPressed: null,
                  child: Text(
                    "Submit report",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              )
            ]),
          );
        });
  }

  void _choose() async {
    file = await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  void _upload() {
    if (file == null) return;
//    String base64Image = base64Encode(file.readAsBytesSync());
//    String fileName = file.path.split("/").last;
  }
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}
