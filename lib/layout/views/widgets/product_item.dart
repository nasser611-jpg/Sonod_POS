import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/manager/ui_bloc/ui_bloc.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    int indexCatagories = BlocProvider.of<UiBloc>(context).catagoreyIndex;
    List<Map<String, dynamic>> prodcuts =
        BlocProvider.of<UiBloc>(context).getProducts(indexCatagories);
    return InkWell(
      onTap: () {},
      child: BlocBuilder<UiBloc, UiState>(

        builder: (context, state) {

          if (state is LoadedProducts) {
  return ListView.builder(
      itemCount: BlocProvider.of<UiBloc>(context)
          .getProducts(indexCatagories)
          .length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8),
          decoration: ShapeDecoration(
            gradient: const RadialGradient(
              center: Alignment(0, -1),
              colors: [Color(0xFFF04D37), Color(0xFFF06837)],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)),
          ),
          child: Column(children: [
            const Expanded(
              child: Center(
                child: Text(
                  "عصير سنكويك",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 24,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(
                  horizontal: 6, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(2),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x7F373737),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: const Center(
                  child: Text(
                "1200",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff374957)),
              )),
            )
          ]),
        );
      });
}return const Center(child:  Text('there  is no state '),);
        },
      ),
    );
  }
}
