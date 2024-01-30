part of 'fetch_proudect_by_id_bloc.dart';

sealed class FetchProudectByIdEvent extends Equatable {
  const FetchProudectByIdEvent();

  @override
  List<Object> get props => [];
}
class FeatchProductsByIdEvent extends FetchProudectByIdEvent{
final int proudctId;

  const FeatchProductsByIdEvent({required this.proudctId});
}
