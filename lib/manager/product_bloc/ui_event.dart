part of 'ui_bloc.dart';

abstract class UiEvent {}

class BuildProductsScreen extends UiEvent {}

class FeatchProductsEvent extends UiEvent {
  final int classId;

  FeatchProductsEvent({required this.classId});
}

class AddFavoriteProductEvent extends UiEvent {
  final int productID;
  final int isFavroite;

  AddFavoriteProductEvent({required this.productID, required this.isFavroite});
}

class FetchFavoriteProductsEvent extends UiEvent {}
