import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sonod_point_of_sell/core/util/blocs_objects.dart';
import 'package:sonod_point_of_sell/core/util/formatted_proudct.dart';
import 'package:sonod_point_of_sell/core/util/time.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/cart_item.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/categories.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/proudcts_items_widget.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';
import 'package:sonod_point_of_sell/manager/product_bloc/ui_bloc.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart' as model;
import 'package:sonod_point_of_sell/model/prodect_model.dart';
import 'package:window_manager/window_manager.dart';

import '../app_layout.dart';
import 'widgets/menu_item.dart';









class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController? controller = ScrollController();
  late StreamController<String> _streamController;
  late Stream<String> _stream;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<UiBloc>(context).add(FeatchProductsEvent(classId: 1));

    featchBlocById(context).add(FetchproudctyByIDDEvenet(proudctId: 0));

    super.initState();

    // Initialize stream controller with a string type
    _streamController = StreamController<String>();
    // Create a stream that emits the current date and time every second
    _stream = _streamController.stream;

    // Start emitting events
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _streamController.add(getCurrentDateTime());
    });
  }

  double stayedAmount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
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
          ),
          Container(
            height: 55,
            color: Colors.white,
            child: Row(children: [
              const StatsItem(
                  icon: 'assets/icons/orders.svg', text: "عدد الطلبات : 64 "),
              const StatsItem(
                  icon: 'assets/icons/last_invoice.svg',
                  text: " اخر فاتورة : 2022/01/02 02:22"),
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
          ),
          // page content
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Categories(),
                    ProudctsItems(),
                    const OptionBar()
                  ],
                ),
              ),
              Container(
                width: 346,
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(width: 1, color: Color(0xffE7E7E7)))),
                child:
                    BlocBuilder<FetchProudectByIdBloc, FetchProudectByIdState>(
                  builder: (context, state) {
                    if (state is ProudectsLoadedByIdState) {
                      List<model.Product>? pr = state.prodcts;
                      List<FormattedProduct>? formattedProducts =
                          ProductFormatter.formatProducts(pr.cast<Product>());

                      double total = 0.0;

                      // Iterate through the products and accumulate the total price
                      for (var product in state.prodcts) {
                        // Calculate the total for each product based on quantity
                        double itemTotal = product.price as double;
                        total += itemTotal;
                      }
                      featchBlocById(context).total = total;

                      return Column(
                        children: [
                          Container(
                            height: 84,
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: const BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Color(0xFFAFA6A6),
                                  blurRadius: 4,
                                  offset: Offset(0, 0),
                                  spreadRadius: 0,
                                )
                              ],
                              gradient: LinearGradient(
                                begin: Alignment(0.00, -1.00),
                                end: Alignment(0, 1),
                                colors: [Color(0xFF2D969B), Color(0xFF2D7F9B)],
                              ),
                            ),
                            child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 6.0),
                                              child: Text(
                                                "رقم الفاتورة",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              height: 32,
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.white),
                                              child: const Text("1205",
                                                  style: TextStyle(
                                                      color: Color(0xff2D969B),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15)),
                                            )
                                          ],
                                        ),
                                      )),
                                  Expanded(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(bottom: 6.0),
                                              child: Text(
                                                "نوع الفاتورة",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Container(
                                              height: 32,
                                              width: double.infinity,
                                              padding: const EdgeInsets.all(4),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                  color: Colors.white),
                                              child: const Text("نقداً",
                                                  style: TextStyle(
                                                      color: Color(0xff2D969B),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15)),
                                            )
                                          ],
                                        ),
                                      )),
                                ]),
                          ),

                          Container(
                              height: 34,
                              color: const Color(0xff374957),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: const Row(
                                children: [
                                  Expanded(
                                      flex: 7,
                                      child: Text(
                                        "الصنف",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  Expanded(
                                      flex: 4,
                                      child: Text(
                                        "الوحدة",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  Expanded(
                                      flex: 3,
                                      child: Text(
                                        "السعر",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                  Expanded(
                                      flex: 2,
                                      child: Text(
                                        "الكمية",
                                        style: TextStyle(color: Colors.white),
                                      )),
                                ],
                              )),

                          // Cart Items

                          Expanded(
                            child: ListView.builder(
                              itemCount: state.prodcts.length,
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                if (index >= 0 &&
                                    index < formattedProducts.length) {
                                  return GestureDetector(
                                    onTap: () {
                                      featchBlocById(context).isSelected=true;
                                   
                                    },
                                    child: CartItem(
                                     
                                      quantity: formattedProducts[index].count,
                                      proudctId:
                                          state.prodcts[index].productId as int,
                                      count: index,
                                      proudctName: formattedProducts[index]
                                          .productName
                                          .toString(),
                                      price:
                                          formattedProducts[index].totalPrice,
                                      unit: formattedProducts[index]
                                          .unit
                                          .toString(),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),

                          Container(height: 2, color: const Color(0xffE7E7E7)),
                          Container(
                            height: 350,
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            color: const Color(0xffF5F5F5),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ////
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Text(
                                          "مبلغ الفاتورة",
                                          style: TextStyle(
                                              color: Color(0xff5E5E5E)),
                                        ),
                                      ),
                                      Container(
                                          height: 32,
                                          width: double.infinity,
                                          padding: const EdgeInsets.all(4),
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color:
                                                      const Color(0xffD9D9D9)),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              color: Colors.white),
                                          child: Text(
                                              "${featchBlocById(context).total}",
                                              style: const TextStyle(
                                                  color: Color(0xff374957),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)))
                                    ],
                                  ),

                                  ///
                                  Row(
                                    children: [
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Text(
                                                  "المبلغ المدفوع",
                                                  style: TextStyle(
                                                      color: Color(0xff5E5E5E)),
                                                ),
                                              ),
                                              Container(
                                                height: 32,
                                                width: double.infinity,
                                                padding:
                                                    const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: const Color(
                                                            0xffD9D9D9)),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    color: Colors.white),
                                                child: Text(
                                                  '${featchBlocById(context).paidAmountController}',
                                                  style: const TextStyle(
                                                      color: Color(0xff374957),
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 8),
                                                child: Text(
                                                  'المبلغ المتبقي',
                                                  style: TextStyle(
                                                      color: Color(0xff5E5E5E)),
                                                ),
                                              ),
                                              Container(
                                                  height: 32,
                                                  width: double.infinity,
                                                  padding:
                                                      const EdgeInsets.all(4),
                                                  decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color: const Color(
                                                              0xffD9D9D9)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              4),
                                                      color: Colors.white),
                                                  child: Text('${stayedAmount}',
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xffEB1E4B), // Color(0xff374957),
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15)))
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 16),

                                  Keyboard(onTap: (value) {
                                    if (value == 'تصفير') {
                                      featchBlocById(context)
                                          .paidAmountController = 0.0;
                                    } else if (value == 'حذف') {
                                      // Handle delete logic if needed
                                    } else {
                                      double valueOffcail = double.parse(value);
                                      double currentAmount =
                                          featchBlocById(context)
                                              .paidAmountController;

                                      // Concatenate the current amount and the pressed value
                                      double newValue =
                                          currentAmount * 10 + valueOffcail;

                                      // Update the paidAmountController with the new concatenated value
                                      featchBlocById(context)
                                          .paidAmountController = newValue;
                                    }

                                    // Print the updated paidAmountController value
                                    print(
                                        'the value is ${featchBlocById(context).paidAmountController}');
                                    stayedAmount =
                                        featchBlocById(context).total -
                                            featchBlocById(context)
                                                .paidAmountController;

                                    // Trigger the FetchproudctyByIDDEvenet event with the updated paidAmountController
                                    featchBlocById(context).add(
                                        FetchproudctyByIDDEvenet(proudctId: 0));
                                  })
                                ]),
                          )
                        ],
                      );
                    } else {
                      return const Center(
                        child: Text('there  is no state'),
                      );
                    }
                  },
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}

class Keyboard extends StatefulWidget {
  const Keyboard({
    super.key,
    required this.onTap,
  });

  final Function(String) onTap;

  @override
  State<Keyboard> createState() => _KeyboardState();
}

class _KeyboardState extends State<Keyboard> {
  List<String> keyname = [
    "تصفير",
    "9",
    "8",
    "7",
    "0",
    "6",
    "5",
    "4",
    "حذف",
    "3",
    "2",
    "1"
  ];

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: GridView.builder(
            itemCount: 12,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, childAspectRatio: 1.6),
            itemBuilder: (context, index) => InkWell(
                  onTap: () => widget.onTap(keyname[index]),
                  child: Container(
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: const Color(0xff374957)),
                    child: Center(
                        child: Text(keyname[index],
                            style: const TextStyle(
                              color: Colors.white,
                            ))),
                  ),
                )));
  }
}

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
