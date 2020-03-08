import 'package:flutter/material.dart';
import 'package:matimela/src/models/user.dart';
import 'package:matimela/src/screens/auth/login.dart';
import 'package:matimela/src/screens/user/regular/dashboard.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) return Authenticate();
    return HomePage();
  }
}
