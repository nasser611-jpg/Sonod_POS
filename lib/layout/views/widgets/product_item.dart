import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';

class ProductItem extends StatefulWidget {
  final String productName;
  final double price;
  final int  productId;
  const ProductItem({Key? key, required this.productName, required this.price,required this.productId})
      : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {

  
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
  BlocProvider.of<FetchProudectByIdBloc>(context).add(FeatchProductsByIdEvent(proudctId: widget.productId));
  print('inkwall');
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          gradient: const RadialGradient(
            center: Alignment(0, -1),
            colors: [Color(0xFFF04D37), Color(0xFFF06837)],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: GestureDetector(
          onTap:() {
          },
          child: Column(children: [
            Expanded(
              child: Center(
                child: Text(
                  widget.productName,
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ),
            Container(
              height: 24,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
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
              child: Center(
                  child: Text(
                widget.price.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff374957)),
              )),
            )
          ]),
        ),
      ),
    );
  }
}
