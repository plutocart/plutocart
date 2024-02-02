part of 'goal_bloc.dart';

abstract class GoalEvent extends Equatable {
  @override
  List<Object> get props => [];
}
class CreateGoal extends GoalEvent {
  final String nameGoal;
  final double amountGoal;
  final double dificit;
  final String? endDateGoalAdd;
  CreateGoal(this.nameGoal, this.amountGoal, this.dificit, this.endDateGoalAdd);
}
class ResetGoal extends GoalEvent {}

class ResetGoalStatus extends GoalEvent{}

class getGoalByAccountId extends GoalEvent{}