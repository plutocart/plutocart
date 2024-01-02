part of 'transaction_category_bloc.dart';

class TransactionCategoryState extends Equatable {
  final int id;
  final String nameTransactionCategory;
  final String imageIconUrl;
  final List<dynamic> transactionCategoryInComeList;
  final List<dynamic> transactionCategoryExpenseList;

  const TransactionCategoryState(
      {this.id = 0,
      this.nameTransactionCategory = "",
      this.imageIconUrl = "",
      this.transactionCategoryInComeList = const [],
      this.transactionCategoryExpenseList = const []});

  TransactionCategoryState copyWith(
      {int? transactionCategoryId,
      String? nameTransactionCategory,
      String? imageIconUrl,
      List<dynamic>? transactionCategoryInComeList,
      List<dynamic>? transactionCategoryExpenseList}) {
    return TransactionCategoryState(
        id:
            transactionCategoryId ?? this.id,
        nameTransactionCategory:
            nameTransactionCategory ?? this.nameTransactionCategory,
        imageIconUrl: imageIconUrl ?? this.imageIconUrl,
        transactionCategoryExpenseList: transactionCategoryExpenseList ??
            this.transactionCategoryExpenseList,
        transactionCategoryInComeList: transactionCategoryInComeList ??
            this.transactionCategoryInComeList);
  }

  @override
  List<Object> get props => [
        id,
        nameTransactionCategory,
        imageIconUrl,
        transactionCategoryExpenseList,
        transactionCategoryInComeList
      ];
}
