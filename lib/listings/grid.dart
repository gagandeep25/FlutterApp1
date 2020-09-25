import 'package:flutter/material.dart';

import 'menu_listing.dart';

class Grid extends StatelessWidget {
  const Grid(this.cell);
  @required
  final MenuForListing cell;

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.blue[300],
        child: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1.0),
                  child: FadeInImage.assetNetwork(
                    placeholder: "images/mixveg.png",
                    image: "${cell.menuImg}",
                    width: 300,
                    height: 180,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),
                child: Text(
                  cell.menuTitle,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500),
                ),
              )
            ],
          ),
        ));
  }
}