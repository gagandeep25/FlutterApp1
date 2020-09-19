class MenuForListing {
  String menuID;
  String menuTitle;

  MenuForListing({
    this.menuID,
    this.menuTitle,
  });

  factory MenuForListing.fromJson(Map<String, dynamic> items) {
    return MenuForListing(menuID: items["id"], menuTitle: items["name"]);
  }
}
