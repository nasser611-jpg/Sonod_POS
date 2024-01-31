part of 'refresh_price_bloc.dart';

@immutable
sealed class RefreshPriceState {}

final class RefreshPriceInitial extends RefreshPriceState {}
class RefreshStayedAmountState extends RefreshPriceState{}