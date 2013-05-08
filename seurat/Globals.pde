
///////////////////////////////////////////////////////////////////////////
//
//     GLOBAL VARIABLES
//
///////////////////////////////////////////////////////////////////////////

// Initializatin of main
boolean screenControlsOn = true;

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


//////////////////////////// ARTISTIC PARAMETERS /////////////////////////////////
int NumberOfFrames = 11;
int displayMode = 1;  // 1 for classic, 2 for diagonal 

// Frames
float maxAlpha = 10.0;
float maxLevel = 1.0;
float minLevel = 0.8;
float frameAlpha = 4.0;  // increase to decrease persistence of drawing
float baseFrameRate = 30;

// Particles
int   NUMBER_OF_PARTICLES = 2  ;       // number of particles in each frame
float MAXRADIUS = 180;
float INITIAL_RADIUS = 130;
float MaxRadius = INITIAL_RADIUS;      // 60; // maximum particle radius

float CSPEED = 0.1;                    // Color velocity



//////////////////////////////////////////////////////////////////////////////////////////

// CONSTANTS
float inverseGoldenRatio = 0.618;
int COMMAND = 157;
float deg = 2*PI/360;


//////////////////////////////////////////

void printColor(color c, String label) {
  
  colorMode(RGB);
  println(label + ": rgb = " + red(c) + ", " + green(c) + ", " + blue(c));
  
}
