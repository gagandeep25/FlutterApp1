import 'package:acm1/alerts/logout.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/listings/grid.dart';
import 'package:acm1/listings/menu_listing.dart';
import 'package:acm1/views/cooked.dart';
import 'package:acm1/views/menulist.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'bin_mapping.dart';
import 'cart.dart';

class GridsView extends StatefulWidget {
  GridsView() : super();
  final String title = "Menu";

  @override
  GridsViewState createState() => GridsViewState();
}

class GridsViewState extends State<GridsView> {
  gridshow(AsyncSnapshot<List<MenuForListing>> cell) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GridView.count(
        crossAxisCount: 1,
        childAspectRatio: 1.0,
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        children: cell.data.map((album) {
          return GestureDetector(
            child: GridTile(
              child: Grid(album),
            ),
            onTap: () {
              cellClick(album);
            },
          );
        }).toList(),
      ),
    );
  }

  cellClick(MenuForListing album) {
    showDialog(context: context, builder: (_) => MenuList(ind: album.menuInd));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton:

//     FloatingActionButton(onPressed: () => PopupMenuButton) ,
            SpeedDial(
          marginBottom: 100,
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
                child: Icon(Icons.business_center),
                backgroundColor: Colors.blue,
                label: 'Bin Mapping',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () =>
                    showDialog(context: context, builder: (_) => BinMap())),
            SpeedDialChild(
                child: Icon(Icons.power_settings_new),
                backgroundColor: Colors.blue,
                label: 'Log Out',
                labelStyle: TextStyle(fontSize: 18.0),
                onTap: () =>
                    showDialog(context: context, builder: (_) => LogOut())),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Flexible(
                child: FutureBuilder<List<MenuForListing>>(
              future: MenuService.getMenu(),
              builder: (context, cell) {
                if (cell.hasError) {
                  return Text("Error ${cell.error}");
                }

                if (cell.hasData) {
                  return gridshow(cell);
                }
                return Center(child: CircularProgressIndicator());
              },
            )),
          ],
        ));
  }
}
