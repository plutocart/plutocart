import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:plutocart/src/models/goal/goal.dart';
import 'package:plutocart/src/repository/goal_repository.dart';

part 'goal_event.dart';
part 'goal_state.dart';

class GoalBloc extends Bloc<GoalEvent, GoalState> {
  GoalBloc() : super(GoalState()) {
    on<ResetGoal>((event, emit) {
      emit(GoalState()); // Reset the state to the initial state
    });

    on<ResetGoalStatus>((event, emit) async {
      emit(state.copyWith(
          createGoalStatus: GoalStatus.loading, amountGoal: 0.0 , dificit: 0.0 , nameGoal: ""));
    });

      on<ResetGoalStatusDelete>((event, emit) async {
      emit(state.copyWith(
           deleteGoalStatus: GoalStatus.loading));
    });



   on<CreateGoal>((event, emit) async {
      print("start working create transaction income");
      try {
        Map<String, dynamic> response = await GoalRepository()
            .createGoalByAccountId(
                event.nameGoal,
                event.amountGoal,
                event.dificit,
                event.endDateGoalAdd!,);
          
        print("respone add goal : ${response['data']}");
        if (response['data'] == null) {
          print(
              "not created goal in goal bloc : ${response['data']}");
        } else {
          DateTime dateTime = DateTime.parse(response['data']['endDateGoal']);
          print("create goal in goal bloc success");
          emit(state.copyWith(
              nameGoal: response['data']['nameGoal'],
              amountGoal: response['data']['amountGoal'],
              dificit: response['data']['deficit'],
              endDateGoal: dateTime,
              createGoalStatus: GoalStatus.loaded));
          print("after create goal status is : ${state.createGoalStatus}");
          print("print state datetime : ${state.endDateGoal}");
        }
      } catch (e) {
        emit(state.copyWith(createGoalStatus: GoalStatus.loading));
        print("Error creating goal  in bloc bloc : ${e}" );
      }
    });



    on<GetGoalByAccountId>(
  (event, emit) async {
    print("Start get goal in goal bloc");
    try {
      List<dynamic> response = await GoalRepository().getGoalByAccountId();
      
      if (response.isNotEmpty) {
        print("response is:  ${response}");
        emit(state.copyWith(goalList: response));
      }
    } catch (e) {
      print("Error: $e");
    }
  },
);

 on<DeleteGoalByGoalId>((event, emit) async {
      try {
        print("start step delete account bloc");
         await GoalRepository().deleteGoal(event.goalId);
        final List<dynamic> newListGoal = [...state.goalList!];
        print("new list goal : ${newListGoal}");
        newListGoal.removeWhere((element) => element['id'] == event.goalId);
              print("after new list goal : ${newListGoal}");
        emit(state.copyWith(deleteGoalStatus: GoalStatus.loaded , goalList: newListGoal));
        print("check list : ${state.goalList}");
       
      } catch (error) {
        print("error delete account bloc: $error");
        throw error;
      }
    });


        on<UpdateGoalbyGoalId>((event, emit) async {
      try {
        print("start update account in bloc");
        Map<String, dynamic> response = await GoalRepository().updateGoal(event.goalId , event.nameGoal, event.amountGoal , event.deficit , event.endDateString);
        print("after update in bloc: $response");
        if (response['data'] == null) {
          print("response update goal: ${response['data']}");     
        } else {
          print(
              "signin customer after update account guest to member repository loginEmailGoole working ? :");
           emit(state.copyWith(
              updateGoalStatus: GoalStatus.loaded,
              nameGoal: event.nameGoal,
              amountGoal: event.amountGoal,
              dificit: event.deficit, 
              endDateGoalString: event.endDateString));
        }
      } catch (error) {
        print('Error update goal : $error');

      }
    });


  }
  
}
