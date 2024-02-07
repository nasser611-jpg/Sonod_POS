import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';
import 'package:sonod_point_of_sell/layout/app_layout.dart';

class PageHeader extends StatelessWidget {
  const PageHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return          GestureDetector(
            onPanStart: (details) => windowManager.startDragging(),
            child: Container(
                height: 36,
                color: LayoutColor.primaryColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 135,
                      child: Row(
                        children: [
                          Container(
                              width: 45,
                              height: 36,
                              color: LayoutColor.alertDanger,
                              child: Center(
                                  child: SvgPicture.asset("assets/exit.svg"))),
                          Container(
                              width: 45,
                              height: 36,
                              color: LayoutColor.primaryColor,
                              child: Center(
                                  child:
                                      SvgPicture.asset("assets/maxmize.svg"))),
                          Container(
                              width: 45,
                              height: 36,
                              color: LayoutColor.primaryColor,
                              child: Center(
                                  child:
                                      SvgPicture.asset("assets/minimize.svg")))
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8),
                          child: Text(" RESTURANT",
                              style: TextStyle(color: Colors.white)),
                        ),
                        Container(
                          width: 1,
                          decoration:
                              const BoxDecoration(color: Color(0xff4EA9AD)),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: SvgPicture.asset("assets/logo.svg"),
                        ),
                      ],
                    )
                  ],
                )),
          );
  }
}