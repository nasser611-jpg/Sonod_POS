class Bill {
  int? billId;
  String? billDate;
  double? paidAmount;
  double? stayedAmount;
  String? billType;
  double? total;

  Bill({
    this.billId,
    this.billDate,
    this.paidAmount,
    this.stayedAmount,
    this.billType,
    this.total,
  });

  Map<String, dynamic> toMap() {
    return {
      'billId': billId,
      'billDate': billDate,
      'paidAmount': paidAmount,
      'stayedAmount': stayedAmount,
      'billType': billType,
      'total': total,
    };
  }

  Bill.fromMap(Map<String, dynamic> map) {
    billId = map['billId'];
    billDate = map['billDate'];
    paidAmount = map['paidAmount'];
    stayedAmount = map['stayedAmount'];
    billType = map['billType'];
    total = map['total'];
  }
}

class BillProduct {
  int? billProductsId;
  int? billId;
  int? productId;

  BillProduct({
    this.billProductsId,
    this.billId,
    this.productId,
  });

  Map<String, dynamic> toMap() {
    return {
      'billProductsId': billProductsId,
      'billId': billId,
      'productId': productId,
    };
  }

  BillProduct.fromMap(Map<String, dynamic> map) {
    billProductsId = map['billProductsId'];
    billId = map['billId'];
    productId = map['productId'];
  }
}

class ProductBill {
  int? productId;
  String? productName;
  String? classs; // Changed from classss
  double? price;
  String? unit;
  int? quantity;

  ProductBill({
    this.productId,
    this.productName,
    this.classs,
    this.price,
    this.unit,
    this.quantity,
  });

  Map<String, dynamic> toMap() {
    return {
      'product_id': productId,
      'product_name': productName,
      'classs': classs, // Changed from classss
      'price': price,
      'unit': unit,
      'quantity': quantity,
    };
  }

  ProductBill.fromMap(Map<String, dynamic> map) {
    productId = map['product_id'];
    productName = map['product_name'];
    classs = map['classs']; // Changed from classss
    price = map['price'];
    unit = map['unit'];
    quantity = map['quantity'];
  }
}
