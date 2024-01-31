part of 'refresh_price_bloc.dart';

@immutable
abstract class RefreshPriceEvent {}
sealed class  RefreshStayedAmountEvent extends RefreshPriceEvent{}
