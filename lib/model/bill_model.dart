class Bill {
  int? billNumber;
  String? billType;
  int? classId;
  int? productId;
  int? quantity;
  double? price;
  String? unit;
  double? billAmount;
  double? paidAmount;
  double? stayedAmount;
  String? billTime;

  Bill({
    this.billNumber,
    this.billType,
    this.classId,
    this.productId,
    this.quantity,
    this.price,
    this.unit,
    this.billAmount,
    this.paidAmount,
    this.stayedAmount,
    this.billTime,
  });

  Map<String, dynamic> toMap() {
    
    return {
      'bill_number': billNumber,
      'bill_type': billType,
      'class_id': classId,
      'product_id': productId,
      'quantity': quantity,
      'price': price,
      'unit': unit,
      'bill_amount': billAmount,
      'paid_amount': paidAmount,
      'stayed_amount': stayedAmount,
      'bill_time': billTime,
    };
  }
}
