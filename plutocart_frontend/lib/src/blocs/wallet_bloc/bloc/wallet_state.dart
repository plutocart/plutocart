part of 'wallet_bloc.dart';

 class WalletState extends Equatable {
  final String walletName;
  final double dailyExpense;
  final double dailyIncome;
  final double walletBalance;
  final int walletStatus;
  const WalletState(
      { this.walletName = "",
      this.dailyExpense = 0.0,
      this.dailyIncome = 0.0,
      this.walletBalance = 0.0,
      this.walletStatus = 0
      });
  WalletState copyWith(
      {String? walletName, double? dailyExpense, double? dailyIncome , double? walletBalance , int? walletStatus}) {
    return WalletState(
        walletName: walletName ?? this.walletName,
        dailyExpense: dailyExpense ?? this.dailyExpense,
        dailyIncome: dailyIncome ?? this.dailyIncome, 
        walletBalance: walletBalance?? this.walletBalance,
        walletStatus: walletStatus?? this.walletStatus);
  }

  List<WalletState> ListCopyWith(List<Wallet> wallets){
    List<WalletState> list = [];
    for(int i = 0; i < wallets.length; i++){
      list.add(WalletState(
          walletName: wallets[i].walletName,
          dailyExpense: 10.10,
          dailyIncome: 20.20,
          walletBalance: wallets[i].walletBalance,
          walletStatus: wallets[i].statusWallet));
    }
    return list;
  }


  @override
  List<Object> get props => [walletName, dailyExpense, dailyIncome , walletBalance , walletStatus];
}
