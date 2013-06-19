



//////////////

void printColor(color c, String label) {

  colorMode(RGB, 255, 255, 255, 255);
  println(label + ": rgb = " + nfc(red(c), 0) + ", " + nfc(green(c), 0) + ", " + nfc(blue(c), 0));
}

String colorString (color c) {

  colorMode(RGB, 255, 25, 255);
  return "rgb: " + red(c) + ", " + green(c) + ", " + blue(c);
}

String randomString(int n) {

  String val = "";
  String alpha = "abcdefghijklmnopqrstuvwxyz";

  for (int i = 0; i < n; i++) {

    int k = int(random(0, 16));
    val = val + alpha.charAt(k);
  }

  return  val;
}
