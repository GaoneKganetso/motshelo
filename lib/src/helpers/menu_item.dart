import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final FlatButton icon;
  final String label;

  MenuItem({
    @required this.icon,
    @required this.label,
  })  : assert(icon != null),
        assert(label != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 42.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          icon,
          SizedBox(
            width: 8.0,
          ),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
          ),
        ],
      ),
    );
  }
}
