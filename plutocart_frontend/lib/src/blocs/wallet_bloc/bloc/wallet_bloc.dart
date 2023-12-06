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
          walletBalance: event.walletBalance));
    });

    on<OnIndexChanged>((event, emit) {
      emit(state.copyWith(currentColossalIndex: event.index));
    });

    on<CreateWallet>((event, emit) async {
      print("wallets 9999");
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
        responseWallet.add(wallet);
        final List<Wallet> newListWallet = responseWallet.map((e) {
          return Wallet(
              walletId: e.walletId,
              walletName: e.walletName,
              statusWallet: e.statusWallet,
              walletBalance: e.walletBalance);
        }).toList();
        print("wallets 3");
        emit(state.copyWith(wallets: newListWallet));
        print("wallets 4 : ${newListWallet.length}");
      }
    });

    on<DeleteWallet>((event, emit) async {
      try {
        final int index = state.currentColossalIndex == state.wallets.length
            ? 0
            : state.currentColossalIndex ;
        print("accountId : ${event.accountId} : walletID : ${event.walletId}");
        await walletRepository()
            .deleteWalletById(event.accountId, event.walletId);
        final List<Wallet> newListWallet = [...state.wallets];
        newListWallet
            .removeWhere((element) => element.walletId == event.walletId);
        emit(state.copyWith(
            wallets: newListWallet, currentColossalIndex: index));
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
          int index = newListWallet
              .indexWhere((element) => element.walletId == event.walletId);
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
        Wallet response = await walletRepository()
            .updateStatusWallet(event.accountId, event.walletId);
        List<dynamic> responseWallet =
            await walletRepository().getWalletAll(event.accountId);
        responseWallet
            .where((element) => element['statusWallet'] == 1)
            .toList();
        if (response != null) {
          final List<Wallet> newListWallet = responseWallet.map((e) {
            return Wallet(
              walletId: e['walletId'],
              walletName: e['walletName'],
              statusWallet: e['statusWallet'],
              walletBalance: e['walletBalance'],
            );
          }).toList();
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
