import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/models/wallet/wallet_model.dart';
import 'package:plutocart/src/repository/wallet_repository.dart';


part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  WalletBloc() : super( WalletState()) {

   on<UpdateWallet>((event, emit) async {
  try {
    Wallet response = await walletRepository().updateWallet(
      event.accountId,
      event.walletId,
      event.walletName,
      event.walletBalance,
    );
    
    if (response != null) {
       emit(state.copyWith(walletName: event.walletName, walletBalance: event.walletBalance));
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
