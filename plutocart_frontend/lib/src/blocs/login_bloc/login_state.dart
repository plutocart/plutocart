part of 'login_bloc.dart';

class LoginState extends Equatable {
  final String imei;
  final String accountRole;
  final int accountId;
  final String email;
  final bool hasAccountGuest;
  final bool hasAccountMember;
  final bool signUpMemberSuccess;
  final bool signUpGuestSuccess;
  final bool signInGuestSuccess;
  final bool signInMemberSuccess;
  final bool signInGoogleStatus;
  final bool isLogOut;
  const LoginState(
      {this.imei = "",
      this.accountRole = "Guest",
      this.accountId = 0,
      this.email = "",
      this.hasAccountGuest = false,
      this.hasAccountMember = false,
      this.signUpMemberSuccess = false,
      this.signUpGuestSuccess = false,
      this.signInMemberSuccess = true,
      this.signInGuestSuccess = true , this.signInGoogleStatus = true , this.isLogOut = false});

  LoginState copyWith(
      {String? imei,
      String? accountRole,
      int? accountId,
      String? email,
      bool? hasAccountGuest,
      bool? hasAccountMember,
      bool? signUpMemberSuccess,
      bool? signUpGuestSuccess,
      bool? signInMemberSuccess,
      bool? signInGuestSuccess , bool ? signInGoogleStatus , bool ? isLogOut}) {
    return LoginState(
        imei: imei ?? this.imei,
        accountRole: accountRole ?? this.accountRole,
        accountId: accountId ?? this.accountId,
        email: email ?? this.email,
        hasAccountGuest: hasAccountGuest ?? this.hasAccountGuest,
        hasAccountMember: hasAccountMember ?? this.hasAccountMember,
        signUpMemberSuccess:
        signUpMemberSuccess ?? this.signUpMemberSuccess,
        signUpGuestSuccess: signUpGuestSuccess ?? this.signUpGuestSuccess,
        signInMemberSuccess: signInMemberSuccess ?? this.signInMemberSuccess,
        signInGuestSuccess: signInGuestSuccess ?? this.signInGuestSuccess , signInGoogleStatus : signInGoogleStatus ?? this.signInGoogleStatus , isLogOut: isLogOut ?? this.isLogOut);
  }

  @override
  List<Object> get props => [
        imei,
        accountRole,
        accountId,
        email,
        hasAccountGuest,
        hasAccountMember,
        signUpMemberSuccess,
        signUpGuestSuccess,
        signInMemberSuccess,
        signInGuestSuccess , signInGoogleStatus , isLogOut
      ];
}
