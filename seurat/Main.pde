

///////////////////////////////////////////////////////////////////////////
//
//     GLOBAL VARIABLES
//
///////////////////////////////////////////////////////////////////////////

// Initializatin of main
boolean screenControlsOn = true;
String foobar;
XML xml = createXML("filesSaved");
String logString;
String logStringArray[] = new String[0];

// Initializaton of controller:
int numberOfControlBanks = 3;


// Switches
boolean acceptText;
boolean acceptFileName;
//   boolean acceptDisplayString;


// Text 
PFont font;
String typedText = "";
String displayString = "art";
String message = "";
String previousMessage = "";

int count;
String fileName = "frame";

// Display
int controlMargin = 140;
int displayMargin = 60;
char lastKey;;

//////////////////////////// ARTISTIC PARAMETERS /////////////////////////////////

int NumberOfFrames = 11;
int displayMode = 1;  // 1 for classic, 2 for diagonal 

//////////////////////////////////////////////////////////////////////////////////////////

// CONSTANTS
float inverseGoldenRatio = 0.618;
int COMMAND = 157;
float deg = 2*PI/360;


//////////////////////////////////////////


// Serial port
import processing.serial.*;
Serial port;
String USB_PORT = "dev/Bluetooth-PDA-Sync";    // "/dev/slave"; // "/dev/tty.usbmodem1411";
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

int HEIGHT = displayHeight;

///////////

// SOUND

import ddf.minim.*;
import ddf.minim.ugens.*;
// this time we also need effects because the filters are there for this release
import ddf.minim.effects.*;

// create all of the variables that will need to be accessed in
// more than one methods (setup(), draw(), stop()).
Minim minim;
AudioOutput out;
NoiseInstrument myNoise, myNoise2, myNoise3, myNoise4;

//////////

void setup () {

   //// SOUND
  float soundLevel = 4.0;
  // initialize the minim and out objects
  minim = new Minim( this );
  out = minim.getLineOut( Minim.MONO, 512 );
  // need to initialize the myNoise object   
  myNoise = new NoiseInstrument( 2.0*soundLevel, out );
  myNoise2 = new NoiseInstrument( 4.0*soundLevel, out );
  myNoise3 = new NoiseInstrument( 1.0*soundLevel, out );
  myNoise4 = new NoiseInstrument( 2.0*soundLevel, out );

  
  // play the note for 100.0 seconds
  out.playNote( 0.1, 10000.0, myNoise );
  /*
  out.playNote( 1, 10000.0, myNoise2 );
  out.playNote( 2, 10000.0, myNoise3 );
  // out.playNote( 3, 10000.0, myNoise4 );
  */

  //// END SOUND

  
  foobar = randomString(4);
  println("foobar = "+foobar);
  
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
  
  
  
  // Serial communication
  port = new Serial(this, USB_PORT, 9600); 
  port.bufferUntil('\n');


  // Create master objects
  frameSet = new FrameSet(WW, NumberOfFrames);
  frameRate(frameSet.baseFrameRate);
  frameSet.spacingFactor = 0.3;
  frameSet.makeFrames();
  frameSet.setQualities();
  frameSet.setColorPhase(20);
 
  controller = new Controller(numberOfControlBanks); 

  frameSet.setColorTori();  
 
  /// acceptDisplayString = false;
  acceptFileName = false;
  acceptText = false;
  acceptFileName = false;

  background(0);
}


void handleSerialInput() {
  
  if (incomingMessage.length() > 0) 
  {
    if (incomingMessage.charAt(0) == 'S') 
    {
      parseSerialData(NFIELDS);
      reactToData();
    }
  }
}

void draw () {

  handleSerialInput();
  
  dialSound();
   
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


void stop()
{
  // close the AudioOutput
  out.close();
  // stop the minim object
  minim.stop();
  // stop the processing object
  super.stop();
  
}

/// SOUND

void dialSound() {
  
  float freq = map( frameSet.frame[0].hue_(), 0, 360, 220, 440 );
  float q = map( frameSet.frame[0].particles[0].x, 0, frameSet.frame[0].w, 20, 100 );
  // and call the methods of the instrument to change the sound
  myNoise.setFilterCF( freq );
  myNoise.setFilterQ( q );
  
  /*
 float freq2 = map( frameSet.frame[0].particles[0].x, 0, frameSet.frame[0].w, 60, 120 );
 float q2 = map( frameSet.frame[1].particles[0].y, 0, frameSet.frame[0].h, 20, 100 );
  // and call the methods of the instrument to change the sound
  myNoise2.setFilterCF( freq2 );
  myNoise2.setFilterQ( q2 );
  
  float freq3 = map( frameSet.frame[1].hue_(), 0, 360, 120, 240 );
  float q3 = map( frameSet.frame[1].particles[0].x, 0, frameSet.frame[1].w, 20, 100 );
  // and call the methods of the instrument to change the sound
  myNoise3.setFilterCF( freq3 );
  myNoise3.setFilterQ( q3 );
  
  
 float freq4 = map( frameSet.frame[0].particles[0].x, 0, frameSet.frame[1].w, 120, 240 );
 float q4 = map( frameSet.frame[1].particles[0].y, 0, frameSet.frame[1].h, 20, 100 );
  // and call the methods of the instrument to change the sound
  myNoise4.setFilterCF( freq4 );
  myNoise4.setFilterQ( q4 );
  */
}

void mouseMoved()
{
  /*
  // map the position of the mouse to useful values
  float freq = map( mouseY, 0, height, 1500, 150 );
  float q = map( mouseX, 0, width, 0.9, 100 );
  // and call the methods of the instrument to change the sound
  myNoise.setFilterCF( freq );
  myNoise.setFilterQ( q );
  */
  
}

/// END SOUND
