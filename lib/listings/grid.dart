import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:share/share.dart';
import 'menu_listing.dart';

class Grid extends StatelessWidget {
  const Grid(this.cell);
  @required
  final MenuForListing cell;

  double rateConvert(int rating){
    double x = rating.toDouble();
    return x/2;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        color: Colors.white,
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
                    width: 600,
                    height: 360,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  cell.menuTitle,
                  maxLines: 2,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10.0),
                child: RatingBarIndicator(
                  rating: rateConvert(cell.menurating),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                ),
              ),
              FlatButton(
                onPressed: () {share(context);},
                child: Text("Share"),
                textColor: Colors.black,
                color: Colors.blue,
              ),
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Your Rating: ",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                  ),
                  RatingBar.builder(
                    minRating: 1,
                    itemCount: 5,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    onRatingUpdate: (rating) {
                      print(rating);
                    },
                    itemBuilder: (context, _) => Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                  ),
                ],
              ),*/
            ],
          ),
        ));
  }
  void share(BuildContext context) {
    final String msg =
        "The Dish *${cell.menuTitle}*, from ACM is really good, you must try it.\n Try it Now : ${cell.menuImg}";
    Share.share(msg);
  }
}
