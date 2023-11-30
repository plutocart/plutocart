part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetAllWallet extends WalletEvent {
  final int accountId;
  GetAllWallet(this.accountId);
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

class MapEventToState extends WalletEvent {
  final int? walletId;
  final String? walletName;
  final double? walletBalance;
  MapEventToState(this.walletId, this.walletName, this.walletBalance);
}

class GetWalletById extends WalletEvent {
  final int accountId;
  GetWalletById(this.accountId);
}
