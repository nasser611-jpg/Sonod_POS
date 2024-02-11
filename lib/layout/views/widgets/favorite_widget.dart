import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/manager/product_bloc/ui_bloc.dart';

class FilterdProducts extends StatelessWidget {
  const FilterdProducts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 104,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: ShapeDecoration(
          gradient: const LinearGradient(
            begin: Alignment(-1.00, -0.01),
            end: Alignment(1, 0.01),
            colors: [Color(0xFFFFEAB5), Colors.white],
          ),
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1, color: Color(0xFFE97B00)),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        child: Center(
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset("assets/icons/star.svg"),
              ),
              const Text(
                "المفضلة",
                style: TextStyle(color: Color(0xffE97B00)),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        BlocProvider.of<UiBloc>(context).add(FetchFavoriteProductsEvent());
      },
    );
  }
}
