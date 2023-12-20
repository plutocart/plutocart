import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/repository/wallet_repository.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageBlocEvent, HomePageState> {


  HomePageBloc() : super(HomePageState()) {

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
