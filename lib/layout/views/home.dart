import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/core/util/blocs_objects.dart';
import 'package:sonod_point_of_sell/core/util/format_number.dart';
import 'package:sonod_point_of_sell/core/util/formatted_proudct.dart';
import 'package:sonod_point_of_sell/core/util/keyboard_opertion.dart';
import 'package:sonod_point_of_sell/core/util/trans_pdf.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/bill_header.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/bill_number.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/cart_item.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/categories.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/keyboard.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/optional_bar.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/page_header.dart';
import 'package:sonod_point_of_sell/layout/views/widgets/proudcts_items_widget.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';
import 'package:sonod_point_of_sell/manager/product_bloc/ui_bloc.dart';
import 'package:sonod_point_of_sell/model/prodect_model.dart' as model;
import 'package:sonod_point_of_sell/model/prodect_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ScrollController? controller = ScrollController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<UiBloc>(context).add(FeatchProductsEvent(classId: 1));

    featchBlocById(context).add(FetchproudctyByIDDEvenet(proudctId: 0));
  }

  double stayedAmount = 0;
  int selectedIndex = -1;
  @override
  Widget build(BuildContext context) {
    bool isSelected = false;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const PageHeader(),
          const BillHeader(),
          // page content
          Expanded(
              child: Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    const Categories(),
                    ProudctsItems(),
                    const OptionBar(),
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
                        // Check if product.price is not null before accessing it
                        if (product.price != null) {
                          double itemTotal = product.price!.toDouble();
                          total += itemTotal;
                        }
                      }

                      featchBlocById(context).total = total;
                      featchBlocById(context).formatProducts =
                          formattedProducts;
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
                                  const BillNumber(),
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
                                        "        الصنف",
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
                              itemCount: formattedProducts.length,
                              itemBuilder: (
                                context,
                                index,
                              ) {
                                return GestureDetector(
                                  onTap: () {
                                    final featchBloc = featchBlocById(context);

                                    if (isSelected) {
                                      featchBlocById(context).quantityEdited =
                                          0;
                                      featchBloc.proudctSelectedId = 0;
                                      featchBloc.clickedItem = false;
                                      featchBloc.add(FetchproudctyByIDDEvenet(
                                          proudctId: 0));
                                    } else {
                                      featchBloc.proudctSelectedId =
                                          formattedProducts[index].productId!;
                                      featchBloc.productName =
                                          formattedProducts[index].productName;
                                      featchBloc.clickedItem = true;
                                      featchBloc.index = index;
                                      featchBloc.add(FetchproudctyByIDDEvenet(
                                          proudctId: 0));
                                    }

                                    isSelected = !isSelected;
                                  },
                                  child: CartItem(
                                    isSelected: featchBlocById(context)
                                            .proudctSelectedId ==
                                        formattedProducts[index].productId,
                                    quantity: formattedProducts[index].count,
                                    proudctId:
                                        formattedProducts[index].productId ?? 1,
                                    count: index,
                                    proudctName: formattedProducts[index]
                                        .productName
                                        .toString(),
                                    price: formattedProducts[index].totalPrice,
                                    unit: formattedProducts[index]
                                        .unit
                                        .toString(),
                                  ),
                                );
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
                                          child: Text(formatWithCommas(total),
                                              style: const TextStyle(
                                                  color: Color(0xff374957),
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15)))
                                    ],
                                  ),
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
                                                  formatWithCommas(
                                                      featchBlocById(context)
                                                          .paidAmountController),
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
                                                  child: Text(
                                                      formatWithCommas(
                                                          featchBlocById(
                                                                  context)
                                                              .stayedAmount),
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
                                      keyboardOperions.onTapClear(
                                          context, state.prodcts);
                                    } else if (value == 'حذف') {
                                      keyboardOperions.onTapDelete(
                                          context, state.prodcts);
                                    } else {
                                      keyboardOperions.onTapNumber(
                                          context,
                                          state.prodcts,
                                          value,
                                          formattedProducts);
                                      if (featchBlocById(context).clickedItem ==
                                          false) {
                                        keyboardOperions
                                            .updateStayedAmount(context);
                                      }
                                    }
                                  }),
                                  TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PdfFourColumnExample(formattedproudct:formattedProducts,
                                                  paidAmount: featchBlocById(context).paidAmountController,
                                                  stayedAmount:featchBlocById(context).stayedAmount ,
                                                  totalAmount: total,
                                                  ),
                                            ));
                                      },
                                      child: Text('PDF'))
                                ]),
                          )
                        ],
                      );
                    } else if (state is CancelBillState) {
                      featchBlocById(context)
                          .formatProducts
                          // ignore: list_remove_unrelated_type
                          .remove(featchBlocById(context).formatProducts);
                    }
                    return const Center(
                      child: CircularProgressIndicator.adaptive(),
                    );
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
