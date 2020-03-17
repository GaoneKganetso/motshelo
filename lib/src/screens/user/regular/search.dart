import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/scaled_tile.dart';
import 'package:flutter/material.dart';
import 'package:matimela/src/models/case.dart';
import 'package:matimela/src/screens/user/regular/report_matimela.dart';
import 'package:matimela/src/services/report.dart';
import 'package:sweet_alert_dialogs/sweet_alert_dialogs.dart';

class SearchAnimal extends StatefulWidget {
  @override
  _SearchAnimalState createState() => _SearchAnimalState();
}

class _SearchAnimalState extends State<SearchAnimal> {
  final SearchBarController<AnimalCase> _searchBarController = SearchBarController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isReplay = false;
  bool searching = true;
  File file;
  ReportService _reportService = ReportService();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Search Matimela"),
        backgroundColor: Colors.grey[700],
        actions: <Widget>[
          IconButton(
              icon: Icon(
                Icons.add_circle_outline,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.push(
                  context, new MaterialPageRoute(builder: (context) => ReportMatimela())))
        ],
      ),
      body: SafeArea(
          child: searching
              ? StreamBuilder(
                  stream: _reportService.getAllCases(),
                  builder: (context, snapshot) {
                    final int casesLength = snapshot.data.documents.length;
                    List<AnimalCase> cases = new List<AnimalCase>();
                    for (int i = 0; i < casesLength; i++) {
                      final DocumentSnapshot _case = snapshot.data.documents[i];
                      cases.add(new AnimalCase(brand: _case['brand'], color: _case['color']));
                    }
                    print(cases.toString());
                    return SearchBar<AnimalCase>(
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
                      indexedScaledTileBuilder: (int index) =>
                          ScaledTile.count(1, index.isEven ? 2 : 1),
                      header: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          RaisedButton(
                            child: Text("sort"),
                            onPressed: () {
                              _searchBarController.sortList((AnimalCase a, AnimalCase b) {
                                return a.brand.compareTo(b.brand);
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
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 5,
                      crossAxisCount: 1,
                      suggestions: cases,
                      onItemFound: (AnimalCase post, int index) {
                        return Container(
                          color: Colors.lightBlue,
                          child: ListTile(
                            title: Text(post.brand),
                            isThreeLine: false,
                            subtitle: Text(post.description),
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                        );
                      },
                    );
                  })
              : getPosts(context)),
    );
  }

  Widget getPosts(BuildContext context) {
    return new StreamBuilder<QuerySnapshot>(
      stream: _reportService.getMatimelaCases(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Connecting...');
        final int cardLength = snapshot.data.documents.length;
        return new ListView.builder(
          itemCount: cardLength,
          itemBuilder: (BuildContext context, int index) {
            final DocumentSnapshot _case = snapshot.data.documents[index];
            return new ListTile(
              title: new Text(_case['brand']),
              subtitle: new Text(_case['description'] ?? ""),
            );
          },
        );
      },
    );
  }

  Future<List<AnimalCase>> _getALlPosts(String text) async {
    print(text);
    List<AnimalCase> cases = new List<AnimalCase>();
    _reportService.getAllCases().listen((QuerySnapshot snapshot) {
      List<DocumentSnapshot> docs = snapshot.documents;
      docs.forEach((doc) {
        print(doc.data['brand']);
        if (doc.data['brand'] == text) {
          cases.add(AnimalCase(brand: doc.data['brand'], color: doc.data['color']));
        }
      });
    });
    return cases;
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
