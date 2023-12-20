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
        print("imeis : nooooo");
        throw ArgumentError("please register a guest");
      } else {
        print("imeis : ${response.data.imei}");
        print("imeis : ${response.data.accountRole}");
        print("imeis : ${response.data.accountId}");
        emit(state.copyWith(
            imei: response.data.imei,
            accountRole: response.data.accountRole,
            accountId: response.data.accountId));
      }
    });
  }
}
