import 'package:acm1/alerts/choose_features.dart';
import 'package:flutter/material.dart';

class ChooseAction extends StatefulWidget {
  final String menuID;
  final String menuTitle;
  ChooseAction({this.menuID, this.menuTitle});

  @override
  _ChooseActionState createState() => _ChooseActionState();
}

class _ChooseActionState extends State<ChooseAction> {
  int _counter = 1;

  void _incrementCouter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCouter() {
    setState(() {
      _counter--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Choose portions for ${widget.menuTitle} : $_counter',
            style: TextStyle(fontSize: 21)),
        actions: <Widget>[
          FlatButton(
            child: Text('+', style: TextStyle(fontSize: 21)),
            onPressed: () {
              _incrementCouter();
            },
          ),
          FlatButton(
            child: Text('-', style: TextStyle(fontSize: 21)),
            onPressed: () {
              _decrementCouter();
            },
          ),
          FlatButton(
            child: Text('Ok', style: TextStyle(fontSize: 18)),
            onPressed: () {
              if (_counter > 0) {
                showDialog(
                    context: context,
                    builder: (_) => ChooseFeature(
                          menuID: widget.menuID,
                          menuTitle: widget.menuTitle,
                        ));
              }
              if (_counter < 0) {
                Navigator.of(context).pop();
              }
            },
          ),
        ]);
  }
}
