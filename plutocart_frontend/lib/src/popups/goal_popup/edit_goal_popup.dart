import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/goal_bloc/goal_bloc.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/DatePickerFieldOnlyDay.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/amount_text_field.dart';
import 'package:plutocart/src/pages/transaction/component_transaction/change_formatter.dart';
import 'package:plutocart/src/popups/action_popup.dart';
import 'package:plutocart/src/popups/loading_page_popup.dart';

class EditGoalPopup extends StatefulWidget {
  final Map<String, dynamic>? goal;
  const EditGoalPopup({Key? key, this.goal}) : super(key: key);

  @override
  _EditGoalPopupState createState() => _EditGoalPopupState();
}

class _EditGoalPopupState extends State<EditGoalPopup> {
  TextEditingController budgetGoalController = TextEditingController();
  TextEditingController yourSaveMoneyController = TextEditingController();
  TextEditingController tranDateController = TextEditingController();
  TextEditingController nameGoalController = TextEditingController();
  bool? fullField;
  void checkFullField() {
    fullField = (budgetGoalController.text.length <= 0 ||
            yourSaveMoneyController.text.length <= 0 ||
            nameGoalController.text.length <= 0)
        ? false
        : true;
  }

  @override
  void initState() {
    nameGoalController.text = widget.goal!['nameGoal'];
    budgetGoalController.text = widget.goal!['totalGoal'].toString();
    yourSaveMoneyController.text = widget.goal!['collectedMoney'].toString();
    String date = widget.goal!['endDateGoal'].toString();
    String formattedDateTime =
        '${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)} ${date.substring(11, 13)}:${date.substring(14, 16)}';
    tranDateController.text = formattedDateTime;
    checkFullField();
    nameGoalController.addListener(() {
      setState(() {
        checkFullField();
      });
    });
    budgetGoalController.addListener(() {
      setState(() {
        checkFullField();
      });
    });
    yourSaveMoneyController.addListener(() {
      setState(() {
        checkFullField();
      });
    });

    super.initState();
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Edit Goals",
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
              ],
            ),
            TextField(
              maxLength: 15,
              controller: nameGoalController,
              decoration: InputDecoration(
                labelText: "Name of Your Goal",
                labelStyle: TextStyle(
                  color: nameGoalController.text.length != 0
                      ? Color(0xFF1A9CB0)
                      : Color(0XFFDD0000),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: nameGoalController.text.length != 0
                        ? Color(0xFF15616D)
                        : Color(0XFFDD0000),
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 1,
                    color: nameGoalController.text.length != 0
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
            AmountTextField(
              amountMoneyController: budgetGoalController,
              nameField: "Budget of Goals",
            ),
            AmountTextField(
              amountMoneyController: yourSaveMoneyController,
              nameField: "Collect money",
            ),
            DatePickerFieldOnlyDay(
              tranDateController: tranDateController,
              nameField: 'Selected Date',
            ),
            ActionPopup(
              isFullField: fullField,
              bottonFirstName: "Cancel",
              bottonSecondeName: "Confirm",
              bottonFirstNameFunction: () {
                Navigator.pop(context);
              },
              bottonSecondeNameFunction: () {
                if (fullField == true) {
                  double amountGoal = double.parse(budgetGoalController.text);
                  double deficitGoal =
                      double.parse(yourSaveMoneyController.text);
                  String tranDateFormat =
                      changeFormatter(tranDateController.text);
                  showLoadingPagePopUp(context);
                  context.read<GoalBloc>().add(UpdateGoalbyGoalId(
                      widget.goal!['id'],
                      nameGoalController.text,
                      amountGoal,
                      deficitGoal,
                      tranDateFormat));
                  print("dificitGoal! : ${deficitGoal}");
                  context.read<GoalBloc>().stream.listen((state) {
                    if (state.updateGoalStatus == GoalStatus.loaded) {
                      context.read<GoalBloc>().add(ResetGoal());
                      context.read<GoalBloc>().add(GetGoalByAccountId());
                      print("check statetus : ${state.updateGoalStatus}");
                      Navigator.pop(context);
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  });
                } else {
                  null;
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
