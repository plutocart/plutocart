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
  final int walletId;
  final TransactionStatus incomeStatus;
  final TransactionStatus expenseStatus;
  final double dailyIncome;
  final double dailyExpense;

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
      this.dailyExpense = 0.0,
      this.dailyIncome = 0.0})
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
      double? dailyIncome,
      double? dailyExpense}) {
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
        dailyIncome: dailyIncome ?? this.dailyIncome , dailyExpense:  dailyExpense ?? this.dailyExpense);
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
        expenseStatus , dailyIncome , dailyExpense
      ];
}
