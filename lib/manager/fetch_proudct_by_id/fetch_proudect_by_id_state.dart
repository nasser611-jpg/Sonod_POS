part of 'fetch_proudect_by_id_bloc.dart';

@immutable
abstract class FetchProudectByIdState {
  const FetchProudectByIdState();
}

final class FetchProudectByIdInitial extends FetchProudectByIdState {}

class ProudectsLoadedByIdState extends FetchProudectByIdState {
  final List<Product> prodcts;

  const ProudectsLoadedByIdState({required this.prodcts});
}

final class LoadingFetchProductById extends FetchProudectByIdState {}

final class FetchTotalPriceState extends FetchProudectByIdState {}

class RefreshDeletionOp extends FetchProudectByIdState {}
