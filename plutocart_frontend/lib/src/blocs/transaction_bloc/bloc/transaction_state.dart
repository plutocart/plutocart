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

  TransactionState({
    this.id = 0,
    this.stmTransaction = 0.0,
    this.imageIconUrl = "",
    this.statementType = 0,
    DateTime? dateTransaction, // Nullable DateTime
    this.description = "",
    this.tranCategoryIdCategory = 1, this.walletId = 0 , this.incomeStatus = TransactionStatus.loading
  }) : dateTransaction = dateTransaction ?? DateTime.now();

  TransactionState copyWith(
      {int? id,
      double? stmTransaction,
      String? imageIconUrl,
      int? statementType,
      DateTime? dateTransaction,
      String? description,
      int? tranCategoryIdCategory , int? walletId , TransactionStatus ?incomeStatus }) {
    return TransactionState(
        id: id ?? this.id,
        stmTransaction: stmTransaction ?? this.stmTransaction,
        imageIconUrl: imageIconUrl ?? this.imageIconUrl,
        statementType: statementType ?? this.statementType,
        dateTransaction: dateTransaction ?? this.dateTransaction,
        description: description ?? this.description,
        tranCategoryIdCategory:
            tranCategoryIdCategory ?? this.tranCategoryIdCategory , walletId: walletId ?? this.walletId , incomeStatus: incomeStatus ?? this.incomeStatus);
  }

  @override
  List<Object> get props => [
        id,
        stmTransaction,
        imageIconUrl,
        statementType,
        dateTransaction!,
        description,
        tranCategoryIdCategory , walletId , incomeStatus
      ];
}
