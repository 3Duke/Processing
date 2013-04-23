


 float deg = 2*PI/360;

class ColorWheel {
  
  float x, y, r;
  
  
  ColorWheel(float x_, float y_, float r_) {
    
    x = x_; y = y_; r = r_;
   
    
  }
  
  
  void display() {
    
    float s = 100;
    float b = 100;
    
    noStroke();
    rectMode(CENTER);
   
    colorMode(HSB,360,100,100);
    
    for( float angle = 0; angle < 360; angle += 0.5 ) {
      fill(angle, s, b);
      arc(x, y, r, r, -angle*deg, (-angle + 0.5)*deg);
    }
    
    colorMode(RGB, 255, 255, 255, 255);
   
    
  }

   void react() {
    
    
    if ((mouseX > x) && (mouseY > y)) {
      
      // int segmentHit = -1;
      
      if ((mouseX < x + r) && (mouseY < y + r)) {
        
        display();
      
      }// end if
    } // end if
   } // end react
   
   

   
  boolean mouseInside() {
    
    boolean value = false;
    
    if ((mouseX > x - r) && (mouseY > y - r)) {
      
      // int segmentHit = -1;
      
      if ((mouseX < x + r) && (mouseY < y + r)) {
        
        value = true;
    
      
      }// end if
 
    }
     return value;
  } // 
  


  float angle() {
    
    
   float xm = mouseX; float ym = mouseY;
    
    float tan_ = -(ym - y)/(xm - x);  // infinities?
    
   float angle = 360*atan(tan_)/(2*3.14159265);
   
   if ((ym - y > 0) && (xm - x > 0)) { // Quadran1 IV
     
     angle = 360 + angle;
   }
   
   if ((ym - y > 0) && (xm - x < 0)) { // Quadrant III
     
     angle = 180 + angle;
   }
   
   if ((y - ym > 0) && (xm - x < 0)) { // Quadrant II
     
     angle =  180 + angle;
   }
   
   return angle; 
  }
  

  
  float radius() {
    
   float xm = mouseX; float ym = mouseY;
   
   float dx = xm - x; float dy = ym - y;
   
   float r2 = dx*dx + dy*dy;
    
    return 2*sqrt(r2)/r;
  }
  

 
} // end class


