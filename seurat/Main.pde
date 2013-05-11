


//////// MASTER OBJECTS /////
FrameSet frameSet;
Controller controller;
Responder responder;
Serial port;
SerialManager serialManager;
Sound sound;


///

int WW, HEIGHT;

String USB_PORT = "dev/Bluetooth-PDA-Sync";    // "/dev/slave"; // "/dev/tty.usbmodem1411"

void setup () {
  
  foobar = randomString(4);
  
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
 
  /// acceptDisplayString = false;
  acceptFileName = false;
  acceptText = false;
  acceptFileName = false;
  
}

void draw () {

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


///////////////////////////////////////////////////////

void mousePressed() {

  responder.manageMousePress();
  
}
  

void keyPressed() {

  responder.manageKeyPress();
  
}

/////////////////////////////////////////////////

void display() {
  
  if ((!acceptText) && (!acceptFileName)) {
    count++;   
    controller.display();
    frameSet.display();
    displayMessage();
    
    // manageFrameRate();
  }

  if ((acceptText) || (acceptFileName)) {
    text(typedText+(frameCount/10 % 2 == 0 ? "_" : ""), 35, 45);
  }
  
}

void setAppearance() {
  
  int WIDTH = int((1/inverseGoldenRatio)*HEIGHT);
  
  if (screenControlsOn) {
  
    HEIGHT = displayHeight - displayMargin;  // Set HEIGHT to some value manually if you wish
  
  }
  
  // Appearance:

  if (screenControlsOn) { WW = WIDTH - controlMargin; } else { WW = WIDTH; }
  font = loadFont("AndaleMono-48.vlw");
  textFont(font);
  size(WW, HEIGHT);
  
  smooth();
  background(0);
  
}
