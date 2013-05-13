
FrameSet frameSet;
Controller controller;
Responder responder;
Serial port;
SerialManager serialManager;
Sound sound;

int fc;
float phase;

void setup () {

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
  
  
fc = frameCount % 7000;
    phase = 1;
    if (fc < 500) { 
      phase = 0.5;
    } else if (fc < 1500) {
      phase = 1;
    } else if (fc < 3000) {
      phase = 2;
    } else if (fc < 5000) {
      phase = 0.5;
    } else if (fc < 6000) {
      phase = 0.25;
    } else if ( fc < 7000) {
      phase = -1;
    }
    
    println(fc+": "+ phase);

  serialManager.handleInput();
  sound.play();
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
  size(WW, HEIGHT);

  smooth();
  background(0);
}
