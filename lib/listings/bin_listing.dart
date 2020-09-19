class BinListing {
  String ingID;
  String ingTitle;
  int ingNumber;

  BinListing({this.ingID, this.ingTitle, this.ingNumber});

  factory BinListing.fromJson(Map<String, dynamic> items) {
    return BinListing(
        ingID: items["id"],
        ingTitle: items["Name"],
        ingNumber: items["Bin_Number"]);
  }
}
