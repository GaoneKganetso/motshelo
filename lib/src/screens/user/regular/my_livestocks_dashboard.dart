import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matimela/src/models/case.dart';
import 'package:matimela/src/models/user.dart';
import 'package:matimela/src/screens/user/regular/register_livestock_dashboard.dart';
import 'package:matimela/src/services/my_livestock.dart';
import 'package:matimela/src/utils/constants.dart';
import 'package:provider/provider.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class MyLivestock extends StatefulWidget {
  @override
  _MyLivestockState createState() => _MyLivestockState();
}

class _MyLivestockState extends State<MyLivestock> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool searching = true;
  String searchText;
  File file;
  LivestockManager _livestockManager = LivestockManager();

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
            "My Livestock",
            style: TextStyle(
              fontFamily: 'Quicksand',
            ),
          ),
          backgroundColor: Colors.grey[700],
          actions: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.add_circle_outline,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () => Navigator.push(
                    context, new MaterialPageRoute(builder: (context) => RegisterLivestock())))
          ],
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
    var user = Provider.of<User>(context, listen: false);
    print(user.displayName);
    return new StreamBuilder<QuerySnapshot>(
      stream: _livestockManager.getMyLivestock(user.id),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        List<AnimalCase> cases = new List<AnimalCase>();
        if (!snapshot.hasData) return const Text('Connecting...');

        List<DocumentSnapshot> docs = snapshot.data.documents;
        docs.forEach((doc) {
          cases.add(AnimalCase("", doc.data['date'], doc.data['owner'], doc.data['brand'],doc.data['color'], doc.data['photo'], doc.data['tag']));
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
    if ("" == searchItem || searchText == null) return list;

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
                      "Tag: ${animal.tag}",
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
                      "Location: ${animal.tag ?? 'None'}",
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
                      "Owner: ${animal.lastSeen ?? 'None'} ",
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
    );
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
