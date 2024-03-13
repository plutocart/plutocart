import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:plutocart/src/blocs/debt_bloc/debt_bloc.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/DatePickerFieldOnlyDay.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/amount_text_field.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/change_formatter.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/custom_alert_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';

class EditDebtPopup extends StatefulWidget {
  final Map<String, dynamic>? debt;
  const EditDebtPopup({Key? key, this.debt}) : super(key: key);

  @override
  _EditDebtPopupState createState() => _EditDebtPopupState();
}

class _EditDebtPopupState extends State<EditDebtPopup> {
  TextEditingController nameOfYourDebtController = TextEditingController();
  TextEditingController totalDebtController = TextEditingController();
  TextEditingController totalPeriodController = TextEditingController();
  TextEditingController paidPeriodController = TextEditingController();
  TextEditingController monthlyPaymentController = TextEditingController();
  TextEditingController debtPaidController = TextEditingController();
  TextEditingController moneyLenderController = TextEditingController();
  TextEditingController latestPaidController = TextEditingController();
  double? calMonthlyPayment;
  double? calDetPaid;

      bool ? fullField;

    void checkFullField(){
        fullField =    (nameOfYourDebtController.text.length <= 0 ||
                    totalDebtController.text.length <= 0 ||
                    totalPeriodController.text.length <= 0 ||
                    paidPeriodController.text.length <= 0 ||
                    monthlyPaymentController.text.length <= 0 ||
                    debtPaidController.text.length <= 0 ||
                    moneyLenderController.text.length <= 0 ) ?  false :  true;
    }

