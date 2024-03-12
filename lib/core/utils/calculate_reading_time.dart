int calculateReadingTime(String content) {
  final wordCount = content.split(RegExp(r'\s+')).length;

  // speed= d/t  225
  final readingTime = wordCount / 225;

  return readingTime.ceil();
}
