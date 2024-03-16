part of 'debt_bloc.dart';

enum DebtStatus { loaded, loading }

class DebtState extends Equatable {
  final List<dynamic> debtList;
  final DebtStatus getDebtStatus;
  final DebtStatus createDebtStatus;
  final DebtStatus deleteDebtStatus;
  final DebtStatus updateDebtStatus;
  final DebtStatus genarateMothlyPaymentStatus;
  final double monthlyPayment;
  final int statusFilterDebtNumber;

  DebtState(
      {this.debtList = const [],
      this.getDebtStatus = DebtStatus.loading,
      this.updateDebtStatus = DebtStatus.loading,
      this.createDebtStatus = DebtStatus.loading,
      this.deleteDebtStatus = DebtStatus.loading,
      this.monthlyPayment = 0,
      this.genarateMothlyPaymentStatus = DebtStatus.loading,
      this.statusFilterDebtNumber = 0});

  DebtState copyWith(
      {List<dynamic>? debtList,
      DebtStatus? getDebtStatus,
      DebtStatus? createDebtStatus,
      DebtStatus? deleteDebtStatus,
      double? monthlyPayment,
      DebtStatus? genarateMothlyPaymentStatus,
      DebtStatus? updateDebtStatus,
      int? statusFilterDebtNumber}) {
    return DebtState(
        debtList: debtList ?? this.debtList,
        getDebtStatus: getDebtStatus ?? this.getDebtStatus,
        updateDebtStatus: updateDebtStatus ?? this.updateDebtStatus,
        createDebtStatus: createDebtStatus ?? this.createDebtStatus,
        deleteDebtStatus: deleteDebtStatus ?? this.deleteDebtStatus,
        monthlyPayment: monthlyPayment ?? this.monthlyPayment,
        genarateMothlyPaymentStatus:
            genarateMothlyPaymentStatus ?? this.genarateMothlyPaymentStatus , statusFilterDebtNumber : statusFilterDebtNumber ?? this.statusFilterDebtNumber);
  }

  @override
  List<Object> get props => [
        debtList,
        getDebtStatus,
        createDebtStatus,
        deleteDebtStatus,
        monthlyPayment,
        genarateMothlyPaymentStatus,
        updateDebtStatus , statusFilterDebtNumber
      ];
}
