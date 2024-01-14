part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class MapEventToState extends WalletEvent {
  final int? walletId;
  final String? walletName;
  final double? walletBalance;
  final int? walletStatus;
  MapEventToState(this.walletId, this.walletName, this.walletBalance, this.walletStatus);
}

// ignore: must_be_immutable
class GetAllWallet extends WalletEvent {
  bool? enableOnlyStatusOnCard = false;
  GetAllWallet({this.enableOnlyStatusOnCard});
}
class GetAllWalletOpenStatus extends WalletEvent {
  GetAllWalletOpenStatus();
}
class GetWalletById extends WalletEvent {
  final int walletId;
  GetWalletById( this.walletId);
}

class UpdateWallet extends WalletEvent {
  final int walletId;
  final String walletName;
  final double walletBalance;
  UpdateWallet(
       this.walletId, this.walletName, this.walletBalance);
}

class UpdateStatusWallet extends WalletEvent {
  final int walletId;
  final int walletStatus;
  UpdateStatusWallet( this.walletId, this.walletStatus);
}

class DeleteWallet extends WalletEvent {
  final int walletId;
  DeleteWallet(this.walletId);
}
class CreateWallet extends WalletEvent {
  final String walletName;
  final double walletBalance;
  CreateWallet(this.walletName, this.walletBalance);
}

class OnIndexChanged extends WalletEvent {
  final int index;
  OnIndexChanged(this.index);
}

class ResetWallet extends WalletEvent {}



