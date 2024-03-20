import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:plutocart/src/blocs/debt_bloc/debt_bloc.dart';
import 'package:plutocart/src/interfaces/slide_pop_up/slide_popup_dialog.dart';
import 'package:plutocart/src/popups/debt_popup/add_debt_popup.dart';


class DebtDropdown extends StatefulWidget {
    final List<dynamic> debtList;
  final Function(String?) onChanged;
  const DebtDropdown({ Key? key , required this.debtList,
      required this.onChanged, }) : super(key: key);

  @override
  _DebtDropdownState createState() => _DebtDropdownState();
}

class _DebtDropdownState extends State<DebtDropdown> {
 bool isDebtSelected = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF15616D)),
      decoration: InputDecoration(
        labelText: "Select your debt",
        labelStyle: TextStyle(
            color: isDebtSelected ? Color(0xFF1A9CB0) : Color(0XFFDD0000),
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color: isDebtSelected ? Color(0xFF15616D) : Color(0XFFDD0000)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
              color: isDebtSelected ? Color(0xFF15616D) : Color(0XFFDD0000)),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an item';
        }
        return null;
      },
      items: widget.debtList.map((debt) {
        return DropdownMenuItem<String>(
          value: debt['id'].toString(),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image(
                  image: AssetImage('assets/icon/debt-icon.png'),
                  width: MediaQuery.of(context).size.width * 0.1,   
                ),
              ),
              Text(
                debt['nameDebt'],
                style: TextStyle(
                  color: Color(0xFF15616D),
                  fontSize: 18,
                  fontFamily: 'Roboto',
                  fontWeight: FontWeight.w500,
                  height: 0,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      onChanged: (value) {
        int v = int.parse(value!);
        print("choose debt id : ${v}");
       context.read<DebtBloc>().add(SetMonthlyPayment(v));
        setState(() {
          isDebtSelected = true;
        });
        widget.onChanged(value);
      },
    );
  }

}