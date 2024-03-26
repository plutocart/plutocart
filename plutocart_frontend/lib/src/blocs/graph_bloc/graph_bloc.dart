import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/repository/graph_repository.dart';

part 'graph_event.dart';
part 'graph_state.dart';

class GraphBloc extends Bloc<GraphEvent, GraphState> {
  GraphBloc() : super(GraphState()) {
    on<GetGraph>(
      (event, emit) async {
        Map<String,dynamic> response =
            await GraphRepository().getTransactionForGraphByAccountId(event.stmType);
        print(event.stmType);
        print("Start get transaction by account id");
        try {
          emit(state.copyWith(
            graphList : response,
            ));
          print("state.transactionsList : ${state.graphList[0]}");
        } catch (e) {
          print("Error state.transactionList");
        }
      },
    );
  }
}
