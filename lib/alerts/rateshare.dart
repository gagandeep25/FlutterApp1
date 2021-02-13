import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class RateShare extends StatefulWidget {

  RateShare({this.menuTitle});
  final String menuTitle;

  @override
  _RateShareState createState() => _RateShareState();
}

class _RateShareState extends State<RateShare> {

  double _rating;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Done!", style: TextStyle(fontSize: 25),),
      content: Text("Thank you for trying out ${widget.menuTitle}. Would you like to rate and share the recipe with your friends?",),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 48.0, 0),
          child: RatingBar.builder(
            minRating: 1,
            itemCount: 5,
            direction: Axis.horizontal,
            allowHalfRating: true,
            onRatingUpdate: (rating) {
              _rating = rating;
            },
            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(onPressed: () {
              print(_rating);
              Navigator.of(context).pop();
            }, child: Text("Rate & Share")),
            FlatButton(onPressed: () {
              print(_rating);
              Navigator.of(context).pop();
            }, child: Text("Rate")),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text("Share")),
            FlatButton(onPressed: () {
              Navigator.of(context).pop();
            }, child: Text("No, thanks!")),
          ],
        ),
      ],
    );
  }
}
