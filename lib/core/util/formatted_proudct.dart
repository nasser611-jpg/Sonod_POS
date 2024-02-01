import 'package:sonod_point_of_sell/model/prodect_model.dart';

class ProductFormatter {
  static List<FormattedProduct> formatProducts(List<Product> products) {
    Map<int?, ProductSummary> summary = groupAndSum(products);

    List<FormattedProduct> formattedProducts = summary.entries.map((entry) {
      int? productId = entry.key;
      double totalPrice = entry.value.totalPrice;
      int count = entry.value.count;

      // Find the corresponding product details or provide a default product
      Product product = products.firstWhere(
        (p) => p.productId == productId,
        orElse: () => Product(productName:''), // Provide a default Product instance
      );

      return FormattedProduct(
        productId: productId,
        productName: product.productName,
        unit: product.unit,
        totalPrice: totalPrice,
        count: count,
      );
    }).toList();

    return formattedProducts;
  }

  static Map<int?, ProductSummary> groupAndSum(List<Product> products) {
    Map<int?, ProductSummary> summary = {};

    for (Product product in products) {
      int? productId = product.productId;

      if (summary.containsKey(productId)) {
        summary[productId]!.totalPrice += (product.price ?? 0);
        summary[productId]!.count += 1;
      } else {
        summary[productId] = ProductSummary()
          ..totalPrice = product.price ?? 0
          ..count = 1;
      }
    }

    return summary;
  }
}


class FormattedProduct {
  int? productId;
  String? productName;
  String? unit;
  double totalPrice;
  int count;

  FormattedProduct({
    this.productId,
    this.productName,
    this.unit,
    required this.totalPrice,
    required this.count,
  });
}

class ProductSummary {
  double totalPrice = 0.0;
  int count = 0;
}
