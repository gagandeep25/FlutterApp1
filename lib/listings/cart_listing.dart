class CartListing {
  String orderID;
  String orderTitle;
  bool orderstatus;
  int portions;
  int feature;

  CartListing(
      {this.orderID,
      this.orderTitle,
      this.orderstatus,
      this.portions,
      this.feature});

  factory CartListing.fromJson(Map<String, dynamic> item) {
    //if (item['is_cooked'] == false)
    {
      return CartListing(
          orderID: item['item_id'],
          orderTitle: item['item_name'],
          orderstatus: item['is_cooked'],
          portions: item['portions'],
          feature: item['feature']);
    }
  }
}
