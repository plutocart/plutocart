part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class MapEventToState extends WalletEvent {
  final int? walletId;
  final String? walletName;
  final double? walletBalance;
  MapEventToState(this.walletId, this.walletName, this.walletBalance);
}

class GetAllWallet extends WalletEvent {
  final int accountId;
  GetAllWallet(this.accountId);
}
class GetAllWalletOpenStatus extends WalletEvent {
  final int accountId;
  GetAllWalletOpenStatus(this.accountId);
}
class GetWalletById extends WalletEvent {
  final int accountId;
  final int walletId;
  GetWalletById(this.accountId , this.walletId);
}

class UpdateWallet extends WalletEvent {
  final int accountId;
  final int walletId;
  final String walletName;
  final double walletBalance;
  UpdateWallet(
      this.accountId, this.walletId, this.walletName, this.walletBalance);
}

class UpdateStatusWallet extends WalletEvent {
  final int accountId;
  final int walletId;
  UpdateStatusWallet(this.accountId, this.walletId);
}

class DeleteWallet extends WalletEvent {
  final int accountId;
  final int walletId;
  DeleteWallet(this.accountId, this.walletId);
}


