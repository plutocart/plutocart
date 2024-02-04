part of 'goal_bloc.dart';

enum GoalStatus { loading, loaded }

class GoalState extends Equatable {
  final String nameGoal;
  final double amountGoal;
  final double dificit;
  final GoalStatus createGoalStatus;
  final GoalStatus deleteGoalStatus;
  final GoalStatus updateGoalStatus;
  final DateTime? endDateGoal;
  final bool  statusGoal;
  final List<dynamic> ? goalList;
  final String endDateGoalString;

  GoalState(
      {this.nameGoal = "",
      this.amountGoal = 0,
      this.dificit = 0,
      DateTime? endDateGoal,
      this.createGoalStatus = GoalStatus.loading , this.goalList = const[] , this.deleteGoalStatus = GoalStatus.loading , this.statusGoal = false , this.updateGoalStatus = GoalStatus.loading , this.endDateGoalString = ""})
      : endDateGoal = endDateGoal ?? DateTime.now();

  GoalState copyWith(
      {String? nameGoal,
      double? amountGoal,
      double? dificit,
      GoalStatus? createGoalStatus,
      DateTime? endDateGoal , List<dynamic>? goalList , GoalStatus? deleteGoalStatus , bool ? statusGoal , GoalStatus? updateGoalStatus , String? endDateGoalString}) {
    return GoalState(
        nameGoal: nameGoal ?? this.nameGoal,
        dificit: dificit ?? this.dificit,
        createGoalStatus: createGoalStatus ?? this.createGoalStatus,
        endDateGoal: endDateGoal ?? this.endDateGoal , goalList: goalList?? this.goalList , deleteGoalStatus: deleteGoalStatus ?? this.deleteGoalStatus , statusGoal: statusGoal ?? this.statusGoal , updateGoalStatus: updateGoalStatus ?? this.updateGoalStatus , 
        endDateGoalString: endDateGoalString ?? this.endDateGoalString);
  }

  @override
  List<Object> get props =>
      [nameGoal, amountGoal, dificit, createGoalStatus, endDateGoal! , goalList! , deleteGoalStatus , statusGoal , updateGoalStatus , endDateGoalString];
}
