part of 'transaction_bloc.dart';

enum TransactionStatus { loading, loaded }

class TransactionState extends Equatable {
  final int id;
  final double stmTransaction;
  final String imageIconUrl;
  final int statementType;
  final DateTime? dateTransaction;
  final String description;
  final int tranCategoryIdCategory;
  final int goalId;
  final int walletId;
  final TransactionStatus incomeStatus;
  final TransactionStatus expenseStatus;
  final TransactionStatus goalStatus;
  final TransactionStatus debtStatus;
  final TransactionStatus deleteTransactionStatus;
  final List<dynamic> transactionsDailyInExList;
  final List<dynamic> transactionLimit3;
  final List<dynamic> transactionList;
  final TransactionStatus updateTransactionInEx;
  final TransactionStatus updateTransactionGoal;
  final TransactionStatus updateTransactionDebt;

  TransactionState(
      {this.id = 0,
      this.stmTransaction = 0.0,
      this.imageIconUrl = "",
      this.statementType = 0,
      DateTime? dateTransaction, // Nullable DateTime
      this.description = "",
      this.tranCategoryIdCategory = 1,
      this.walletId = 0,
      this.incomeStatus = TransactionStatus.loading,
      this.expenseStatus = TransactionStatus.loading,
      this.transactionsDailyInExList = const [],
      this.transactionLimit3 = const [],
      this.transactionList = const [],
      this.goalId = 0,
      this.goalStatus = TransactionStatus.loading,
      this.debtStatus = TransactionStatus.loading,
      this.deleteTransactionStatus = TransactionStatus.loading,
      this.updateTransactionInEx = TransactionStatus.loading,
      this.updateTransactionGoal = TransactionStatus.loading , this.updateTransactionDebt = TransactionStatus.loading})
      : dateTransaction = dateTransaction ?? DateTime.now();

  TransactionState copyWith(
      {int? id,
      double? stmTransaction,
      String? imageIconUrl,
      int? statementType,
      DateTime? dateTransaction,
      String? description,
      int? tranCategoryIdCategory,
      int? walletId,
      TransactionStatus? incomeStatus,
      TransactionStatus? expenseStatus,
      List<dynamic>? transactionsDailyInExList,
      List<dynamic>? transactionLimit3,
      List<dynamic>? transactionList,
      int? goalId,
      TransactionStatus? goalStatus,
      TransactionStatus? debtStatus,
      TransactionStatus? deleteTransactionStatus,
      TransactionStatus? updateTransactionInEx,
      TransactionStatus? updateTransactionGoal , TransactionStatus? updateTransactionDebt}) {
    return TransactionState(
        id: id ?? this.id,
        stmTransaction: stmTransaction ?? this.stmTransaction,
        imageIconUrl: imageIconUrl ?? this.imageIconUrl,
        statementType: statementType ?? this.statementType,
        dateTransaction: dateTransaction ?? this.dateTransaction,
        description: description ?? this.description,
        tranCategoryIdCategory:
            tranCategoryIdCategory ?? this.tranCategoryIdCategory,
        walletId: walletId ?? this.walletId,
        incomeStatus: incomeStatus ?? this.incomeStatus,
        expenseStatus: expenseStatus ?? this.expenseStatus,
        transactionsDailyInExList:
            transactionsDailyInExList ?? this.transactionsDailyInExList,
        transactionLimit3: transactionLimit3 ?? this.transactionLimit3,
        transactionList: transactionList ?? this.transactionList,
        goalId: goalId ?? this.goalId,
        goalStatus: goalStatus ?? this.goalStatus,
        debtStatus: debtStatus ?? this.debtStatus,
        deleteTransactionStatus:
            deleteTransactionStatus ?? this.deleteTransactionStatus,
        updateTransactionInEx:
            updateTransactionInEx ?? this.updateTransactionInEx,
        updateTransactionGoal:
            updateTransactionGoal ?? this.updateTransactionGoal , updateTransactionDebt: updateTransactionDebt ?? this.updateTransactionDebt);
  }

  @override
  List<Object> get props => [
        id,
        stmTransaction,
        imageIconUrl,
        statementType,
        dateTransaction!,
        description,
        tranCategoryIdCategory,
        walletId,
        incomeStatus,
        expenseStatus,
        transactionsDailyInExList,
        transactionList,
        transactionLimit3,
        goalId,
        goalStatus,
        debtStatus,
        deleteTransactionStatus,
        updateTransactionInEx,
        updateTransactionGoal , updateTransactionDebt
      ];
}
