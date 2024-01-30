part of 'database_bloc.dart';

@immutable

abstract class ProductsEvent {}

class FetchProducts extends ProductsEvent {
  final int classId;

  FetchProducts(this.classId);
}
class FeatchCalssesEvent extends ProductsEvent{}