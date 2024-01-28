import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'ui_event.dart';
part 'ui_state.dart';

class UiBloc extends Bloc<UiEvent, UiState> {
  int catagoreyIndex = 0; 
   List<Map<String, dynamic>> getProducts(int categoryIndex) {
        categoryIndex = catagoreyIndex;
        print(categoryIndex);
        return {
              0: [
                {'name': 'Steak', 'price': 20.99},
                {'name': 'Chicken', 'price': 15.99},
              ],
              1: [
                {'name': 'Orange Juice', 'price': 3.99},
                {'name': 'Apple Juice', 'price': 4.99},
                {'name': 'Orange Juice', 'price': 3.99},
                {'name': 'Apple Juice', 'price': 4.99},
              ],
              2: [
                {'name': 'pitzaa', 'price': 3.99},
                {'name': 'humberger', 'price': 4.99},
                {'name': 'chacklater', 'price': 3.99},
                {'name': 'huberella', 'price': 4.99},
              ],
            }[categoryIndex] ??
            [];
      }
   
  UiBloc() : super(UiInitial()) {
     
    on<UiEvent>((event, emit) {
      if(event is BuildProductsScreen ){
        emit(LoadedProducts());
      }
    });
  }
}
