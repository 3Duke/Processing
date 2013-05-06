class FrameSet {
  
  SEFrame [] frame;
  
  // temporary variables //
  float x = 0; 
  float y = 0;

  // wdith of square
  float W = 621; 
  float pW = W; // previous W
  ////////////////////////////
  


FrameSet(float WIDTH, int numberOfFrames) {
  
  frame = new SEFrame[numberOfFrames];

  // Set up frames in golden ratio spiral

  float scale = 1;

  // corner of square
  
    
  // first frame
  
  frame[0] = new SEFrame(x, y, W, W, NUMBER_OF_PARTICLES, scale, spacingFactor);
  

  // the other frames
  float sf = spacingFactor;
  for (int i = 1; i < frame.length; i++) {
    
    // println(i+": "+nfc(x,2)+", "+nfc(y,2)+", "+nfc(W,2)+", "+nfc(pW,2));
    nextSquare(i);
    scale = inverseGoldenRatio*scale;
    sf = 2*sf;  // increase spancing factor in smaller frames
    frame[i] = new SEFrame(x, y, W, W, NUMBER_OF_PARTICLES, scale, sf);
    lastFrame(i);
    
  } // end for
        
}  // constructor


///////////////////////////////////////

  void setQualities (){
  
    for(int i = 0; i < frame.length; i++) {
  
  
      frame[i].phase = 200*i;  // 200*i ==> 10*i for test
      frame[i].levelMin = minLevel;
      frame[i].levelMax = maxLevel;
      frame[i].levelPhase = frame[i].phase*sqrt(2);
      frame[i].levelPeriod  = 20000/(i+1);
    }
  }
  
  void setLevelRange( float min, float max ) {
    
    for (int i = 0; i < frame.length; i++ ) {
      
      frame[i].levelMin = min;
      frame[i].levelMax = max;
      
    }
    
  }


void setAlpha(float a) {
 
  for (int i = 0; i < frame.length; i++) {
    
    frame[i].a = a;

  }
}


  void setParticleType(int particleType) {
 
 for(int i = 0; i < frame.length; i++) {
  
   SEFrame f = frame[i];
   
   for (int j = 0; j < f.particles.length; j++ ) {
     
     f.particles[j].ptype = particleType;
     
   } 
 } 
}
  
  void display () {

    float M = MaxRadius;
  
    for (int i = 0; i < frame.length; i++) {  // XXX
    
      frame[i].display(M);
      frame[i].change(200);
      M = inverseGoldenRatio*M;
    }
  }
  
 
 float red(int i) { return frame[i].red(); }
 float green(int i) { return 255; }
 float blue(int i) { return 255; }
  
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
// controller.colorBox1.setRGBAColor(r1, g1, b1, 255);
controller.colorBox2.setRGBAColor(r2, g2, b2, 255);
 


  for (int i = 0; i < frame.length; i++) {
    // frames[i].randomSetColor();
    frame[i].setColor(0, 100, 200, 200);

    // alpha value of frame.  Increase it for decreased persistence
    // object drawn in the frame
    frame[i].a = frameAlpha;

    // speed factor for changing color of frame
    frame[i].speed = 0.1;

    // relative rates of change for colors
    frame[i].setDColor(1, 0, (i+1)*(i+1), 0);
  }
 
}

void setColorTori2(Box box1, Box box2) {

  float r1, g1, b1, r2, g2, b2;
  
  r1 = box1.red();  g1 = box1.green(); b1 = box1.blue();
  r2 = box2.red();  g2 = box2.green(); b2 = box2.blue();
  // 
  for (int i = 0; i < frame.length; i++) {
    // frames[i].randomSetColor();
    frame[i].setColor(r1, g1, b1, frameAlpha);

    // alpha value of frame.  Increase it for decreased persistence
    // object drawn in the frame
    frame[i].a = frameAlpha;

    // speed factor for changing color of frame
    frame[i].speed = 0.1;


    float dr = r2 - r1; 
    float dg = g2 - g1; 
    float db = b2 - b1;

    float k = 0.01;//  0.001;

    dr = k*dr; 
    dg = k*dg; 
    db = k*db;

    // relative rates of change for colors
    // frame[i].setDColor(dr, (i+1)*dg, (i+1)*(i+1)*db, 0);
    frame[i].setDColor(dr, dg, db, 0);
  }
  
}

///////////////

void setColorPhase(float p) {
  
  for(int i = 0; i < frame.length; i++ ) {
    
   frame[i].setColorPhase( (i+1)*p ); 
  }
  
}

void nextSquare(int i) {
   // compute new upper left corner
    if (i % 4 == 1) 
    {
      x = x + W;
      pW = W;
      W = inverseGoldenRatio*W;
    } 
    else if ( i % 4 == 2) 
    {
      x = x +  inverseGoldenRatio*(pW - W);
      y = y + W;
      pW = W;
      W = inverseGoldenRatio*W;
    }
    else if ( i % 4 == 3) 
    {
      x = x - inverseGoldenRatio*W;
      y = y + W;
      y = y - inverseGoldenRatio*W;
      W = inverseGoldenRatio*W;
    }
    else if ( i % 4 == 0) 
    {
      y = y - inverseGoldenRatio*W;
      W = inverseGoldenRatio*W;
    }
}



void lastFrame(int i) {
  
  // Last frame, which is a rectangle
    if (i == frame.length - 1) {
      if (i % 4 == 0 ) 
      {   
        frame[i].w =  frame[i].w/inverseGoldenRatio;
      } 
      else if (i % 4 == 1) 
      {
        frame[i].h =  frame[i].h/inverseGoldenRatio;
      } 
      else if (i % 4 == 2) 
      {
        float xx = frame[i].x;
        float ww = frame[i].w/inverseGoldenRatio;
        float dx = ww/inverseGoldenRatio - ww;
        frame[i].x = xx - dx*inverseGoldenRatio;
        frame[i].w = ww;
      } 
      else if (i % 4 == 3) 
      {
        float yy = frame[i].y;
        float ww = frame[i].w/inverseGoldenRatio;
        float dy = ww/inverseGoldenRatio - ww;
        frame[i].y = yy - dy*inverseGoldenRatio;
        frame[i].h = ww;
      }
    }
    
}
  
 } // FrameSet
