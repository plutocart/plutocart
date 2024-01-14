part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginGuest extends LoginEvent {}

class LoginMember extends LoginEvent {}

class loginEmailGoole extends LoginEvent {}

class CreateAccountGuest extends LoginEvent {}

class CreateAccountMember extends LoginEvent {}

class LogOutAccountMember extends LoginEvent {}

class ResetLogin extends LoginEvent {}

class DeleteAccount extends LoginEvent {}
