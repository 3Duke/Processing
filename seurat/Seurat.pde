
// Serial port
import processing.serial.*;
Serial port;
String USB_PORT = "/dev/tty.usbmodem1411";
String incomingMessage = "";
int N_SERIAL_INPUTS = 6;

// Analogue data:
float colorAngle1, colorAngle2, particleSize, speedRead;
 // Digital inputs:
int switchA,  switchB, switchC;


// Frames and Controls
JCFrame [] frames;
Control control;
ColorWheel colorWheel1, colorWheel2;
Box colorBox1, colorBox2;
Slider radiusSlider, speedSlider;

// Switches
boolean controlsActive;
boolean acceptText;
boolean acceptFileName;
boolean acceptDisplayString;

// Text display
PFont font;
String typedText = "";
String displayString = "art";
String message = "";
String previousMessage = "";

int count;
String fileName = "frame";

// Global settings:
int HEIGHT = 700; // displayHeight; // 700 for macbook air, 1390 for iMac
float displayScale = HEIGHT/700;
int NumberOfFrames = 11;
int displayMode = 1;  // 1 for classic, 2 for diagonal 


// ARTISTIC PARAMETERS
float MAXRADIUS = 240;
float INITIAL_RADIUS = 24;
float MaxRadius = INITIAL_RADIUS; // 60; // maximum particle radius
float frameAlpha = 7.5;  // increase to decrease persistence of drawing
float baseFrameRate = 30;

color c1, c2;

// CONSTANTS
float inverseGoldenRatio = 0.618;

void setupFrames1(float WIDTH) {

  // Set up frames in golden ratio spiral

  float scale = 1;

  // corner of square
  float x = 0; 
  float y = 0;

  // wdith of square
  float W = inverseGoldenRatio*WIDTH; 

  // first frame
  float sf = 1.0;
  frames[0] = new JCFrame(x, y, W, W, 6, scale, sf);

  // the other frames
  for (int i = 1; i < frames.length; i++) {

    // compute new upper left corner
    if (i % 2 == 0) {
      y = y + W;
    } 
    else {
      x = x + W;
    }

    // compute width of square
    W = inverseGoldenRatio*W;

    // scale factor to use inside frame for drawing
    scale = inverseGoldenRatio*scale;


    sf = 2*sf;

    if (i < frames.length - 1) {
      frames[i] = new JCFrame(x, y, W, W, 6, scale, sf);
    } 
    else {
      frames[i] = new JCFrame(x, y, W/inverseGoldenRatio, W, 6, scale, sf);
    }
    frames[i].phase = 200*i;  // 200*i ==> 10*i for test
  } // end for
}

void setupFrames2(float WIDTH) {

  // Set up frames in golden ratio spiral

  float scale = 1;

  // corner of square
  float x = 0; 
  float y = 0;

  // wdith of square
  float W = inverseGoldenRatio*WIDTH; 
  float pW = W; // previous W

    
  // first frame
  float sf = 1.0;
  frames[0] = new JCFrame(x, y, W, W, 6, scale, sf);

  // the other frames
  for (int i = 1; i < frames.length; i++) {

    // compute new upper left corner
    if (i % 4 == 1) {

      x = x + W;
      pW = W;
      W = inverseGoldenRatio*W;
    } 
    else if ( i % 4 == 2) {

      x = x +  inverseGoldenRatio*(pW - W);
      y = y + W;
      pW = W;
      W = inverseGoldenRatio*W;
    }
    else if ( i % 4 == 3) {

      x = x - inverseGoldenRatio*W;
      y = y + W;
      y = y - inverseGoldenRatio*W;
      W = inverseGoldenRatio*W;
    }
    else if ( i % 4 == 0) {

      y = y - inverseGoldenRatio*W;
      W = inverseGoldenRatio*W;
    }

    // compute width of square
    // W = inverseGoldenRatio*W;

    // scale factor to use inside frame for drawing
    scale = inverseGoldenRatio*scale;


    sf = 2*sf;


    frames[i] = new JCFrame(x, y, W, W, 6, scale, sf);
 

    if (i == frames.length - 1) {
      if (i % 4 == 0 ) {
       
        frames[i].w =  frames[i].w/inverseGoldenRatio;
      } 
      else if (i % 4 == 1) {
       
        frames[i].h =  frames[i].h/inverseGoldenRatio;
      } 
      else if (i % 4 == 2) {
       
        float xx = frames[i].x;
        float ww = frames[i].w/inverseGoldenRatio;
        float dx = ww/inverseGoldenRatio - ww;
        frames[i].x = xx - dx*inverseGoldenRatio;
        frames[i].w = ww;
      } 
      else if (i % 4 == 3) {
  
        float yy = frames[i].y;
        float ww = frames[i].w/inverseGoldenRatio;
        float dy = ww/inverseGoldenRatio - ww;
        frames[i].y = yy - dy*inverseGoldenRatio;
        frames[i].h = ww;
      }
    }


    frames[i].phase = 200*i;  // 200*i ==> 10*i for test
    frames[i].levelMin = 0.2;
    frames[i].levelMax = 1.0;
    frames[i].levelPhase = frames[i].phase*sqrt(2);
    frames[i].levelPeriod  = 20000/(i+1);
  } // end for
}

