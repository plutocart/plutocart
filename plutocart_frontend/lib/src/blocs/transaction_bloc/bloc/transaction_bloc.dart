import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/models/transaction/transaction_model.dart';
import 'package:plutocart/src/repository/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState()) {
   
     on<createTransactionIncome>((event, emit) async {
      print("start working create transaction income");
      try {
        Map<String, dynamic> response =
            await TransactionRepository().createTransactionInCome(event.walletId , event.imageUrl , event.stmTransaction , event.desctiption , event.transactionCategoryId);
        if (response['data'] == null) {
          print(
              "not created transacton income in transaction bloc : ${response['data']}");
        } else {
          print("create transacton income in transaction bloc success");
          emit(state.copyWith(
              id: response['data']['id'],
              stmTransaction: response['data']['stmTransaction'],
              statementType: 1,
              description: response['data']['description'], walletId: response['data']['wid']));
        }
      } catch (e) {
        print("Error creating transacton income in transaction bloc");
      }
    });
  }
}
