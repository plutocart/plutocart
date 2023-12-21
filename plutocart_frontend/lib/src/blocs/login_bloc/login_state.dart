part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String imei;
  final String accountRole;
  final int accountId;
  final String userName;
  const LoginState({this.imei = "" , this.accountRole = "guest", this.accountId = 0 , this.userName = ""});

  LoginState copyWith({String? imei , String? accountRole , int? accountId , String? userName}) {
    return LoginState(
      imei: imei ?? this.imei,
      accountRole: accountRole ?? this.accountRole,
      accountId: accountId ?? this.accountId,
      userName: userName ?? this.userName,
    );
  }

  @override
  List<Object> get props => [imei , accountRole , accountId , userName];
}
