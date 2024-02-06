part of 'goal_bloc.dart';

enum GoalStatus { loading, loaded }

class GoalState extends Equatable {
  final String nameGoal;
  final double amountGoal;
  final double deficit;
  final GoalStatus createGoalStatus;
  final GoalStatus deleteGoalStatus;
  final GoalStatus updateGoalStatus;
  final DateTime? endDateGoal;
  final bool  statusGoal;
  final List<dynamic> ? goalList;
  final String endDateGoalString;
  final bool goalComplete;

  GoalState(
      {this.nameGoal = "",
      this.amountGoal = 0,
      this.deficit = 0,
      DateTime? endDateGoal,
      this.createGoalStatus = GoalStatus.loading , this.goalList = const[] , this.deleteGoalStatus = GoalStatus.loading , this.statusGoal = false , this.updateGoalStatus = GoalStatus.loading , this.endDateGoalString = "" , this.goalComplete = false})
      : endDateGoal = endDateGoal ?? DateTime.now();

  GoalState copyWith(
      {String? nameGoal,
      double? amountGoal,
      double? deficit,
      GoalStatus? createGoalStatus,
      DateTime? endDateGoal , List<dynamic>? goalList , GoalStatus? deleteGoalStatus , bool ? statusGoal , GoalStatus? updateGoalStatus , String? endDateGoalString , bool? goalComplete}) {
    return GoalState(
      amountGoal: amountGoal ?? this.amountGoal,
        nameGoal: nameGoal ?? this.nameGoal,
        deficit: deficit ?? this.deficit,
        createGoalStatus: createGoalStatus ?? this.createGoalStatus,
        endDateGoal: endDateGoal ?? this.endDateGoal , goalList: goalList?? this.goalList , deleteGoalStatus: deleteGoalStatus ?? this.deleteGoalStatus , statusGoal: statusGoal ?? this.statusGoal , updateGoalStatus: updateGoalStatus ?? this.updateGoalStatus , 
        endDateGoalString: endDateGoalString ?? this.endDateGoalString , goalComplete: goalComplete ?? this.goalComplete );
  }

  @override
  List<Object> get props =>
      [nameGoal, amountGoal, deficit, createGoalStatus, endDateGoal! , goalList! , deleteGoalStatus , statusGoal , updateGoalStatus , endDateGoalString , goalComplete];
}
