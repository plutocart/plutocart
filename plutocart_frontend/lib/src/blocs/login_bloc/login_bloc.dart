import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
        print("imeis !! : ${response.data.imei}");
        print("account role !! : ${response.data.accountRole}");
        print("account id !! : ${response.data.accountId}");
        emit(state.copyWith(
            imei: response.data.imei,
            accountRole: response.data.accountRole,
            accountId: response.data.accountId));
      }
    });

    on<createAccountGuest>((event, emit) async {
      print("Start create account");
      Map<String, dynamic> response = await LoginRespository().createAccountGuest(event.userName);
       print("Start create account2");
      if (response.isEmpty) {
         print("Start create account3");
        print("Nooooooo!");
        throw ArgumentError("haven't number imei");
      } else {
        print("imeisS !! : ${response['data']['imei']}");
        print("imeisS !! : ${response['data']['accountRole']}");
        print("imeisS !! : ${response['data']['accountId']}");

        emit(state.copyWith(
            userName: event.userName, accountId: response['data']['accountId']));
      }
    });
  }
}
