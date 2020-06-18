import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matimela/src/models/case.dart';
import 'package:matimela/src/screens/user/regular/maps_location_tracker_page.dart';
import 'package:matimela/src/services/auth.dart';
import 'package:matimela/src/services/report.dart';
import 'package:matimela/src/utils/constants.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class MyNotifications extends StatefulWidget {
  @override
  _NotificationState createState() => _NotificationState();
}

class _NotificationState extends State<MyNotifications> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool searching = true;
  String searchText;
  File file;
  ReportService _reportService = ReportService();
  final Key _mapKey = UniqueKey();
  AuthService _authService = new AuthService();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(
            "Search My Cow",
            style: TextStyle(
              fontFamily: 'Quicksand',
            ),
          ),
          backgroundColor: Colors.grey[700],
        ),
        body: Stack(
          fit: StackFit.loose,
          children: <Widget>[
            searchBarComponent(),
            Container(margin: EdgeInsets.only(top: 80), child: getPosts(context)),
          ],
        ));
  }

  Widget getPosts(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: _reportService.getMyMatimelaCases(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<AnimalCase> cases = new List<AnimalCase>();
        if (!snapshot.hasData) return const Text('Connecting...');
        List<DocumentSnapshot> docs = snapshot.data.documents;
        docs.forEach((doc) {
          cases.add(AnimalCase("", doc.data['date'], doc.data['reporter'], doc.data['brand'],
              doc.data['color'], doc.data['tag'], doc.data['photo']));
        });
        return animalListComponent(cases);
      },
    );
  }

  Widget searchBarComponent() {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      height: 60,
      decoration: BoxDecoration(
          color: Colors.grey[200], borderRadius: BorderRadius.all(Radius.circular(15))),
      padding: EdgeInsets.fromLTRB(20, 20, 10, 10),
      child: TextField(
        cursorColor: DARK_ORANGE,
        onChanged: (val) {
          setState(() {
            searchText = val;
          });
        },
        decoration: InputDecoration(
          hintText: "Search",
          hintStyle: TextStyle(
            fontFamily: 'Quicksand',
          ),
          border: InputBorder.none,
          suffixIcon: Icon(
            Icons.search,
            color: DARK_ORANGE,
          ),
        ),
      ),
    );
  }

  List<AnimalCase> searchItem(List<AnimalCase> list) {
    if (searchItem == "" || searchText == null) return list;

    final filteredList = list.where(
      (animal) => animal.brand.toLowerCase().contains(searchText.toLowerCase()),
    );
    return filteredList.toList();
  }

  Widget animalListComponent(list) {
    final filteredList = searchItem(list);
    return ListView.separated(
      separatorBuilder: (ctx, i) => Divider(height: 20),
      padding: EdgeInsets.all(20),
      physics: BouncingScrollPhysics(),
      itemCount: filteredList.length,
      itemBuilder: (context, index) => animalItemComponent(filteredList[index], index),
    );
  }

  Widget animalItemComponent(AnimalCase animal, int index) {
    return Card(
        child: GestureDetector(
      child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: 130,
                height: 100,
                child: Image(
                  image: NetworkImage(animal.picture ??
                      'https://p7.hiclipart.com/preview/1001/363/656/limousin-cattle-livestock-computer-icons-beef-clip-art-others.jpg'),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Text(
                      "Brand: ${animal.brand}",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand',
                          fontSize: 14,
                          decorationStyle: TextDecorationStyle.solid),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Color: ${animal.color}" ?? "",
                      style: TextStyle(
                        color: Color(0xff8C68EC),
                        fontFamily: 'Quicksand',
                        fontSize: 13,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Tag: ${animal.tag ?? 'None'}",
                      style: TextStyle(
                        color: Color(0xff8C68EC),
                        fontFamily: 'Quicksand',
                        fontSize: 12,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      "Last Seen: ${animal.lastSeen ?? 'None'} ",
                      style: TextStyle(
                        color: Color(0xff8C68EC),
                        fontFamily: 'Quicksand',
                        fontSize: 12,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                    ),
                  ],
                ),
              ),
//              Expanded(
//                child: ExpansionTile(
//                  initiallyExpanded: false,
//                  children: <Widget>[
//                    Container(
//                      height: 30,
//                      child: FlatButton(
//                          onPressed: () => null,
//                          child: Text(
//                            "Owner",
//                            style: TextStyle(color: Colors.white),
//                          )),
//                      decoration: BoxDecoration(
//                          borderRadius: BorderRadius.all(Radius.circular(10)), color: Colors.blue),
//                    )
//                  ],
//                ),
//              )
            ],
          )),
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => new MapsLocationTrackerPage(tag: animal.tag, key: _mapKey))),
    ));
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
}

class Post {
  final String title;
  final String body;

  Post(this.title, this.body);
}
