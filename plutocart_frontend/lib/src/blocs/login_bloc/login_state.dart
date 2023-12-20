part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String imei;
  final String accountRole;
  final int accountId;
  const LoginState({this.imei = "" , this.accountRole = "guest", this.accountId = 0});

  LoginState copyWith({String? imei , String? accountRole , int? accountId}) {
    return LoginState(
      imei: imei ?? this.imei,
      accountRole: accountRole ?? this.accountRole,
      accountId: accountId ?? this.accountId
    );
  }

  @override
  List<Object> get props => [imei , accountRole , accountId];
}
