part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String imei;
  final String accountRole;
  final int accountId;
  final String userName;
  final String email;
  const LoginState({this.imei = "" , this.accountRole = "guest", this.accountId = 0 , this.userName = "" , this.email = ""});

  LoginState copyWith({String? imei , String? accountRole , int? accountId , String? userName , String? email}) {
    return LoginState(
      imei: imei ?? this.imei,
      accountRole: accountRole ?? this.accountRole,
      accountId: accountId ?? this.accountId,
      userName: userName ?? this.userName,
      email: email ?? this.email,
    );
  }

  @override
  List<Object> get props => [imei , accountRole , accountId , userName , email];
}
