import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/product_item.dart';
import 'package:sonod_point_of_sell/manager/catagories_bloc/database_bloc.dart';
import 'package:sonod_point_of_sell/manager/product_bloc/ui_bloc.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart';

class ProudctsItems extends StatelessWidget {
  ProudctsItems({Key? key}) : super(key: key);
  ScrollController? controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scrollbar(
        controller: controller,
        trackVisibility: true,
        interactive: true,
        thumbVisibility: true,
        thickness: 8.0,
        radius: const Radius.circular(20),
        child: CustomScrollView(
          controller: controller,
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              sliver: BlocBuilder<UiBloc, UiState>(
                builder: (context, state) {
                  print('state $state');
                  if (state is ProudectsLoadedState) {
                    List<Product> products = state.prodcts;
                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        crossAxisSpacing: 0,
                        childAspectRatio: 1.3,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ProductItem(
                          isFavorate: false,
                          productName: products[index].productName,
                          price: products[index].price!.toDouble(),
                          productId: products[index].productId!.toInt(),
                        ),
                        childCount: products.length,
                      ),
                    );
                  } else if (state is ProductsError) {
                    // Handle error state, show error message if needed
                    return const SliverToBoxAdapter(
                      child: Center(
                        child: Text('Error: '),
                      ),
                    );
                  } else if (state is FeachFavroiteState) {
                    List<Product> products = state.products;
                    return SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithMaxCrossAxisExtent(
                        maxCrossAxisExtent: 150,
                        crossAxisSpacing: 0,
                        childAspectRatio: 1.3,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => ProductItem(
                          isFavorate: true,
                          productName: products[index].productName,
                          price: products[index].price!.toDouble(),
                          productId: products[index].productId!.toInt(),
                        ),
                        childCount: products.length,
                      ),
                    );
                  }
                  return const SliverToBoxAdapter(child: SizedBox());
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
