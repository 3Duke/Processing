class FrameSet {

  SEFrame [] frame;

  // temporary variables //
  float x = 0; 
  float y = 0;

  // wdith of square
  float W = 621; 
  float pW = W; // previous W
  ////////////////////////////


  //////////////

  float baseFrameRate = 30;

  int particleType = 1;

  float MAXRADIUS = 180;
  float INITIAL_RADIUS = 130;
  float maxRadius = INITIAL_RADIUS; 
  float minRadius = INITIAL_RADIUS/4;

  float maxAlpha = 10.0;
  float frameAlpha = 2.0;  // increase to decrease persistence of drawing 
  float maxBrightness = 1.0;
  float minBrightness = 0.8;

  color c1, c2;

  int numberOfParticles = 32;
  int numberOfActiveParticles = 1;
  float spacingFactor = 0.1;
  float colorVelocity = 0.2;
  float scale = 1;



  FrameSet(float WIDTH, int numberOfFrames_) {

    frame = new SEFrame[numberOfFrames_];
  }  

  void configure () {

    frameRate(frameSet.baseFrameRate);
    frameSet.spacingFactor = 0.3;
    frameSet.makeFrames();
    frameSet.setQualities();
    frameSet.setColorPhase(20);
  }


  void makeFrames() {

    // first frame

    frame[0] = new SEFrame(x, y, W, W, numberOfParticles, scale, spacingFactor);
    frame[0].colorVelocity = colorVelocity;
    frame[0].setParticles(1.0);


    // the other frames
    for (int i = 1; i < frame.length; i++) {

      // println(i+": "+nfc(x,2)+", "+nfc(y,2)+", "+nfc(W,2)+", "+nfc(pW,2));
      nextSquare(i);
      scale = inverseGoldenRatio*scale;  // increase spancing factor in smaller frames

      float sf = spacingFactor + i/10.0;
      sf = min(sf, 1.4);
      frame[i] = new SEFrame(x, y, W, W, numberOfParticles, scale, sf);

      // propagate properties from frameSet to framw
      frame[i].colorVelocity = colorVelocity;   

      // propagate properties fom frame to particles
      frame[i].setParticles(1.0);

      lastFrame(i);
    } // end for
  }

  ///////////////////////////////////////

  void setQualities () {

    for (int i = 0; i < frame.length; i++) {

      frame[i].numberOfActiveParticles = numberOfActiveParticles;
      frame[i].spacingFactor = spacingFactor;

      frame[i].phase = 200*i;  // 200*i ==> 10*i for test
      frame[i].levelMin = minBrightness;
      frame[i].levelMax = maxBrightness;
      frame[i].levelPhase = frame[i].phase*sqrt(2);
      frame[i].levelPeriod  = 20000/(i+1);

      // frame[i].setParticles(scale);  /// propagate changes
    }
  }

  void setParticles () {

    for (int i = 0; i < frame.length; i++) {

      frame[i].setParticles(1.0);  /// propagate changes
    }
  }

  void setParticleQualities () {

    for (int i = 0; i < frame.length; i++) {

      frame[i].setParticleQualities(1.0);  /// propagate changes
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


  void setParticleType(int particleType_) {

    particleType = particleType_;

    for (int i = 0; i < frame.length; i++) {

      SEFrame f = frame[i];

      for (int j = 0; j < f.particles.length; j++ ) {

        f.particles[j].ptype = particleType;
      }
    }
  }

  void display () {

    float M = maxRadius;
    float m = minRadius;

    for (int i = 0; i < frame.length; i++) 
    {  
      frame[i].display(m, M);
      frame[i].change(  );
      M = inverseGoldenRatio*M;
      m = inverseGoldenRatio*m;
    }
  }


  void setColorTori() {

    float r1, g1, b1, r2, b2, g2;
    float dr, dg, db;
    // float a;


    r1 = 0; 
    g1 = 100; 
    b1 = 200;

    colorMode(RGB, 255, 255, 255);
    c1 = color(r1, g1, b1, 200);


    // a = 200;
    dr = 1; 
    dg = 0; 
    db = 1;

    float k = 100;
    r2 = r1 + k*dr; 
    g2 = g1 + k*dg;  
    b2 = b1 + k*db;

    c2 = color(r2, g2, b2, 200);

    /////////UUUU
    // controller.colorBox1.setRGBAColor(r1, g1, b1, 255);
    controller.colorBox2.setRGBAColor(r2, g2, b2, 255);

    println("\n\nSetting colors of frames ...");

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

  void setColorTori2() {

    colorMode(RGB, 255, 255, 255, 255);
    float r1, g1, b1, r2, g2, b2;

    printColor(c1, "setColorTori(1)");
    printColor(c2, "setColorTori(2)");

    r1 = red(c1);  
    g1 = green(c1); 
    b1 = blue(c1);
    r2 = red(c2);  
    g2 = green(c2); 
    b2 = blue(c2);
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

    for (int i = 0; i < frame.length; i++ ) {

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

  XML appendXMLOfParameters(XML xml, String fileName_) {

    // XML xml = createXML("parameters");
    XML ff = xml.addChild("fileSaved");

    XML fn = ff.addChild("fileName");
    fn.setContent(fileName_);

    XML cc1 = ff.addChild("color1");
    XML cc1r = cc1.addChild("red");
    cc1r.setContent(nfc(red(c1), 2));
    XML cc1g = cc1.addChild("green");
    cc1g.setContent(nfc(green(c1), 2));
    XML cc1b = cc1.addChild("blue");
    cc1b.setContent(nfc(blue(c1), 2));
    XML cc1a = cc1.addChild("alpha");
    cc1a.setContent(nfc(alpha(c1), 2));

    XML cc2 = ff.addChild("color2");
    XML cc2r = cc2.addChild("red");
    cc2r.setContent(nfc(red(c2), 2));
    XML cc2g = cc2.addChild("green");
    cc2g.setContent(nfc(green(c2), 2));
    XML cc2b = cc2.addChild("blue");
    cc2b.setContent(nfc(blue(c2), 2));
    XML cc2a = cc2.addChild("alpha");
    cc2a.setContent(nfc(alpha(c2), 2));

    XML pt = ff.addChild("particleType");
    pt.setContent( nfc(particleType, 0) );

    XML mr = ff.addChild("minRadius");
    mr.setContent(nfc(minRadius, 2));

    XML MR = ff.addChild("maxRadius");
    MR.setContent(nfc(maxRadius, 2));

    XML fa = ff.addChild("frameAlpha");
    fa.setContent(nfc(frameAlpha, 2));

    XML mb = ff.addChild("minBrightness");
    mb.setContent(nfc(minBrightness, 2));

    XML MB = ff.addChild("maxBrightness");
    MB.setContent(nfc(maxBrightness, 2));

    XML cv = ff.addChild("colorVelocity");
    cv.setContent(nfc(colorVelocity, 2));

    XML nap = ff.addChild("numberOfActiveParticles");
    nap.setContent(nfc(numberOfActiveParticles, 0));


    XML psf = ff.addChild("particleSpacingFactor");
    psf.setContent(nfc(spacingFactor, 2));

    return xml;
  }


  String stringValOfParameters() {

    String val = "";

    val = "c1:"+colorString(c1);
    val += "; c2: "+colorString(c2);
    val += "; particleType: "+particleType;
    val += ", minRadius: "+minRadius;
    val += ", maxRadius: "+maxRadius;
    val += ", frameAlpha: "+frameAlpha; 
    val += ", minBrightness: "+minBrightness;
    val += ", maxBrightness: "+maxBrightness;
    val += ", colorVelocity: "+colorVelocity;
    val += ", frameAlpha: "+frameAlpha;
    val += ", numberOfActiveParticles: "+numberOfActiveParticles;
    val += ", particleSpacingFactor: "+spacingFactor;

    return val;
  }
} // FrameSet
