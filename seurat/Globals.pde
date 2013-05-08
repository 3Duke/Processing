
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

//////////////////////////////////////////////////////////////////////////////////////////

// CONSTANTS
float inverseGoldenRatio = 0.618;
int COMMAND = 157;
float deg = 2*PI/360;


//////////////////////////////////////////
