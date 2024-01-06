import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/blocs/transaction_category_bloc/bloc/transaction_category_bloc.dart';
import 'package:plutocart/src/models/transaction/transaction_model.dart';
import 'package:plutocart/src/repository/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState()) {
     on<ResetTransactionStatus>((event, emit) async {
      emit(state.copyWith(incomeStatus: TransactionStatus.loading , stmTransaction: 0.0));
    });

    on<CreateTransaction>((event, emit) async {
      print("start working create transaction income");
      try {
        Map<String, dynamic> response = await TransactionRepository()
            .createTransactionInCome(
                event.statementType,
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
              statementType: event.statementType,
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


     on<GetTransactionDailyIncome>((event, emit) async {
      print("start get transaction  income bloc");
       try{
        print("try transaction  bloc");
           Map<String , dynamic> response = await TransactionRepository().getTransactionDailyIncome(event.accountId , event.walletId);
           if(response.containsKey('data')){
           print("check data response in getTransaction bloc daily income : ${response['data']}"); 
           emit(state.copyWith(dailyIncome: response['data']['income']));
           print("after emit state in getTransaction daily income bloc income");
           print("check emit transaction  income list : ${state.dailyIncome}");
           }     
       }
       catch(e){
          print("error statar test");
       }
    });

    on<GetTransactionDailyExpense>((event, emit) async {
      print("start get transaction  expense bloc");
       try{
        print("try transaction expense bloc");
           Map<String , dynamic> response = await TransactionRepository().getTransactionDailyExpense(event.accountId , event.walletId);
           if(response.containsKey('data')){
           print("check data response in getTransaction bloc daily expense : ${response['data']}"); 
           emit(state.copyWith(dailyExpense: response['data']['expense']));
           print("after emit state in getTransaction daily expense bloc ");
           print("check emit transaction category expense list : ${state.dailyIncome}");
           }     
       }
       catch(e){
          print("error statar test");
       }
    });
  }
}
