part of 'goal_bloc.dart';

enum GoalStatus { loading, loaded }

class GoalState extends Equatable {
  final String nameGoal;
  final double amountGoal;
  final double dificit;
  final GoalStatus createGoalStatus;
  final GoalStatus deleteGoalStatus;
  final DateTime? endDateGoal;
  final List<dynamic> ? goalList;

  GoalState(
      {this.nameGoal = "",
      this.amountGoal = 0,
      this.dificit = 0,
      DateTime? endDateGoal,
      this.createGoalStatus = GoalStatus.loading , this.goalList = const[] , this.deleteGoalStatus = GoalStatus.loading})
      : endDateGoal = endDateGoal ?? DateTime.now();

  GoalState copyWith(
      {String? nameGoal,
      double? amountGoal,
      double? dificit,
      GoalStatus? createGoalStatus,
      DateTime? endDateGoal , List<dynamic>? goalList , GoalStatus? deleteGoalStatus}) {
    return GoalState(
        nameGoal: nameGoal ?? this.nameGoal,
        dificit: dificit ?? this.dificit,
        createGoalStatus: createGoalStatus ?? this.createGoalStatus,
        endDateGoal: endDateGoal ?? this.endDateGoal , goalList: goalList?? this.goalList , deleteGoalStatus: deleteGoalStatus ?? this.deleteGoalStatus);
  }

  @override
  List<Object> get props =>
      [nameGoal, amountGoal, dificit, createGoalStatus, endDateGoal! , goalList! , deleteGoalStatus];
}
