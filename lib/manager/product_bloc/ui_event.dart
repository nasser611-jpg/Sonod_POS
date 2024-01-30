part of 'ui_bloc.dart';

@immutable
sealed class UiEvent {}
class BuildProductsScreen extends UiEvent{}
class FeatchProductsEvent extends UiEvent{
final int classId;

  FeatchProductsEvent({required this.classId});
}