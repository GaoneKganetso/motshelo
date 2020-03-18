import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SquareButton extends StatelessWidget {
  final String label;
  final Icon icon;
  final Function action;

  SquareButton({@required this.label, @required this.icon, @required this.action})
      : assert(label != null),
        assert(icon != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        SizedBox(
          width: 60.0,
          height: 60.0,
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            borderRadius: BorderRadius.circular(20.0),
            onPressed: action,
            color: Colors.green,
            child: Icon(
              icon.icon,
              size: 26.0,
            ),
          ),
        ),
        SizedBox(
          height: 8.0,
        ),
        Container(
          width: 60.0,
          height: 20.0,
          child: Center(
            child: Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .caption
                  .copyWith(color: Colors.black87, fontFamily: 'Quicksand', fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
