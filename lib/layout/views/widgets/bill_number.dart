import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/manager/bill_bloc/bill_bloc.dart';

class BillNumber extends StatelessWidget {
  const BillNumber({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: 6.0),
                child: Text(
                  "رقم الفاتورة",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Container(
                height: 32,
                width: double.infinity,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.white),
                child: BlocBuilder<BillBloc, BillState>(
                  builder: (context, state) {
                    if (state is FechBillHeaderState) {
                      return Text("${state.lastRequst + 1}",
                          style: const TextStyle(
                              color: Color(0xff2D969B),
                              fontWeight: FontWeight.bold,
                              fontSize: 15));
                    }
                    return const SizedBox();
                  },
                ),
              )
            ],
          ),
        ));
  }
}
