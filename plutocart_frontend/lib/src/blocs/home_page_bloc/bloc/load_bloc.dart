import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/repository/wallet_repository.dart';

part 'load_event.dart';
part 'load_state.dart';

class LoadBloc extends Bloc<loadEvent, LoadState> {
  LoadBloc() : super(LoadState()) {

    on<LoadingHomePage>((event, emit) async {
  try {
    emit(state.copyWith(isLoading: true));
    List<dynamic> response = await walletRepository().getWalletAll();
    if (response.isEmpty) {
      throw ArgumentError("Wallet not found");
    }
    emit(state.copyWith(
      isLoading: false,));
  } catch (error) {
    emit(state.copyWith(isLoading: false));
  }
});
  }
}
