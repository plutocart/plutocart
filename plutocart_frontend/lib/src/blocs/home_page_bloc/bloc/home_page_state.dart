part of 'home_page_bloc.dart';

class HomePageState extends Equatable {
  final bool isLoading;
  final int accountId;
  const HomePageState({
    this.isLoading = false,
    this.accountId = 0
  });

  HomePageState copyWith(
      {bool? isLoading , String? accountId}) {
    return HomePageState(
        isLoading: isLoading ?? this.isLoading , accountId: this.accountId);
  }

  @override
  List<Object> get props => [
        isLoading,
        accountId
      ];
}

