import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/models/login/login_model.dart';
import 'package:plutocart/src/repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {
    on<loginGuest>((event, emit) async {
      Login response = await LoginRespository().loginGuest();
      if (response.data.imei == "") {
        throw ArgumentError("please register a guest");
      } else {
        emit(state.copyWith(
            imei: response.data.imei,
            accountRole: response.data.accountRole,
            accountId: response.data.accountId));
      }
    });

    on<createAccountGuest>((event, emit) async {
      Map<String, dynamic> response = await LoginRespository().createAccountGuest();
      if (response.isEmpty) {
        throw ArgumentError("haven't number imei");
      } else {
        emit(state.copyWith(
             accountId: response['data']['accountId']));
      }
    });
  }
}
