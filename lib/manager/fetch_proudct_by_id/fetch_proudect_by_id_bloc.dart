import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sonod_point_of_sell/Database/featch_prodects.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';

part 'fetch_proudect_by_id_event.dart';
part 'fetch_proudect_by_id_state.dart';

class FetchProudectByIdBloc
    extends Bloc<FetchProudectByIdEvent, FetchProudectByIdState> {
  List<double> totals = [];
  double total = 0.0;
  double paidAmountController=0;
  
  FetchProudectByIdBloc() : super(FetchProudectByIdInitial()) {

    List<Product> products = <Product>[];
    on<FetchProudectByIdEvent>((event, emit) async {
      if (event is FetchproudctyByIDDEvenet) {
        try {
          LoadingFetchProductById();
          products.addAll(await getProductsByProductId(event.proudctId));
          // Example usage:
// List<Product> products = ...; // Your list of products
//  List<f.FormattedProduct> formattedProducts = f.ProductFormatter.formatProducts(products.cast<f.Product>());

//  print(formattedProducts);
      emit(ProudectsLoadedByIdState(prodcts: products));

        } catch (e) {

        }
      } else if(event is FetchTotalPriceEvent){
        emit(FetchTotalPriceState());
      }
    });
  }

}
