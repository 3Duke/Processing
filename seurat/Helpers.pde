

void displayMessage() {

  noStroke();

  textSize(12);
  // Erase the previous display of frameCount
  // fill(frameSet.red(0), frameSet.green(0), frameSet.blue(0), 255); // XXX
  text(previousMessage, 10, height - 8);
  // Display frameCount
  fill(200);
  previousMessage = message;
  // message = str(frameCount) + ", " + str(round(frameRate));
  text(message, 10, height - 8);
}



void manageFrameRate(float newFrameRate) {
  // changes frame rate
  frameSet.baseFrameRate = newFrameRate;
  float currentFrameRate =   frameSet.baseFrameRate + 7*sin(TWO_PI*frameCount/20000);
  frameRate(currentFrameRate);
}

void keyReleased() {

  if (key != CODED) {
    switch(key) {
    case BACKSPACE:
      typedText = typedText.substring(0, max(0, typedText.length()-1));
      break;
    case TAB:
      typedText += "";
      break;
    case ENTER:
    case RETURN:
      // comment out the following two lines to disable line-breaks
      // typedText += "\n";
      //  break;
    case ESC:
    case DELETE:
      break;
    default:
      typedText += key;
    }
  }
}

//////////////

void printColor(color c, String label) {
  
  colorMode(RGB,255,255,255,255);
  println(label + ": rgb = " + nfc(red(c),0) + ", " + nfc(green(c),0) + ", " + nfc(blue(c),0));
  
}

String colorString (color c) {
  
  colorMode(RGB,255,25,255);
  return "rgb: " + red(c) + ", " + green(c) + ", " + blue(c);
  
}

String randomString(int n) {
  
  String val = "";
  String alpha = "abcdefghijklmnopqrstuvwxyz";
  
  for (int i = 0; i < n; i++) {
    
    int k = int(random(0,16));
    val = val + alpha.charAt(k);
    
  }
  
 return  val; 
}
