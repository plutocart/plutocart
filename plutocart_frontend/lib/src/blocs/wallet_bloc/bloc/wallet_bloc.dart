import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/repository/wallet_repository.dart';
part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super(WalletState()) {
    on<MapEventToState>((event, emit) {
      emit(state.copyWith(
          walletId: event.walletId,
          walletName: event.walletName,
          walletBalance: event.walletBalance));
    });

    on<DeleteWallet>((event, emit) async {
      try {
        print("accountId : ${event.accountId} : walletID : ${event.walletId}");
          await walletRepository().deleteWalletById(event.accountId, event.walletId);
          final List<Wallet> newListWallet = [...state.wallets];
          newListWallet.removeWhere((element) => element.walletId == event.walletId);
          emit(state.copyWith(wallets: newListWallet));
      } catch (error) {
        print("Error: $error");
        throw error;
      }
    });

    on<UpdateWallet>((event, emit) async {
      try {
        Wallet response = await walletRepository().updateWallet(
          event.accountId,
          event.walletId,
          event.walletName,
          event.walletBalance,
        );
        if (response.toString().isNotEmpty) {
           final List<Wallet> newListWallet = [...state.wallets];
          Wallet wallet = newListWallet.where((element) => element.walletId == event.walletId,).first;
          wallet = Wallet( walletId: wallet.walletId  , walletName: event.walletName, walletBalance: event.walletBalance);
          int index = newListWallet.indexWhere((element) => element.walletId == event.walletId);
          newListWallet.replaceRange(index, index+1, [wallet]);
          emit(state.copyWith(
              wallets: newListWallet
              ));
        } else {
          throw ArgumentError('Wallet update failed.');
        }
      } catch (error) {
        // Handle errors or re-throw if necessary
        print("Error: $error");
        throw error;
      }
    });

    on<UpdateStatusWallet>((event, emit) async {
      try {
        Wallet response = await walletRepository()
            .updateStatusWallet(event.accountId, event.walletId);

        if (response != null) {
          // emit(state.copyWith(
          //    walletStatus: ));
        } else {
          throw ArgumentError('Wallet update failed.');
        }
      } catch (error) {
        // Handle errors or re-throw if necessary
        print("Error: $error");
        throw error;
      }
    });

    on<GetWalletById>((event, emit) async {
      Wallet response = await walletRepository().getWalletById(event.accountId , event.walletId);
      if (response.walletName.isEmpty) {
        throw ArgumentError("Wallet not found");
      } else {
        emit(state.copyWith(
            walletName: response.walletName,
            walletBalance: response.walletBalance));
      }
    });

    on<GetAllWallet>((event, emit) async {
      List<dynamic> response =await walletRepository().getWalletAll(event.accountId);
      if (response.isEmpty) {
        throw ArgumentError("Wallet not found");
      } else {
        emit(state.copyWith(
            wallets: response.map((walletData) {
          return Wallet(
              walletId: walletData['walletId'],
              walletName: walletData['walletName'],
              statusWallet: walletData['statusWallet'],
              walletBalance: walletData['walletBalance']);
        }).toList()));
        // print(response);
      }
    });

      on<GetAllWalletOpenStatus>((event, emit) async {
      List<dynamic> response =await walletRepository().getWalletAll(event.accountId);
      if (response.isEmpty) {
        throw ArgumentError("Wallet not found");
      } else {
        emit(state.copyWith(
            wallets: response.map((walletData) {
          return Wallet(
              walletId: walletData['walletId'],
              walletName: walletData['walletName'],
              statusWallet: walletData['statusWallet'],
              walletBalance: walletData['walletBalance']);
        }).toList()));
        // print(response);
      }
    });

  }
}
