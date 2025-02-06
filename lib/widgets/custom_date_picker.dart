import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomDatePicker extends StatefulWidget {
  final Function(DateTime) onDateSelected;

  const CustomDatePicker({
    Key? key,
    required this.onDateSelected,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  String _displayedDate = "MONTH / DAY / YYYY";

  void _showWheelPicker(BuildContext context) {
    DateTime selectedDate = DateTime.now();

    showModalBottomSheet(
      context: context,
      builder: (_) {
        return Container(
          height: 250,
          color: Colors.white,
          child: Column(
            children: [
              // Done button
              Container(
                padding: const EdgeInsets.all(8.0),
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    setState(() {
                      _displayedDate =
                          "${selectedDate.month} / ${selectedDate.day} / ${selectedDate.year}";
                    });
                    widget.onDateSelected(selectedDate);
                  },
                  child: const Text(
                    "Done",
                    style: TextStyle(color: Colors.red, fontSize: 16),
                  ),
                ),
              ),

              // CupertinoDatePicker
              Expanded(
                child: CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  minimumDate: DateTime(1900),
                  maximumDate: DateTime.now(),
                  onDateTimeChanged: (DateTime date) {
                    selectedDate = date;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showWheelPicker(context),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _displayedDate,
              style: const TextStyle(color: Colors.black54, fontSize: 14),
            ),
            const Icon(Icons.calendar_today, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
