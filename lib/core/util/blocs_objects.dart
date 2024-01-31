import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sonod_point_of_sell/manager/catagories_bloc/database_bloc.dart';
import 'package:sonod_point_of_sell/manager/fetch_proudct_by_id/fetch_proudect_by_id_bloc.dart';
import 'package:sonod_point_of_sell/manager/product_bloc/ui_bloc.dart';

var  featchBlocById=BlocProvider.of<FetchProudectByIdBloc>;

var  uiBloc=BlocProvider.of<UiBloc>;

var  productsBloc=BlocProvider.of<ProductsBloc>;