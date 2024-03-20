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

class CreateTransactionDebt extends TransactionEvent {
  final int walletId;
  final int debtIdDebt;
  final double stmTransaction;
  final String dateTimeTransaction;
  final File? imageUrl;
  final String? desctiption;
  CreateTransactionDebt(
      this.walletId,
      this.debtIdDebt,
      this.stmTransaction,
      this.dateTimeTransaction,
      this.imageUrl,
      this.desctiption);
}

class DeleteTransaction extends TransactionEvent {
  final int transactionId;
  final int walletId;
  DeleteTransaction(this.transactionId, this.walletId);
}

class ResetTransactionStatus extends TransactionEvent {}

class ResetTransactionGoalStatus extends TransactionEvent {}
class ResetTransactionDebtStatus extends TransactionEvent {}

class GetTransactionDailyInEx extends TransactionEvent {}

class GetTransactionLimit3 extends TransactionEvent {}

class ResetTransaction extends TransactionEvent {}

class StatusLoadTransactionList extends TransactionEvent {}

class ResetTransactionList extends TransactionEvent {}

class UpdateFilterStatus extends TransactionEvent {
   final int walletId ;
   final int? month ;
   final int? year ;
   UpdateFilterStatus(this.walletId, this.month, this.year);
}

class GetTransactionList extends TransactionEvent {
   final int walletId ;
   final int? month ;
   final int? year ;
   GetTransactionList(this.walletId, this.month, this.year);
}

class UpdateTransactionInEx extends TransactionEvent {
   final int statementType;
  final int transactionCategoryId;
  final int walletId;
  final double stmTransaction;
  final String dateTimeTransaction;
  final File? imageUrl;
  final String? description;
  final int transactionId;
  UpdateTransactionInEx(
      this.statementType,
      this.transactionCategoryId,
      this.walletId,
      this.stmTransaction,
      this.dateTimeTransaction,
      this.imageUrl,
      this.description , this.transactionId);
}

class ResetUpdateTransactionInEx extends TransactionEvent {}


class UpdateTransactionGoal extends TransactionEvent {
  final int goalId;
   final int statementType;
  final int transactionCategoryId;
  final int walletId;
  final double stmTransaction;
  final String dateTimeTransaction;
  final File? imageUrl;
  final String? description;
  final int transactionId;
  UpdateTransactionGoal(
      this.goalId,
      this.statementType,
      this.transactionCategoryId,
      this.walletId,
      this.stmTransaction,
      this.dateTimeTransaction,
      this.imageUrl,
      this.description , this.transactionId);
}

class ResetUpdateTransactionGoal extends TransactionEvent {}


class UpdateTransactionDebt extends TransactionEvent {
  final int debtId;
   final int statementType;
  final int transactionCategoryId;
  final int walletId;
  final double stmTransaction;
  final String dateTimeTransaction;
  final File? imageUrl;
  final String? description;
  final int transactionId;
  UpdateTransactionDebt(
      this.debtId,
      this.statementType,
      this.transactionCategoryId,
      this.walletId,
      this.stmTransaction,
      this.dateTimeTransaction,
      this.imageUrl,
      this.description , this.transactionId);
}

class ResetUpdateTransactionDebt extends TransactionEvent {}
