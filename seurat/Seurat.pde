
Interpreter interpreter;
FrameSet frameSet;
Controller controller;
Responder responder;
Serial port;
SerialManager serialManager;
Sound sound;
// int noteFrameSize = 220;  // 200


int phase = 0;    // phase increases by 1 after each phrase
int phase2 = 0;   // phase2 increases by 1 each time the score is complete

boolean mainDisplayOn = true;


/// period = 2000 works
// int period = 2000;
// int onPeriod = period;  // int(0.9*period);

String message_ = "";
float message_text_size = 0;
float message_x = 0;
float message_y = 0;

// int fc;

void setup () {
  
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

  // SOUND
  sound = new Sound(25, 144);  // 15, 124
  sound.setupVoices();
 
}

void startupScreen() {
  
 if (frameCount < 60) {
   mainDisplayOn = false;
 } else {
   mainDisplayOn = true;
 }
  
  if ((frameCount > 30) && (frameCount < 170)) {

    fill(200);
    textSize(80);
    text("Bebop in C", 250, 250);
  }
  if ((frameCount > 50) && (frameCount < 110)) {
    fill(0,0,255);
    textSize(50);
    text("Jim Carlson", 300, 400); 
  }
  if ((frameCount > 50) && (frameCount < 110)) {
    
    fill(20,20,40);
    ellipse(530,485,120,120);
    fill(0,0,255);
    ellipse(560,485,40,40);
    rectMode(CENTER);
    // rect(530,485,5,120);
    rectMode(CORNER);
    
    fill(0,0,255);
    text("Offcenter Studios", 600, 500);
    text("2013", 1000, 560); 
    
     
  }
  textSize(18);
}

void draw () {

  interpreter.run(frameCount);
 
  phase = int(frameCount/sound.framesPerPhrase);
  phase2 = int(frameCount/(sound.framesPerPhrase*sound.scoreLength)) + 1;

  serialManager.handleInput();
  
  sound.play();
  
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