void setColorTori() {

  float r1, g1, b1, r2, b2, g2;
  float dr, dg, db;
  float a;

  r1 = 0; 
  g1 = 100; 
  b1 = 200; 
  a = 200;
  dr = 1; 
  dg = 0; 
  db = 1;

  float k = 100;
  r2 = r1 + k*dr; 
  g2 = g1 + k*dg;  
  b2 = b1 + k*db;

 /////////UUUU
  colorBox1.r = r1; 
  colorBox1.g = g1; 
  colorBox1.b = b1;
  colorBox2.r = r2; 
  colorBox2.g = g2; 
  colorBox2.b = b2;


  for (int i = 0; i < frames.length; i++) {
    // frames[i].randomSetColor();
    frames[i].setColor(0, 100, 200, 200);

    // alpha value of frame.  Increase it for decreased persistence
    // object drawn in the frame
    frames[i].a = frameAlpha;

    // speed factor for changing color of frame
    frames[i].speed = 0.1;

    // relative rates of change for colors
    frames[i].setDColor(1, 0, (i+1)*(i+1), 0);
  }
}

void setColorTori2(Box box1, Box box2) {

  float r1, g1, b1, r2, g2, b2;
  
  r1 = box1.r; g1 = box1.g; b1 = box1.b;
  r2 = box2.r; g2 = box2.g; b2 = box2.b;
  // 
  for (int i = 0; i < frames.length; i++) {
    // frames[i].randomSetColor();
    frames[i].setColor(r1, g1, b1, 200);

    // alpha value of frame.  Increase it for decreased persistence
    // object drawn in the frame
    frames[i].a = frameAlpha;

    // speed factor for changing color of frame
    frames[i].speed = 0.1;


    float dr = r2 - r1; 
    float dg = g2 - g1; 
    float db = b2 - b1;

    float k = 0.01;//  0.001;

    dr = k*dr; 
    dg = k*dg; 
    db = k*db;

    // relative rates of change for colors
    frames[i].setDColor(dr, (i+1)*dg, (i+1)*(i+1)*db, 0);
  }
}

void setColorTori3(color C1, color C2) {

  
  float r1 = red(C1);
  float g1 = green(C1);
  float b1 = blue(C1);
  
  float r2 = red(C2);
  float g2 = green(C2);
  float b2 = blue(C2);
  // 
  for (int i = 0; i < frames.length; i++) {
    // frames[i].randomSetColor();
    frames[i].setColor(r1, g1, b1, 200);

    // alpha value of frame.  Increase it for decreased persistence
    // object drawn in the frame
    frames[i].a = frameAlpha;

    // speed factor for changing color of frame
    frames[i].speed = 0.1;


    float dr = r2 - r1; 
    float dg = g2 - g1; 
    float db = b2 - b1;

    float k = 0.001;

    dr = k*dr; 
    dg = k*dg; 
    db = k*db;

    // relative rates of change for colors
    frames[i].setDColor(dr, (i+1)*dg, (i+1)*(i+1)*db, 0);
  }
}


void setColorTorus(color C, float alpha) {

  
  float r1 = red(C);
  float g1 = green(C);
  float b1 = blue(C);
  
   // 
  for (int i = 0; i < frames.length; i++) {
    // frames[i].randomSetColor();
    frames[i].setColor(r1, g1, b1, alpha);

    // alpha value of frame.  Increase it for decreased persistence
    // object drawn in the frame
    frames[i].a = frameAlpha;

    // speed factor for changing color of frame
    frames[i].speed = 0.1;
  }
}


void setColorTorusPathAngle(float dA) {
 
  // dA  = 30;
  
  float t = dA/360;
  float dr, dg, db;
  
  if (t < 0.33) 
  {
   dr = 1 - 3*t; dg = 3*t; db = 0;
  }
  else if (t < 0.66) 
  {
    dr = 0; dg = 2 - 3*t; db = 3*t - 1;
  } else {
    dr = 3*t - 2; dg = 0; db = 3 - 3*t;
  }
  
  message = "t = "+nfc(t,2)+",  dr = "+nfc(dr,2)+", dg = "+nfc(dg,2)+", db = "+nfc(db,2);
  
  colorMode(RGB,255,255,255,255);
  
  float K = 1.4;
  float F = 1;
  
  float k = 1;  // k is base color velocity
  dr = k*dr; 
  dg = k*dg; 
  db = k*db;
  
  for (int i = 0; i < frames.length; i++) {
    
    // relative rates of change for colors
    // frames[i].setDColor(dr, (i+1)*dg, (i+1)*(i+1)*db, 0);
    
    frames[i].setDColor(F*dr, F*dg, F*db, 0);
    F = K*F;
  }
}

