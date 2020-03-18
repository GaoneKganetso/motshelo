import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'page_view_card_list_tile.dart';

class PageViewCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                title: 'Farmer',
                content: 'Tiro Letshwiti',
                biggerContent: true,
              ),
              PageViewCardListTile(
                title: 'Location',
                content: 'Molepolole',
              ),
              PageViewCardListTile(
                title: 'Kraal Location',
                content: 'Mahetlwe',
              ),
              PageViewCardListTile(
                title: 'Description of Animal',
                content: 'CSC Response condition. Lorem ipsum dolor sit amet, consecteture.',
              ),
              SizedBox(
                child: CupertinoButton(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Text(
                        'Animal details',
                        style: TextStyle(color: Colors.black, fontFamily: 'Quicksand'),
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
}
