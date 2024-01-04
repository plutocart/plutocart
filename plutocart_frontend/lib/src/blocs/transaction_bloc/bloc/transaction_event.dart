part of 'transaction_bloc.dart';

abstract class TransactionEvent extends Equatable {
  @override
  List<Object> get props => [];
}

 class createTransactionIncome extends TransactionEvent{
   final int transactionCategoryId;
   final int walletId;
   final double stmTransaction;
   final String dateTimeTransaction;
   final File? imageUrl;
   final String? desctiption;
   createTransactionIncome(this.transactionCategoryId , this.walletId , this.stmTransaction  , this.dateTimeTransaction , this.imageUrl , this.desctiption);
  }

  class resetIncomeStatus extends TransactionEvent{

  }

