import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:plutocart/src/models/transaction_category/transaction_category.dart';
import 'package:plutocart/src/repository/transaction_category_repository.dart';

part 'transaction_category_event.dart';
part 'transaction_category_state.dart';

class TransactionCategoryBloc extends Bloc<TransactionCategoryEvent, TransactionCategoryState> {
  TransactionCategoryBloc() : super(TransactionCategoryState()) {
   
    on<GetTransactionCategoryIncome>((event, emit) async {
      print("start get transaction category income bloc");
       try{
        print("try transaction category bloc");
           Map<String , dynamic> response = await TransactionCategoryRepository().getTransactionTypeIncome();
           if(response.containsKey('data')){
           print("check data response in getTransaction category bloc income : ${response['data']}"); 
           emit(state.copyWith(transactionCategoryInComeList: response['data']));
           print("after emit state in getTransaction category bloc income");
           print("check emit transaction category income list : ${state.transactionCategoryInComeList}");
           }     
       }
       catch(e){
          print("error statar test");
       }
    });

        on<GetTransactionCategoryExpense>((event, emit) async {
      print("start get transaction category expense bloc");
       try{
        print("try transaction category bloc");
           Map<String , dynamic> response = await TransactionCategoryRepository().getTransactionTypeExpense();
           if(response.containsKey('data')){
           print("check data response in getTransaction category bloc expense : ${response['data']}"); 
           emit(state.copyWith(transactionCategoryExpenseList: response['data']));
           print("after emit state in getTransaction category bloc expense");
           print("check emit transaction category income expense : ${state.transactionCategoryExpenseList}");
           }     
       }
       catch(e){
          print("error statar test");
       }
    });
  }
}
