import 'package:acm1/alerts/api_response.dart';
import 'package:acm1/listings/cooked_listing.dart';
import 'package:acm1/apis/menu_services.dart';
import 'package:acm1/views/gridsview.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class Cooked extends StatefulWidget {
  @override
  _CookedState createState() => _CookedState();
}

class _CookedState extends State<Cooked> {
  MenuService get service => GetIt.instance<MenuService>();

  APIResponse<List<CookListing>> _apiResponse;
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

    _apiResponse = await service.getCookedList();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Cooked'),
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
              return Dismissible(
                key: ValueKey(_apiResponse.data[index].orderID),
                // direction: DismissDirection.startToEnd,
                //  onDismissed: (direction) {},
                /*   confirmDismiss: (direction) async {
                  final result = await showDialog(
                      context: context, builder: (_) => NoteDelete());

                  if (result) {
                    final deleteResult = await service
                       .deleteNote(_apiResponse.data[index].menuID);
                    var message;
                    if (deleteResult != null && deleteResult.data == true) {
                      message = 'The Item is Deleted';
                    } else {
                      message =
                          deleteResult?.errorMessage ?? 'An Error Occured';
                    }

                    showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                              title: Text('Done'),
                              content: Text(message),
                              actions: <Widget>[
                                FlatButton(
                                    child: Text('Ok'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    })
                              ],
                            ));

                    return deleteResult?.data ?? false;
                  } 

                //  return result;
                }, */
                child: ListTile(
                  title: Center(
                    child: Text(
                      _apiResponse.data[index].orderTitle,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor, fontSize: 20),
                    ),
                  ),
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
