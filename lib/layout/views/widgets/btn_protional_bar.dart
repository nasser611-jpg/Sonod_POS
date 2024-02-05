import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';


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
    return InkWell(
      onTap: () {},
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
