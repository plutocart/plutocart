import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_event.dart';
part 'page_state.dart';

class PageBloc extends Bloc<PageEvent, PageState> {
  PageBloc() : super(PageState()) {


    on<saveIndexPage>((event, emit) async {
      emit(state.copyWith(
          indexPage: event.indexPage));
    });

      on<ResetPage>((event, emit) async {
      emit(state.copyWith(indexPage: 0));
    });

  }
}

