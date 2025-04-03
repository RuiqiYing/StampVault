import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'addPostPart.dart';

String TAG;

class tagCard extends StatefulWidget {
  tagCard({Key key, this.text, this.mode, this.selectMode = 0}) : super(key: key);
  String text;
  bool mode;
  int selectMode;
  @override
  _tagCardState createState() => _tagCardState();
}

class _tagCardState extends State<tagCard> {
  @override
  Widget build(BuildContext context) {
    String text = widget.text;
    text = "#" + text + "#";
    return Container(
        decoration: BoxDecoration(
                        border: new Border.all(
                  width: 3, color: Colors.black12),
              borderRadius: BorderRadius.circular(10),
          color: widget.selectMode == 1? Colors.green: (widget.mode ? Colors.grey[350] : Colors.white),
        ),
        child: TextButton(
            child: Text(text,
                style: TextStyle(color: Color(0xff333333), fontSize: 14)),
            onPressed: () {
              setState(() {
                widget.selectMode = 1 - widget.selectMode;
                setTag(text.toString());
                getTAG();
                if (!widget.mode) Navigator.pop(context);
              });
            }));
  }
}
