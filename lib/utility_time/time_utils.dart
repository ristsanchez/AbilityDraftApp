String getMinFromSecsForm(int duration) {
  String secs = '';
  int seconds = duration % 60;
  if (seconds < 10) {
    secs = '0$seconds';
  } else {
    secs = '$seconds';
  }

  return '${duration ~/ 60}:$secs';
}

String getTimeSinceEpoch(int startTime) {
  var date = DateTime.fromMillisecondsSinceEpoch(startTime * 1000);

  return date.toString();
}

String getTimeAgoEpoch(int startTime) {
  int now = DateTime.now().toUtc().millisecondsSinceEpoch;
  int since = startTime * 1000;

  int seconds = (now - since) ~/ 1000;
  int quantityOfUnit = 0;
  String timeUnit = 'year';

  if (seconds < 3600) {
    quantityOfUnit = seconds ~/ 60;
    timeUnit = 'min';
  } else if (seconds < 86400) {
    quantityOfUnit = seconds ~/ 3600;
    timeUnit = 'hour';
  } else if (seconds < 604800) {
    quantityOfUnit = seconds ~/ 86400;
    timeUnit = 'day';
  } else if (seconds < 2419200) {
    quantityOfUnit = seconds ~/ 604800;
    timeUnit = 'week';
  } else if (seconds < 29030400) {
    quantityOfUnit = seconds ~/ 2419200;
    timeUnit = 'month';
  } else {
    quantityOfUnit = seconds ~/ 29030400;
  }

  //If the unit is more than 1 add 's' char
  // e.g., 2 hour/day/week, add s at the end
  if (quantityOfUnit > 1) {
    timeUnit += 's';
  }

  return '$quantityOfUnit $timeUnit ago';

  //minutes     60 * 1  = 60
  //hours       60 * 60 = 3600
  //days      3600 * 24 = 86400
  //weeks    86400 * 7  = 604800
  //months  604800 * 4  = 2419200
  //years  2419200 * 12 = 29030400
}
