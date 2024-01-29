part of 'database_bloc.dart';

@immutable
sealed class DatabaseState {}

final class DatabaseInitial extends DatabaseState {}
class LoadingDataState extends DatabaseState{}
class SuccessDataState extends DatabaseState{}
class FailuraDataState extends DatabaseState{
  final String erorrMessage;

  FailuraDataState({required this.erorrMessage});
}
