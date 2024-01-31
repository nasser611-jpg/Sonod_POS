import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'refresh_price_event.dart';
part 'refresh_price_state.dart';

class RefreshPriceBloc extends Bloc<RefreshPriceEvent, RefreshPriceState> {
  RefreshPriceBloc() : super(RefreshPriceInitial()) {
    on<RefreshPriceEvent>((event, emit) {
    if(event is  RefreshStayedAmountEvent){
      emit(RefreshStayedAmountState());
    }
    });
  }
}
