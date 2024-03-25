part of 'graph_bloc.dart';

enum GraphStatus { loading, loaded }

class GraphState extends Equatable {
  final String test;
  const GraphState({this.test = ""});

  GraphState copyWith(String test) {
    return GraphState(test: test ?? this.test);
  }

  @override
  List<Object> get props => [test];
}
