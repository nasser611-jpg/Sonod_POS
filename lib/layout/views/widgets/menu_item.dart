import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StatsItem extends StatelessWidget {
  //this for head of screen 
  const StatsItem({super.key, required this.icon, required this.text});
  final String icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 34,
      margin: const EdgeInsets.all(8),
      alignment: Alignment.centerRight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
          border: Border.all(color: const Color(0xffD9D9D9)),
          color: const Color(0xffF7F7F7)),
      child: Row(children: [Padding(
        padding: const EdgeInsets.symmetric( horizontal:  8),
        child: SvgPicture.asset(icon),
      ), Padding(
        padding: const EdgeInsets.symmetric( horizontal:  8),
        child: Text(text),
      )]),
    );
  }
}
