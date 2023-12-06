part of 'wallet_bloc.dart';

class WalletState extends Equatable {
  final String walletName;
  final double dailyExpense;
  final double dailyIncome;
  final double walletBalance;
  final int walletStatus;
  final List<Wallet> wallets;
  final int walletId;
  final int currentColossalIndex;
  const WalletState(
      {this.walletName = "",
      this.dailyExpense = 0.0,
      this.dailyIncome = 0.0,
      this.walletBalance = 0.0,
      this.walletStatus = 1,
      this.wallets = const [],
      this.walletId = 1 , 
      this.currentColossalIndex = 0});

  WalletState copyWith(
      {String? walletName,
      double? dailyExpense,
      double? dailyIncome,
      double? walletBalance,
      int? walletStatus,
      bool? hightPopupActive,
      List<Wallet>? wallets ,
      int? walletId , int? currentColossalIndex}) {
    return WalletState(
        walletName: walletName ?? this.walletName,
        dailyExpense: dailyExpense ?? this.dailyExpense,
        dailyIncome: dailyIncome ?? this.dailyIncome,
        walletBalance: walletBalance ?? this.walletBalance,
        walletStatus: walletStatus ?? this.walletStatus,
        wallets: wallets ?? this.wallets,
        walletId: walletId?? this.walletId , 
        currentColossalIndex: currentColossalIndex ?? this.currentColossalIndex );
  }


  @override
  List<Object> get props =>
      [walletName, dailyExpense, dailyIncome, walletBalance, walletStatus , wallets , walletId , currentColossalIndex];
}
