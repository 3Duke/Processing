

// Serial port
import processing.serial.*;
Serial port;
String USB_PORT = "/dev/tty.usbmodem1411";
String incomingMessage = "";                     // message recieved on serial port
int NFIELDS = 6;                                 // Number of fields in incomingMessage

// Serial protocal exampe: if incomiing message (e.g., produced by Arduino 
// sketch SerialReportor) is "S,4,5,6", then NFIELDS = 3.  The leading "S"
// is htere to confirm that the data is valid.


// Serial data
float colorAngle1, colorAngle2, particleSize, speedRead;  // Analogue: values in range 0..1023.
int switchA,  switchB, switchC;  // Digital.  Values are 0 and 1'

//////// MASTER OBJECTS /////
FrameSet frameSet;
Controller controller;


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
  
  frameSet = new FrameSet(WW, NumberOfFrames);
  frameSet.setQualities();
  frameSet.setColorPhase(20);
 
  controller = new Controller(); 

  frameSet.setColorTori();  

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
