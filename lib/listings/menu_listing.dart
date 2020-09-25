class MenuForListing {
  String menuID;
  String menuTitle;
  String menuImg;
  int menuInd;
  String menImgloc;

  MenuForListing(
      {this.menuID,
      this.menuTitle,
      this.menuImg,
      this.menuInd,
      this.menImgloc});

  factory MenuForListing.fromJson(Map<String, dynamic> items) {
    return MenuForListing(
        menuID: items["id"] as String,
        menuTitle: items["name"] as String,
        menuImg: items["image"] as String,
        menuInd: items["index"] as int,
        menImgloc: items["imagelocal"] as String);
  }
}
