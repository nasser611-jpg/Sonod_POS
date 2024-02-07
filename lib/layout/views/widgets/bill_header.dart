import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/core/util/time.dart';
import 'package:sonod_point_of_sell/core/util/blocs_objects.dart';
import 'package:sonod_point_of_sell/manager/bill_bloc/bill_bloc.dart';
import 'package:sonod_point_of_sell/manager/product_bloc/ui_bloc.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/menu_item.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';



class BillHeader extends StatefulWidget {
  const BillHeader({Key? key}) : super(key: key);

  @override
  State<BillHeader> createState() => _BillHeaderState();
}

class _BillHeaderState extends State<BillHeader> {
  late StreamController<String> _streamController;

  late Stream<String> _stream;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UiBloc>(context).add(FeatchProductsEvent(classId: 1));

    featchBlocById(context).add(FetchproudctyByIDDEvenet(proudctId: 0));

    super.initState();

    _streamController = StreamController<String>();
    _stream = _streamController.stream;

    // Start emitting events
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamController.add(getCurrentDateTime());
    });
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<BillBloc>(context).add(FechBillHeaderEvent());
    return Container(
      height: 55,
      color: Colors.white,
      child: Row(children: [
        BlocBuilder<BillBloc, BillState>(
          builder: (context, state) {
            if (state is FechBillHeaderState) {
              return Row(
                children: [
                  StatsItem(
                      icon: 'assets/icons/orders.svg',
                      text: "عدد الطلبات : ${state.lastRequst} "),
                   StatsItem(
                      icon: 'assets/icons/last_invoice.svg',
                      text: " اخر فاتورة : ${state.lastDate}"),
                ],
              );
            }
            return const SizedBox();
          },
        ),
        StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return StatsItem(
                    icon: 'assets/icons/clock.svg',
                    text: "تاريخ : ${getCurrentDateTime()}");
              } else {
                return const SizedBox();
              }
            }),
        const Spacer(),
        const StatsItem(icon: 'assets/icons/exit.svg', text: "الخروج"),
      ]),
    );
  }
}
