  class Particle {

  // frame:
  float fx, fy, fxx, fyy;
  
  // position and size
  float x, y, radius;
  float dx, dy, dradius;
  float spacingFactor;
  
  // color
  float r, g, b, a;
  float dr, dg, db, da;
  
  // speed
  float xspeed, yspeed, rspeed, cspeed;


  Particle(float tfx, float tfy, float tfxx, float tfyy) {
    
    fx = tfx; fy = tfy; fxx = tfxx; fyy = tfyy;

    r = random(255);
    g = random(255);
    b = random(255);
    a = 255;

    dr = 1; dg = 0.2; db = 1.2; da = 1;

    x = random(fx,fxx);
    y = random(fy,fyy);
    radius = 10;
    spacingFactor = 1.0;
    
    xspeed = 1;
    yspeed = 1;
    rspeed = 1;
    cspeed = 0.25;
    
    dradius = 0.1;
  }

  void  display() {

    rectMode(CENTER);
    fill(r,g,b,a);
    noStroke();
    ellipse(x, y, radius, radius);
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
    
      r = r + cspeed*dr;
      g = g + cspeed*dg;
      b = b + cspeed*db;
      a = a + cspeed*da;
      
      if (r < 0) {  r = 255; }
      if (r > 255) { r = 0;} 
  
      if (g < 0) { g = 255; }
      if (g > 255) { g = 0; }
  
      if (b < 0) {  b = 255; }
      if (b > 255) { b = 0; } 
  
      if (a > alphaMax) {  a = alphaMin;}
      if (a < alphaMin) { a = alphaMax; }
            
  }
          
  void changePosition(float M) {
    
    // Brownian motion:
    x = x + spacingFactor*xspeed*random(-radius,radius);
    y = y + spacingFactor*yspeed*random(-radius,radius);
    
    float k = 1.2;
    
    // Reflect off walls:
    if (x + radius > fxx) {
      x = fxx - k*xspeed*random(1,M) - 1;
    }
    if (x - radius < fx) {
      x = fx + k*xspeed*random(1,M) + 1;
    } 
    
    if (y + radius > fyy) {
      y = fyy - k*yspeed*random(1,M) - 1;
    }
    if (y - radius < fy) {
      y = fy + k*yspeed*random(1,M) + 1;
    } 
    
  }
  
  void changeRadius(float m, float M) {
    
    radius = radius + rspeed*dradius;
    
    if (radius > M) {
      radius = m;
    }
    
  }
  
  
  void  change(float M) { 
    
  changePosition(M);
  changeRadius(M/10, M);
  changeColor(50,100);
  
  }
}  

