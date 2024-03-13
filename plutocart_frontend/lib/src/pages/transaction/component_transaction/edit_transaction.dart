import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plutocart/src/blocs/transaction_bloc/bloc/transaction_bloc.dart';
import 'package:plutocart/src/blocs/transaction_category_bloc/bloc/transaction_category_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/amount_text_field.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/change_formatter.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/date_picker_field.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/description_text_field.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/image_form_edit.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/image_selection_screen.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/transaction_category_dropdown.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/wallet_dropdown.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';
import 'package:http/http.dart' as http;

class EditTransaction extends StatefulWidget {
  final Map<String, dynamic>? transaction;
  const EditTransaction({Key? key, required this.transaction})
      : super(key: key);
  @override
  _EditTransactionState createState() => _EditTransactionState();
}

class _EditTransactionState extends State<EditTransaction> {
  int indexType = 0;
  int? idTransactionCategory;
  TextEditingController nameOfCategoryController = TextEditingController();
  TextEditingController walletController = TextEditingController();
  TextEditingController amoutOfMoneyController = TextEditingController();
  TextEditingController imageController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController();
  TextEditingController tranOfTransactionController = TextEditingController();
  bool? fullFieldTranactionInEx;

  XFile? _image;
  File? _imageFile;

    void resetData() {
    setState(() {
      indexType = 0;
      idTransactionCategory = null;
      nameOfCategoryController.clear();
      walletController.clear();
      amoutOfMoneyController.clear();
      imageController.text = "";
      descriptionController.clear();
      tranOfTransactionController.clear();
      fullFieldTranactionInEx = null;
      _image = null;
      _imageFile = null;
    });
  }

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

  void checkFullFieldTransactionInEx() {
    fullFieldTranactionInEx = (walletController.text.length <= 0 ||
            amoutOfMoneyController.text.length <= 0)
        ? false
        : true;
  }

  // void checkFullFieldTransactionGoal() {
  //   fullFieldTranactionInEx = (
  //           idGoal == null ||
  //           walletController .text.length <=0 ||
  //           amoutOfMoneyController.text.length <= 0)
  //       ? false
  //       : true;
  // }

  // void checkFullFieldTransactionDebt() {
  //   fullFieldTranactionInEx = (
  //           idDebt == null ||
  //            walletController .text.length <=0 ||
  //           amoutOfMoneyController.text.length <= 0)
  //       ? false
  //       : true;
  // }

