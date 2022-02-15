import 'package:intl/intl.dart';
import 'package:xchange/app/barrel.dart';

import 'const_string.dart';

class AgePicker extends StatefulWidget {
  final Function(String) onPicked;
  final String? initalAge;
  const AgePicker({Key? key, required this.onPicked, this.initalAge})
      : super(key: key);

  @override
  _AgePickerState createState() => _AgePickerState();
}

class _AgePickerState extends State<AgePicker> {
  String selectedAge = 'Age';
  @override
  void initState() {
    if (widget.initalAge != null) {
      selectedAge = widget.initalAge!;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        await selectDate();
      },
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2),
          child: Text(selectedAge,
              style: TextStyle(
                  fontFamily: 'League Spartan',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  height: 1,
                  letterSpacing: 0.2,
                  color: selectedAge == 'Age' ? apptextGrey : Colors.black)),
        ),
      ),
    );
  }

  Future<void> selectDate() async {
    final diff = DateTime(DateTime.now().year - 14);
    final _diffInDays = diff.difference(DateTime.now()).inDays.abs();
    final _lastDate = DateTime.now().subtract(Duration(days: _diffInDays));

    var selectedDate = _lastDate;
    final DateTime? picked = await showDatePicker(
        context: Get.context!,
        initialDate: selectedDate,
        firstDate: DateTime(1900, 8),
        lastDate: _lastDate);
    if (picked != null && picked != selectedDate) {
      selectedDate = picked;
      final dob = DateFormat('yyyy/MM/dd').format(picked);
      selectedAge = calculateAge(dob);
      widget.onPicked(dob);
      setState(() {});
    }
  }
}
