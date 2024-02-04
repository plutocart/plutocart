part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CreateTransaction extends TransactionEvent {
  final int statementType;
  final int transactionCategoryId;
  final int walletId;
  final double stmTransaction;
  final String dateTimeTransaction;
  final File? imageUrl;
  final String? desctiption;
  CreateTransaction(
      this.statementType,
      this.transactionCategoryId,
      this.walletId,
      this.stmTransaction,
      this.dateTimeTransaction,
      this.imageUrl,
      this.desctiption);
}
class CreateTransactionGoal extends TransactionEvent {
  final int walletId;
  final int goalIdGoal;
  final double stmTransaction;
  final String dateTimeTransaction;
  final File? imageUrl;
  final String? desctiption;
  CreateTransactionGoal(
      this.walletId,
      this.goalIdGoal,
      this.stmTransaction,
      this.dateTimeTransaction,
      this.imageUrl,
      this.desctiption);
}

class ResetTransactionStatus extends TransactionEvent {}

class ResetTransactionGoalStatus extends TransactionEvent {}

class GetTransactionDailyInEx extends TransactionEvent {}

class GetTransactionLimit3 extends TransactionEvent {}

  class ResetTransaction extends TransactionEvent {}

