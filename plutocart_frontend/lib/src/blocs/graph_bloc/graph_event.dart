part of 'graph_bloc.dart';

abstract class GraphEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetGraph extends GraphEvent {
  final int stmType;
  GetGraph(this.stmType);
}

class ResetGraph extends GraphEvent {}
