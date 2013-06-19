
Interpreter interpreter;
FrameSet frameSet;
Controller controller;
Responder responder;
Serial port;
SerialManager serialManager;

Score opus;
Pitch pitch;
Sound sound;
Ensemble ensemble;


int beatsPerPhrase = 25;
float bpm = 140;
int phase = 0;    // phase increases by 1 after each phrase
int phase2 = 0;   // phase2 increases by 1 each time the score is complete

boolean mainDisplayOn = true;

String message_ = "";
float message_text_size = 0;
float message_x = 0;
float message_y = 0;

void setup () {
  
  pitch = new Pitch();
  
  // randomSeed(hour()*minute()*second() + millis()); 
  
  interpreter = new Interpreter("program1" );
  interpreter.initialize();

  HEIGHT = displayHeight;
  setAppearance();

  // SERIAL OOMMUNICATION
  port = new Serial(this, USB_PORT, 9600); 
  serialManager = new SerialManager(port, 6);

  // FRAMESET
  frameSet = new FrameSet(WW, NumberOfFrames);
  frameSet.configure();

  // CONTROLLER
  controller = new Controller(numberOfControlBanks); 
  frameSet.setColorTori();

  responder = new Responder(frameSet, controller);
 
 // LOAD SCORE
  opus = new Score("op3n1");
  opus.display();
  println("Number of sections = "+nfc(opus.numberOfSections()));
  println("Number of parts = "+nfc(opus.numberOfParts()));
  println("-------------------------------\n\n");
  opus.displayGenerators();
  println("-------------------------------\n\n");
  println("BAR");

  // SOUND & PLAYER
  sound = new Sound(25, 144);  // 15, 124
  ensemble = new Ensemble(opus, sound, 25, 144);
  
}


void draw () {

  interpreter.run(frameCount);
 
  int framesPerPhrase = int(60*frameRate*beatsPerPhrase/bpm); 
  println("framesPerPhrase = "+nfc(framesPerPhrase,1));
  phase = int(frameCount/framesPerPhrase);
  phase2 = int(frameCount/(sound.framesPerPhrase*sound.scoreLength)) + 1;

  serialManager.handleInput();
  
  ensemble.play();
  
  if (mainDisplayOn) {
    display();
  }
  
  textSize(message_text_size);
  text(message_, message_x, message_y);
  
  if (frameCount < 500) {
    startupScreen();
  }
  
}  


void stop()
{
  sound.stop();
  super.stop();
}

//////////////////////////////////////////////////

void mousePressed() {

  responder.manageMousePress();
}


void keyPressed() {

  responder.manageKeyPress();
}

void keyReleased() {

  if (key != CODED) {
    switch(key) {
    case BACKSPACE:
      responder.typedText = responder.typedText.substring(0, max(0, responder.typedText.length()-1));
      break;
    case TAB:
      responder.typedText += "";
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
      responder.typedText += key;
    }
  }
}

/////////////////////////////////////////////////

void display() {

  if (displayOn) {
    count++;   
    controller.display();
    frameSet.display();
    displayMessage();
  } 
  else 
  {
    text(responder.typedText+(frameCount/10 % 2 == 0 ? "_" : ""), 35, 45);
  }
}

void setAppearance() {

  int WIDTH = int((1/inverseGoldenRatio)*HEIGHT);

  if (screenControlsOn) {

    HEIGHT = displayHeight - displayMargin;  // Set HEIGHT to some value manually if you wish
  }

  // Appearance:

  if (screenControlsOn) { 
    WW = WIDTH - controlMargin;
  } 
  else { 
    WW = WIDTH;
  }
  font = loadFont("AndaleMono-48.vlw");
  textFont(font);
  // size(WW, HEIGHT);
  size(displayWidth, displayHeight);

  smooth();
  background(0);
}
