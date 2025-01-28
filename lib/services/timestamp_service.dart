import 'package:intl/intl.dart';

// mendapatkan data secara realtime, memanggil kelas yg disediakan dari librari intl
void setDateTime(Function(String, String, String) onDateTimeSet) {
  var dateNow = DateTime.now();
  var dateFormat = DateFormat('dd mm yyyy');
  var dateTime = DateFormat('hh:mm:ss');

  String date = dateFormat.format(dateNow);
  String time = dateTime.format(dateNow);
  String currentDate = '$date | $time';

  onDateTimeSet(date, time, currentDate);
}

void setAttendanceStatus(Function(String) onStatusSet) {
  var dateNow = DateTime.now();
  // int.parse = mengubah integer jadi string
  var hour = int.parse(DateFormat('hh').format(dateNow));
  var minute = int.parse(DateFormat('mm').format(dateNow));
  // peng kondisian timestamp
  String attendanceStatus;
  if (hour <= 7 || (hour == 7 && minute <= 00)) {
    attendanceStatus = "Attend";
  } else if (hour > 7 || (hour == 7 && minute <= 01)) {
    attendanceStatus = "Late";
  } else {
    attendanceStatus = "Absent";
  }

  onStatusSet(attendanceStatus);
}