void setup () {
  
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
 
  speedSlider = new Slider(480, height - 20, 200, 40, 30, "fps");
  radiusSlider = new Slider(720, height - 20, 200, 40, 400, "r");

  controlsActive = false;
  acceptDisplayString = false;
  acceptFileName = false;
  acceptText = false;

  background(0);
}


void displayMessage() {

  noStroke();

  textSize(12);
  // Erase the previous display of frameCount
  fill(frames[0].r, frames[0].g, frames[0].b, 255);
  text(previousMessage, 10, height - 8);
  // Display frameCount
  fill(200);
  previousMessage = message;
  // message = str(frameCount) + ", " + str(round(frameRate));
  text(message, 10, height - 8);
}

void displayFrames () {

  float M = MaxRadius;

  for (int i = 0; i < frames.length; i++) {  // XXX

    frames[i].display(M);
    frames[i].change(200);
    M = inverseGoldenRatio*M;
  }
}

void manageFrameRate() {

  float currentFrameRate = baseFrameRate + 7*sin(TWO_PI*frameCount/20000);
  frameRate(currentFrameRate);
}

void displayControls() {
  
  
  if (switchA == 1) {
    
    colorBox1.display(); 
    colorBox2.display();
  }

  if (controlsActive) {

    control.display();

    colorWheel1.display();
    colorWheel2.display();

    colorBox1.display(); 
    colorBox2.display();

    radiusSlider.display();
    speedSlider.display();

    float radiusRead = radiusSlider.read();
    if (radiusRead > 0) {
      MaxRadius = radiusRead;
    }
    
    float speedRead = speedSlider.read();
    if (speedRead > 0) {
      baseFrameRate = speedRead;
    }
   
  }
}

void nop() {
} // dummy function, does nothing



void draw () {

  if (incomingMessage.length() > 0) 
  {
    if (incomingMessage.charAt(0) == 'S') 
    {
      parseSerialData(N_SERIAL_INPUTS);
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
    
      // controlsActive = true;
      println("A: ON");
  } else {
    
    // controlsActive = false;
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

void parseSerialData(int n_serial_inputs) {
   
  println(incomingMessage);
  String value[] = incomingMessage.split(",");
  
  
    // Example of data format for serial data (a string):
    // "S,123.4,8,9"
    // In this case nFields = 3
    // The first field is "S".  Its presence confirms
    // the validity of the string received.
    
    
     // Get digital inputs:
     switchA = int(value[4]);
     switchB = int(value[5]);
     switchC = int(value[6]);
    
    if (value.length == n_serial_inputs + 1) { 
     
     if (switchA == 1) // Manage bank 1 -- colors
     {
       colorAngle1 = float(value[1]);
       colorAngle2 = float(value[2]);  

       colorAngle1 = map(colorAngle1, 0, 1023, 0, 360); 
       colorAngle2 = map(colorAngle2, 0, 1023, 0, 360);
     } 
    else  // Manage bank 0 -- speed, size, 
    {
      particleSize = float(value[1]);
      speedRead = float(value[2]);
      
      particleSize = map(particleSize, 0, 1023, 0, 200);
      speedRead = map(speedRead, 0, 1023, 0, 200);
     }
   
     
    }
    
}

void reactToData () 
{          
   /* 
  if (speedRead > 0) {
  baseFrameRate = speedRead;  
  }
  */
    
  colorMode(HSB, 360, 1, 1);   
  color c = color(colorAngle1, 1, 1);
  // message = "angle = "+colorAngle1+"speed = "+speedRead +"    A = "+ switchA+" B = "+switchB+" C = "+switchC;      
  colorMode(RGB, 255, 255, 255, 255);
  
  /** c1 *
  if (switchC == 1) {
    setColorTorus(c, 200);
    setColorTorusPathAngle(colorAngle2);
  }
  **/
  
  
  if (switchA == 1)  // Bank 1 --- manage colors
  {
    colorMode(HSB, 360, 1, 1);
    color cc = color(colorAngle1, 1, 1);
    colorBox1.setColor(cc);
    
    colorMode(HSB, 360, 1, 1);
    cc = color(colorAngle2, 1, 1);
    println("CA2 = "+nfc(colorAngle2,1));
    colorBox2.setColor(cc);
    
  } else 
  {

    if (particleSize > 0) {
      MaxRadius = particleSize;
    }
    
    if (speedRead > 0) {
      
      baseFrameRate = speedRead;
      manageFrameRate();
      // frameRate(baseFrameRate);
    }
  }
  

 
 
}


void serialEvent(Serial port) {
  incomingMessage = port.readStringUntil('\n');
  incomingMessage = incomingMessage.trim();
  // println(incomingMessage);

}
////////

