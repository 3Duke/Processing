

void setup () {
  
  smooth();
  
  if (screenControlsOn) {
  
    HEIGHT = displayHeight - displayMargin;  // Set HEIGHT to some value manually if you wish
  
  }
  
  int WIDTH = int((1/inverseGoldenRatio)*HEIGHT);
  
  
  port = new Serial(this, USB_PORT, 9600); 
  port.bufferUntil('\n');

  font = loadFont("AndaleMono-48.vlw");
  textFont(font);

  if (screenControlsOn) {
    
    size(WIDTH - controlMargin, HEIGHT);
    
  } else {
    
    size(WIDTH, HEIGHT);
    
  }

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


  if (screenControlsOn) {
    setupFrames2(WIDTH-controlMargin);
  } else {
    setupFrames2(WIDTH);
  }
  
  colorBox1 = new Box(20, height - 45, 30, 30, "");
  colorBox2 = new Box(20, height - 5, 30, 30, "");
  setColorTori();
  
  fileControlBox = new Box(960, height - 45, 30, 30, "F");
  textControlBox = new Box(960, height - 5, 30, 30, "T");
  fileControlBox.setRGBAColor(0,0,200,255);
  textControlBox.setRGBAColor(0,0,200,255);
  
  
  String particleLabels[] = { 
    "C", "T", "Q", "L", "W"
  };
  
  control = new Control(270, height - 20, 150, 40, particleLabels.length, particleLabels); 
  colorWheel1 = new ColorWheel(100, height - 40, 70, "Color 1");
  colorWheel2 = new ColorWheel(180, height - 40, 70, "Color 2");
 
  speedSlider = new Slider(480, height - 20, 200, 40, 100, "fps", "Framerate");
  radiusSlider = new Slider(720, height - 20, 200, 40, MAXRADIUS, "r", "Radius");
  
  alphaSlider = new Slider(20, height - 25, 200, 40, maxAlpha, "a", "Alpha");
  maxLevelSlider = new Slider(460, height - 25, 200, 40, 1.0, "max", "Maximum Level");
  minLevelSlider = new Slider(240, height - 25, 200, 40, 1.0, "min", "Minimum Level");
  
  speedSlider.setValue(baseFrameRate);  
  radiusSlider.setValue(INITIAL_RADIUS);
  alphaSlider.setValue(frameAlpha);
  maxLevelSlider.setValue(maxLevel);
  minLevelSlider.setValue(minLevel);
  

  controlsActive = false;
  controlsActive2 = false;
  acceptDisplayString = false;
  acceptFileName = false;
  acceptText = false;
  acceptFileName = false;

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
  
  
  
  if ((!acceptText) && (!acceptFileName)) {
    count++;
    
    //////////////////////  
   
    displayControls();
    displayFrames();
    displayMessage();
    
    // manageFrameRate();
  }

  if ((acceptText) || (acceptFileName)) {
    text(typedText+(frameCount/10 % 2 == 0 ? "_" : ""), 35, 45);
  }
  
  if (switchA == 1) {
      // println("A: ON");
  } else {
    
      // println("A: OFF");
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
