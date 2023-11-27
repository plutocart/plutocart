part of 'wallet_bloc.dart';

abstract  class WalletEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class getAllWallet extends WalletEvent {
  final int accountId;
  getAllWallet(this.accountId);
 }


class getWalletById extends WalletEvent{
  final int accountId;
  getWalletById(this.accountId);
}

 
