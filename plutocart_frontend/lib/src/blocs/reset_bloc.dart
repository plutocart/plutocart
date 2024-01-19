import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/login_bloc/login_bloc.dart';
import 'package:plutocart/src/blocs/page_bloc/page_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/transaction_category_bloc/bloc/transaction_category_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';

// BlocWallet
class ResetWalletState extends WalletEvent {}

class BlocWallet extends Bloc<WalletEvent, WalletState> {
  BlocWallet() : super(WalletState());

  @override
  Stream<WalletState> mapEventToState(WalletEvent event) async* {
    if (event is ResetWalletState) {
      // Clear or reset data within the state
      yield WalletState(); // Replace with your actual initial state
    }
  }

  void reset() {
    add(ResetWalletState());
  }
}

class ResetTransactionState extends TransactionEvent {}

// BlocTransaction
class BlocTransaction extends Bloc<TransactionEvent, TransactionState> {
  BlocTransaction() : super(TransactionState());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if (event is ResetTransactionState) {
      // Clear or reset data within the state
      yield TransactionState(); // Replace with your actual initial state
    }
  }

  void reset() {
    add(ResetTransactionState());
  }
}

// BlocTransactionCategory
class ResetTransactionCategoryState extends TransactionCategoryEvent {}

class BlocTransactionCategory
    extends Bloc<TransactionCategoryEvent, TransactionCategoryState> {
  BlocTransactionCategory() : super(TransactionCategoryState());

  @override
  Stream<TransactionCategoryState> mapEventToState(
      TransactionCategoryEvent event) async* {
    if (event is ResetTransactionCategoryState) {
      // Clear or reset data within the state
      yield TransactionCategoryState(); // Replace with your actual initial state
    }
  }

  void reset() {
    add(ResetTransactionCategoryState());
  }
}

// BlocLogin
class ResetLoginState extends LoginEvent {}

class BlocLogin extends Bloc<LoginEvent, LoginState> {
  BlocLogin() : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is ResetLoginState) {
      print('Before reset: $state');
      yield LoginState(); // Replace with your actual initial state
      print('After reset: $state');
    }
  }

  void reset() {
    add(ResetLoginState());
  }
}



// BlocPage

class ResetPageSate extends PageEvent {}

class BlocPage
    extends Bloc<PageEvent, PageState> {
  BlocPage() : super(PageState());

  @override
  Stream<PageState> mapEventToState(
      PageEvent event) async* {
    if (event is ResetPageSate) {
      // Clear or reset data within the state
      yield PageState(); // Replace with your actual initial state
    }
  }

  void reset() {
    add(ResetPageSate());
  }
}
