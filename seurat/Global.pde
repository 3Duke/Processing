
class Parameters {

  int numberOfFrames = 11;
  int numberOfControlBanks = 3;

  int controlMargin = 140;
  int displayMargin = 60;
  boolean screenControlsOn = true;
  boolean displayOn = true;

  float inverseGoldenRatio = 0.618;

  int WW, HEIGHT;

  String USB_PORT = "dev/Bluetooth-PDA-Sync";    // "/dev/slave"; // "/dev/tty.usbmodem1411"
}

class RunningMessage {

  String message = "";
  String previousMessage = "";
 
  RunningMessage( String message_, String previousMessage_) {
    
    message = message_;
    previousMessage = previousMessage_;
    
  } 

  void display() {

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
  
}

class Message {

  String msg;
  float x, y;
  float textSize;

  Message(String msg_, float x_, float y_, float textSize_) {

    msg = msg_;
    x = x_;
    y = y_;
    textSize = textSize_;
  }

  void display() {

    textSize(textSize);
    text(msg, x, y);
  }
}
