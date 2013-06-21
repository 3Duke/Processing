
Parameters parameters;

Interpreter interpreter;
FrameSet frameSet;
Controller controller;
Responder responder;
Serial port;
SerialManager serialManager;


Pitch pitch;
MusicParameters musicParameters;
Music music;

boolean mainDisplayOn = true;
boolean debug = true;

Message message1 = new Message("", 0, 0, 18);
RunningMessage message = new RunningMessage("", "");

void setup () {
  
  println("DISPLAY: "+nfc(displayWidth)+", "+nfc(displayHeight));

  println("@ DEBUG 0");
  parameters = new Parameters(true, true);

  randomSeed(hour()*minute()*second() + millis()); 

 
  setAppearance();

  // SERIAL OOMMUNICATION
  port = new Serial(this, parameters.USB_PORT, 9600); 
  serialManager = new SerialManager(port, 6);

  // FRAMESET
  frameSet = new FrameSet(parameters.frameHeight, parameters.numberOfFrames);
  frameSet.configure();

  // CONTROLLER
  int xc = int(parameters.horizontalFrameMargin);
  int yc = int(parameters.verticalFrameMargin + parameters.frameHeight);
  
  controller = new Controller(parameters.numberOfControlBanks, xc, yc);
  frameSet.setColorTori();

  responder = new Responder(frameSet, controller);

  musicParameters = new MusicParameters();

  interpreter = new Interpreter("program1" );
  interpreter.initialize();

  println("@ 1");
  pitch = new Pitch();
  musicParameters.initialize();
  music = new Music(musicParameters);
  music.display();
  
  
}


void draw () {
  
  
  float xxx = parameters.horizontalFrameMargin, yyy = parameters.verticalFrameMargin;
  /*
  fill(255,0,0);
  rect(0,0,xxx,yyy);
  */


  if (frameCount > 15) {
    music.framesPerPhrase = int(60*frameRate*music.beatsPerPhrase/music.bpm);
  }
  music.phase = int(frameCount/music.framesPerPhrase);
  music.phase2 = int(frameCount/(music.framesPerPhrase*music.opus.numberOfSections()));

  interpreter.run(frameCount);


  serialManager.handleInput();

  music.ensemble.play();

  if (mainDisplayOn) {
    display();
      
    /*   
    fill(255,0,0);
    rect(0,0,xxx,yyy);
    */
   
    
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

 

  // Appearance:

  
  PFont font = loadFont("AndaleMono-48.vlw");
  textFont(font);
  // size(WW, HEIGHT);
  size(displayWidth, displayHeight);

  smooth();
  background(0);
}
