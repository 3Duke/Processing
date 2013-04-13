
// Raindrop obj1, obj2;

PFont font; 

JCFrame [] frames;
int count;
float goldenRatio = 0.618;
String message = "";
String previousMessage = "";

// ARTISTIC PARAMETERS
float MaxRadius = 120; // 60; // maximum particle radius
float frameAlpha = 7.5;  // increase to decrease persistence of drawing
float baseFrameRate = 15;


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
    frames[i].phase = 200*i;
  } // end for
}

void setColorTori() {

  // 
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

void setup () {

  int HEIGHT =700;
  int WIDTH = int((1/goldenRatio)*HEIGHT);

  font = loadFont("AndaleMono-48.vlw");
  textFont(font);
  textSize(12);

  size(WIDTH, HEIGHT);
  frameRate(baseFrameRate); 

  frames = new JCFrame[9];

  setupFrames(WIDTH);
  setColorTori();


  background(0);
}

void draw () {

  // delay(100);

  count++;

  float M = MaxRadius;
  for (int i = 0; i < frames.length; i++) {

    frames[i].display(M);
    frames[i].change(200);
    M = goldenRatio*M;
  }
  float Pi = 3.14159265;
  float currentFrameRate = baseFrameRate + 7*sin(2*Pi*frameCount/20000);
  frameRate(currentFrameRate);

  noStroke();

  // Erase the previous display of frameCount
  fill(frames[0].r, frames[0].g, frames[0].b, 255);
  text(previousMessage, 10, height - 8);
  // Display frameCount
  fill(200);
  previousMessage = message;
  message = str(frameCount) + ", " + str(round(frameRate));
  text(message, 10, height - 8);
}

