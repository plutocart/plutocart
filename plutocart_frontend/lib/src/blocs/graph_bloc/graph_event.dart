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

class UpdateTypeGraph extends GraphEvent {
  final int stmType;
  UpdateTypeGraph(this.stmType);
}

class ResetGraphList extends GraphEvent {}

class ResetGraphAnalysic extends GraphEvent {}

class UpdateGraphList extends GraphEvent {}
