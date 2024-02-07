part of 'bill_bloc.dart';

@immutable
sealed class BillEvent {}

class InsertBillEvent extends BillEvent {
final List<FormattedProduct> formattedProduct;
final double paidAmount;
final double stayedAmount;
final double total;
final String billDate;
final String billType;

  InsertBillEvent({required this.formattedProduct, required this.paidAmount, required this.stayedAmount,
   required this.total, required this.billDate, required this.billType});

  
}
class FechBillHeaderEvent extends BillEvent{}
