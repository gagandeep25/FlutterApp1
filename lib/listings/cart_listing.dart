class CartListing {
  String orderID;
  String orderTitle;
  bool orderstatus;
  int portions;
  int feature;
  int endtime;

  CartListing(
      {this.orderID,
      this.orderTitle,
      this.orderstatus,
      this.portions,
      this.feature,
      this.endtime});

  factory CartListing.fromJson(Map<String, dynamic> item) {
    {
      return CartListing(
          orderID: item['item_id'],
          orderTitle: item['item_name'],
          orderstatus: item['is_cooked'],
          portions: item['portions'],
          feature: item['feature'],
          endtime: item['EndTime']);
    }
  }
}
