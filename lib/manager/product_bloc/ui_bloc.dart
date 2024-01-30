import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sonod_point_of_sell/Database/featch_prodects.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';

part 'ui_event.dart';
part 'ui_state.dart';

class UiBloc extends Bloc<UiEvent, UiState> {
  int catagoreyIndex = 0; 
  UiBloc() : super(UiInitial()) {
     
    on<UiEvent>((event, emit)async{
      if (event is FeatchProductsEvent) {
        try {
          final List<Product> prodcts = await getProductsByClassId(event.classId);
          emit(ProudectsLoadedState(prodcts: prodcts));
        } catch (e) {
    
        }
      }
    }
    );
  }
}
