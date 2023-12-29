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
  final bool signInCustomerSuccess;
  final bool signInGoogleStatus;
  const LoginState(
      {this.imei = "",
      this.accountRole = "guest",
      this.accountId = 0,
      this.email = "",
      this.hasAccountGuest = false,
      this.hasAccountCustomer = false,
      this.signUpCustomerSuccess = false,
      this.signUpGuestSuccess = false,
      this.signInCustomerSuccess = true,
      this.signInGuestSuccess = true , this.signInGoogleStatus = true});

  LoginState copyWith(
      {String? imei,
      String? accountRole,
      int? accountId,
      String? email,
      bool? hasAccountGuest,
      bool? hasAccountCustomer,
      bool? signUpCustomerSuccess,
      bool? signUpGuestSuccess,
      bool? signInCustomerSuccess,
      bool? signInGuestSuccess , bool ? signInGoogleStatus }) {
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
        signInCustomerSuccess: signInCustomerSuccess ?? this.signInCustomerSuccess,
        signInGuestSuccess: signInGuestSuccess ?? this.signInGuestSuccess , signInGoogleStatus : signInGoogleStatus ?? this.signInGoogleStatus);
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
        signInCustomerSuccess,
        signInGuestSuccess , signInGoogleStatus
      ];
}
