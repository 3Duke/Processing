class ColorParticle {
  
 float r, g, b, a;

 ColorParticle() {
  
     r = random(0,255);
     g = random(0,255);
     b = random(0,255);
     a = 255;
 } 
  
 color getColor() {
   
   colorMode(RGB, 255, 255, 255, 255);
   return color(r,g,b,a);

 }
 

float red() { return r; }
float green() { return g; }
float blue() { return b; }
float alpha() { return a; }

void setRed(float r_) { r = r_; }
void setGreen(float g_) { g = g_; }
void setBlue(float b_) { b = b_; }
void setAlpha(float a_) { a = a_; }


void randomStep( float relativeSize ) {
  
  float step = 255*relativeSize;
  
  r = r + random(-step, step);
  r = r % 255;
  
  g = g + random(-step, step);
  g = g % 255;
  
  b = b + random(-step, step);
  b = b % 255;
  
}


}
