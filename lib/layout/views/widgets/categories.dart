import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sonod_point_of_sell/manager/catagories_bloc/database_bloc.dart';
import 'package:sonod_point_of_sell/manager/product_bloc/ui_bloc.dart';
import 'package:sonod_point_of_sell/model/catag_model.dart';

class Categories extends StatefulWidget {
  const Categories({
    super.key,
  });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductsBloc>(context).add(FeatchCalssesEvent());
    return Container(
      height: 84,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: const BoxDecoration(
          color: Colors.white,
          //---
          boxShadow: [
            BoxShadow(
              color: Color(0x33374957),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
            )
          ]),
      child: Row(
        children: [
          BlocBuilder<ProductsBloc, ProductsState>(
            builder: (context, state) {
              if (state is ClassesLoadedState) {
                final List<Class> catagories = state.classes;
                return Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: catagories.length,
                    itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        activeIndex = index;

                        BlocProvider.of<UiBloc>(context)
                            .add(FeatchProductsEvent(classId: index + 1));

                        setState(() {});
                      },
                      child: Container(
                        width: 104,
                        margin: const EdgeInsets.symmetric(horizontal: 8),
                        decoration: ShapeDecoration(
                          shadows: [
                            if (activeIndex == index)
                              BoxShadow(
                                  color: Colors.teal.withOpacity(0.7),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 2),
                                  blurStyle: BlurStyle.outer),
                          ],
                          gradient: const LinearGradient(
                            begin: Alignment(-1.00, -0.01),
                            end: Alignment(1, 0.01),
                            colors: [Color(0xFFFCE3DA), Colors.white],
                          ),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                width: 1, color: Color(0xFFF04937)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            catagories[index].className,
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Color(0xffF04A37)),
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Container(
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
          )
        ],
      ),
    );
  }
}
