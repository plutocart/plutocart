import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plutocart/src/blocs/debt_bloc/debt_bloc.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/transaction_category_bloc/bloc/transaction_category_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/pages/debt/companent_debt/DebtDropdown.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/amount_text_field.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/change_formatter.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/date_picker_field.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/description_text_field.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/goal_dropdown.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/image_selection_screen.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/transaction_category_dropdown.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/transaction_type_dropdown.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/type_transaction_router.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/wallet_dropdown.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';

class CardTransactionPopup extends StatefulWidget {
  const CardTransactionPopup({Key? key}) : super(key: key);

  @override
  _CardTransactionPopupState createState() => _CardTransactionPopupState();
}

class _CardTransactionPopupState extends State<CardTransactionPopup> {
  BuildContext? contextAlert;

  final GlobalKey<FormFieldState> globalKeyTransaction = GlobalKey();
  final GlobalKey<FormFieldState> globalKeyWallet = GlobalKey();
  int indexTransactionType = 0;
  int indexWallet = 0;
  int indexGoal = 0;
  int indexDebt = 0;
  int indexTransactionCategoryType = 0;
  TextEditingController debtMonthLyPaymentController = TextEditingController();
  TextEditingController amountMoneyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tranDateController = TextEditingController();
  TypeTransactionType typeTransaction = TypeTransactionType();
  // form
  bool? fullFieldTranactionInEx;
  int? idTransactionCategory;
  int? idWallet;
  int? idGoal;
  int? idDebt;
  // image
  XFile? _image;
  File? _imageFile;

