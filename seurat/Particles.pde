
class Particle {
  
  
int CIRCLE = 0;
int TRI = 1;
int SQU = 2;
int QUA = 3;
int STA = 4;
int SQ2 = 5;
int LETTER = 6;
int WORD = 7;


  // frame:
  float fx, fy;         // a corner of the frame in which particle lives
  float fxx, fyy;       // opposit corner

  // position and size
  float x, y, radius;
  float dx, dy, dradius;
  float spacingFactor;

  // color
  float r, g, b, a;
  float dr, dg, db, da;

  // speed
  float xspeed, yspeed, rspeed;
  float colorVelocity;

  // particle ptype
  int ptype;


  Particle(float fx_, float fy_, float fxx_, float fyy_) {

    fx = fx_; 
    fy = fy_; 
    fxx = fxx_; 
    fyy = fyy_;

    r = random(255);
    g = random(255);
    b = random(255);
    a = 255;

    dr = 1; 
    dg = 0.2; 
    db = 1.2; 
    da = 1;

    x = random(fx, fxx);
    y = random(fy, fyy);
    radius = 10;

    spacingFactor = 1.0;

    xspeed = 1;
    yspeed = 1;
    rspeed = 1;


    // XXXX working on this
    dradius = 0.1;
    dr = 1;

    ptype = frameSet.particleType;  // initial value
  }

  void  display() {


    rectMode(CENTER);
    fill(r, g, b, a);
    noStroke();




    if (ptype == CIRCLE) {

      ellipse(x, y, radius, radius);
    } 
    else if (ptype == TRI) {

      triangle_(x, y, radius);
    } 
    else if (ptype == SQU) {

      rect(x, y, radius, radius);
    } 
    else if (ptype == QUA) {

      quad_(x, y, radius);
    } 
    else if (ptype == STA) {

      color c = color(r, g, b, a);

      SEStar star = new SEStar(x, y, radius/2, 6, c);

      star.display();
    } 
    else if (ptype == SQ2) {

      color c = color(r, g, b, a);
      noFill();
      stroke(c);
      rectMode(CENTER);
      rect(x, y, radius/2, radius/2);
    }
    else if (ptype == LETTER) {

      float tSize = radius;
      textSize(tSize);

      text(responder.lastKey, x, y);
    } 
    else if (ptype == WORD) {

      float tSize = radius;
      textSize(tSize);
      text (responder.displayString, x - textWidth(responder.displayString)/2, y);
    }

    // rectMode(CORNER);  // XXX
  }


  void setColor( color c ) {

    colorMode(RGB, 255, 255, 255, 255);
    r = red(c); 
    g = green(c); 
    b = blue(c); 
    a = alpha(c);
  }


  void reflectAcross() {

    float midpoint = width/2;
    x = midpoint - (x - midpoint);
  }

  void reflectUp() {

    float midpoint = height/2;
    y = midpoint - (y - midpoint);
  }


  void moveTo(float xx, float yy) {

    x = xx; 
    y = yy;
  }

  void changeColor(float alphaMin, float alphaMax) {

    r = r + colorVelocity*dr;
    g = g + colorVelocity*dg;
    b = b + colorVelocity*db;
    a = a + colorVelocity*da;

    if (r < 0) {  
      r = 255;
    }
    if (r > 255) { 
      r = 0;
    } 

    if (g < 0) { 
      g = 255;
    }
    if (g > 255) { 
      g = 0;
    }

    if (b < 0) {  
      b = 255;
    }
    if (b > 255) { 
      b = 0;
    } 

    if (a > alphaMax) {  
      a = alphaMin;
    }
    if (a < alphaMin) { 
      a = alphaMax;
    }
  }

  void changePosition(float M) {

    // Brownian motion:
    // x = x + spacingFactor*xspeed*random(-radius,radius);
    // y = y + spacingFactor*yspeed*random(-radius,radius);
    float dd = 1;
    // spacingFactor = 1.0/3;
    x = x + spacingFactor*xspeed*random(-radius/dd, radius/dd);
    y = y + spacingFactor*yspeed*random(-radius/dd, radius/dd);

    float k = 1.2;
    float collisionRadius = radius/8;  // allow it to partially penetrate the wall

    // Reflect off walls:
    if (x + collisionRadius > fxx) {
      x = fxx - k*xspeed*random(1, M) - 1;
    }
    if (x - collisionRadius < fx) {
      x = fx + k*xspeed*random(1, M) + 1;
    } 

    if (y + collisionRadius > fyy) {
      y = fyy - k*yspeed*random(1, M) - 1;
    }
    if (y - collisionRadius < fy) {
      y = fy + k*yspeed*random(1, M) + 1;
    }
  }

  void changeRadius(float m, float M) {

    radius = radius + rspeed*dradius;

    if (radius > M) {
      radius = m;
    }
  }


  void  change(float m, float M) { 

    changePosition(M);
    changeRadius(m, M);
    changeColor(50, 100);
  }
} 


/// HELPERS

void triangle_(float x, float y, float r) {

  float x1, y1, x2, y2, x3, y3;

  x1 = x + random(0, r);
  y1 = y + random(0, r);

  if ( random(0, 100) > 50 ) { // second quadrant
    x2 = x + random(0, -r);
    y2 = y + random(0, r);
  } 
  else { // third quadrant
    x2 = x + random(0, r);
    y2 = y + random(0, -r);
  }

  x3 = x + random(0, -r);
  y3 = y + random(0, -r);

  rectMode(CORNER);
  triangle(x1, y1, x2, y2, x3, y3);
}


void quad_(float x, float y, float r) {

  float x1, y1, x2, y2, x3, y3, x4, y4;

  x1 = x + random(0, r);
  y1 = y + random(0, r);

  x2 = x + random(0, -r);
  y2 = y + random(0, r);

  x3 = x + random(0, -r);
  y3 = y + random(0, -r);

  x4 = x + random(0, r);
  y4 = y + random(0, -r);

  quad(x1, y1, x2, y2, x3, y3, x4, y4);
}
