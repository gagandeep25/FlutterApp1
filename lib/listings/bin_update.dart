import 'package:flutter/foundation.dart';

class BinUpdate {
  String binname;
  String binid;
  int binnum;

  BinUpdate(
      {@required this.binid, @required this.binname, @required this.binnum});

  Map<String, dynamic> toJson() {
    return {'Name': binname, 'id': binid, 'Bin_Number': binnum};
  }
}
