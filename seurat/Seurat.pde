
Interpreter interpreter;
FrameSet frameSet;
Controller controller;
Responder responder;
Serial port;
SerialManager serialManager;
Sound sound;
int longCount = 220;  // 200
int phase = 0;
/// period = 2000 works
int period = 2000;
int onPeriod = period;  // int(0.9*period);



// int fc;

void setup () {
  
  /*
  Instruction i0 = new Instruction("1 color 255 0 0 0 0 255");
  Instruction i1 = new Instruction("2 radius 100 200");
  Instruction i2 = new Instruction("3 shape quad");
  Instruction i3 = new Instruction("4 framerate 15");
  Instruction i4 = new Instruction("5 alpha 1.0");
  Instruction i5 = new Instruction("6 colorvelocity 0.9");
  Instruction i6 = new Instruction("7 currentradius 100");  
  
  Instruction [ ] program = { i0, i1, i2, i3, i4, i5, i6 };
  */
  
  interpreter = new Interpreter("program2" );

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
  sound = new Sound();
 
}

void draw () {

  interpreter.run(frameCount);
  // println(nfc(1+frameCount/MODULUS,0) +", "+frameCount+": "+fc+", "+ phase);
  phase = int(frameCount/longCount);
  int periodCount = int(frameCount/period) + 1;
  // println(periodCount+", "+phase+": "+frameCount);
  serialManager.handleInput();
  sound.play();
  // sound.test();
  display();
}  // end draw


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
