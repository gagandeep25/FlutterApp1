/*
import 'package:flutter/material.dart';

/// This Widget is the main application widget.
class BinMap extends StatelessWidget {
  //static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //title: "Bin-Ingredient Mapping",
      home: Scaffold(
        appBar: AppBar(title: Text("Bin-Ingredient Mapping")),
        body: Center(
          child: MyStatefulWidget(),
        ),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  String dropdownValue = 'One';

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
      },
      items: <String>['One', 'Two', 'Free', 'Four']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
*/

import 'package:acm1/alerts/api_response.dart';
import 'package:acm1/alerts/bin_change.dart';
import 'package:acm1/alerts/logout.dart';
import 'package:acm1/listings/bin_listing.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/views/cooked.dart';
import 'package:acm1/views/menulist.dart';
import 'package:get_it/get_it.dart';
import 'package:acm1/views/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intro_slider/slide_object.dart';

class BinMap extends StatefulWidget {
  @override
  _BinMapState createState() => _BinMapState();
}

class _BinMapState extends State<BinMap> {
  MenuService get service => GetIt.instance<MenuService>();
  List<Slide> slides = new List();

  APIResponse<List<BinListing>> _binResponse;
  bool _isLoading = false;
  int count = 0;
  int a = 0;

  @override
  void initState() {
    _fetchNote();
    super.initState();
  }

  _fetchNote() async {
    setState(() {
      _isLoading = true;
    });

    _binResponse = await service.getBinList();

    setState(() {
      count = _binResponse.data.length;
    });

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
          centerTitle: true,
        ),
        floatingActionButton: SpeedDial(
          // both default to 16
          // marginRight: 300,
          marginBottom: 60,
          animatedIcon: AnimatedIcons.menu_close,
          animatedIconTheme: IconThemeData(size: 30.0),
          // this is ignored if animatedIcon is non null
          // child: Icon(Icons.add),
          visible: true,
          // If true user is forced to close dial manually
          // by tapping main button and overlay is not rendered.
          closeManually: false,
          curve: Curves.bounceIn,
          overlayColor: Colors.black,
          overlayOpacity: 0.5,

          tooltip: 'Speed Dial',
          heroTag: 'speed-dial-hero-tag',
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          elevation: 60.0,
          shape: CircleBorder(),
          children: [
            SpeedDialChild(
                child: Icon(Icons.access_alarm),
                backgroundColor: Colors.red,
                label: 'Being Cooked',
                labelStyle: TextStyle(fontSize: 21.0),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Cart()))),
            SpeedDialChild(
                child: Icon(Icons.timer),
                backgroundColor: Colors.red,
                label: 'Cooked',
                labelStyle: TextStyle(fontSize: 21.0),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => Cooked()))),
            SpeedDialChild(
                child: Icon(Icons.power_settings_new),
                backgroundColor: Colors.blue,
                label: 'Log Out',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () =>
                    showDialog(context: context, builder: (_) => LogOut())),
            SpeedDialChild(
                child: Icon(Icons.menu),
                backgroundColor: Colors.red,
                label: 'Menu',
                labelStyle: TextStyle(fontSize: 21.0),
                onTap: () => Navigator.of(context)
                    .push(MaterialPageRoute(builder: (_) => MenuList())))
          ],
        ),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_binResponse.error) {
            return Center(child: Text(_binResponse.errorMessage));
          }

          return ListView.separated(
            separatorBuilder: (_, __) =>
                Container(child: Divider(height: 25, color: Colors.blue)),
            itemBuilder: (_, index) => ListTile(
              title: Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "${_binResponse.data[index].ingTitle} : ${_binResponse.data[index].ingNumber}",
                    style: TextStyle(
                        color: Theme.of(context).primaryColor, fontSize: 20),
                  ),
                ),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (_) => BinChange(
                          binID: _binResponse.data[index].ingID,
                          binTitle: _binResponse.data[index].ingTitle,
                          binNum: _binResponse.data[index].ingNumber,
                        ));
              },
              //onLongPress: ,
            ),
            itemCount: _binResponse.data.length,
          );
        }));
  }
}
