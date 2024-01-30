import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sonod_point_of_sell/Database/featch_prodects.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';

part 'fetch_proudect_by_id_event.dart';
part 'fetch_proudect_by_id_state.dart';

class FetchProudectByIdBloc extends Bloc<FetchProudectByIdEvent, FetchProudectByIdState> {
 
  FetchProudectByIdBloc() : super(FetchProudectByIdInitial()) {
     List<Product> products=<Product>[];
    on<FetchProudectByIdEvent>((event, emit)async {
       
 
    if (event is FeatchProductsByIdEvent) {
  
        try { 
           print('bloc  clicked');
          products.addAll(await getProductsByProductId(event.proudctId));
          
          emit(ProudectsLoadedByIdState(prodcts: products));
      
        } catch (e) {
    
        }
      }else{
        emit(LoadingFetchProductById());
      }
    });
  }
}
