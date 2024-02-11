class Product {
  int? productId;
  int ?isFavorite;
  String productName;
  double? price;
  String? unit;
  int? classId;
    int count;
  Product({
    this.productId,
    required this.productName,
    this.price,
    this.unit,
    this.classId,
    this.count=1,
    this.isFavorite
  });

  Map<String, dynamic> toMap() {
    return {
      'isFavorite':isFavorite,
      'product_id': productId,
      'product_name': productName,
      'price': price,
      'unit': unit,
      'class_id': classId,
    };
  }
}
