part of 'bill_bloc.dart';

@immutable
sealed class BillState {}

final class BillInitial extends BillState {}
class FechBillHeaderState extends BillState{

  final int  lastRequst;
  final String lastDate;
  FechBillHeaderState({required this.lastDate,  required this.lastRequst});
}