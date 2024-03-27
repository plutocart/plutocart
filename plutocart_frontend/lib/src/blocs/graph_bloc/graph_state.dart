part of 'graph_bloc.dart';

enum GraphStatus { loading, loaded }

class GraphState extends Equatable {
  final Map<String, dynamic> graphList;
  final GraphStatus getLoading;
  final int updateTypeGraph;

  GraphState(
      {this.graphList = const {},
      this.getLoading = GraphStatus.loading,
      this.updateTypeGraph = 0});

  GraphState copyWith(
      {Map<String, dynamic>? graphList,
      GraphStatus? getLoading,
      int? updateTypeGraph}) {
    return GraphState(
        graphList: graphList ?? this.graphList,
        getLoading: getLoading ?? this.getLoading,
        updateTypeGraph: updateTypeGraph ?? this.updateTypeGraph);
  }

  @override
  List<Object> get props => [graphList, getLoading, updateTypeGraph];
}
