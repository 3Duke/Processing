  
class SEFrame {
  
  // Geometry of frame
  float x, y;
  float w, h;
  
  float speed;
  
  // Color of frame
  float r, g, b, a;
  float dr, dg, db, da;  // change in color
  float colorPhase;      // phase
  float colorVelocity;
  color frameColor;
  float frameHue;
  
  float level; // brightness
  float levelPhase; // frames
  float levelPeriod;  // frames
  float levelMax;  // 1.0
  float levelMin; //  0.0
  
  Particle [] particles;
  int numberOfActiveParticles;
  
  int phase;  // number of frames before staring
  float spacingFactor;
  


  // Constructor: parameters define frame, number of particles,
  // and drawing scale.  default values are set for other fields.
  SEFrame(float xx, float yy, float ww, float hh, int numberOfParticles, float scale, float spacingFactor_) {

    // Geometry of frame
    x = xx; 
    y = yy;
    w = ww; 
    h = hh;

    // Default color of frame
    r = random(100,200);
    g = random(100,200);
    b = random(100,200);  

    colorMode(RGB,255,255,255,255);
    frameColor = color(r,g,b);
    colorMode(HSB,360, 360, 360);
    frameHue = hue(frameColor);
    

    // Change of color of frame
    dr = random(-1,1);
    dg = random(-1,1);
    db = random(-1,1);
    da = random(-1,1);

    speed = 0.1; // 0.01;
    
    
    // Create particles
    particles = new Particle[numberOfParticles];
    numberOfActiveParticles = numberOfParticles;
    for (int i = 0; i < particles.length; i++) {
      
      // Create new paricle with motion constrained to 
      // the frame (x, y, x + w, y + h)
      particles[i] = new Particle(x, y, x + w, y + h);
    }
    
    spacingFactor = spacingFactor_;

    setParticles(1.0);
    
  }
  
  void setParticles(float scale) {
    
    ColorParticle colorParticle = new ColorParticle();
    
    for (int i = 0; i < particles.length; i++) {
      
      // Put particle at center of frame
      particles[i].x = x + w/2;
      particles[i].y = y + h/2;
      
      particles[i].setColor( colorParticle.getColor() );
      colorParticle.randomStep(0.1);
      
   
      
      // Adjust particle parameters for the drawing scale;
      particles[i].radius = scale*particles[i].radius;
      particles[i].xspeed = scale*particles[i].xspeed;
      particles[i].yspeed = scale*particles[i].yspeed;
      particles[i].colorVelocity = colorVelocity;
      particles[i].rspeed = scale*0.5; // scale*particles[i].rspeed;
      particles[i].spacingFactor = spacingFactor;
      
    }
    
  }
  
  void setParticleRadii(float radius, float localScale) {
    
    for (int i = 0; i < particles.length; i++) {
     
      particles[i].radius = localScale*radius;
      
    }  
  }
  
  void setParticleColorVelocities(float velocity) {
    
    for (int i = 0; i < particles.length; i++) {
     
      particles[i].colorVelocity = velocity;
      
    }  
  }
  
  void setParticleQualities(float scale) {
    
    for (int i = 0; i < particles.length; i++) {
        
      // Adjust particle parameters for the drawing scale;
      particles[i].radius = scale*particles[i].radius;
      particles[i].xspeed = scale*particles[i].xspeed;
      particles[i].yspeed = scale*particles[i].yspeed;
      particles[i].colorVelocity = colorVelocity;
      particles[i].rspeed = scale*0.5; // scale*particles[i].rspeed;
      particles[i].spacingFactor = spacingFactor;
      
    }
    
  }
  
  void updateParticleType(int newType) {
    
    for (int i = 0; i < particles.length; i++) {
      particles[i].ptype = newType;
    }
  }
    
  void setNumberOfActiveParticles(int n) {
    
    if (n > particles.length) {
      
      numberOfActiveParticles = particles.length;
      
    } 
    else 
    {
      numberOfActiveParticles = n;
    }
      
  }

  void changeColor() {
    
     // change color changes by a small random amount
      float epsilon = 0.1;
      dr = (1 + random(-epsilon,epsilon))*dr;
      dg = (1 + random(-epsilon,epsilon))*dg;
      db = (1 + random(-epsilon,epsilon))*db;


    r = r + speed*dr;
    g = g + speed*dg;
    b = b + speed*db;
    a = a + speed*da;
   
    r = r % 256;
    g = g % 256;
    b = b % 256;
    a = a % 256;
    
  }
  
  void setColor(float r_, float g_, float b_, float a_) 
  {
    r = r_; g = g_; b = b_; g = g_; a = a_;
    print("SC: "+r+", "+g+", "+b+" -- "); count = 0;
    colorMode(RGB,255,255,255,255);
    frameColor = color(r,g,b,a);
    
    colorMode(HSB,360, 1, 1);
    float h = hue(frameColor);
    printColor(frameColor, "frameColor");
    // println("!! frameHue = "+h);
    // println("## frameHue = "+hue_());
    // colorMode(RGB,255,255,255);
  }
  
  void randomSetColor() {
    setColor(random(255), random(255), random(255), random(255));
  }
  
  void setDColor(float dr_, float dg_, float db_, float da_) {
    dr = dr_; dg = dg_; db = db_; da = da_;
  }

  void change() {
    
    changeColor();
    
  }

  void display(float m, float M) {

   
  // adjust level
    float LF = 1.0;
    if (levelPeriod > 0) {
      
      LF = abs(sin((levelMax - levelMin)*sin(TWO_PI*(frameCount - phase)/levelPeriod))) +levelMin;
      if (LF  > 1) {
          LF = 1;
      }
     LF = 1;  // JC: disable change of contrast, value for now;
    }
    
      
      float rr = r + colorPhase*dr % 256;
      float gg = g + colorPhase*dg % 256;
      float bb = b + colorPhase*db % 256;
    
 
      float rrr = LF*rr; 
      float ggg = LF*gg; 
      float bbb = LF*bb;
      
      colorMode(RGB,255,255,255,255);
      fill(rrr,ggg,bbb,a);

      stroke(0);
      rectMode(NORMAL);
      rect(x, y, x + w, y + h);
      
      frameColor = color(rrr,ggg,bbb,a);
      // printColor(frameColor, "DIS");
   
      
   if (frameCount > phase) 
   {
      for(int i = 0; i < numberOfActiveParticles ; i++) {
        particles[i].change(m, M);  // M = maximum particle radius  
      }
      
      for(int i = 0; i < numberOfActiveParticles ; i++) {
        particles[i].display();    
      }
    }
  }  // display
  
  
  void setColorPhase(float p) {
    
    colorPhase = p;
  }
  
  float red() { return r; }
  float green() { return g; }
  float blue() { return b; }
  
  float hue_() { 
    
   colorMode(HSB,360, 1, 1);
   return hue(frameColor);

    
  }
    
  
} // Frame
