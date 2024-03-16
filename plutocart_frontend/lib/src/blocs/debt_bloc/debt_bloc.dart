import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/repository/debt_repository.dart';

part 'debt_event.dart';
part 'debt_state.dart';

class DebtBloc extends Bloc<DebtEvent, DebtState> {
  DebtBloc() : super(DebtState()) {
    on<GetDebtByAccountId>( (event, emit) async {
        print("Start get debt in debt bloc");
        try {
          List<dynamic> response = await DebtRepository().getDebtByAccountId(event.statusDebt);

          if (response.isNotEmpty) {
            print("response is:  ${response}");
            emit(state.copyWith(debtList: response));
          }
        } catch (e) {
          print("Error: $e");
        }
      },
    );

    on<SetMonthlyPayment>(
      (event, emit) async {
        print("Start get debt in debt bloc");
        try {
          print("check debt monthly payment : 1A");
          final List<dynamic> newListeDebt = [...state.debtList];
          print("check debt monthly payment : 1B");
          print(
              "check debt monthly payment : ${newListeDebt.where((element) => element['id'] == event.debtId).first['monthlyPayment']}");
          emit(state.copyWith(
              monthlyPayment: double.parse(newListeDebt
                  .where((element) => element['id'] == event.debtId)
                  .first['monthlyPayment']),
              genarateMothlyPaymentStatus: DebtStatus.loaded));
        } catch (e) {
          emit(state.copyWith(genarateMothlyPaymentStatus: DebtStatus.loading));
          print("Error set monthly payment: $e");
        }
      },
    );

    on<DeleteDebt>((event, emit) async {
      try {
        print("start step delete account bloc");
        await DebtRepository().deleteDebt(event.debtId);
        final List<dynamic> newListeDebt = [...state.debtList!];
        print("new list goal : ${newListeDebt}");
        newListeDebt.removeWhere((element) => element['id'] == event.debtId);
        print("after new list goal : ${newListeDebt}");
        emit(state.copyWith(
            deleteDebtStatus: DebtStatus.loaded, debtList: newListeDebt));
        print("check list : ${state.debtList}");
      } catch (error) {
        print("error delete account bloc: $error");
        throw error;
      }
    });

    on<CreateDebt>((event, emit) async {
      print("start working create transaction income");
      try {
        Map<String, dynamic> response = await DebtRepository()
            .createDebtByAccountId(
                event.nameOfYourDebt,
                event.totalDebt,
                event.totalPeriod,
                event.paidPeriod,
                event.monthlyPayment,
                event.debtPaid,
                event.moneyLender,
                event.debtDate);

        print("respone add debt : ${response['data']}");
        if (response['data'] == null) {
          print("not created debt in debt bloc : ${response['data']}");
        } else {
          print("create debt in debt bloc success");
          emit(state.copyWith(createDebtStatus: DebtStatus.loaded));
          print("after create debt status is : ${state.createDebtStatus}");
        }
      } catch (e) {
        emit(state.copyWith(createDebtStatus: DebtStatus.loading));
        print("Error creating debt  in bloc bloc : ${e}");
      }
    });

    on<ResetDebt>((event, emit) {
      emit(DebtState()); // Reset the state to the initial state
    });

    on<ResetDebtStatus>((event, emit) {
      emit(state.copyWith(
          createDebtStatus:
              DebtStatus.loading)); // Reset the state to the initial state
    });

       on<ResetUpdateDebtStatus>((event, emit) {
      emit(state.copyWith(
          updateDebtStatus:
              DebtStatus.loading)); // Reset the state to the initial state
    });

    on<UpdateDebt>((event, emit) async {
      try {
        print("start update account in bloc");
        Map<String, dynamic> response = await DebtRepository().updateDebt(
          event.debtId,
          event.nameOfYourDebt,
          event.totalDebt,
          event.totalPeriod,
          event.paidPeriod,
          event.monthlyPayment,
          event.debtPaid,
          event.moneyLender,
          event.latestPayDate,
        );
        print("after update in bloc: $response");

        if (response['data'] == null) {
          print("Error updating debt: ${response['error']}");
        } else {
          print("Update successful. Response data: ${response['data']}");
            emit(state.copyWith(
               updateDebtStatus :  DebtStatus.loaded
            )); 
        }
      } catch (error) {
        print('Error updating debt: $error');
      }
    });

      on<CompleteDebt>((event, emit) async {
  try {
    print("start complete debt in bloc");
    Map<String, dynamic> response = await DebtRepository().completeDebt(event.debtId);
    print("after complete debt  in bloc: $response");

    if (response['data'] == null) {
      print("Error updating debt: ${response['error']}");
    } else {
      print("Update successful. Response data: ${response['data']}");

      if (response['data'] is Map<String, dynamic>) {
        emit(state.copyWith(
          updateDebtStatus: DebtStatus.loaded,
        ));
      } else {
        print("Invalid response data structure.");
      }
    }
  } catch (error) {
    print('Error updating debtsss: $error');
  }
});

on<UpdateStatusNumberDebt>(((event, emit) {
  emit(state.copyWith(
    debtList: [],
    statusFilterDebtNumber: event.statusNumber
  ));
}));
  }
}
