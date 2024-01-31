part of 'ui_bloc.dart';

@immutable
sealed class UiState {}

final class UiInitial extends UiState {}
class LoadedProducts extends UiState{}
class ProudectsLoadedState extends UiState{
final List<Product>prodcts;

  ProudectsLoadedState({required this.prodcts});
}

class ProudectsLoadedStateById extends UiState{
final List<Product>prodcts;

  ProudectsLoadedStateById({required this.prodcts});
}