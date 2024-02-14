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

class ResetGoalStatus extends GoalEvent {}

class ResetGoalStatusDelete extends GoalEvent {}


class ResetGoalCompleteStatus extends GoalEvent {}


class GetGoalByAccountId extends GoalEvent {}

class DeleteGoalByGoalId extends GoalEvent {
  final int goalId;
  DeleteGoalByGoalId(this.goalId);
}

class CheckGoalComplete extends GoalEvent {
  final int goalId;
  CheckGoalComplete(this.goalId);
}

class StatusCardGoal extends GoalEvent {
  final List<bool> statusCardGoal;
  StatusCardGoal(this.statusCardGoal);
}

class UpdateGoalbyGoalId extends GoalEvent {
  final int goalId;
  final String nameGoal;
  final double amountGoal;
  final double deficit;
  final String endDateString;
  UpdateGoalbyGoalId(this.goalId, this.nameGoal, this.amountGoal, this.deficit,
      this.endDateString);
}
