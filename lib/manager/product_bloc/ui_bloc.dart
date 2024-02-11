import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sonod_point_of_sell/Database/store_bill.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';
import 'package:sonod_point_of_sell/Database/featch_prodects.dart';

part 'ui_event.dart';
part 'ui_state.dart';

class UiBloc extends Bloc<UiEvent, UiState> {
  int catagoreyIndex = 0;
  UiBloc() : super(UiInitial()) {
    on<UiEvent>((event, emit) async {
      if (event is FeatchProductsEvent) {
        try {
          final List<Product> prodcts =
              await getProductsByClassId(event.classId);
          emit(ProudectsLoadedState(prodcts: prodcts));
          // ignore: empty_catches
        } catch (e) {}
      } else if (event is AddFavoriteProductEvent) {
        await addFavoriteProduc(event.isFavroite, event.productID);
      } else if (event is FetchFavoriteProductsEvent) {
        final List<Product> products = await getFavoriteProducts();
       
        emit(FeachFavroiteState(products: products));
      }
    });
  }
}