  @override
  void initState() {
    nameOfYourDebtController.text = widget.debt!['nameDebt'];
    totalDebtController.text = widget.debt!['totalDebt'].toString();
    totalPeriodController.text = widget.debt!['totalPeriod'].toString();
    paidPeriodController.text = widget.debt!['paidPeriod'].toString();
    monthlyPaymentController.text =
        widget.debt!['monthlyPayment'].toString();
    debtPaidController.text = widget.debt!['debtPaid'].toString();
    moneyLenderController.text = widget.debt!['moneyLender'].toString();
    DateTime now = DateTime.now();
    String formattedDateTimeNow =   '${now.toString().substring(8, 10)}/${now.toString().substring(5, 7)}/${now.toString().substring(0, 4)} ${now.toString().substring(11, 13)}:${now.toString().substring(14, 16)}';
    String date = widget.debt!['latestPayDate'].toString();
    String formattedDateTime =  date == "null" ? "-" : '${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)} ${date.substring(11, 13)}:${date.substring(14, 16)}';
    latestPaidController.text = formattedDateTime;
    nameOfYourDebtController.addListener(() {setState(() {
      checkFullField();
    });});
    totalDebtController.addListener(() {
      setState(() {
         checkFullField();
        if (totalPeriodController.text.length != 0 &&
            totalPeriodController.text.length != 0 &&
            paidPeriodController.text.length != 0 ) {
          calMonthlyPayment = double.parse(totalDebtController.text) /
              double.parse(totalPeriodController.text);
          monthlyPaymentController.text = calMonthlyPayment!.toStringAsFixed(2);
          calDetPaid = double.parse(paidPeriodController.text) *
              double.parse(monthlyPaymentController.text);
          debtPaidController.text = calDetPaid!.toStringAsFixed(2);
        } else if (totalPeriodController.text.length != 0 &&
            totalPeriodController.text.length != 0) {
          calMonthlyPayment = double.parse(totalDebtController.text) /
              double.parse(totalPeriodController.text);
          monthlyPaymentController.text = calMonthlyPayment!.toStringAsFixed(2);
        }

      });
    });
    totalPeriodController.addListener(() {
      setState(() {
         checkFullField();
        if (totalDebtController.text.length != 0 &&
            totalPeriodController.text.length != 0) {
          calMonthlyPayment = double.parse(totalDebtController.text) /
              double.parse(totalPeriodController.text);
          monthlyPaymentController.text = calMonthlyPayment!.toStringAsFixed(2);
        }
      });
    });

    paidPeriodController.addListener(() {
      setState(() {
         checkFullField();
        if (paidPeriodController.text.length != 0 &&
            monthlyPaymentController.text.length != 0 &&
            totalDebtController.text.length != 0 && int.parse(paidPeriodController.text) > 0) {
            latestPaidController.text = formattedDateTimeNow;
          calDetPaid = double.parse(paidPeriodController.text) *
              double.parse(monthlyPaymentController.text);
          debtPaidController.text = calDetPaid!.toStringAsFixed(2);
        } else if (paidPeriodController.text.length != 0 &&
            monthlyPaymentController.text.length != 0 && int.parse(paidPeriodController.text) > 0 && int.parse(paidPeriodController.text) > 0) {
          calDetPaid = double.parse(paidPeriodController.text) *
              double.parse(monthlyPaymentController.text);
          debtPaidController.text = calDetPaid!.toStringAsFixed(2);
           latestPaidController.text = "${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)} ${date.substring(11, 13)}:${date.substring(14, 16)}";
        }
        else if ( int.parse(paidPeriodController.text) == 0){
           latestPaidController.text = "-";
        }
      });
    });
    monthlyPaymentController.addListener(() {setState(() {
      checkFullField();
    });});
    debtPaidController.addListener((){setState(() {
      checkFullField();
    });});
    moneyLenderController.addListener((){setState(() {
      checkFullField();
    });});
    checkFullField();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: SingleChildScrollView(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit Debt",
                style: TextStyle(
                  color: Color(0xFF15616D),
                  fontSize: 24,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w700,
                  height: 0,
                ),
              ),
              Text(
                "You can set 'Goals' of your life!",
                style: TextStyle(
                  color: Color(0xFF898989),
                  fontSize: 14,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                maxLength: 15,
                controller: nameOfYourDebtController,
                decoration: InputDecoration(
                  labelText: "Name of Your debt",
                  labelStyle: TextStyle(
                    color: nameOfYourDebtController.text.length != 0
                        ? Color(0xFF1A9CB0)
                        : Color(0XFFDD0000),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 2,
                      color: nameOfYourDebtController.text.length != 0
                          ? Color(0xFF15616D)
                          : Color(0XFFDD0000),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      width: 1,
                      color: nameOfYourDebtController.text.length != 0
                          ? Color(0xFF15616D)
                          : Color(0XFFDD0000),
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                keyboardType: TextInputType.text,
                style: TextStyle(
                  color: Color(0xFF15616D),
                  fontSize: 16,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w400,
                ),
                onChanged: (value) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 15,
              ),
              AmountTextField(
                amountMoneyController: totalDebtController,
                nameField: "Total debt",
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                readOnly: true,
                controller: totalPeriodController,
                style: TextStyle(
                  color: Color(0xFF15616D),
                ),
                decoration: InputDecoration(
                  labelText: "Total period",
                  labelStyle: TextStyle(
                      color: totalPeriodController.text.length != 0
                          ? Color(0xFF1A9CB0)
                          : Color(0XFFDD0000)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: totalPeriodController.text.length != 0
                            ? Color(0xFF15616D)
                            : Color(0XFFDD0000)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: totalPeriodController.text.length != 0
                            ? Color(0xFF15616D)
                            : Color(0XFFDD0000)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.import_export_outlined,
                      color: Color(0xFF15616D),
                    ), 
                    onPressed: () {
                      if (totalDebtController.text.length != 0) {
                        addPayPeriod(
                            context,
                            int.parse(totalPeriodController.text),
                            totalPeriodController,
                            1,
                            360);
                      } else {
                        customAlertPopup(context, "Please input total debt!",
                            Icons.error_outline_rounded, Colors.red.shade200);
                      }
                    },
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                readOnly: true,
                controller: paidPeriodController,
                style: TextStyle(
                  color: Color(0xFF15616D),
                ),
                decoration: InputDecoration(
                  labelText: "Paid periods",
                  labelStyle: TextStyle(
                      color: totalPeriodController.text.length != 0
                          ? Color(0xFF1A9CB0)
                          : Color(0XFFDD0000)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 2,
                        color: totalPeriodController.text.length != 0
                            ? Color(0xFF15616D)
                            : Color(0XFFDD0000)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 1,
                        color: totalPeriodController.text.length != 0
                            ? Color(0xFF15616D)
                            : Color(0XFFDD0000)),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.import_export_outlined,
                      color: Color(0xFF15616D),
                    ), 
                    // ตัวอย่าง icon button เป็น calendar_today
                    onPressed: () {
                      if (totalPeriodController.text == "") {
                        customAlertPopup(context, "Please input total period!",
                            Icons.error_outline_rounded, Colors.red.shade200);
                      } else {
                        int parsePayPeriodToInt =
                            int.parse(totalPeriodController.text);

                        addPayPeriod(context, 1, paidPeriodController, 0,
                            parsePayPeriodToInt);
                      }
                    },
                  ),
                ),
                 onChanged: (value) {
                  setState(() {});
                },
              ),
              SizedBox(
                height: 15,
              ),
              AmountTextField(
                  amountMoneyController: monthlyPaymentController,
                  nameField: "Monthly payment"),
              SizedBox(
                height: 15,
              ),
              AmountTextField(
                  amountMoneyController: debtPaidController,
                  nameField: "Debt paid"),
              SizedBox(
                height: 15,
              ),
              AmountTextField(
                  amountMoneyController: moneyLenderController, nameField: "Moneylender"),
              latestPaidController.text == "-" ||  paidPeriodController.text == "0"  ? SizedBox.shrink() : SizedBox(
                height: 15,
              ),
              latestPaidController.text == "-" || paidPeriodController.text == "0" ?  SizedBox.shrink() : DatePickerFieldOnlyDay(
                tranDateController: latestPaidController,
                nameField: "Latest paid",
              ),
              SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ActionPopup(
                  isFullField: fullField,
                  bottonFirstName: "Cancel",
                  bottonSecondeName: "Confirm",
                  bottonFirstNameFunction: () {
                    Navigator.pop(context);
                  },
                  bottonSecondeNameFunction: () {
                    if (nameOfYourDebtController.text.length <= 0 ||
                        totalDebtController.text.length <= 0 ||
                        totalPeriodController.text.length <= 0 ||
                        paidPeriodController.text.length <= 0 ||
                        monthlyPaymentController.text.length <= 0 ||
                        debtPaidController.text.length <= 0 ||
                        moneyLenderController.text.length <= 0 ||
                        latestPaidController.text.length <= 0) {
                      // customAlertPopup(context, "Information missing",
                      //     Icons.error_outline_rounded, Colors.red.shade200);
                      null;
                    }else{
                      print("Check id debt : ${widget.debt!['id']}");
                      double totalDebt = double.parse(totalDebtController.text);
                      int totalPeriod  = int.parse(totalPeriodController.text);
                      int paidPeriod = int.parse(paidPeriodController.text);
                      double monthlyPayment = double.parse(monthlyPaymentController.text);
                      double debtPaid = double.parse(debtPaidController.text);
                      String lastestPaid = latestPaidController.text == "-" || paidPeriodController.text == "0"  ? "" : changeFormatter(latestPaidController.text);
                      showLoadingPagePopUp(context);
                      context.read<DebtBloc>().add(UpdateDebt(widget.debt!['id'], nameOfYourDebtController.text, totalDebt, totalPeriod, paidPeriod, monthlyPayment, debtPaid, moneyLenderController.text, lastestPaid));
                        context.read<DebtBloc>().stream.listen((state) {
                    if(state.updateDebtStatus == DebtStatus.loaded){
                      context.read<DebtBloc>().add(ResetUpdateDebtStatus());
                      context.read<DebtBloc>().add(GetDebtByAccountId());
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                      
                    }
                  }); 
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addPayPeriod(BuildContext context, int currentValue,
      TextEditingController textEditingController, int minValue, int maxValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  NumberPicker(
                    value: currentValue,
                    minValue: minValue,
                    maxValue: maxValue,
                    onChanged: (value) {
                      setState(() {
                        currentValue = value;
                      });
                    },
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF15616D),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        textEditingController.text = currentValue.toString();
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Confirm value: $currentValue",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.w400,
                        ),
                      ))
                ],
              );
            },
          ),
        );
      },
    );
  }
}
