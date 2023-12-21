part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];

}

  class loginGuest extends LoginEvent{
  }

  class createAccountGuest extends LoginEvent{
    final String userName;
    createAccountGuest(this.userName);
  }
