import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/repository/transaction_repository.dart';

part 'transaction_event.dart';
part 'transaction_state.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  TransactionBloc() : super(TransactionState()) {
    on<ResetTransactionStatus>((event, emit) async {
      emit(state.copyWith(
          incomeStatus: TransactionStatus.loading, stmTransaction: 0.0));
    });

        on<ResetTransactionGoalStatus>((event, emit) async {
      emit(state.copyWith(
          goalStatus: TransactionStatus.loading, stmTransaction: 0.0));
    });


    on<ResetTransaction>((event, emit) {
      emit(TransactionState()); // Reset the state to the initial state
    });

    on<GetTransactionDailyInEx>(
      (event, emit) async {
        List<dynamic> response =
            await TransactionRepository().getTransactionDailyInEx();
        print("Start get transaction daily in ex");
        try {
          if (response.length > 0 && response.isNotEmpty) {
            emit(state.copyWith(transactionsDailyInExList: response));
            print(
                "state.transactionsDailyInExList : ${state.transactionsDailyInExList}");
          }
        } catch (e) {
          print("Error state.transactionsDailyInExList");
        }
      },
    );

    on<GetTransactionLimit3>(
      (event, emit) async {
        List<dynamic> response =
            await TransactionRepository().getTransactionlimit3();
        print("Start get transaction limit 3");
        try {
          emit(state.copyWith(transactionLimit3: response));
          print(
              "state.transactionsLimit3 : ${state.transactionLimit3[0].walletName}");
        } catch (e) {
          print("Error state.transactionsLimit3");
        }
      },
    );

        on<GetTransactionList>(
      (event, emit) async {
        List<dynamic> response =
            await TransactionRepository().getTransactionByAccountId();
        print("Start get transaction by account id");
        try {
          emit(state.copyWith(transactionList: response));
          print(
              "state.transactionsList : ${state.transactionList[0]}");
        } catch (e) {
          print("Error state.transactionList");
        }
      },
    );


    on<CreateTransaction>((event, emit) async {
      print("start working create transaction income");
      try {
        Map<String, dynamic> response = await TransactionRepository()
            .createTransaction(
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

    on<CreateTransactionGoal>((event, emit) async {
      print("start working create transaction goal");
      try {
        Map<String, dynamic> response =
            await TransactionRepository().createTransactionGoal(
          event.walletId,
          event.imageUrl,
          event.stmTransaction,
          event.dateTimeTransaction,
          event.desctiption,
          event.goalIdGoal,
        );
        if (response['data'] == null) {
          print(
              "not created transacton goal in transaction bloc : ${response['data']}");
        } else {
          print("create transacton goal in transaction bloc success");
          emit(state.copyWith(
              id: response['data']['id'],

              stmTransaction: response['data']['stmTransaction'],
              description: response['data']['description'],
              walletId: response['data']['wid'],
              goalId: response['data']['goalId'],
              goalStatus: TransactionStatus.loaded));
          print("after create income status is : ${state.incomeStatus}");
        }
      } catch (e) {
        emit(state.copyWith(incomeStatus: TransactionStatus.loading));
        print("Error creating transacton income in transaction bloc");
      }
    });
  }
}
