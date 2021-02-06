class MenuForListing {
  String menuID;
  String menuTitle;
  String menuImg;
  int menuInd;
  String menImgloc;
  double menurating;

  MenuForListing(
      {this.menuID,
      this.menuTitle,
      this.menuImg,
      this.menuInd,
      this.menImgloc,
      this.menurating});

  factory MenuForListing.fromJson(Map<String, dynamic> items) {
    return MenuForListing(
        menuID: items["id"] as String,
        menuTitle: items["name"] as String,
        menuImg: items["image"] as String,
        menuInd: items["index"] as int,
        menImgloc: items["imagelocal"] as String,
        menurating: items["rating"] as double);
  }
}
