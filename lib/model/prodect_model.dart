class Product {
  int? productId;
  String productName;
  double? price;
  String? unit;
  int? classId;

  Product({
    this.productId,
    required this.productName,
    this.price,
    this.unit,
    this.classId,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'unit': unit,
      'class_id': classId,
    };
  }
}
