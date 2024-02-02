part of 'goal_bloc.dart';

enum GoalStatus { loading, loaded }

class GoalState extends Equatable {
  final String nameGoal;
  final double amountGoal;
  final double dificit;
  final GoalStatus createGoalStatus;
  final DateTime? endDateGoal;
  final List<dynamic> ? goalList;

  GoalState(
      {this.nameGoal = "",
      this.amountGoal = 0,
      this.dificit = 0,
      DateTime? endDateGoal,
      this.createGoalStatus = GoalStatus.loading , this.goalList = const[]})
      : endDateGoal = endDateGoal ?? DateTime.now();

  GoalState copyWith(
      {String? nameGoal,
      double? amountGoal,
      double? dificit,
      GoalStatus? createGoalStatus,
      DateTime? endDateGoal , List<dynamic>? goalList}) {
    return GoalState(
        nameGoal: nameGoal ?? this.nameGoal,
        dificit: dificit ?? this.dificit,
        createGoalStatus: createGoalStatus ?? this.createGoalStatus,
        endDateGoal: endDateGoal ?? this.endDateGoal , goalList: goalList?? this.goalList);
  }

  @override
  List<Object> get props =>
      [nameGoal, amountGoal, dificit, createGoalStatus, endDateGoal! , goalList!];
}
