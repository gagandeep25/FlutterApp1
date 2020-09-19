import 'package:flutter/material.dart';

class NoteDelete extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Warning'),
      content: Text('Item will be deleted'),
      actions: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: Text('Ok')),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: Text('Cancel'))
      ],
    );
  }
}
