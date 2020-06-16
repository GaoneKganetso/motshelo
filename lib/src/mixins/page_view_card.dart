import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matimela/src/models/user.dart';
import 'package:matimela/src/services/auth.dart';

import 'page_view_card_list_tile.dart';

class PageViewCard extends StatelessWidget{
  Firestore _firestore = Firestore();
  AuthService _authService = new AuthService();
  User user;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _authService.currentUser(),
        builder: (context, snapshot) {
          if(!snapshot.hasData){
            return Center(child: CupertinoActivityIndicator());
          }

          User user = snapshot.data;
          return StreamBuilder(
              stream: _firestore.collection('profile').document(user.id).snapshots(),
              builder: (context, snapshot) {
                if(!snapshot.hasData){
                  return Center(child: CupertinoActivityIndicator());
                }
                log(snapshot.data.toString());
                Profile profile = Profile.fromJson(snapshot.data);
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 7.0),
                  child: Card(
                    color: Colors.grey[200],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          PageViewCardListTile(
                            title: 'Farmer Name',
                            content: profile.name,
                            biggerContent: true,
                          ),
                          PageViewCardListTile(
                            title: 'Kraal Location',
                            content: profile.location,
                          ),
                          PageViewCardListTile(
                            title: 'Surname',
                            content: profile.surname,
                          ),
                          PageViewCardListTile(
                            title: 'BrandName',
                            content: profile.brandName,
                          ),
                          SizedBox(
                            child: CupertinoButton(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    'click for more details',
                                    style: TextStyle(color: Colors.black,
                                        fontFamily: 'Quicksand'),
                                  ),
                                  Expanded(child: SizedBox()),
                                  RotatedBox(
                                    quarterTurns: 3,
                                    child: Icon(
                                      CupertinoIcons.down_arrow,
                                      color: Color(0xFFB42827),
                                    ),
                                  ),
                                ],
                              ),
                              color: Colors.green.withOpacity(0.3),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }
          );
        }
    );
  }

}
