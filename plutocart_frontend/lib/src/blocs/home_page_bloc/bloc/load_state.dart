part of 'load_bloc.dart';

class LoadState extends Equatable {
  final bool isLoading;
  final int accountId;
  const LoadState({
    this.isLoading = false,
    this.accountId = 0
  });

  LoadState copyWith(
      {bool? isLoading , String? accountId}) {
    return LoadState(
        isLoading: isLoading ?? this.isLoading , accountId: this.accountId);
  }

  @override
  List<Object> get props => [
        isLoading,
        accountId
      ];
}

