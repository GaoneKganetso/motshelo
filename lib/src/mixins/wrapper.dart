import 'package:flutter/material.dart';
import 'package:matimela/src/models/user.dart';
import 'package:matimela/src/screens/auth/login.dart';
import 'package:matimela/src/screens/user/regular/dashboard.dart';
import 'package:matimela/src/services/auth.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> {
  final AuthService _authService = AuthService();
  bool isLoggedIn = false;
  @override
  void initState() {
    isLoggedIn = false;
    _authService.currentUser().then((user) => user != null
        ? setState(() {
            isLoggedIn = true;
          })
        : null);
    super.initState();
    // new Future.delayed(const Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context, listen: true);
    if (user == null) return Authenticate();

    return isLoggedIn ? new HomePage() : new Authenticate();
  }
}
