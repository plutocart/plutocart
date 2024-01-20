import 'package:flutter/material.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/amount_text_field.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/date_picker_field.dart';
import 'package:plutocart/src/popups/action_popup.dart';

class AddGoalPopup extends StatefulWidget {
  const AddGoalPopup({Key? key}) : super(key: key);

  @override
  _AddGoalPopupState createState() => _AddGoalPopupState();
}

class _AddGoalPopupState extends State<AddGoalPopup> {
  TextEditingController budgetGoalController = TextEditingController();
  TextEditingController yourSaveMoneyController = TextEditingController();
  TextEditingController tranDateController = TextEditingController();
  TextEditingController nameGoalController = TextEditingController();

  @override
  void initState() {
    DateTime now = DateTime.now();
    String formattedDateTime =
        '${now.day}/${now.month}/${now.year} ${now.hour}:${now.minute.toString().padLeft(2, '0')}';
    tranDateController.text = formattedDateTime;
    super.initState();
  }

  void dispose() {
    budgetGoalController.dispose();
    yourSaveMoneyController.dispose();
    tranDateController.dispose();
    nameGoalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.55,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Add Goals",
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
            TextField(
              maxLength: 15,
              controller: nameGoalController,
              decoration: InputDecoration(
                labelText: "Name of Your Goal",
                labelStyle: TextStyle(
                  color: nameGoalController.text.length != 0
                      ? Color(0xFF1A9CB0)
                      : Colors.red,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: nameGoalController.text.length != 0
                        ? Color(0xFF15616D)
                        : Colors.red,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: nameGoalController.text.length != 0
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
            AmountTextField(
              amountMoneyController: budgetGoalController,
              nameField: "Budget of Goals",
            ),
            AmountTextField(
              amountMoneyController: yourSaveMoneyController,
              nameField: "You've saved money",
            ),
            DatePickerField(
              tranDateController: tranDateController,
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
        ),
      ),
    );
  }
}
