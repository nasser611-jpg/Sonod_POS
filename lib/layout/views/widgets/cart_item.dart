import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';

class CartItem extends StatelessWidget {
  final int count;
  final String proudctName;
  final String unit;
  final double price;
  CartItem({
    super.key,
    this.isSelected = false,
    this.count = 0,
    required this.proudctName,
    required this.unit,
    required this.price,
  });
  TextEditingController quantity = TextEditingController(text: '1');
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: 38,
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
            color:
                isSelected ? const Color(0xffF4FFFF) : const Color(0xffE7E7E7),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
                color: isSelected
                    ? const Color(0xff2D969B)
                    : const Color(0xffE7E7E7))),
        child: Center(
          child: Row(children: [
            Expanded(
                flex: 1,
                child: Center(
                    child: Text((count + 1).toString(),
                        style: TextStyle(
                            color: isSelected
                                ? const Color(0xff2D969B)
                                : const Color(0xff5E5E5E),
                            fontWeight: FontWeight.bold)))),
            Expanded(
                flex: 5,
                child: Text(
                  proudctName,
                  style: TextStyle(
                      color: isSelected
                          ? const Color(0xff2D969B)
                          : const Color(0xff5E5E5E)),
                )),
            Expanded(
                flex: 2,
                child: Text(
                  unit,
                  style: TextStyle(
                      color: isSelected
                          ? const Color(0xff2D969B)
                          : const Color(0xff5E5E5E)),
                )),
            Expanded(
                flex: 2,
                child: Text(
                  price.toString(),
                  style: TextStyle(
                      color: isSelected
                          ? const Color(0xff2D969B)
                          : const Color(0xff5E5E5E),
                      fontWeight: FontWeight.bold),
                )),
            Expanded(
                flex: 2,
                child: TextField(onSubmitted: (value) {
                       num valueOffcail = num.parse(value);
                       BlocProvider.of<FetchProudectByIdBloc>(context).quantity=valueOffcail;
                      print(value);
                },
                  
                    textAlign: TextAlign.end,
                    controller: quantity,
                    keyboardType: TextInputType.number,
                    style: TextStyle(
                        color: isSelected
                            ? const Color(0xff2D969B)
                            : const Color(0xff5E5E5E),
                        fontWeight: FontWeight.bold)))
          ]),
        ));
  }
}
