part of 'transaction_category_bloc.dart';

abstract class TransactionCategoryEvent extends Equatable {
  @override
  List<Object> get props => [];

}

  class GetTransactionCategoryIncome extends TransactionCategoryEvent{
  }

 class GetTransactionCategoryExpense extends TransactionCategoryEvent{
  }

  class ResetTransactionCategory extends TransactionCategoryEvent {}