  @override
  void initState() {
    context.read<TransactionCategoryBloc>().add(GetTransactionCategoryIncome());
    context
        .read<TransactionCategoryBloc>()
        .add(GetTransactionCategoryExpense());
    indexType = widget.transaction!['statementType'] == "expense" ? 2 : 1;
    nameOfCategoryController.text = widget
        .transaction!['tranCategoryIdCategory']['nameTransactionCategory'];
    int walletId = widget.transaction!['walletIdWallet']['walletId'];
    walletController.text = "${walletId}";
    amoutOfMoneyController.text = "${widget.transaction!['stmTransaction']}";
    idTransactionCategory = widget.transaction!['tranCategoryIdCategory']['id'];
    imageController.text = widget.transaction!['imageUrl'] == null
        ? ""
        : widget.transaction!['imageUrl'];
    descriptionController.text = widget.transaction!['description'] == "null"
        ? "-"
        : widget.transaction!['description'];
    DateTime now = DateTime.parse(widget.transaction!['dateTransaction']);
    String formattedDateTime =
        '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    tranOfTransactionController.text = formattedDateTime;
    amoutOfMoneyController.addListener(() {
      setState(() {
        checkFullFieldTransactionInEx();
      });
    });
    checkFullFieldTransactionInEx();

    super.initState();
  }
  

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "Edit Transaction",
                        style: TextStyle(
                          color: Color(0xFF15616D),
                          fontSize: 24,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "Fix things that went wrong",
                    style: TextStyle(
                      color: Color(0XFF898989),
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  )
                ],
              ),
              widget.transaction!['tranCategoryIdCategory']['id'] == 32 ||
                      widget.transaction!['tranCategoryIdCategory']['id'] == 33
                  ? SizedBox.shrink()
                  : SizedBox(
                      height: 16,
                    ),
              widget.transaction!['tranCategoryIdCategory']['id'] == 32 ||
                      widget.transaction!['tranCategoryIdCategory']['id'] == 33
                  ? SizedBox.shrink()
                  : widget.transaction!['tranCategoryIdCategory']
                              ['typeCategory'] ==
                          "income"
                      ? BlocBuilder<TransactionCategoryBloc,
                          TransactionCategoryState>(
                          builder: (context, state) {
                            return TransactionCategoryDropdown(
                              isValue: true,
                              nameCategory: nameOfCategoryController.text,
                              transactionCategoryList:
                                  state.transactionCategoryInComeList,
                              indexTransactionCategoryType: indexType,
                              onCategoryChanged: (index, categoryId) {
                                setState(() {
                                  indexType = index;
                                  idTransactionCategory = categoryId;
                                  checkFullFieldTransactionInEx();
                                });
                              },
                            );
                          },
                        )
                      : BlocBuilder<TransactionCategoryBloc,
                          TransactionCategoryState>(
                          builder: (context, state) {
                            return TransactionCategoryDropdown(
                              isValue: true,
                              nameCategory: nameOfCategoryController.text,
                              transactionCategoryList:
                                  state.transactionCategoryExpenseList,
                              indexTransactionCategoryType: indexType,
                              onCategoryChanged: (index, categoryId) {
                                setState(() {
                                  indexType = index;
                                  idTransactionCategory = categoryId;
                                  checkFullFieldTransactionInEx();
                                });
                              },
                            );
                          },
                        ),
              SizedBox(
                height: 16,
              ),
              BlocBuilder<WalletBloc, WalletState>(
                builder: (context, state) {
                  return WalletDropdown(
                    isValue: true,
                    walleId:
                        '${widget.transaction!['walletIdWallet']['walletId']}',
                    walletList: state.wallets,
                    onChanged: (value) {
                      print(
                          "Hello value : ${widget.transaction!['walletIdWallet']['walletId']}");
                      setState(() {
                        walletController.text = value!;
                        checkFullFieldTransactionInEx();
                      });
                      print(walletController.text);
                    },
                  );
                },
              ),
              SizedBox(
                height: 16,
              ),
              AmountTextField(
                nameField: "Amount of money",
                amountMoneyController: amoutOfMoneyController,
              ),
              SizedBox(
                height: 16,
              ),
              Column(
                children: [
                  widget.transaction!['imageUrl'] == null ||
                          imageController.text.length == 0
                      ? ImageSelectionScreen(
                          image: _image,
                          getImageFromCamera: _getImageFromCamera,
                          getImageFromGallery: _getImageFromGallery,
                          onViewImage: () {
                            if (_image != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
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
                        )
                      : ImageFromEdit(
                          image: imageController.text,
                          onDeleteImage: () {
                            if (widget.transaction!['imageUrl'] != null) {
                              setState(() {
                                imageController.text = "";
                              });
                            }
                          },
                          onViewImage: () {
                            if (widget.transaction!['imageUrl'] != null) {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return Scaffold(
                                  appBar: AppBar(
                                    backgroundColor: Color(0xFF15616D),
                                  ),
                                  body: Center(
                                      child: Image.network(
                                          widget.transaction!['imageUrl'])),
                                );
                              }));
                            }
                          },
                        ),
                  SizedBox(
                    height: 16,
                  ),
                  DatePickerField(
                    nameField: "Date",
                    tranDateController: tranOfTransactionController,
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  DescriptionTextField(
                    descriptionController: descriptionController,
                  ),
                  ActionPopup(
                    isFullField: fullFieldTranactionInEx,
                    bottonFirstName: "Cancel",
                    bottonSecondeName: "Confirm",
                    bottonFirstNameFunction: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    bottonSecondeNameFunction: () async {
                      print("aakimindexType : ${indexType}");
                      print("aakimindexTransaction : ${indexType}");
                      print("aakimName :${ widget.transaction!['tranCategoryIdCategory']['typeCategory']}");
                      if (idTransactionCategory != 32 || idTransactionCategory != 33) {
                        // print("aakimTransction : ${widget.transaction}");
                        print(
                            "aakimTransaction Category Id : ${idTransactionCategory}");
                        print("aakimwalletId : ${walletController.text}");
                        int walletId = int.parse(walletController.text);
                        print(
                            "aakimstmTransaction : ${amoutOfMoneyController.text}");
                        double amountOfTransaction =
                            double.parse(amoutOfMoneyController.text);
                        String tranDateFormat =
                            changeFormatter(tranOfTransactionController.text);
                        print("aakimdateTimeTransactoin : ${tranDateFormat}");
                        print("aakimimage : ${imageController.text}");
                        print(
                            "aakimIdTransaction : ${widget.transaction!['id']}"); 
                            print("aakimShowFile :${File(imageController.text)}");    
                        showLoadingPagePopUp(context);
                        context
                            .read<TransactionBloc>()
                            .add(UpdateTransactionInEx(
                                widget.transaction!['tranCategoryIdCategory']['typeCategory'] == "expense" ? 2 : 1,
                                idTransactionCategory!,
                                walletId,
                                amountOfTransaction,
                                tranDateFormat,
                                _imageFile == null
                                    ? imageController.text.isEmpty
                                        ? null
                                        : File(imageController.text)
                                    : _imageFile,
                                descriptionController.text,
                                widget.transaction!['id']));
                        context.read<TransactionBloc>().stream.listen((event) {
                          if (event.updateTransactionInEx ==
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
                                .add(ResetUpdateTransactionInEx());
                            resetData();    
                            Navigator.pop(context);
                            Navigator.pop(context);
                            Navigator.pop(context);
                          }
                        });
                      } else {
                        print("aakimHello");
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
