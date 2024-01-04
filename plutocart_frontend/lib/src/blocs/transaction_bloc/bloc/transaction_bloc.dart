import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/models/transaction/transaction_model.dart';
import 'package:plutocart/src/repository/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState()) {
     on<resetIncomeStatus>((event, emit) async {
      emit(state.copyWith(incomeStatus: TransactionStatus.loading , stmTransaction: 0.0));
    });




    on<createTransactionIncome>((event, emit) async {
      print("start working create transaction income");
      try {
        Map<String, dynamic> response = await TransactionRepository()
            .createTransactionInCome(
                event.walletId,
                event.imageUrl,
                event.stmTransaction,
                event.dateTimeTransaction,
                event.desctiption,
                event.transactionCategoryId);
        if (response['data'] == null) {
          print(
              "not created transacton income in transaction bloc : ${response['data']}");
        } else {
          print("create transacton income in transaction bloc success");
          emit(state.copyWith(
              id: response['data']['id'],
              stmTransaction: response['data']['stmTransaction'],
              statementType: 1,
              description: response['data']['description'],
              walletId: response['data']['wid'],
              incomeStatus: TransactionStatus.loaded));
          print("after create income status is : ${state.incomeStatus}");
        }
      } catch (e) {
        emit(state.copyWith(incomeStatus: TransactionStatus.loading));
        print("Error creating transacton income in transaction bloc");
      }
    });
  }
}
