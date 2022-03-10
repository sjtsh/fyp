String addCommas(input) {
  String output = input.toString().split(".").first;
  int numberOfCommas = output.length ~/ 3;
  for (int i = 0; i <= numberOfCommas; i++) {
    if (output.length < 4 * (i + 1)) {
      return output.toString();
    } else {
      output = output.substring(0, output.length - (3 + 4 * i)) +
          "," +
          output.substring(output.length - (3 + 4 * i));
    }
  }
  return input;
}
