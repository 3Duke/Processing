
Parameters parameters;

Interpreter interpreter;
FrameSet frameSet;
Controller controller;
Responder responder;
Serial port;
SerialManager serialManager;
  
  
Pitch pitch;
Music music;

boolean mainDisplayOn = true;
boolean debug = true;



Message message1 = new Message("", 0, 0, 18);
RunningMessage message = new RunningMessage("", "");

void setup () {

  parameters = new Parameters();
  
   pitch = new Pitch();
    
    if (pitch == null) {
      println("pitch is NULL");
    } else {
      println("pitch is OK");
    }
  
  music = new Music("op3n1", 25, 144);
  music.display();

  if (music == null) {
    println("ERROR: music is NULL");
  } 
  else {
    println("music is OK");
  }


  // randomSeed(hour()*minute()*second() + millis()); 

  interpreter = new Interpreter("program1" );
  interpreter.initialize();

  parameters.HEIGHT = displayHeight;
  setAppearance();

  // SERIAL OOMMUNICATION
  port = new Serial(this, parameters.USB_PORT, 9600); 
  serialManager = new SerialManager(port, 6);

  // FRAMESET
  frameSet = new FrameSet(parameters.WW, parameters.numberOfFrames);
  frameSet.configure();

  // CONTROLLER
  controller = new Controller(parameters.numberOfControlBanks); 
  frameSet.setColorTori();

  responder = new Responder(frameSet, controller);

  
}


void draw () {
  
    music.phase = int(frameCount/music.framesPerPhrase);
    // music.phase2 = int(frameCount/(music.framesPerPhrase*sound.scoreLength)) + 1;

  interpreter.run(frameCount);


  serialManager.handleInput();

  music.ensemble.play();

  if (mainDisplayOn) {
    display();
  }

  message1.display();

  if (frameCount < 500) {
    startupScreen();
  }
}  


void stop()
{
  music.sound.stop();
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

  if (parameters.displayOn) {
    // count++;   
    controller.display();
    frameSet.display();
    message.display();
  } 
  else 
  {
    text(responder.typedText+(frameCount/10 % 2 == 0 ? "_" : ""), 35, 45);
  }
}

void setAppearance() {

  int WIDTH = int((1/parameters.inverseGoldenRatio)*HEIGHT);

  if (parameters.screenControlsOn) {

    parameters.HEIGHT = displayHeight - parameters.displayMargin;  // Set HEIGHT to some value manually if you wish
  }

  // Appearance:

  if (parameters.screenControlsOn) { 
    parameters.WW = WIDTH - parameters.controlMargin;
  } 
  else { 
    parameters.WW = WIDTH;
  }
  PFont font = loadFont("AndaleMono-48.vlw");
  textFont(font);
  // size(WW, HEIGHT);
  size(displayWidth, displayHeight);

  smooth();
  background(0);
}
