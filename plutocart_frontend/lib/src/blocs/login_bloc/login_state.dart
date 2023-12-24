part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String imei;
  final String accountRole;
  final int accountId;
  final String email;
  final bool hasAccountGuest;
  final bool hasAccountCustomer;
  const LoginState(
      {this.imei = "",
      this.accountRole = "guest",
      this.accountId = 0,
      this.email = "",
      this.hasAccountGuest = false,
      this.hasAccountCustomer = false});

  LoginState copyWith(
      {String? imei,
      String? accountRole,
      int? accountId,
      String? userName,
      String? email,
      bool? hasAccountGuest,
      bool? hasAccountCustomer}) {
    return LoginState(
        imei: imei ?? this.imei,
        accountRole: accountRole ?? this.accountRole,
        accountId: accountId ?? this.accountId,
        email: email ?? this.email,
        hasAccountCustomer: hasAccountCustomer ?? this.hasAccountCustomer,
        hasAccountGuest: hasAccountGuest ?? this.hasAccountCustomer);
  }

  @override
  List<Object> get props => [
        imei,
        accountRole,
        accountId,
        email,
        hasAccountGuest,
        hasAccountCustomer
      ];
}
