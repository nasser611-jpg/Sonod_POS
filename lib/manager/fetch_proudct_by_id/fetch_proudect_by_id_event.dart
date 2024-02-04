part of 'fetch_proudect_by_id_bloc.dart';

@immutable
abstract class FetchProudectByIdEvent  {}


class FetchproudctyByIDDEvenet extends FetchProudectByIdEvent{
final int proudctId;

  FetchproudctyByIDDEvenet({required this.proudctId});
}
class FetchTotalPriceEvent extends FetchProudectByIdEvent{
}
