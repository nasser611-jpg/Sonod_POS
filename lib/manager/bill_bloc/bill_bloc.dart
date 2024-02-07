import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sonod_point_of_sell/Database/store_bill.dart';
import 'package:sonod_point_of_sell/Database/init_database.dart';
import 'package:sonod_point_of_sell/Database/fech_last_bill.dart';
import 'package:sonod_point_of_sell/core/util/formatted_proudct.dart';

part 'bill_event.dart';
part 'bill_state.dart';

class BillBloc extends Bloc<BillEvent, BillState> {
  BillBloc() : super(BillInitial()) {
    on<BillEvent>((event, emit) async {
      if (event is InsertBillEvent) {
        await insertBill(
            billDate: event.billDate,
            formattedProduct: event.formattedProduct,
            paid_amount: event.paidAmount,
            stayed_amount: event.stayedAmount,
            total: event.total);
      } 
      
      else if (event is FechBillHeaderEvent) {
          DbHelper dbO = DbHelper();
         await dbO.createDatabase();
  
       

        final int lastId = await lastBillId();
        final String lastDate = await  lastBillDate();
        emit(FechBillHeaderState( lastRequst: lastId,lastDate: lastDate));
      
      }
    });
  }
}
