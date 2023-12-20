part of 'home_page_bloc.dart';

abstract class HomePageBlocEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadingHomePage extends HomePageBlocEvent {
}
