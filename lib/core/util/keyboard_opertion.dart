import 'package:flutter/material.dart';
import 'package:sonod_point_of_sell/core/util/blocs_objects.dart';
import 'package:sonod_point_of_sell/core/util/formatted_proudct.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';

class keyboardOperions{
  
static  void onTapClear(BuildContext context, List<Product> products) {
  if (featchBlocById(context).clickedItem) {
    featchBlocById(context).editQuantity = true;
    bool removed = false;

    while (!removed) {
      removed = true;

      for (int i = 0; i < products.length; i++) {
        Product element = products[i];

        if (element.productId == featchBlocById(context).proudctSelectedId) {
          if (products.where((p) => p.productId == element.productId).length >
              1) {
            removed = false;
            products.remove(element);
            break;
          }
        }
      }
    }
  } else {
    featchBlocById(context).paidAmountController = 0.0;
    featchBlocById(context).add(FetchproudctyByIDDEvenet(proudctId: 0));
  }

  updateState(context, products);
}

static  void onTapDelete(BuildContext context, List<Product> products) {
  if (featchBlocById(context).clickedItem) {
    products.removeWhere(
      (element) =>
          element.productId == featchBlocById(context).proudctSelectedId,
    );
  }

  featchBlocById(context).add(FetchproudctyByIDDEvenet(proudctId: 0));
  updateState(context, products);
}


static void onTapNumber(BuildContext context, List<Product> products, String value, List<FormattedProduct> formattedProducts) {

  double currentAmount = featchBlocById(context).quantityEdited;

  // Concatenate the new character to the existing value
  int newValue = (currentAmount * 10 + int.parse(value)).toInt();
 
  if (featchBlocById(context).clickedItem) {
    // Update the UI to display the concatenated value
   featchBlocById(context).quantityEdited= newValue.toDouble();

    if (featchBlocById(context).proudctSelectedId == formattedProducts[featchBlocById(context).index].productId) {
      bool removed = false;
     
      while (!removed) {
        removed = true;

        for (int i = 0; i < products.length; i++) {
          Product element = products[i];

          if (element.productId == featchBlocById(context).proudctSelectedId) {
            if (products.where((p) => p.productId == element.productId).length > 1) {
              removed = false;
              products.remove(element);
              break;
            }
          }
        }
    
      }

      int count = 0;
      int index = featchBlocById(context).index;

      try {
        while (count < newValue - 1) { // Use newValue directly here
          products.add(Product(
            productName: products[index].productName,
            productId: featchBlocById(context).proudctSelectedId,
            unit: products[index].unit,
            price: products[index].price,
          ));

          count++;
        }
      } catch (e) {
        print('Error: $e');
      }

  

      featchBlocById(context).add(FetchproudctyByIDDEvenet(proudctId: 0));
    }
  } else {
  double currentAmount = featchBlocById(context).paidAmountController;
  int newValue = (currentAmount * 10 + int.parse(value)).toInt();
  featchBlocById(context).paidAmountController= newValue.toDouble();
     featchBlocById(context).add(FetchproudctyByIDDEvenet(proudctId: 0));
  }

  updateState(context, products);
}

static  void updateState(BuildContext context, List<Product> products) {
  double stayedAmount = featchBlocById(context).total -
      featchBlocById(context).paidAmountController;
  featchBlocById(context).stayedAmount = stayedAmount;

  featchBlocById(context).add(FetchproudctyByIDDEvenet(proudctId: 0));
}

}