import 'package:acm1/alerts/api_response.dart';
import 'package:acm1/alerts/choose_action.dart';
import 'package:acm1/alerts/logout.dart';
import 'package:acm1/listings/menu_listing.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/views/bin_mapping.dart';
import 'package:acm1/views/cooked.dart';
import 'package:get_it/get_it.dart';
import 'package:acm1/views/cart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';

class MenuList extends StatefulWidget {
  @override
  _MenuListState createState() => _MenuListState();
}

class _MenuListState extends State<MenuList> {
  MenuService get service => GetIt.instance<MenuService>();
  List<Slide> slides = new List();

  APIResponse<List<MenuForListing>> _menuResponse;
  bool _isLoading = false;
  int count = 0;
  int a = 0;

  List<String> images = [
    'images/mixveg.png',
    'images/palpan.png',
    'images/dalmak.png',
    'images/ricekhe.png',
    'images/jeerice.png',
    'images/tomsoup.png'
  ];

  @override
  void initState() {
    _fetchNote();
    super.initState();
  }

  _fetchNote() async {
    setState(() {
      _isLoading = true;
    });

    _menuResponse = await service.getMenuList();

    setState(() {
      count = _menuResponse.data.length;
    });

    for (int i = 0; i < count; i++) {
      slides.add(
        new Slide(
          title: _menuResponse.data[i].menuTitle,
          description: "Good, Healthy, Tasty",
          pathImage: images[i],
          marginDescription:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
          marginTitle:
              EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
          backgroundColor: Color(0xff29b6f6),
        ),
      );
    }

    setState(() {
      _isLoading = false;
    });
  }

  Widget renderNextBtn() {
    return Text("Next", style: TextStyle(color: Colors.black, fontSize: 21));
  }

  onSkipPress() {
    showDialog(
        context: context,
        builder: (_) => ChooseAction(
            menuID: _menuResponse.data[a].menuID,
            menuTitle: _menuResponse.data[a].menuTitle));
  }

  void onTabChangeCompleted(index) {
    setState(() {
      a = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Menu'),
          centerTitle: true,
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
                child: Icon(Icons.cake),
                backgroundColor: Colors.red,
                label: 'Cook',
                labelStyle: TextStyle(fontSize: 21.0),
                onTap: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => ChooseAction(
                        menuID: _menuResponse.data[a].menuID,
                        menuTitle: _menuResponse.data[a].menuTitle)))),
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
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_menuResponse.error) {
            return Center(child: Text(_menuResponse.errorMessage));
          }
          return IntroSlider(
            slides: this.slides,
            nameSkipBtn: "Cook",
            nameDoneBtn: "Cook",
            isShowDoneBtn: false,
            isShowPrevBtn: true,
            isShowSkipBtn: false,
            nameNextBtn: "Next",
            namePrevBtn: "Previous",
            styleNameSkipBtn: TextStyle(fontSize: 21),
            styleNameDoneBtn: TextStyle(fontSize: 21),
            renderNextBtn: this.renderNextBtn(),
            styleNamePrevBtn: TextStyle(fontSize: 21),
            onSkipPress: this.onSkipPress,
            onDonePress: this.onSkipPress,
            onTabChangeCompleted: this.onTabChangeCompleted,
          );
        }));
  }
}
