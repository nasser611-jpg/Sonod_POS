part of 'fetch_proudect_by_id_bloc.dart';

sealed class FetchProudectByIdState extends Equatable {
  const FetchProudectByIdState();

  @override
  List<Object> get props => [];
}

final class FetchProudectByIdInitial extends FetchProudectByIdState {}

class ProudectsLoadedByIdState extends FetchProudectByIdState {
  final List<Product> prodcts;

  const ProudectsLoadedByIdState({required this.prodcts});
}
final class LoadingFetchProductById extends FetchProudectByIdState {}