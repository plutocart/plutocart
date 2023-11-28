part of 'wallet_bloc.dart';

abstract  class WalletEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllWallet extends WalletEvent {
  final int accountId;
  GetAllWallet(this.accountId);
 }


class GetWalletById extends WalletEvent{
  final int accountId;
  GetWalletById(this.accountId);
}

 
