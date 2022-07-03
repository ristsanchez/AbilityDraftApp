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

