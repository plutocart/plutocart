part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String imei;
  final String accountRole;
  final int accountId;
  final String email;
  final bool hasAccountGuest;
  final bool hasAccountCustomer;
  final bool signUpCustomerSuccess;
  final bool signUpGuestSuccess;
  final bool signInGuestSuccess;
  final bool statusLoginGoogle;
  const LoginState(
      {this.imei = "",
      this.accountRole = "guest",
      this.accountId = 0,
      this.email = "",
      this.hasAccountGuest = false,
      this.hasAccountCustomer = false,
      this.signUpCustomerSuccess = false,
      this.signUpGuestSuccess = false,
      this.statusLoginGoogle = true,
      this.signInGuestSuccess = true});

  LoginState copyWith(
      {String? imei,
      String? accountRole,
      int? accountId,
      String? email,
      bool? hasAccountGuest,
      bool? hasAccountCustomer,
      bool? signUpCustomerSuccess,
      bool? signUpGuestSuccess,
      bool? statusLoginGoogle,
      bool? signInGuestSuccess }) {
    return LoginState(
        imei: imei ?? this.imei,
        accountRole: accountRole ?? this.accountRole,
        accountId: accountId ?? this.accountId,
        email: email ?? this.email,
        hasAccountGuest: hasAccountGuest ?? this.hasAccountGuest,
        hasAccountCustomer: hasAccountCustomer ?? this.hasAccountCustomer,
        signUpCustomerSuccess:
            signUpCustomerSuccess ?? this.signUpCustomerSuccess,
        signUpGuestSuccess: signUpGuestSuccess ?? this.signUpGuestSuccess,
        statusLoginGoogle: statusLoginGoogle ?? this.statusLoginGoogle,
        signInGuestSuccess: signInGuestSuccess ?? this.signInGuestSuccess);
  }

  @override
  List<Object> get props => [
        imei,
        accountRole,
        accountId,
        email,
        hasAccountGuest,
        hasAccountCustomer,
        signUpCustomerSuccess,
        signUpGuestSuccess,
        statusLoginGoogle,
        signInGuestSuccess
      ];
}
