import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plutocart/src/repository/login_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginState()) {


    on<LoginGuest>((event, emit) async {
      Map<String, dynamic> response = await LoginRepository().loginGuest();
      print("bloc id account : ${response['data']['accountId']}");
      if (response['data']['imei'] == "") {
        throw ArgumentError("please register a guest");
      } else {
        emit(state.copyWith(
            imei: response['data']['imei'],
            accountRole: response['data']['accountRole'],
            accountId: response['data']['accountId']));
      }
    });

    on<CreateAccountGuest>((event, emit) async {
      try {
        Map<String, dynamic> response =
            await LoginRepository().createAccountGuest();

        if (response.isEmpty ||
            response['data'] == null ||
            response['data']['accountId'] == null) {
        } else {
          emit(state.copyWith(
            accountId: response['data']['accountId'],
          ));
        }
      } catch (e) {}
    });

    on<CreateAccountCustomer>((event, emit) async {
      try {
        Map<String, dynamic> response =
            await LoginRepository().createAccountCustomer();
        print("starto1 : ${response['data']['email']}");
        print("starto1 : ${response['data']['imei']}");
        if (response.isEmpty) {
            emit(state.copyWith(hasAccountCustomer: false));
        } else {
          emit(state.copyWith(
            accountId: response['data']['accountId'],
            email: response['data']['email'],
            imei: response['data']['imei'],
            hasAccountCustomer: true,
          ));
        }
      } catch (error) {
        print('Error during account creation: $error');
      }
    });

   on<LoginCustomer>((event, emit) async {
  try {
    print("login customer : ");
    Map<String, dynamic> response = await LoginRepository().loginCustomer();
    if (response.containsKey('data') &&
        response['data'] != null &&
        response['data']['imei'] != null &&
        response['data']['email'] != null &&
        response['data']['imei'] != "" &&
        response['data']['email'] != "") {
      emit(state.copyWith(
        imei: response['data']['imei'],
        email: response['data']['email'],
        accountRole: response['data']['accountRole'],
        accountId: response['data']['accountId'],
      ));
    } else {
      throw ArgumentError("Please register as a guest.");
    }
  } catch (error) {
    print('Error during login: $error');
  }
});

  }
}
