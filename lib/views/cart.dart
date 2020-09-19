import 'package:acm1/alerts/api_response.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/listings/cart_listing.dart';
import 'package:acm1/views/menulist.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  MenuService get service => GetIt.instance<MenuService>();

  APIResponse<List<CartListing>> _apiResponse;
  bool _isLoading = false;

  @override
  void initState() {
    _fetchCart();
    super.initState();
  }

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
                  .push(MaterialPageRoute(builder: (_) => MenuList()));
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
                subtitle: Text(
                  "Portions : ${_apiResponse.data[index].portions} , Feature A : ${_apiResponse.data[index].feature}%",
                  style: TextStyle(
                      color: Theme.of(context).primaryColor, fontSize: 15),
                  // onTap: () {
                  // Navigator.of(context)
                  //   .push(MaterialPageRoute(builder: (_) => ChooseAction()));
                  // },
                ),
              );
            },
            itemCount: _apiResponse.data.length,
          );
        }));
  }
}
