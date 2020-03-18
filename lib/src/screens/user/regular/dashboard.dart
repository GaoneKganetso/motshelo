import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:matimela/src/mixins/page_view_card.dart';
import 'package:matimela/src/mixins/square_button.dart';
import 'package:matimela/src/mixins/tracking_lines.dart';
import 'package:matimela/src/screens/user/profile.dart';
import 'package:matimela/src/screens/user/regular/kraal_dashboard.dart';
import 'package:matimela/src/screens/user/regular/search_dashboard.dart';
import 'package:matimela/src/services/auth.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isDrawerOpen = false;
  int _currentIndex = 1;
  final _authService = AuthService();
  PageController _pageController = PageController(
    viewportFraction: 0.92,
    initialPage: 1,
  );

  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    _pageController.addListener(() {
      setState(() => _currentIndex = _pageController.page.round());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: Colors.white.withOpacity(.8),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            right: 0.0,
            child: CupertinoNavigationBar(
              backgroundColor: Colors.grey[800],
              border: Border.all(
                style: BorderStyle.none,
              ),
              actionsForegroundColor: Colors.white,
              leading: GestureDetector(
                onTap: () => setState(() => _isDrawerOpen = true),
                child: Icon(
                  IconData(0xF394,
                      fontFamily: CupertinoIcons.iconFont,
                      fontPackage: CupertinoIcons.iconFontPackage),
                ),
              ),
            ),
          ),
          Positioned(
            top: 90.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height -
                  (MediaQuery.of(context).size.height / 1.8) -
                  120.0,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
//                    RichText(
//                      textAlign: TextAlign.start,
//                      text: TextSpan(children: [
//                        TextSpan(
//                          text: 'Welcome! ',
//                          style: TextStyle(
//                            fontWeight: FontWeight.w500,
//                            fontSize: 26.0,
//                          ),
//                        ),
//                        TextSpan(
//                          text: 'Moffat',
//                          style: TextStyle(
//                            fontSize: 20.0,
//                          ),
//                        ),
//                      ]),
//                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        SquareButton(
                          icon: Icon(FontAwesomeIcons.search),
                          label: 'Cases',
                          action: () {
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context) => SearchAnimal()));
                          },
                        ),
                        SquareButton(
                          icon: Icon(FontAwesomeIcons.horse),
                          label: 'My Kraal',
                          action: () {
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context) => MyKraalPage()));
                          },
                        ),
                        SquareButton(
                          icon: Icon(FontAwesomeIcons.userFriends),
                          label: 'Farmers',
                          action: () {
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context) => SearchAnimal()));
                          },
                        ),
                        SquareButton(
                          icon: Icon(FontAwesomeIcons.solidComments),
                          label: 'Message',
                          action: () {
                            Navigator.push(context,
                                new MaterialPageRoute(builder: (context) => SearchAnimal()));
                          },
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Container(
                            width: 7.0,
                            height: 7.0,
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text(
                            'News Feed',
                            style:
                                Theme.of(context).textTheme.subtitle.copyWith(color: Colors.black),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Icon(
                            CupertinoIcons.ellipsis,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 80.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: MediaQuery.of(context).size.height / 1.6 - 90.0,
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 40.0),
                    child: PageView(
                      controller: _pageController,
                      children: <Widget>[
                        PageViewCard(),
                        PageViewCard(),
                        PageViewCard(),
                        PageViewCard(),
                        PageViewCard(),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: TrackingLines(
                        length: 5,
                        currentIndex: _currentIndex,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              height: 90.0,
              color: Colors.green.withOpacity(.7),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Container(
                            width: 45.0,
                            height: 45.0,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25.0),
                              color: Colors.white.withOpacity(0.1),
                            ),
                            child: Center(
                              child: Icon(
                                IconData(0xF391,
                                    fontFamily: CupertinoIcons.iconFont,
                                    fontPackage: CupertinoIcons.iconFontPackage),
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              '60',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline
                                  .copyWith(fontWeight: FontWeight.w500, color: Colors.white),
                            ),
                            Text(
                              'My Reports',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.white.withOpacity(0.5)),
                            ),
                          ],
                        ),
                        Expanded(child: SizedBox()),
                        CupertinoButton(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30.0),
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            'Reports',
                            style: TextStyle(
                              color: Color(0xFFB42827),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          AnimatedPositioned(
            duration: Duration(milliseconds: 300),
            curve: Curves.easeIn,
            top: 0.0,
            bottom: 0.0,
            left: _isDrawerOpen ? 0.0 : -(MediaQuery.of(context).size.width / 3) * 2,
            child: Container(
              width: (MediaQuery.of(context).size.width / 3) * 2,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height -
                        (MediaQuery.of(context).size.height / 1.8 - 90.0) -
                        120.0,
                    color: Colors.grey.withOpacity(.4),
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          top: 50.0,
                          right: 10.0,
                          child: GestureDetector(
                            onTap: () => setState(() => _isDrawerOpen = false),
                            child: Icon(
                              CupertinoIcons.clear,
                              color: Colors.black,
                              size: 40.0,
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.bottomLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 46.0, bottom: 46.0),
                            child: UserInfo(
                                picture: 'assets/image/profile/user-default.png',
                                name: 'Tiro',
                                id: '0023-mor'
                                    'e'),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height / 1.8 + 30.0,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0, top: 46.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            FlatButton.icon(
                                onPressed: () async {
                                  await _authService.sigOut();
                                },
                                icon: Icon(Icons.person),
                                label: Text("Account")),
                            SizedBox(
                              height: 8.0,
                            ),
                            FlatButton.icon(
                                onPressed: () async {
                                  await _authService.sigOut();
                                },
                                icon: Icon(FontAwesomeIcons.cogs),
                                label: Text(" Settings")),
                            SizedBox(
                              height: 8.0,
                            ),
                            FlatButton.icon(
                                onPressed: () async {
                                  await _authService.sigOut();
                                },
                                icon: Icon(Icons.help_outline),
                                label: Text("About")),
                            SizedBox(
                              height: 8.0,
                            ),
                            FlatButton.icon(
                                onPressed: () async {
                                  await _authService.sigOut();
                                },
                                icon: Icon(Icons.person),
                                label: Text("logout"))
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
