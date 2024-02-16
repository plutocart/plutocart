import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/DatePickerFieldOnlyDay.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/amount_text_field.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/custom_alert_popup.dart';

class AddDebtPopup extends StatefulWidget {
  const AddDebtPopup({Key? key}) : super(key: key);

  @override
  _AddDebtPopupState createState() => _AddDebtPopupState();
}

class _AddDebtPopupState extends State<AddDebtPopup> {
  TextEditingController nameDebtController = new TextEditingController();
  TextEditingController amountDebtController = new TextEditingController();
  TextEditingController payDatePMonthController = new TextEditingController();
  TextEditingController monthHToPayController = new TextEditingController();
  TextEditingController payPeriodController = new TextEditingController();
  TextEditingController DatePayController = new TextEditingController();
  TextEditingController moneyLeanderController = new TextEditingController();
  TextEditingController latestDatePayController = new TextEditingController();
  int? integerValuePayPeriod;
  int? integerValueHowMYPay;
  @override
  void initState() {
    integerValuePayPeriod = 1;
    integerValueHowMYPay = 0;
     payPeriodController.addListener(() {
    setState(() {});
  });
   monthHToPayController.addListener(() {
    setState(() {}); 
  });
   DatePayController.addListener(() {
    setState(() {}); 
  });
   moneyLeanderController.addListener(() {
    setState(() {}); 
  });

    DateTime now = DateTime.now();
    String formattedDateTime =
        '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    latestDatePayController.text = formattedDateTime;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add Debt",
                    style: TextStyle(
                      color: Color(0xFF15616D),
                      fontSize: 24,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Text(
                    "Record various debts and manage them!",
                    style: TextStyle(
                      color: Color(0xFF898989),
                      fontSize: 14,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            maxLength: 15,
            controller: nameDebtController,
            decoration: InputDecoration(
              labelText: "Name of Your Debt",
              labelStyle: TextStyle(
                color: nameDebtController.text.length != 0
                    ? Color(0xFF1A9CB0)
                    : Colors.red,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: nameDebtController.text.length != 0
                      ? Color(0xFF15616D)
                      : Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: nameDebtController.text.length != 0
                      ? Color(0xFF15616D)
                      : Colors.red,
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
              amountMoneyController: amountDebtController,
              nameField: "Total debt"),
          SizedBox(
            height: 15,
          ),
         
          TextField(
            readOnly: true,
            controller: payPeriodController,
            style: TextStyle(
              color: Color(0xFF15616D),
            ),
            decoration: InputDecoration(
              labelText: "Total period",
              labelStyle: TextStyle(color: payPeriodController.text.length != 0 ?  Color(0xFF1A9CB0) : Colors.red),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: payPeriodController.text.length != 0 ?  Color(0xFF15616D) : Colors.red),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1,  color: payPeriodController.text.length != 0 ?  Color(0xFF15616D) : Colors.red),
                borderRadius: BorderRadius.circular(16),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.import_export_outlined,
                  color: Color(0xFF15616D),
                ), // ตัวอย่าง icon button เป็น calendar_today
                onPressed: () {
                  addPayPeriod(context, integerValuePayPeriod!,
                      payPeriodController, 1, 36);
                },
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          TextField(
            readOnly: true,
            controller: monthHToPayController,
            style: TextStyle(
              color: Color(0xFF15616D),
            ),
            decoration: InputDecoration(
              labelText: "Paid period(s)",
              labelStyle: TextStyle(color: monthHToPayController.text.length != 0 ? Color(0xFF1A9CB0) : Colors.red),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 2, color: monthHToPayController.text.length != 0 ?  Color(0xFF15616D) : Colors.red),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(width: 1,  color: monthHToPayController.text.length != 0 ?  Color(0xFF15616D) : Colors.red),
                borderRadius: BorderRadius.circular(16),
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.import_export_outlined,
                  color: Color(0xFF15616D),
                ),
                onPressed: () {
                  if (payPeriodController.text == "") {
                    customAlertPopup(context, "Please input pay period!",
                        Icons.error_outline_rounded, Colors.red.shade200);
                  } else {
                    int parsePayPeriodToInt =
                        int.parse(payPeriodController.text);

                    addPayPeriod(context, integerValuePayPeriod!,
                        monthHToPayController, 0, parsePayPeriodToInt);
                  }
                },
              ),
            ),
          ) , 
          
           SizedBox(
            height: 15,
          ),
           AmountTextField(
              amountMoneyController: payDatePMonthController,
              nameField: "Monthly payment"),
          SizedBox(
            height: 15,
          ),
          AmountTextField(
              amountMoneyController: DatePayController,
              nameField: "Debt paid"),
                  SizedBox(
            height: 15,
          ),
          TextField(
            maxLength: 15,
            controller: moneyLeanderController,
            decoration: InputDecoration(
              labelText: "Money lender",
              labelStyle: TextStyle(
                color: moneyLeanderController.text.length != 0
                    ? Color(0xFF1A9CB0)
                    : Colors.red,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 2,
                  color: moneyLeanderController.text.length != 0
                      ? Color(0xFF15616D)
                      : Colors.red,
                ),
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  width: 1,
                  color: moneyLeanderController.text.length != 0
                      ? Color(0xFF15616D)
                      : Colors.red,
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
           DatePickerFieldOnlyDay(
              tranDateController: latestDatePayController,
            ),
             Padding(
               padding: const EdgeInsets.only(bottom: 16),
               child: ActionPopup(
                bottonFirstName: "Cancle",
                bottonSecondeName: "Add",
                bottonFirstNameFunction: () {
                  Navigator.pop(context);
                },
                bottonSecondeNameFunction: () {
               
                },
                         ),
             )
        ],
      ),
    );
  }

  void addPayPeriod(BuildContext context, int currentValue,
      TextEditingController textEditingController, int minValue, int maxValue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
          ),
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
