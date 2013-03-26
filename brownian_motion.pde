// Simulation of Brownian motion
// J. Carlson, 12/23/2010
// http://square-the-circle.com/2013/02/08/brownian-motion-2/

PFont font;    

int maxFrameCount = 100000;
float SIZE = 600;
// Origin
float xo = SIZE/2;
float yo = SIZE/2;
int threads = 1;

float r = 255;
float g = 0;
float b = 0;
float a = 255;


// Current position of radom walker
float x, y; 

float stepSize = SIZE/100.0;

void step() {
  float x2 = x + random(-stepSize, stepSize);
  float y2 = y + random(-stepSize, stepSize);
  //  line(x,y,x2,y2);
  ellipse(x,y,2,2);
  x = x2;
  y = y2;
}

///////////////////////////////////////////////

void setup() {
  size(600,750);
  background(0);
  frameRate(120);
  fill(255,0,0);
  smooth();
  x = xo;
  y = yo;
  // Code for text:
  font = loadFont("AndaleMono-36.vlw");
  textFont(font);
  textSize(24);
}

float norm(float x, float y) {
  return max(abs(x-xo), abs(y-yo));
}

void draw() { 
    if (frameCount % maxFrameCount == 0) {
    x = xo; y = yo;
    fill(0);
    rect(0,0,600,600);
    threads = 1; 
  }
  fill(r,g,b,a); 
  step();
  if( norm(x,y) &gt; SIZE/2 ) {
    threads += 1;
    x = xo; 
    y = yo;
    r = random(0,255);
    g = random(0,255);
    b = random(0,255);
    a = random(254,255);
  }

  if (frameCount % 1000 == 0) {
    saveFrame();
  }
  fill(0);
  noStroke();
  rect(0,660,width, 90);
  fill(128);
  text("Markov 2", 250, 700);
  fill(90);
  text("T:"+threads+" N:" + frameCount, 15, 700);
  text("R:" + round(norm(x,y)), 500, 700);
}
