import 'package:flutter/foundation.dart';

class MenuInsert {
  String menuTitle;
  String menuid;
  int menuportions;
  double menufeat;

  MenuInsert(
      {@required this.menuTitle,
      @required this.menuid,
      @required this.menuportions,
      @required this.menufeat});

  Map<String, dynamic> toJson() {
    return {
      'item_name': menuTitle,
      'item_id': menuid,
      'portions': menuportions,
      'feature': menufeat
    };
  }
}
