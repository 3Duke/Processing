class ColorParticle {
  
  /*
  A ColorParticle has an rgba color state which changes by 
  Browniam motion.  If p is a ColorParticle, then p.randomStep(0.01)
  changes the color parameters r, g, b by at most +/- 1 percent.
  
  
  
  */

  float r, g, b, a;

  ColorParticle() {

    r = random(0, 255);
    g = random(0, 255);
    b = random(0, 255);
    a = 255;
  } 

  color getColor() {

    colorMode(RGB, 255, 255, 255, 255);
    return color(r, g, b, a);
  }


  float red() { 
    return r;
  }
  float green() { 
    return g;
  }
  float blue() { 
    return b;
  }
  float alpha() { 
    return a;
  }

  void setRed(float r_) { 
    r = r_;
  }
  void setGreen(float g_) { 
    g = g_;
  }
  void setBlue(float b_) { 
    b = b_;
  }
  void setAlpha(float a_) { 
    a = a_;
  }


  void randomStep( float relativeSize ) {

    float step = 255*relativeSize;

    r = r + random(-step, step);
    r = r % 256;

    g = g + random(-step, step);
    g = g % 256;

    b = b + random(-step, step);
    b = b % 256;
    
    a = a % 256;
  }
}
