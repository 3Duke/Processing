

void setup () {
  
  smooth();
  
  if (screenControlsOn) {
  
    HEIGHT = displayHeight - displayMargin;  // Set HEIGHT to some value manually if you wish
  
  }
  
  // Appearance:
  int WIDTH = int((1/inverseGoldenRatio)*HEIGHT);
  int WW;
  if (screenControlsOn) { WW = WIDTH - controlMargin; } else { WW = WIDTH; }
  font = loadFont("AndaleMono-48.vlw");
  textFont(font);
  size(WW, HEIGHT);
  frameRate(baseFrameRate);
  
  
  // Serial communication
  port = new Serial(this, USB_PORT, 9600); 
  port.bufferUntil('\n');

 

  // Create master objects
  print("1");
   controller = new Controller();   
   print("2");
  
  frameSet = new FrameSet(WW, NumberOfFrames);
  frameSet.setQualities();
  frameSet.setColorPhase(20);
  

  controlsActive = false;
  controlsActive2 = false;
  acceptDisplayString = false;
  acceptFileName = false;
  acceptText = false;
  acceptFileName = false;

  background(0);
}



void draw () {

  if (incomingMessage.length() > 0) 
  {
    if (incomingMessage.charAt(0) == 'S') 
    {
      parseSerialData(NFIELDS);
      reactToData();
    }
  }
  
  
  
  if ((!acceptText) && (!acceptFileName)) {
    count++;
    
    //////////////////////  
   
    controller.display();
    frameSet.display();
    displayMessage();
    
    // manageFrameRate();
  }

  if ((acceptText) || (acceptFileName)) {
    text(typedText+(frameCount/10 % 2 == 0 ? "_" : ""), 35, 45);
  }
  
  if (switchA == 1) {
      // println("A: ON");
  } else {
    
      // println("A: OFF");
  }

}  // end draw


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
