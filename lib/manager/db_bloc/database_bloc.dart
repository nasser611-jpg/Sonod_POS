import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'database_event.dart';
part 'database_state.dart';

class DatabaseBloc extends Bloc<DatabaseEvent, DatabaseState> {   
   int classID=1;
   
  DatabaseBloc() : super(DatabaseInitial()) {

    on<DatabaseEvent>((event, emit) {
      if (event is FeatchCatagoriesEvent) {
        print('bloc class id $classID');
        try {
          emit(SuccessDataState());
        } on Exception catch (e) {
          emit(FailuraDataState(erorrMessage: e.toString()));
        }
      }
    });
  }
}
