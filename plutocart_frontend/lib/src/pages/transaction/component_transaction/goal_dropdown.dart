import 'package:flutter/material.dart';


class GoalDropdown extends StatefulWidget {
    final List<dynamic> goalList;
  final Function(String?) onChanged;
  const GoalDropdown({ Key? key , required this.goalList,
      required this.onChanged, }) : super(key: key);

  @override
  _GoalDropdownState createState() => _GoalDropdownState();
}

class _GoalDropdownState extends State<GoalDropdown> {
 bool isGoalSelected = false;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      menuMaxHeight: MediaQuery.of(context).size.height * 0.4,
      icon: Icon(Icons.keyboard_arrow_down_rounded, color: Color(0xFF15616D)),
      decoration: InputDecoration(
        labelText: "Select your goal",
        labelStyle: TextStyle(
            color: isGoalSelected ? Color(0xFF1A9CB0) : Colors.red,
            fontSize: 16,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
              color: isGoalSelected ? Color(0xFF15616D) : Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: BorderSide(
              color: isGoalSelected ? Color(0xFF15616D) : Colors.red),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please select an item';
        }
        return null;
      },
      items: widget.goalList.map((goal) {
        return DropdownMenuItem<String>(
          value: goal['id'].toString(),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image(
                  image: AssetImage('assets/icon/Goals-icon.png'),
                  width: MediaQuery.of(context).size.width * 0.1,   
                ),
              ),
              Text(
                goal['nameGoal'],
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
        setState(() {
          isGoalSelected = true;
        });
        widget.onChanged(value);
      },
    );
  }
}