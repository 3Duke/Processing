

void setup () {
  
  smooth();
  
  HEIGHT = displayHeight - 80;  // Set HEIGHT to some value manually if you wish
  port = new Serial(this, USB_PORT, 9600); 
  port.bufferUntil('\n');

  int WIDTH = int((1/inverseGoldenRatio)*HEIGHT);

  font = loadFont("AndaleMono-48.vlw");
  textFont(font);

  size(WIDTH, HEIGHT);

  frameRate(baseFrameRate); 

  frames = new JCFrame[NumberOfFrames];

  switch(displayMode) {

  case 1: 
    setupFrames1(WIDTH); 
    break;

  case 2: 
    setupFrames2(WIDTH); 
    break;
  }



  setupFrames2(WIDTH);
  
  colorBox1 = new Box(20, height - 80, 30, 30);
  colorBox2 = new Box(20, height - 40, 30, 30);
  setColorTori();

  String particleLabels[] = { 
    "C", "T", "Q", "L", "W"
  };
  
  control = new Control(270, height - 60, 150, 40, 5, particleLabels); 
  colorWheel1 = new ColorWheel(100, height - 40, 70);
  colorWheel2 = new ColorWheel(180, height - 40, 70);
 
  speedSlider = new Slider(480, height - 20, 200, 40, 30, "fps", "Framerate");
  radiusSlider = new Slider(720, height - 20, 200, 40, 400, "r", "Radius");
  alphaSlider = new Slider(20, height - 40, 200, 40, 20, "r", "Alpha");

  controlsActive = false;
  controlsActive2 = false;
  acceptDisplayString = false;
  acceptFileName = false;
  acceptText = false;

  background(0);
}



void draw () {

  if (incomingMessage.length() > 0) 
  {
    if (incomingMessage.charAt(0) == 'S') 
    {
      parseSerialData(NFIELDS);
      reactToData();
    }
  }
  
  
  
  if (!acceptText) {
    count++;
    
    //////////////////////  
   
    displayControls();
    displayFrames();
    displayMessage();
    
    manageFrameRate();
  }

  if (acceptText) {
    text(typedText+(frameCount/10 % 2 == 0 ? "_" : ""), 35, 45);
  }
  
  if (switchA == 1) {
      println("A: ON");
  } else {
    
      println("A: OFF");
  }

}  // end draw


void keyReleased() {

  if (key != CODED) {
    switch(key) {
    case BACKSPACE:
      typedText = typedText.substring(0, max(0, typedText.length()-1));
      break;
    case TAB:
      typedText += "";
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
      typedText += key;
    }
  }
}
