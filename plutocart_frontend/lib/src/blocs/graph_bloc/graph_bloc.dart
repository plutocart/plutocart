import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/repository/graph_repository.dart';

part 'graph_event.dart';
part 'graph_state.dart';

class GraphBloc extends Bloc<GraphEvent, GraphState> {
  GraphBloc() : super(GraphState()) {
    on<ResetGraph>((event, emit) {
      emit(GraphState()); // Reset the state to the initial state
    });

    on<UpdateGraphList>((event, emit) {
      emit(state.copyWith(
          loadingGraph:
              GraphStatus.loaded)); // Reset the state to the initial state
    });
    on<ResetGraphList>((event, emit) {
      emit(state.copyWith(
          graphList: {},
          updateTypeGraph: 1)); // Reset the state to the initial state
    });
    on<ResetGraphAnalysic>((event, emit) {
      emit(state.copyWith(
        loadingGraph: GraphStatus.loading,
      )); // Reset the state to the initial state
    });
    on<UpdateTypeGraph>((event, emit) {
      emit(state.copyWith(
          updateTypeGraph:
              event.stmType)); // Reset the state to the initial state
    });

    on<GetGraph>(
      (event, emit) async {
        Map<String, dynamic> response = await GraphRepository()
            .getTransactionForGraphByAccountId(event.stmType);
        print(event.stmType);
        print("Start get transactionsssss by account id : ${response}");
        try {
          emit(state.copyWith(
              graphList: response, getLoading: GraphStatus.loaded));
        } catch (e) {
          print("Error state.transactionList");
        }
      },
    );
  }
}
