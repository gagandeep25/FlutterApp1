import 'dart:async';
import 'package:acm1/alerts/api_response.dart';
import 'package:acm1/alerts/rateshare.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/listings/cart_listing.dart';
import 'package:acm1/views/gridsview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get_it/get_it.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  MenuService get service => GetIt.instance<MenuService>();

  APIResponse<List<CartListing>> _apiResponse;
  bool _isLoading = false;
  //int _counter;
  //Timer _timer;

  @override
  void initState() {
    _fetchCart();
    //_startTimer();
    super.initState();
  }

  /*void _startTimer() {
    if(_timer != null){
      _timer.cancel();
    }
    _counter = 5;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if(_counter > 0){
        setState(() {
          _counter--;
        });
      }
      else{
        setState(() {
          _timer.cancel();
        });
        showDialog(context: context, builder: (_) => RateShare());
      }
    });
  }*/

  _fetchCart() async {
    setState(() {
      _isLoading = true;
    });

    _apiResponse = await service.getCartList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Being Cooked'),
          centerTitle: true,
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => GridsView()));
            },
            child: Icon(Icons.add)),
        body: Builder(builder: (_) {
          if (_isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (_apiResponse.error) {
            return Center(child: Text(_apiResponse.errorMessage));
          }

          return ListView.separated(
            separatorBuilder: (_, __) =>
                Container(child: Divider(height: 0, color: Colors.blue)),
            itemBuilder: (_, index) {
              return ListTile(
                title: Text(
                  _apiResponse.data[index].orderTitle //
                  ,
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 20),
                ),
                subtitle: /*_counter>0? Text(
                  "Portions : ${_apiResponse.data[index].portions} , Feature A : ${_apiResponse.data[index].feature}%"
                      "\nTime Remaining : ${(_counter/60).ceil()} minutes",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 15),
                  // onTap: () {
                  // Navigator.of(context)
                  //   .push(MaterialPageRoute(builder: (_) => ChooseAction()));
                  // },
                ) :*/ Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Portions : ${_apiResponse.data[index].portions} , Feature A : ${_apiResponse.data[index].feature}%",
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 15),
                    ),
                    CountdownTimer(
                      endTime: DateTime.now().millisecondsSinceEpoch + 1000*5,
                      onEnd: () {
                        showDialog(context: context,
                        builder: (_) => RateShare(menuTitle: _apiResponse.data[index].orderTitle,));
                      },
                      widgetBuilder: (_, time) {
                        if(time == null){
                          return Container();
                        }
                        else{
                          return Text("Time remaining : ${time.min==null? "${1} minute":"${time.min+1} minutes"}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor, fontSize: 15),);
                        }
                      },
                    )
                  ],
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        }));
  }
}
