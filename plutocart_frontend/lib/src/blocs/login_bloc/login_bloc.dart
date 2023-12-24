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
         Map<String, dynamic> response = await LoginRespository().loginGuest();
      print("bloc id account : ${response['data']['accountId']}");
      if (response['data']['imei'] == "") {
        throw ArgumentError("please register a guest");
      } else {
        emit(state.copyWith(
            imei: response['data']['imei'],
            accountRole:response['data']['accountRole'],
            accountId: response['data']['accountId']));
      }
    });

    on<createAccountGuest>((event, emit) async {
      Map<String, dynamic> response = await LoginRespository().createAccountGuest();
      if (response.isEmpty) {
        throw ArgumentError("not create account guest");
      } else {
        emit(state.copyWith(
             accountId: response['data']['accountId']));
      }
    });

     on<createAccountCustomer>((event, emit) async {
  try {
    Map<String, dynamic> response = await LoginRespository().createAccountCustomer();
    print("starto1 : ${response['data']['email']}");
      print("starto1 : ${response['data']['imei']}");
    if (response.isEmpty) {
      throw ArgumentError("not create account customer");
    } else {
      emit(state.copyWith(
        accountId: response['data']['accountId'],
        email: response['data']['email'],
        imei: response['data']['imei'],
        hasAccountCustomer: true
      ));
      print("starto1 : ${LoginState().email}");
    }
  } catch (error) {
    // Handle the error here
    print('Error during account creation: $error');
  }
});


  on<loginCustomer>((event, emit) async {
  Map<String, dynamic> response = await LoginRespository().loginCustomer();
  if (response['data'] == null ||
      response['data']['imei'] == null ||
      response['data']['email'] == null ||
      response['data']['imei'] == "" ||
      response['data']['email'] == "") {
    throw ArgumentError("Please register as a guest.");
  } else {
    emit(state.copyWith(
      imei: response['data']['imei'],
      email: response['data']['email'],
      accountRole: response['data']['accountRole'],
      accountId: response['data']['accountId'],
    ));
  }
});

  }
}
