import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plutocart/src/blocs/transaction_category_bloc/bloc/transaction_category_bloc.dart';
import 'package:plutocart/src/blocs/wallet_bloc/bloc/wallet_bloc.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/type_transaction_router.dart';
import 'package:plutocart/src/popups/action_popup.dart';

class CardTransactionPopup extends StatefulWidget {
  const CardTransactionPopup({Key? key}) : super(key: key);

  @override
  _CardTransactionPopupState createState() => _CardTransactionPopupState();
}

class _CardTransactionPopupState extends State<CardTransactionPopup> {
  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDateTime =
        '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute}'; // ตัด millisecond ออก
    tranDateController.text = formattedDateTime;

    super.initState();
  }

  int indexTransactionType = 0;
  int indexWallet = 0;
  int indexTransactionCategoryTypeIncome = 0;
  TextEditingController amountMoneyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController(text: "");
  TextEditingController tranDateController = TextEditingController();
  TypeTransactionType typeTransaction = TypeTransactionType();
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  // image

  XFile? _image;
  Future<void> _getImageFromCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  Future<void> _getImageFromGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = image;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
      await _selectTime(context);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
    }
  }

  @override
  void dispose() {
    amountMoneyController.dispose();
    descriptionController.dispose();
    tranDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
          child: DropdownButtonFormField(
              decoration: InputDecoration(border: InputBorder.none),
              icon: Icon(Icons.keyboard_arrow_down_rounded,
                  color: Color(0xFF15616D)),
              value: typeTransaction.listTypeTransaction[indexTransactionType]
                  ['typeName'],
              style: TextStyle(color: Color(0xFF15616D)),
              dropdownColor: Color.fromARGB(255, 247, 246, 246),
              isExpanded: true,
              items: typeTransaction.listTypeTransaction.map((value) {
                return DropdownMenuItem(
                  value: value['typeName'],
                  child: Text(
                    value['typeName'],
                    style: TextStyle(
                      color: Color(0xFF15616D),
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                print("newValue ${newValue}");
                setState(() {
                  indexTransactionType = typeTransaction.listTypeTransaction
                      .indexWhere((element) => element['typeName'] == newValue);
                });
              }),
        ),
        BlocBuilder<TransactionCategoryBloc, TransactionCategoryState>(
          builder: (context, state) {
            print("transactionCategory type : ${indexTransactionType}");
            switch (indexTransactionType) {
              case 0:
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: DropdownButtonFormField(
                      menuMaxHeight: MediaQuery.sizeOf(context).height * 0.4,
                      icon: Icon(Icons.keyboard_arrow_down_rounded,
                          color: Color(0xFF15616D)),
                      decoration: InputDecoration(
                        labelText: "Choose Transaction Category",
                        labelStyle: TextStyle(color: Color(0xFF15616D)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: BorderSide(color: Color(0xFF15616D)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16.0),
                          borderSide: BorderSide(color: Color(0xFF15616D)),
                        ),
                      ),
                      value: state.transactionCategoryInComeList[
                              indexTransactionCategoryTypeIncome]
                          ['nameTransactionCategory'],
                      items: state.transactionCategoryInComeList.map((value) {
                        return DropdownMenuItem(
                            value: value['nameTransactionCategory'],
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child: Image.network(
                                    value['imageIconUrl'],
                                    width:
                                        MediaQuery.sizeOf(context).width * 0.1,
                                  ),
                                ),
                                Text(
                                  value['nameTransactionCategory'],
                                  style: TextStyle(
                                    color: Color(0xFF15616D),
                                    fontSize: 18,
                                    fontFamily: 'Roboto',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                  ),
                                ),
                              ],
                            ));
                      }).toList(),
                      onChanged: (newValue) {
                        print(
                            "before value in transaction category income : ${indexTransactionCategoryTypeIncome}");
                        print(
                            "length of transaction category income : ${state.transactionCategoryInComeList.length}");
                        setState(() {
                          indexTransactionCategoryTypeIncome = state
                              .transactionCategoryInComeList
                              .indexWhere((element) =>
                                  element['nameTransactionCategory'] ==
                                  newValue);
                        });
                        print(
                            "after value in transaction category income : ${indexTransactionCategoryTypeIncome}");
                        print(state.transactionCategoryInComeList[
                                indexTransactionCategoryTypeIncome]
                            ['nameTransactionCategory']);
                      },
                    ),
                  ),
                );
              case 1:
                return Text("Hello");
            }
            return SizedBox.shrink();
          },
        ),
        SizedBox(
          height: 12,
        ),
        Icon(
          Icons.arrow_downward_rounded,
          color: Color(0xFF15616D),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BlocBuilder<TransactionCategoryBloc, TransactionCategoryState>(
            builder: (context, state) {
              switch (indexTransactionType) {
                case 0:
                  return BlocBuilder<WalletBloc, WalletState>(
                    builder: (context, walletState) {
                      return DropdownButtonFormField(
                        menuMaxHeight: MediaQuery.sizeOf(context).height * 0.4,
                        icon: Icon(Icons.keyboard_arrow_down_rounded,
                            color: Color(0xFF15616D)),
                        decoration: InputDecoration(
                          labelText: "Choose your wallet",
                          labelStyle: TextStyle(color: Color(0xFF15616D)),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16),
                            borderSide: BorderSide(color: Color(0xFF15616D)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(16.0),
                            borderSide: BorderSide(color: Color(0xFF15616D)),
                          ),
                        ),
                        value: walletState.wallets[indexWallet].walletName,
                        items: walletState.wallets.map((valueWallet) {
                          return DropdownMenuItem(
                              value: valueWallet.walletName,
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20),
                                    child: Image(
                                      image: AssetImage(
                                          'assets/icon/wallet_icon.png'),
                                      width: MediaQuery.sizeOf(context).width *
                                          0.1,
                                    ),
                                  ),
                                  Text(
                                    valueWallet.walletName,
                                    style: TextStyle(
                                      color: Color(0xFF15616D),
                                      fontSize: 18,
                                      fontFamily: 'Roboto',
                                      fontWeight: FontWeight.w500,
                                      height: 0,
                                    ),
                                  ),
                                ],
                              ));
                        }).toList(),
                        onChanged: (newValueWallet) {
                          print("new value wallet changed : ${newValueWallet}");
                          indexWallet = walletState.wallets.indexWhere(
                              (element) =>
                                  element.walletName == newValueWallet);
                        },
                      );
                    },
                  );
              }
              return SizedBox.shrink();
            },
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: amountMoneyController,
            decoration: InputDecoration(
              labelText: "Amount of money",
              labelStyle: TextStyle(
                color: amountMoneyController.text.isNotEmpty
                    ? Color(0xFF15616D)
                    : Colors.red,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: amountMoneyController.text.isNotEmpty
                      ? Color(0xFF15616D)
                      : Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: amountMoneyController.text.isNotEmpty
                      ? Color(0xFF15616D)
                      : Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.deny(RegExp(r'[^\d.]')),
              LengthLimitingTextInputFormatter(13),
            ],
            style: TextStyle(
              color: Color(0xFF1A9CB0),
              fontSize: 18,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
            onChanged: (value) {
              if (value.contains('.') &&
                  value.indexOf('.') != value.lastIndexOf('.')) {
                // If there's more than one decimal point, remove the extra one
                amountMoneyController.text =
                    value.substring(0, value.lastIndexOf('.'));
              } else if (value.contains('.') &&
                  value.substring(value.indexOf('.') + 1).length > 2) {
                // If there's a decimal point and more than two digits after it, limit to two digits
                amountMoneyController.text =
                    value.substring(0, value.indexOf('.') + 3);
              } else if (value.length == 10 && !value.contains('.')) {
                // If no decimal point and total length is 10 characters, prevent further input
                amountMoneyController.text =
                    value.substring(0, value.length - 1);
              }
              setState(() {});
            },
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: tranDateController,
            readOnly: true,
            decoration: InputDecoration(
              labelText: 'Selected Date',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF15616D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF15616D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: Color(0xFF15616D)),
              ),
            ),
            onTap: () async {
              await _selectDate(context);
              String formattedDateTime =
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ${selectedTime.hour}:${selectedTime.minute}';
              setState(() {
                tranDateController.text = formattedDateTime;
              });
            },
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 1,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xFF15616D)),
              borderRadius: BorderRadius.circular(16),
            ),
            child: _image == null
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF15616D)),
                              ),
                              onPressed: () {
                                _getImageFromCamera();
                              },
                              child: Row(
                                children: [
                                  Icon(Icons.camera_alt_rounded),
                                  Text("Camera")
                                ],
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF15616D)),
                              ),
                              onPressed: () {
                                _getImageFromGallery();
                              },
                              child: Row(children: [
                                Icon(Icons.image),
                                Text("Camera")
                              ])),
                        ],
                      ),
                    ],
                  )
                : Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return Scaffold(
                            appBar: AppBar(
                              backgroundColor: Color(0xFF15616D),
                            ),
                            body: Center(
                              child: Image.file(
                                File(_image!.path),
                                // ให้ใส่ fit: BoxFit.contain หรือ BoxFit.cover ตามต้องการ
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        }));
                      },
                      child: Image.file(
                        File(_image!.path),
                        height: 300,
                      ),
                    )
                    
                    ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: TextField(
            controller: descriptionController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              labelText: 'Description',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF15616D)),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(color: Color(0xFF15616D)),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.0),
                borderSide: BorderSide(color: Color(0xFF15616D)),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 12,
        ),
        ActionPopup(
          bottonFirstName: "Cancle",
          bottonSecondeName: "Add",
          bottonFirstNameFunction: () {
            Navigator.pop(context);
          },
          bottonSecondeNameFunction: () {},
        )
      ],
    ));
  }
}
