import 'package:flutter/material.dart';

class CustomDateTimePicker extends StatelessWidget {
  final DateTime initialDate;
  final ValueChanged<DateTime> onDateTimeChanged;
  final String labelText;
  final InputBorder? border;

  const CustomDateTimePicker({
    Key? key,
    required this.initialDate,
    required this.onDateTimeChanged,
    required this.labelText,
    this.border = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8.0)),
      borderSide: BorderSide(color: Colors.grey),
    ),
  }) : super(key: key);

  Future<void> _selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(initialDate),
      );

      if (pickedTime != null) {
        final DateTime pickedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        onDateTimeChanged(pickedDateTime);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 4.0), // Espaçamento de 4px
          child: Text(
            labelText,
            style: const TextStyle(
              fontSize: 14,
              color: Color(0xff565656),
            ),
          ),
        ),
        InkWell(
          onTap: () => _selectDateTime(context),
          child: InputDecorator(
            decoration: InputDecoration(
              border: border,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
            ),
            child: Text(
              '${initialDate.day}/${initialDate.month}/${initialDate.year} ${initialDate.hour}:${initialDate.minute}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
