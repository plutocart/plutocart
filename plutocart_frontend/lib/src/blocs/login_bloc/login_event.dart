part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object> get props => [];

}

  class LoginGuest extends LoginEvent{
  }
 class LoginCustomer extends LoginEvent{
  }

class loginEmailGoole extends LoginEvent{
  
}
  class CreateAccountGuest extends LoginEvent{
  }

  class CreateAccountCustomer extends LoginEvent{
  }



  
