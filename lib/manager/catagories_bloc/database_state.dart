part of 'database_bloc.dart';

@immutable
abstract class ProductsState {}

class ProductsInitial extends ProductsState {}

class ProductsLoaded extends ProductsState {
  final List<Product> products;
  
  ProductsLoaded(this.products);
}

class ProductsError extends ProductsState {
  final String errorMessage;

  ProductsError(this.errorMessage);
}
class ClassesLoadedState extends ProductsState{
  final List<Class> classes;

  ClassesLoadedState({required this.classes});
}
