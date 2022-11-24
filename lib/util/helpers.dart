class Helpers {
  static String parseCardNum(String cardNum) {
    var start = 0;
    final strings = <String>[];
    while (start < cardNum.length) {
      final end = start + 4;
      strings.add(cardNum.substring(start, end));
      start = end;
    }
    return strings.join(' ');
  }
}
