import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sonod_point_of_sell/Database/featch_catagories.dart';
import 'package:sonod_point_of_sell/Database/featch_prodects.dart';
import 'package:sonod_point_of_sell/model/catag_model.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';

part 'database_event.dart';
part 'database_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      if (event is FetchProducts) {
        try {
          final List<Product> products =
              await getProductsByClassId(event.classId);
          emit(ProductsLoaded(products));
        } catch (e) {
          emit(ProductsError('Failed to fetch products: $e'));
        }
      } 
       else if (event is FeatchCalssesEvent) {
        try {
       
          final List<Class> classs = await getAllClasses();
          emit(ClassesLoadedState(classes: classs));
        } catch (e) {
          emit(ProductsError(e.toString()));
        }
      }
    });
  }

 
  // @override
  // void onTransition(Transition<ProductsEvent, ProductsState> transition) {
  //   super.onTransition(transition);
  //   // Add a print statement to debug the transitions
  //   print(transition);
  // }
}
