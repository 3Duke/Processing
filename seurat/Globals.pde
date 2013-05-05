
///////////////////////////////////////////////////////////////////////////
//
//     GLOBAL VARIABLES
//
///////////////////////////////////////////////////////////////////////////


// Switches
boolean screenControlsOn = true;
boolean controlsActive, controlsActive2;
boolean acceptText;
boolean acceptFileName;
boolean acceptDisplayString;


// Text 
PFont font;
String typedText = "";
String displayString = "art";
String message = "";
String previousMessage = "";

int count;
String fileName = "frame";

// Display
int HEIGHT = 700; // displayHeight; // 700 for macbook air, 1390 for iMac
float displayScale = HEIGHT/700;
int controlMargin = 140;
int displayMargin = 60;


// ARTISTIC PARAMETERS
int NumberOfFrames = 11;
int displayMode = 1;  // 1 for classic, 2 for diagonal 
int NUMBER_OF_PARTICLES = 4  ;  // number of particles in each frame
float MAXRADIUS = 180;
float INITIAL_RADIUS = 130;
float spacingFactor = 1.0;
float CSPEED = 0.1;
float MaxRadius = INITIAL_RADIUS; // 60; // maximum particle radius
float maxAlpha = 10.0;
float frameAlpha = 4.0;  // increase to decrease persistence of drawing
float baseFrameRate = 30;
float maxLevel = 1.0;
float minLevel = 0.8;

// CONSTANTS
float inverseGoldenRatio = 0.618;
int COMMAND = 157;
float deg = 2*PI/360;
