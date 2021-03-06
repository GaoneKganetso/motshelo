import 'package:flutter/material.dart';
import 'package:matimela/src/screens/user/regular/my_livestocks_dashboard.dart';
import 'package:matimela/src/services/my_livestock.dart';

class MyKraalPage extends StatefulWidget {
  @override
  _MyKraalPageState createState() => new _MyKraalPageState();
}

class _MyKraalPageState extends State<MyKraalPage> {
  LivestockManager _livestockManager = LivestockManager();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(
          "Livestock Manager",
          style: TextStyle(
            fontFamily: 'Quicksand',
          ),
        ),
        backgroundColor: Colors.grey[700],
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Stack(
            children: <Widget>[
//              Container(
//                alignment: Alignment(0.0, -0.40),
//                height: 100.0,
//                color: Colors.white,
//                child: Text(
//                  'My Livestock',
//                  style: TextStyle(fontFamily: 'Montserrat', fontSize: 20.0),
//                ),
//              ),
              Container(
                margin: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 0.0),
                height: 120,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.85),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [BoxShadow(blurRadius: 2.0, color: Colors.grey)]),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(25.0, 15.0, 5.0, 5.0),
                          child: Text(
                            'YOU HAVE',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25.0, 30.0, 5.0, 25.0),
                          child: FutureBuilder(
                              future: _livestockManager.countMyLivestock(),
                              builder: (context, snapshot) {
                                return Text(
                                  snapshot.hasData ? '${snapshot.data.toString()}' : 'counting...',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'Quicksand',
                                      fontWeight: FontWeight.bold,
                                      fontSize: snapshot.hasData ? 40.0 : 20),
                                );
                              }),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(25.0, 80.0, 5.0, 25.0),
                          child: Text(
                            'Livestock',
                            style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Quicksand',
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(width: 60.0),
                    Container(
                      height: 50.0,
                      width: 110.0,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue[300].withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: Center(
                        child: FlatButton(
                          onPressed: () => Navigator.of(context)
                              .push(new MaterialPageRoute(builder: (context) => MyLivestock())),
                          child: Text('Register',
                              style: TextStyle(
                                  fontFamily: 'Quicksand',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 30.0),
          Container(
              padding: EdgeInsets.only(left: 25.0, right: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Livestock Feeding History',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  ),
                  Text(
                    'Vaccine Archieves',
                    style: TextStyle(
                        color: Colors.green,
                        fontFamily: 'Quicksand',
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0),
                  )
                ],
              )),
          SizedBox(height: 10.0),
          GridView.count(
            crossAxisCount: 2,
            primary: false,
            crossAxisSpacing: 2.0,
            mainAxisSpacing: 4.0,
            shrinkWrap: true,
            children: <Widget>[
              _buildCard('Feeding', 'Available', 1,
                  'https://sc01.alicdn.com/kf/HTB1XNneKpXXXXaFXFXXq6xXFXXXX/CALF-GROWING-FEEDS-LIVESTOCK-FEEDS.jpg_300x300.jpg'),
              _buildCard('Vaccine', 'Away', 2,
                  'https://www.srtfund.org/lib/thumb.php?src=11557812088309481698.jpg&y=630&x=708&zc=1'),
              _buildCard(
                  'Livestock', 'Available', 3, 'https://www.fao.org/uploads/pics/cows_01.jpg'),
              _buildCard('Maintenance', 'Available', 4,
                  'https://www.pngitem.com/pimgs/m/481-4816759_maintenance-icon-png-transparent-png.png'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildCard(String name, String status, int cardIndex, String image) {
    return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 7.0,
        child: Column(
          children: <Widget>[
            SizedBox(height: 12.0),
            Stack(children: <Widget>[
              Container(
                height: 60.0,
                width: 60.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    color: Colors.green,
                    image: DecorationImage(fit: BoxFit.cover, image: NetworkImage(image))),
              ),
              Container(
                margin: EdgeInsets.only(left: 40.0),
                height: 20.0,
                width: 20.0,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    color: status == 'Away' ? Colors.amber : Colors.green,
                    border: Border.all(color: Colors.white, style: BorderStyle.solid, width: 2.0)),
              )
            ]),
            SizedBox(height: 8.0),
            Text(
              name,
              style: TextStyle(
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.bold,
                fontSize: 15.0,
              ),
            ),
            SizedBox(height: 5.0),
            Text(
              status,
              style: TextStyle(
                  fontFamily: 'Quicksand',
                  fontWeight: FontWeight.bold,
                  fontSize: 12.0,
                  color: Colors.grey),
            ),
            SizedBox(height: 15.0),
            Expanded(
                child: Container(
                    width: 175.0,
                    decoration: BoxDecoration(
                      color: status == 'Away' ? Colors.grey : Colors.green,
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10.0), bottomRight: Radius.circular(10.0)),
                    ),
                    child: InkWell(
                      onTap: () => Navigator.of(context)
                          .push(new MaterialPageRoute(builder: (context) => MyLivestock())),
                      child: Center(
                        child: Text(
                          'View',
                          style: TextStyle(color: Colors.white, fontFamily: 'Quicksand'),
                        ),
                      ),
                    )))
          ],
        ),
        margin: cardIndex.isEven
            ? EdgeInsets.fromLTRB(10.0, 0.0, 25.0, 10.0)
            : EdgeInsets.fromLTRB(25.0, 0.0, 5.0, 10.0));
  }
}
