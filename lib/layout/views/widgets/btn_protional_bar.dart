import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/core/util/show_message.dart';
import 'package:sonod_point_of_sell/core/util/blocs_objects.dart';
import 'package:sonod_point_of_sell/manager/bill_bloc/bill_bloc.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';

class BtnOptionBar extends StatelessWidget {
  const BtnOptionBar({
    super.key,
    required this.color,
    required this.iconPath,
    required this.child,
  });

  final Color color;
  final String iconPath;
  final String child;

  @override
  Widget build(BuildContext context) {
    FetchProudectByIdBloc fechbloc = BlocProvider.of(context);
    BillBloc bloc = BlocProvider.of(context);
    return InkWell(
      onTap: () {
        if (child == 'حفظ الفاتورة'&&fechbloc.formatProducts.isNotEmpty) {
          bloc.add(InsertBillEvent(
              formattedProduct: fechbloc.formatProducts,
              paidAmount: fechbloc.paidAmountController,
              stayedAmount: fechbloc.stayedAmount,
              total: fechbloc.total,
              billDate: DateTime.now().toString(),
              billType: 'نقداٌ'));

          BlocProvider.of<BillBloc>(context).add(FechBillHeaderEvent());
          showMessage(context, 'تم حفظ الفاتوره بنجاح');
           featchBlocById(context).add(CancelBillEvent());
        } else {
          featchBlocById(context).add(CancelBillEvent());
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        height: double.infinity,
        width: 120,
        padding: const EdgeInsets.all(8),
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(6)),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SvgPicture.asset(iconPath),
          ),
          Expanded(
              child: Text(
            child,
            style: const TextStyle(color: Colors.white),
          ))
        ]),
      ),
    );
  }
}
