import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
   
      onTap: (){},
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: ShapeDecoration(
          gradient: const RadialGradient(
            center: Alignment(0, -1),
            colors: [Color(0xFFF04D37), Color(0xFFF06837)],
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        child: Column(children: [
          const Expanded(
            child: Center(
              child: Text(
                "عصير سنكويك",
                style: TextStyle(color: Colors.white),
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
            child: const Center(child: Text("1200", style: TextStyle( fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xff374957)),)),
          )
        ]),
      ),
    );
  }
}
