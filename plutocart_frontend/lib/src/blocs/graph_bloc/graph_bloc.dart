import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'graph_event.dart';
part 'graph_state.dart';

class GraphBloc extends Bloc<GraphEvent, GraphState> {
  GraphBloc() : super(GraphState()) {
    on<GraphEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
