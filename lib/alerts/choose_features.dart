import 'package:acm1/listings/menu_insert.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/views/gridsview.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_it/get_it.dart';

class ChooseFeature extends StatefulWidget {
  final String menuID;
  final String menuTitle;
  ChooseFeature({
    this.menuID,
    this.menuTitle,
  });

  @override
  _ChooseFeatureState createState() => _ChooseFeatureState();
}

class _ChooseFeatureState extends State<ChooseFeature> {
  int _counter = 1;
  String _featureA = "Normal";

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

  void _featA(double a) {
    if (a < 80) {
      setState(() {
        _featureA = "Least Spicy";
      });
    }
    if (a > 80 && a < 100) {
      setState(() {
        _featureA = "Less Spicy";
      });
    }
    if (a == 100) {
      setState(() {
        _featureA = "Normal";
      });
    }
    if (a > 100 && a < 120) {
      setState(() {
        _featureA = "Spicy";
      });
    }
    if (a > 120) {
      setState(() {
        _featureA = "Extra Spicy";
      });
    }
  }

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
              child:
                  Text('Choose portions for ${widget.menuTitle} : $_counter'),
            ),
            SizedBox(height: 15.0),
            FlatButton(
              child: Text('Increase  + ', style: TextStyle(fontSize: 21)),
              onPressed: () {
                _incrementCouter();
              },
            ),
            SizedBox(height: 10.0),
            FlatButton(
              child: Text('Reduce -', style: TextStyle(fontSize: 21)),
              onPressed: () {
                _decrementCouter();
              },
            ),
            SizedBox(height: 30.0),
            Container(
                width: 600,
                child: Text("Spiciness : $_featureA",
                    style: TextStyle(color: Colors.black, fontSize: 18))),
            Container(
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
                    _featA(_currentSliderValueA);
                  },
                  activeColor: Color(0xffff520d),
                  inactiveColor: Colors.grey,
                )),
            SizedBox(height: 30.0),
            Container(
              width: 600,
              child: Container(
                width: 600,
                child: Text(
                  "Choose the degree of Feature B",
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
            Container(
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
                )),
            FlatButton(
              child: Text(
                'OK',
                style: TextStyle(fontSize: 18),
              ),
              onPressed: () async {
                if (_counter > 0) {
                  final notes = MenuInsert(
                      menuTitle: widget.menuTitle,
                      menuid: widget.menuID,
                      menuportions: _counter,
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
                                            builder: (context) => GridsView()),
                                        (Route<dynamic> route) => false);
                                  },
                                  child: Text('OK'))
                            ],
                          )).then((data) {
                    if (result.data) {
                      Navigator.of(context).pop();
                    }
                  });
                }
                if (_counter < 1) {
                  Fluttertoast.showToast(
                      msg: "Portions can't be negative",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.grey[800],
                      textColor: Colors.lightBlue,
                      fontSize: 14.0);
                }
              },
            ),
            FlatButton(
                child: Text('Cancel', style: TextStyle(fontSize: 18)),
                onPressed: () {
                  Navigator.of(context).pop();
                })
          ],
        ));
  }
}
