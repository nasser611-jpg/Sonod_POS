import 'package:flutter/material.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/btn_protional_bar.dart';

class OptionBar extends StatelessWidget {
  const OptionBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x33374957),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: const Row(children: [
        BtnOptionBar(
            color: Color(0xff2D969B),
            iconPath: "assets/icons/floppy_disks.svg",
            child: "حفظ الفاتورة"),
        BtnOptionBar(
          color: Color(0xffEB1E4B),
          iconPath: "assets/icons/trash.svg",
          child: "الغاء الفاتورة",
        ),
      ]),
    );
  }
}
