part of 'graph_bloc.dart';

enum GraphStatus { loading, loaded }

class GraphState extends Equatable {
  final Map<String,dynamic> graphList;
  final GraphStatus getLoading;

  GraphState({
    this.graphList = const {},
    this.getLoading = GraphStatus.loading
    });

  GraphState copyWith({Map<String,dynamic>? graphList, GraphStatus? getLoading}) {
    return GraphState(
      graphList: graphList ?? this.graphList,
      getLoading: getLoading ?? this.getLoading
    );
  }

  @override
  List<Object> get props => [
    graphList,
    getLoading
  ];
}
