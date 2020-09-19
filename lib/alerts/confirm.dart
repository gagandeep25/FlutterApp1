import 'package:acm1/listings/menu_insert.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/views/menulist.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class ConfirmAction extends StatefulWidget {
  final String menuID;
  final String menuTitle;
  final int menuportions;
  ConfirmAction({this.menuID, this.menuTitle, this.menuportions});

  @override
  _ConfirmActionState createState() => _ConfirmActionState();
}

class _ConfirmActionState extends State<ConfirmAction> {
  /* int _counter = 1;

  void _incrementCouter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCouter() {
    setState(() {
      _counter--;
    });
  }*/

  MenuService get menuService => GetIt.I<MenuService>();
  double _currentSliderValueA = 100;
  double _currentSliderValueB = 100;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        title: Column(
          children: <Widget>[
            Container(
                width: 600,
                child: Container(
                    width: 600,
                    child: Text("Choose the degree of Feature A",
                        style: TextStyle(color: Colors.black, fontSize: 18)))),
            Container(
                width: 600,
                child: Container(
                    child: Container(
                        width: 600,
                        child: Slider(
                          value: _currentSliderValueA,
                          min: 75,
                          max: 125,
                          divisions: 10,
                          label: _currentSliderValueA.round().toString(),
                          onChanged: (double valueA) {
                            setState(() {
                              _currentSliderValueA = valueA;
                            });
                          },
                          activeColor: Color(0xffff520d),
                          inactiveColor: Colors.grey,
                        )))),
            SizedBox(height: 30.0),
            Container(
                width: 600,
                child: Container(
                    width: 600,
                    child: Text("Choose the degree of Feature B",
                        style: TextStyle(color: Colors.black, fontSize: 18)))),
            Container(
                width: 600,
                child: Container(
                    child: Container(
                        width: 600,
                        child: Slider(
                          value: _currentSliderValueB,
                          min: 75,
                          max: 125,
                          divisions: 10,
                          label: _currentSliderValueB.round().toString(),
                          onChanged: (double valueB) {
                            setState(() {
                              _currentSliderValueB = valueB;
                            });
                          },
                          activeColor: Color(0xffff520d),
                          inactiveColor: Colors.grey,
                        )))),
            FlatButton(
              child: Text('OK', style: TextStyle(fontSize: 18)),
              onPressed: () async {
                final notes = MenuInsert(
                    menuTitle: widget.menuTitle,
                    menuid: widget.menuID,
                    menuportions: widget.menuportions,
                    menufeat: _currentSliderValueA);

                final result = await menuService.createOrder(notes);

                final title = 'Done';
                final text = result.error
                    ? (result.errorMessage ?? 'An error has hfwubv occured')
                    : '${widget.menuTitle} has been Requested';

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
                });
              },
            ),
            FlatButton(
                child: Text('Cancel', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (_) => MenuList()));
                })
          ],
        ));
  }
}
