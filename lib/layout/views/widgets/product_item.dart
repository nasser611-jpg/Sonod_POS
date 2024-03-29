import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sonod_point_of_sell/Database/store_bill.dart';
import 'package:sonod_point_of_sell/core/util/blocs_objects.dart';
import 'package:sonod_point_of_sell/core/util/format_number.dart';
import 'package:sonod_point_of_sell/core/util/show_message.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';
import 'package:sonod_point_of_sell/manager/product_bloc/ui_bloc.dart';

class ProductItem extends StatefulWidget {
  final String productName;
  final double price;
  final int productId;
  final bool isFavorate;
  const ProductItem({
    Key? key,
    required this.productName,
    required this.price,
    required this.productId,
    required this.isFavorate,
  }) : super(key: key);

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorate;
  }

  Future<int> isFavorite() async {
    return getIsFavorite(widget.productId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int>(
      future: isFavorite(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator(); // Or any loading indicator
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return InkWell(
            onTap: () {
              featchBlocById(context).add(
                FetchproudctyByIDDEvenet(proudctId: widget.productId),
              );
            },
            onLongPress: () {
              setState(() {
                _isFavorite = !_isFavorite;

                BlocProvider.of<UiBloc>(context).add(
                  AddFavoriteProductEvent(
                    productID: widget.productId,
                    isFavroite: _isFavorite ? 1 : 0,
                  ),
                );

                showMessage(
                    context,
                    _isFavorite
                        ? 'تم الاضافة لمفضلتي'
                        : 'تم  الازاله من المفضله!');
              });
            },
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: ShapeDecoration(
                gradient: const RadialGradient(
                  center: Alignment(0, -1),
                  colors: [Color(0xFFF04D37), Color(0xFFF06837)],
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              child: GestureDetector(
                onTap: () {
                  featchBlocById(context).add(
                    FetchproudctyByIDDEvenet(proudctId: widget.productId),
                  );
                },
                child: BlocBuilder<UiBloc, UiState>(
                  builder: (context, state) {
                    return Stack(
                      children: [
                       snapshot.data==1
                            ? Padding(
                                padding: const EdgeInsets.all(4),
                                child: SvgPicture.asset(
                                  'assets/icons/star.svg',
                                  // ignore: deprecated_member_use
                                  color: Colors.white,
                                  width: 16,
                                ),
                              )
                            : const SizedBox(),
                        Column(
                          children: [
                            Expanded(
                              child: Center(
                                child: Text(
                                  widget.productName,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            Container(
                              height: 24,
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 6),
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
                              child: Center(
                                child: Text(
                                  formatWithCommas(widget.price),
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xff374957),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
