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
        orElse: () => Product(productName: ''),
      );

      return FormattedProduct(
        price: product.price ?? 0.0,
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

  static Map<int?, ProductSummary> setQuantity(
      List<Product> products, int productId, int countToAdd) {
    bool removed = false;

    while (!removed) {
      removed = true;

      for (int i = 0; i < products.length; i++) {
        Product element = products[i];

        if (element.productId == productId) {
          // Check if there are more than one occurrences
          if (products.where((p) => p.productId == element.productId).length >
              1) {
            removed =
                false; // There are more than one occurrences, set removed to false
            products.remove(element); // Remove one occurrence
            break; // Break the loop to reevaluate
          }
        }
      }
    }

    Map<int?, ProductSummary> summary = {};

    for (Product product in products) {
      int? currentProductId = product.productId;

      if (currentProductId == productId) {
        if (summary.containsKey(currentProductId)) {
          summary[currentProductId]!.totalPrice +=
              (product.price ?? 0) * countToAdd;
          summary[currentProductId]!.count += countToAdd;
        } else {
          summary[currentProductId] = ProductSummary()
            ..totalPrice = (product.price ?? 0) * countToAdd
            ..count = countToAdd;
        }
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
  double price;
  FormattedProduct(
      {this.productId,
      this.productName,
      this.unit,
      required this.totalPrice,
      required this.count,
      required this.price});
}

class ProductSummary {
  double totalPrice = 0.0;
  int count = 0;
}
