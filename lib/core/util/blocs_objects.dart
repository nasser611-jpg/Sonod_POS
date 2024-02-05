import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';
import 'package:sonod_point_of_sell/manager/product_bloc/ui_bloc.dart';
import 'package:sonod_point_of_sell/manager/catagories_bloc/database_bloc.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';


var  featchBlocById=BlocProvider.of<FetchProudectByIdBloc>;

var  uiBloc=BlocProvider.of<UiBloc>;

var  productsBloc=BlocProvider.of<ProductsBloc>;
 void removeRepeatedProducts(List<Product> products, int productId) {
  bool removed = false;

  products.removeWhere((element) {
    if (element.productId == productId && !removed) {
      // Check if the count is greater than 1
      if (element.count > 1) {
        element.count--; // Decrease count if greater than 1
      } else {
        removed = true; // Set removed to true when count is 1
        return true; // Remove this occurrence
      }
    }
   
    return false; // Keep other occurrences
  });
}
