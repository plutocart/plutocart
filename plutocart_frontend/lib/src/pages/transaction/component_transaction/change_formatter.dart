 String changeFormatter(String dateTime) {
    print("Check datetime : ${dateTime}");
    List<String> parts = dateTime.split(' ');

    if (parts.length != 2) {
      throw Exception('Invalid date time format');
    }

    List<String> dateParts = parts[0].split('/');
    if (dateParts.length != 3) {
      throw Exception('Invalid date format');
    }

    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    List<String> timeParts = parts[1].split(':');
    if (timeParts.length != 2) {
      throw Exception('Invalid time format');
    }

    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    try {
      DateTime dateTimeObj = DateTime(year, month, day, hour, minute);
      String formattedDateTime =
          '${dateTimeObj.year.toString().padLeft(4, '0')}-'
          '${dateTimeObj.month.toString().padLeft(2, '0')}-'
          '${dateTimeObj.day.toString().padLeft(2, '0')} '
          '${dateTimeObj.hour.toString().padLeft(2, '0')}:'
          '${dateTimeObj.minute.toString().padLeft(2, '0')}:'
          '${dateTimeObj.second.toString().padLeft(2, '0')}';

      print("finished with date:  ${formattedDateTime}");
      return formattedDateTime;
    } catch (e) {
      throw Exception('Invalid date time');
    }
  }