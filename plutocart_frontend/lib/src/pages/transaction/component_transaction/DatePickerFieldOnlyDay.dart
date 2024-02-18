import 'package:flutter/material.dart';

class DatePickerFieldOnlyDay extends StatefulWidget {
final TextEditingController tranDateController;
final String nameField;
  const DatePickerFieldOnlyDay({Key? key , required this.tranDateController , required this.nameField})
      : super(key: key);

  @override
  _DatePickerFieldOnlyDayState createState() => _DatePickerFieldOnlyDayState();
}

class _DatePickerFieldOnlyDayState extends State<DatePickerFieldOnlyDay> {
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null ) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }
 

  @override
  Widget build(BuildContext context) {
    return TextField(
            controller: widget.tranDateController,
            style: TextStyle(color: Color(0xFF15616D)),
            readOnly: true,
            decoration: InputDecoration(
              labelText:  widget.nameField ,
              labelStyle: TextStyle(
                color: Color(0xFF1A9CB0),
              ),
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
              suffixIcon: IconButton(
                icon: Icon(
                  Icons.calendar_today,
                  color: Color(0xFF15616D),
                ), // ไอคอนที่ต้องการใช้งาน
                onPressed: () async {
                  await _selectDate(context);
                  String formattedDateTime =
                      '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}';
                  setState(() {
                    widget.tranDateController.text = formattedDateTime;
                  });
                },
              ),
            ),
            onTap: () async {
              await _selectDate(context);
              String formattedDateTime =
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year} ${selectedDate.hour}:${selectedDate.minute.toString().padLeft(2, '0')}';
              setState(() {
                widget.tranDateController.text = formattedDateTime;
              });
            },
          );
  }
}
