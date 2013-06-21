

class MusicParameters {

  // Need to initialize Music
  float startingFramerate; //
  int beatsPerPhrase;      //
  int framesPerPhrase;     //
  float bpm;               //
  String scoreFile;

  void initialize () {

    framesPerPhrase = int(60*startingFramerate*beatsPerPhrase/bpm);
  }
}


class Parameters {

  int numberOfFrames = 11;
  int numberOfControlBanks = 3;

  int controlMargin = 140;
  int displayMargin = 60;
  
  float displayScaleFactor;
  
  float frameHeight, frameWidth;
  float horizontalFrameMargin, verticalFrameMargin;
 
  boolean screenControlsOn;
  boolean displayOn;

  float goldenRatio = 1.618033988749895;
  float inverseGoldenRatio = 1/goldenRatio;

  String USB_PORT = "dev/Bluetooth-PDA-Sync";    // "/dev/slave"; // "/dev/tty.usbmodem1411"


  Parameters(boolean screenControlsOn_, boolean displayOn_) {

    displayScaleFactor = displayHeight/700;
    
    screenControlsOn = screenControlsOn_;
    displayOn = displayOn_;
    
    float displayScaleFactor;
      
    verticalFrameMargin = 60 ;
    frameHeight = displayHeight - 2*verticalFrameMargin - 0.8*verticalFrameMargin;
    frameWidth = goldenRatio*frameHeight;
    horizontalFrameMargin = (displayWidth - frameWidth)/2.0;
    

    println("IN PARAMETERS: DISPLAY = "+nfc(displayWidth)+", "+nfc(displayHeight));
    println("-------------: frame = "+nfc(frameWidth,1)+", "+nfc(frameHeight,1));
    println("-------------: margins = "+nfc(horizontalFrameMargin,1)+", "+nfc(verticalFrameMargin,1));
 
  }
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

    relativeTextSize(textSize);
   text(msg, parameters.displayScaleFactor*x, parameters.displayScaleFactor*y);
  }
}
