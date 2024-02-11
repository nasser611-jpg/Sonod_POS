import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';
import 'package:sonod_point_of_sell/Database/featch_prodects.dart';
import 'package:sonod_point_of_sell/core/util/formatted_proudct.dart';

part 'fetch_proudect_by_id_event.dart';
part 'fetch_proudect_by_id_state.dart';

class FetchProudectByIdBloc
    extends Bloc<FetchProudectByIdEvent, FetchProudectByIdState> {
  List<double> totals = [];
  double total = 0.0;
  double paidAmountController = 0;
  int quantity = 1;
  int index = 0;
  int countProudct = 0;
  bool isSelected = false;
  int proudctSelectedId = 0;
  bool clickedItem = false;
  bool editQuantity = false;
  double stayedAmount = 0;
  double quantityEdited=0;
  List<FormattedProduct> formatProducts = [];
  String? productName;
  FetchProudectByIdBloc() : super(FetchProudectByIdInitial()) {
    List<Product> products = <Product>[];
    on<FetchProudectByIdEvent>((event, emit) async {
      if (event is FetchproudctyByIDDEvenet) {
        try {
          LoadingFetchProductById();
          products.addAll(await getProductsByProductId(event.proudctId));

          emit(ProudectsLoadedByIdState(prodcts: products));

          // ignore: empty_catches
        } catch (e) {}
      } else if (event is FetchTotalPriceEvent) {
        emit(FetchTotalPriceState());
      } else if (event is CancelBillEvent) {
      products.clear();
       emit(ProudectsLoadedByIdState(prodcts: products));
      }
    });
  }
}
