class PriceItem {
  final String date;
  final double price;
  final String sku;

  PriceItem({required this.date, required this.price, required this.sku});

  factory PriceItem.fromJson(Map<String, dynamic> json) {
    return PriceItem(
        date: json["date"], price: double.parse(json["price"]), sku: json["sku"]);
  }
}
