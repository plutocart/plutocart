part of 'debt_bloc.dart';

abstract class DebtEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetDebtByAccountId extends DebtEvent {}

class ResetDebt extends DebtEvent {}
class ResetDebtStatus extends DebtEvent {}
class ResetUpdateDebtStatus extends DebtEvent {}
class SetMonthlyPayment extends DebtEvent {
  final int debtId;
  SetMonthlyPayment(this.debtId);
}

class DeleteDebt extends DebtEvent {
  final int debtId;
  DeleteDebt(this.debtId);
}

class UpdateDebt extends DebtEvent{
  final int debtId;
    final String nameOfYourDebt;
  final double totalDebt;
  final int totalPeriod;
  final int paidPeriod;
  final double monthlyPayment;
  final double debtPaid;
  final String moneyLender;
  final String latestPayDate;

    UpdateDebt(
      this.debtId , 
      this.nameOfYourDebt,
      this.totalDebt,
      this.totalPeriod,
      this.paidPeriod,
      this.monthlyPayment,
      this.debtPaid,
      this.moneyLender,
      this.latestPayDate);
}

class CreateDebt extends DebtEvent {
  final String nameOfYourDebt;
  final double totalDebt;
  final int totalPeriod;
  final int paidPeriod;
  final double monthlyPayment;
  final double debtPaid;
  final String moneyLender;
  final String debtDate;
  CreateDebt(
      this.nameOfYourDebt,
      this.totalDebt,
      this.totalPeriod,
      this.paidPeriod,
      this.monthlyPayment,
      this.debtPaid,
      this.moneyLender,
      this.debtDate);
}

class CompleteDebt extends DebtEvent{
  final int debtId;
  CompleteDebt(this.debtId);
}
