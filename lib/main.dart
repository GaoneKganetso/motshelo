import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:matimela/src/mixins/wrapper.dart';
import 'package:matimela/src/models/user.dart';
import 'package:matimela/src/services/auth.dart';
import 'package:provider/provider.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: true,
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
