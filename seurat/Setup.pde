
/*************************************************************************

Define functions called in setup()

***************************************************************************/

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
  frames[0] = new JCFrame(x, y, W, W, NUMBER_OF_PARTICLES, scale, sf);

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
      frames[i] = new JCFrame(x, y, W, W, NUMBER_OF_PARTICLES, scale, sf);
    } 
    else {
      frames[i] = new JCFrame(x, y, W/inverseGoldenRatio, W, NUMBER_OF_PARTICLES, scale, sf);
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
  frames[0] = new JCFrame(x, y, W, W, NUMBER_OF_PARTICLES, scale, sf);

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


    frames[i] = new JCFrame(x, y, W, W, NUMBER_OF_PARTICLES, scale, sf);
 

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

void setAlphaOfFrames(float a) {
  
  for (int i = 0; i < frames.length; i++) {
    
    frames[i].a = a;

  }
}

void setColorTori() {

  float r1, g1, b1, r2, b2, g2;
  float dr, dg, db;
  // float a;

  r1 = 0; 
  g1 = 100; 
  b1 = 200; 
  // a = 200;
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
