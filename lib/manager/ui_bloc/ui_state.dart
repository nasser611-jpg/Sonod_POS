part of 'ui_bloc.dart';

@immutable
sealed class UiState {}

final class UiInitial extends UiState {}
class LoadedProducts extends UiState{}