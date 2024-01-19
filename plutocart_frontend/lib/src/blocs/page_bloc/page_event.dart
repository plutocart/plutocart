part of 'page_bloc.dart';

abstract class PageEvent extends Equatable {
  @override
  List<Object> get props => [];
  
}

 class saveIndexPage extends PageEvent{
  final int indexPage;
  saveIndexPage(this.indexPage);
  }

  class ResetPage extends PageEvent {}
