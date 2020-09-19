import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/listings/bin_update.dart';
import 'package:acm1/views/menulist.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class BinChange extends StatefulWidget {
  final String binID;
  final String binTitle;
  final int binNum;
  BinChange({this.binID, this.binTitle, this.binNum});

  @override
  _BinChangeState createState() => _BinChangeState();
}

class _BinChangeState extends State<BinChange> {
  MenuService get menuService => GetIt.I<MenuService>();
  int a = 1;

  void _incrementCouter() {
    setState(() {
      a++;
    });
  }

  void _decrementCouter() {
    setState(() {
      a--;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Choose bin for ${widget.binTitle} : $a',
            style: TextStyle(fontSize: 25)),
        actions: <Widget>[
          FlatButton(
            child: Text('+', style: TextStyle(fontSize: 21)),
            onPressed: () {
              _incrementCouter();

              /*   showDialog(
                  context: context,
                  builder: (_) => ConfirmAction(
                      menuID: widget.menuID, menuTitle: widget.menuTitle)); */
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
            onPressed: () async {
              if (widget.binNum == a || a < 0) {
                Navigator.of(context).pop();
              }
              if ((widget.binNum != a)) {
                {
                  final notes = BinUpdate(
                    binname: widget.binTitle,
                    binid: widget.binID,
                    binnum: a,
                  );

                  final result = await menuService.updateBin(notes);
                  final title = 'Done';
                  final text = result.error
                      ? (result.errorMessage ?? 'An error has hfwubv occured')
                      : 'Change has been Requested';

                  showDialog(
                      context: context,
                      builder: (_) => AlertDialog(
                            title: Text(title),
                            content: Text(text),
                            actions: <Widget>[
                              FlatButton(
                                  onPressed: () {
                                    Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (context) => MenuList()),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Text('OK'))
                            ],
                          )).then((data) {
                    if (result.data) {
                      Navigator.of(context).pop();
                    }
                    /*Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => NoteList()));*/
                  });
                }
              }
            },
          ),
        ]);
  }
}
