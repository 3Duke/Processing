
// Raindrop obj1, obj2;

PFont font; 

JCFrame [] frames;


Control control;
ColorWheel colorWheel1, colorWheel2;
Box colorBox1, colorBox2;
boolean controlsActive;


int count;
float goldenRatio = 0.618;
String message = "";
String previousMessage = "";

// ARTISTIC PARAMETERS
float MaxRadius = 120; // 60; // maximum particle radius
float frameAlpha = 7.5;  // increase to decrease persistence of drawing
float baseFrameRate = 15;

float Pi = 3.14159265;




void setupFrames(float WIDTH) {

  // Set up frames in golden ratio spiral

  float scale = 1;

  // corner of square
  float x = 0; 
  float y = 0;

  // wdith of square
  float W = goldenRatio*WIDTH; 

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
    W = goldenRatio*W;

    // scale factor to use inside frame for drawing
    scale = goldenRatio*scale;


    sf = 2*sf;

    if (i < frames.length - 1) {
      frames[i] = new JCFrame(x, y, W, W, 6, scale, sf);
    } 
    else {
      frames[i] = new JCFrame(x, y, W/goldenRatio, W, 6, scale, sf);
    }
    frames[i].phase = 200*i;  // 200*i ==> 10*i for test
  } // end for

}

void setColorTori() {

  float r1, g1, b1, r2, b2, g2;
  float dr, dg, db;
  float a;
  
  r1 = 0; g1 = 100; b1 = 200; a = 200;
  dr = 1; dg = 0; db = 1;
  
  float k = 100;
  r2 = r1 + k*dr; g2 = g1 + k*dg;  b2 = b1 + k*db;
  
   colorBox1 = new Box(430, height - 80, 30, 30);
  colorBox2 = new Box(430, height - 40, 30, 30);
   colorBox1.r = r1; colorBox1.g = g1; colorBox1.b = b1;
  colorBox2.r = r2; colorBox2.g = g2; colorBox2.b = b2;
  
  
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

void setColorTori2(float r1, float g1, float b1, float r2, float g2, float b2) {

  // 
  for (int i = 0; i < frames.length; i++) {
    // frames[i].randomSetColor();
    frames[i].setColor(r1, g1, b1, 200);

    // alpha value of frame.  Increase it for decreased persistence
    // object drawn in the frame
    frames[i].a = frameAlpha;

    // speed factor for changing color of frame
    frames[i].speed = 0.1;


    float dr = r2 - r1; float dg = g2 - g1; float db = b2 - b1;
    
    float k = 0.001;
    
    dr = k*dr; dg = k*dg; db = k*db;
    
    // relative rates of change for colors
    frames[i].setDColor(dr, (i+1)*dg, (i+1)*(i+1)*db, 0);
  }
}


void setup () {

  int HEIGHT =700;
  int WIDTH = int((1/goldenRatio)*HEIGHT);

  font = loadFont("AndaleMono-48.vlw");
  textFont(font);

  size(WIDTH, HEIGHT);
  frameRate(baseFrameRate); 

  frames = new JCFrame[9];

  setupFrames(WIDTH);
  setColorTori();
  
  String particleLabels[] = { "C", "T", "Q", "L", "W"};
  control = new Control(90, height - 60, 150, 40, 5, particleLabels); 
  colorWheel1 = new ColorWheel(300, height - 40, 70);
  colorWheel2 = new ColorWheel(380, height - 40, 70);
 
  controlsActive = false;

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
  message = str(frameCount) + ", " + str(round(frameRate));
  text(message, 10, height - 8);

}

void displayFrames () {

  float M = MaxRadius;
  for (int i = 0; i < frames.length; i++) {  // XXX

    frames[i].display(M);
    frames[i].change(200);
    M = goldenRatio*M;
  }
}

void manageFrameRate() {
  
   float currentFrameRate = baseFrameRate + 7*sin(2*Pi*frameCount/20000);
   frameRate(currentFrameRate);
  
}

void displayControls() {
  
  if (controlsActive) {
    
    control.display();
    
    colorWheel1.display();
    colorWheel2.display();
    
    colorBox1.display(); 
    colorBox2.display();
     
  }
  
}

void diagnosticMessage() {
  
  println(frameCount+": "+colorBox1.x +", "+colorBox1.y +", "+colorBox1.w +", "+colorBox1.h);
 
}

void nop() {} // dummy function, does nothing

void draw () {
  
  if (frameCount == 1602) {
    
   //  nop(); //<>//
    
  }

  count++;
  displayFrames();
  displayControls();
  displayMessage();
 
  // diagnosticMessage();
  
}  // end draw


////////
