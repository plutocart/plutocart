import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
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
          walletBalance: event.walletBalance,
          walletStatus: event.walletStatus));
    });

    on<OnIndexChanged>((event, emit) {
      emit(state.copyWith(currentColossalIndex: event.index));
    });

    on<CreateWallet>((event, emit) async {
      Map<String, dynamic> response = await walletRepository()
          .createWallet(event.accountId, event.walletName, event.walletBalance);
      Wallet wallet = new Wallet(
          accountId: event.accountId,
          walletBalance: event.walletBalance,
          walletName: event.walletName,
          statusWallet: 1);
      print("wallets 0 : ${wallet.statusWallet} ");
      if (response.isNotEmpty) {
        print("wallets 1");
        List<Wallet> responseWallet = [...state.wallets];
        print("wallets :  ${wallet.walletId}" );
        responseWallet.add(wallet);
        emit(state.copyWith(
            wallets: responseWallet));
      }
    });

    on<DeleteWallet>((event, emit) async {
      try {
        await walletRepository()
            .deleteWalletById(event.accountId, event.walletId);
        final List<Wallet> newListWallet = [...state.wallets];
        newListWallet
            .removeWhere((element) => element.walletId == event.walletId);
        emit(state.copyWith(
            wallets: newListWallet,));
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
          Wallet wallet = newListWallet
              .where(
                (element) => element.walletId == event.walletId,
              )
              .first;
          wallet = Wallet(
              walletId: wallet.walletId,
              walletName: event.walletName,
              walletBalance: event.walletBalance,
              statusWallet: wallet.statusWallet);
          int index = newListWallet.indexWhere((element) => element.walletId == event.walletId);
          print("index: ${index}");
          newListWallet.replaceRange(index, index + 1, [wallet]);

          emit(state.copyWith(wallets: newListWallet));
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
        final int index = state.currentColossalIndex == state.wallets.length
            ? state.currentColossalIndex - 1
            : state.currentColossalIndex;
        Wallet response = await walletRepository()
            .updateStatusWallet(event.accountId, event.walletId);
        List<Wallet> responseWallet = [...state.wallets];
        int indexWallet = responseWallet
            .indexWhere((element) => element.walletId == event.walletId);
        responseWallet.replaceRange(indexWallet, indexWallet + 1, [
          Wallet(
              walletName: responseWallet[indexWallet].walletName,
              walletBalance: responseWallet[indexWallet].walletBalance,
              statusWallet: event.walletStatus,
              walletId: event.walletId,
              accountId: event.accountId)
        ]);
        if (response != null) {
          emit(state.copyWith(
              wallets: responseWallet, currentColossalIndex: index));
        } else {
          throw ArgumentError('Wallet update failed.');
        }
      } catch (error) {
        // Handle errors or re-throw if necessary
        print("Error: $error");
        throw error;
      }
    });

    on<GetAllWallet>((event, emit) async {
      List<dynamic> response =
          await walletRepository().getWalletAll(event.accountId);
      if (response.isEmpty) {
        throw ArgumentError("Wallet not found");
      } else {
        if (event.enableOnlyStatusOnCard == true) {
          response.where((element) => element['statusWallet'] == 1).toList();
        }
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
      List<dynamic> response =
          await walletRepository().getWalletAllStatusOn(event.accountId);
      if (response.isEmpty) {
        return;
      } else {
        emit(state.copyWith(
            wallets: response.map((walletData) {
          return Wallet(
              walletId: walletData['walletId'],
              walletName: walletData['walletName'],
              statusWallet: walletData['statusWallet'],
              walletBalance: walletData['walletBalance']);
        }).toList()));
      }
    });
  }
}
