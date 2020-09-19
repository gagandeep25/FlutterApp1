class CookListing {
  String orderID;
  String orderTitle;
  //bool orderstatus;

  CookListing({
    this.orderID,
    this.orderTitle,
    // this.orderstatus
  });

  factory CookListing.fromJson(Map<String, dynamic> item) {
    return CookListing(
      orderID: item['item_id'],
      orderTitle: item['item_name'],
      //orderstatus: item['is_cooked']
    );
  }
}
