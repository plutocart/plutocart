part of 'page_bloc.dart';

class PageState extends Equatable {
  final int indexPage;

  PageState({this.indexPage = 0});
  PageState copyWith({
    int? indexPage,
  }) {
    return PageState(
      indexPage: indexPage ?? this.indexPage,
    );
  }

  @override
  List<Object> get props => [indexPage];
}
