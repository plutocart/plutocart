import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/repository/wallet_repository.dart';


part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super( WalletState()) {

    on<getAllWallet>((event, emit) async {
       List<Wallet> response = await walletRepository().getWalletAll(event.accountId);
      if(response.isEmpty) {
       throw new ArgumentError();
      }
      else {
          //  emit(state.copyWith(wallets: response));
      }

    });

    on<getWalletById>((event, emit) async {
       Wallet response = await walletRepository().getWalletById(event.accountId);
      if(response.walletName.isEmpty) {
        emit(state.copyWith(walletName: "error" ));
      }
      else {
          emit(state.copyWith(walletName: response.walletName , walletBalance: response.walletBalance));
      }
  
    });
 

  }
}