  Future<void> _getImageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
      _imageFile = _image != null ? File(_image!.path) : null;
    });
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
      _imageFile = _image != null ? File(_image!.path) : null;
    });
  }

  @override
  void dispose() {
    amountMoneyController.dispose();
    descriptionController.dispose();
    tranDateController.dispose();
    super.dispose();
  }

  void resetData() {
    setState(() {
      tranDateController.clear();
      DateTime now = DateTime.now();
      String formattedDateTime =
          '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
      tranDateController.text = formattedDateTime;
      amountMoneyController.clear();
      descriptionController.clear();
      _image = null;
      _imageFile = null;
      indexTransactionCategoryType = 0;
      idTransactionCategory = null;
      idWallet = null;
      idGoal = null;
      idDebt = null;
      indexGoal = 0;
      indexDebt = 0;
      indexWallet = 0;
      globalKeyTransaction.currentState?.reset();
      globalKeyWallet.currentState?.reset();
    });
  }

  void checkFullFieldTransactionInEx() {
    fullFieldTranactionInEx = (idTransactionCategory == null ||
            idWallet == null ||
            amountMoneyController.text.length <= 0)
        ? false
        : true;
  }

  void checkFullFieldTransactionGoal() {
    fullFieldTranactionInEx = (idGoal == null ||
            idWallet == null ||
            amountMoneyController.text.length <= 0)
        ? false
        : true;
  }

  void checkFullFieldTransactionDebt() {
    fullFieldTranactionInEx = (idDebt == null ||
            idWallet == null ||
            amountMoneyController.text.length <= 0)
        ? false
        : true;
  }

  @override
  void initState() {
    DateTime now = DateTime.now();
    context.read<TransactionCategoryBloc>().add(GetTransactionCategoryIncome());
    context
        .read<TransactionCategoryBloc>()
        .add(GetTransactionCategoryExpense());
    String formattedDateTime =
        '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    tranDateController.text = formattedDateTime;

    debtMonthLyPaymentController.addListener(() {
      print("check set state debtId : ${debtMonthLyPaymentController.text}");
      setState(() {
        amountMoneyController.text = debtMonthLyPaymentController.text;
      });
    });

    checkFullFieldTransactionInEx();
    amountMoneyController.addListener(() {
      setState(() {
        if (indexTransactionType == 2) {
          checkFullFieldTransactionGoal();
        } else if (indexTransactionType == 3) {
          checkFullFieldTransactionDebt();
        } else {
          checkFullFieldTransactionInEx();
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        TransactionTypeDropdown(
          listTypeTransaction: typeTransaction.listTypeTransaction,
          indexTransactionType: indexTransactionType,
          onChanged: (newValue) {
            setState(() {
              indexTransactionType = typeTransaction.listTypeTransaction
                  .indexWhere((element) => element['typeName'] == newValue);
              resetData();
            });
          },
        ),
        BlocBuilder<TransactionCategoryBloc, TransactionCategoryState>(
          builder: (context, state) {
            print("indexTransaction : ${indexTransactionType}");
            switch (indexTransactionType) {
              case 0:
              case 1:
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    child: TransactionCategoryDropdown(
                      selectKey: globalKeyTransaction,
                      transactionCategoryList: indexTransactionType == 0
                          ? state.transactionCategoryInComeList
                          : state.transactionCategoryExpenseList,
                      indexTransactionCategoryType:
                          indexTransactionCategoryType,
                      onCategoryChanged: (index, categoryId) {
                        setState(() {
                          indexTransactionCategoryType = index;
                          idTransactionCategory = categoryId;
                          checkFullFieldTransactionInEx();
                        });
                      },
                    ),
                  ),
                );
            }
            return SizedBox.shrink();
          },
        ),
        SizedBox(
          height: 5,
        ),

        (indexTransactionType == 0 || indexTransactionType == 1)
            ? Icon(
                Icons.arrow_downward_rounded,
                color: Color(0xFF15616D),
              )
            : SizedBox.shrink(),

        SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: BlocBuilder<TransactionCategoryBloc, TransactionCategoryState>(
            builder: (context, state) {
              print("indexWallet : ${indexWallet}");
              switch (indexTransactionType) {
                case 0: // case add income
                case 1:
                case 2:
                case 3:
                  return BlocBuilder<WalletBloc, WalletState>(
                    builder: (context, walletState) {
                      return WalletDropdown(
                        selectKey: globalKeyWallet,
                        walletList: walletState.wallets,
                        onChanged: (newValueWallet) {
                          indexWallet = walletState.wallets.indexWhere(
                              (element) =>
                                  element.walletId.toString() ==
                                  newValueWallet);
                          idWallet = walletState.wallets
                              .firstWhere((element) =>
                                  element.walletId.toString() == newValueWallet)
                              .walletId;
                          setState(() {
                            if (indexTransactionType == 2) {
                              checkFullFieldTransactionGoal();
                            } else if (indexTransactionType == 3) {
                              checkFullFieldTransactionDebt();
                            } else {
                              checkFullFieldTransactionInEx();
                            }
                          });
                        },
                      );
                    },
                  );
              }
              return SizedBox.shrink();
            },
          ),
        ),

        indexTransactionType == 2
            ? Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: BlocBuilder<GoalBloc, GoalState>(
                  builder: (context, goalState) {
                    print("indexGoal : ${indexGoal}");
                    print("idGoal : ${idGoal}");
                    print("Goal : ${goalState.goalList!.where((element) => element['statusGoal'] == 1)}");
                    return GoalDropdown(
                      goalList: goalState.goalList!.where((element) => element['statusGoal'] == 1).toList(),
                      onChanged: (newValueGoal) {
                        indexGoal = goalState.goalList!.where((element) => element['statusGoal'] == 1).toList().indexWhere((element) =>
                            element['id'].toString() == newValueGoal);
                        idGoal = goalState.goalList!.where((element) => element['statusGoal'] == 1).toList().firstWhere((element) =>
                            element['id'].toString() == newValueGoal)['id'];
                            setState(() {
                              checkFullFieldTransactionGoal();
                            });

                            
                      },
                    );
                  },
                ))
            : SizedBox.shrink(),

        indexTransactionType == 3
            ? Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: BlocBuilder<DebtBloc, DebtState>(
                  builder: (context, debtState) {
                    print("indexDebt : ${indexDebt}");
                    print("idDebtsss : ${idDebt}");

                    return DebtDropdown(
                      debtList: debtState.debtList.where((element) => element['statusDebt'] == 1).toList(),
                      onChanged: (newValueDebt) {
                        indexDebt =  debtState.debtList.where((element) => element['statusDebt'] == 1).toList().indexWhere((element) =>
                            element['id'].toString() == newValueDebt);
                        idDebt =  debtState.debtList.where((element) => element['statusDebt'] == 1).toList().firstWhere((element) =>
                            element['id'].toString() == newValueDebt)['id'];

                        debtMonthLyPaymentController.text =  debtState.debtList.where((element) => element['statusDebt'] == 1).toList()
                            .firstWhere((element) =>
                                element['id'].toString() ==
                                newValueDebt)['monthlyPayment']
                            .toString();
                            setState(() {
                              checkFullFieldTransactionDebt();
                            });
                      },
                    );
                  },
                ))
            : SizedBox.shrink(),

        SizedBox(
          height: 15,
        ),

        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: AmountTextField(
              amountMoneyController: amountMoneyController,
              nameField: "Amount of money",
            )),
        SizedBox(
          height: 15,
        ),
        // Trsndate
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DatePickerField(
              tranDateController: tranDateController,
              nameField: 'Selected date',
            )),
        SizedBox(
          height: 15,
        ),

        // image
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: ImageSelectionScreen(
            image: _image,
            getImageFromCamera: _getImageFromCamera,
            getImageFromGallery: _getImageFromGallery,
            onViewImage: () {
              if (_image != null) {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Scaffold(
                    appBar: AppBar(
                      backgroundColor: Color(0xFF15616D),
                    ),
                    body: Center(
                      child: Image.file(
                        File(_image!.path),
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                }));
              }
            },
            onDeleteImage: () {
              if (_imageFile != null) {
                _imageFile!.delete().then((_) {
                  setState(() {
                    _image = null;
                    _imageFile = null;
                  });
                }).catchError((error) {
                  print("Error deleting image file: $error");
                });
              }
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: DescriptionTextField(
                descriptionController: descriptionController)),
        SizedBox(
          height: 10,
        ),
        BlocBuilder<TransactionBloc, TransactionState>(
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ActionPopup(
                  isFullField: fullFieldTranactionInEx,
                  bottonFirstName: "Cancel",
                  bottonSecondeName: "Add",
                  bottonFirstNameFunction: () {
                    Navigator.pop(context);
                  },
                  bottonSecondeNameFunction: () async {
                    bool isDropdownDataMissing = false;

                    switch (indexTransactionType) {
                      case 0:
                      case 1:
                        if (idTransactionCategory == null ||
                            idWallet == null ||
                            amountMoneyController.text == "") {
                          isDropdownDataMissing = true;
                        }
                        break;
                    }
                    if (isDropdownDataMissing) {
                      null;
                    } else {
                      switch (indexTransactionType) {
                        case 0:
                        case 1:
                          int idTransactionCategoryFormat =
                              int.parse(idTransactionCategory.toString());
                          int idWalletFormat = int.parse(idWallet.toString());
                          double amount =
                              double.parse(amountMoneyController.text);
                          String tranDateFormat =
                              changeFormatter(tranDateController.text);
                          showLoadingPagePopUp(context);
                          context.read<TransactionBloc>().add(CreateTransaction(
                              indexTransactionType == 0 ? 1 : 2,
                              idTransactionCategoryFormat,
                              idWalletFormat,
                              amount,
                              tranDateFormat,
                              _imageFile,
                              descriptionController.text));

                          context
                              .read<TransactionBloc>()
                              .stream
                              .listen((state) {
                            if (state.incomeStatus ==
                                TransactionStatus.loaded) {
                              context.read<WalletBloc>().add(GetAllWallet());
                              context
                                  .read<TransactionBloc>()
                                  .add(GetTransactionDailyInEx());
                              context
                                  .read<TransactionBloc>()
                                  .add(GetTransactionList());
                              context
                                  .read<TransactionBloc>()
                                  .add(GetTransactionLimit3());
                              context
                                  .read<TransactionBloc>()
                                  .add(ResetTransactionStatus());
                              Navigator.of(context).pop();
                              Navigator.pop(context);
                            }
                          });
                        case 2:
                          int idWalletFormat = int.parse(idWallet.toString());
                          int idGoalFormat = int.parse(idGoal.toString());
                          double amount =
                              double.parse(amountMoneyController.text);
                          String tranDateFormat =
                              changeFormatter(tranDateController.text);
                          showLoadingPagePopUp(context);
                          context.read<TransactionBloc>().add(
                              CreateTransactionGoal(
                                  idWalletFormat,
                                  idGoalFormat,
                                  amount,
                                  tranDateFormat,
                                  _imageFile,
                                  descriptionController.text));

                          context
                              .read<TransactionBloc>()
                              .stream
                              .listen((state) {
                            if (state.goalStatus == TransactionStatus.loaded) {
                              context.read<WalletBloc>().add(GetAllWallet());

                              context
                                  .read<TransactionBloc>()
                                  .add(GetTransactionList());
                              context
                                  .read<TransactionBloc>()
                                  .add(GetTransactionDailyInEx());
                              context
                                  .read<TransactionBloc>()
                                  .add(GetTransactionLimit3());
                              context
                                  .read<GoalBloc>()
                                  .add(GetGoalByAccountId(1));
                              context
                                  .read<TransactionBloc>()
                                  .add(ResetTransactionGoalStatus());
                              context
                                  .read<GoalBloc>()
                                  .add(CheckGoalComplete(idGoalFormat));
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          });
                        case 3:
                          int idWalletFormat = int.parse(idWallet.toString());
                          int idDebtFormat = int.parse(idDebt.toString());
                          double amount =
                              double.parse(amountMoneyController.text);
                          String tranDateFormat =
                              changeFormatter(tranDateController.text);
                          showLoadingPagePopUp(context);
                          context.read<TransactionBloc>().add(
                              CreateTransactionDebt(
                                  idWalletFormat,
                                  idDebtFormat,
                                  amount,
                                  tranDateFormat,
                                  _imageFile,
                                  descriptionController.text));
                          context
                              .read<TransactionBloc>()
                              .stream
                              .listen((state) {
                            if (state.debtStatus == TransactionStatus.loaded) {
                              print("Check t");
                              context.read<WalletBloc>().add(GetAllWallet());
                              context
                                  .read<TransactionBloc>()
                                  .add(GetTransactionList());
                              context
                                  .read<TransactionBloc>()
                                  .add(GetTransactionDailyInEx());
                              context
                                  .read<TransactionBloc>()
                                  .add(GetTransactionLimit3());
                              context
                                  .read<DebtBloc>()
                                  .add(GetDebtByAccountId(1));
                              context
                                  .read<TransactionBloc>()
                                  .add(ResetTransactionDebtStatus());
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          });
                          break;
                      }
                    }
                  }),
            );
          },
        )
      ],
    ));
  }
}
