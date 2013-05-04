class Widget {
  
  float x, y;        // position: upper left corner
  float w, h;        // diemsnsions
  float xc, yc;      // coordinates of center
  color bg;          // background color
  String caption;
  
  Widget(float x_, float y_, float w_, float h_, String caption_) {
    
    x = x_; y = y_;
    w = w_; h = h_;
    caption = caption_;
    
    bg = color(0,0,255);
    
    // Calculated values:
    xc = x + w/2;
    yc = y + h/2;
    
  }
  
  void display() {
    
    colorMode(RGB);
    fill(bg);
    noStroke();
    
    rectMode(CORNER);
    rect(x,y,w, -h); 
    
    fill(255);
    textSize(12);
    text(caption, x, y+15);

    
  }
  
  boolean mouseInside() {
    
    if ( (mouseX > x) && ( mouseX < x + w) && (mouseY > y - h) ) {
      
      return true;
      
    } else {
      
      return false;
      
    }
    
  }
 
  
  float readX() {
    
    if ( (mouseX > x) && ( mouseX < x + w) && (mouseY > y - h) ) {
      
      return (mouseX - x);
      
    } else {
      
      return -1;
      
    }
  }
  
  float readY() {
    
    if ( (mouseX > x) && ( mouseX < x + w) && (mouseY > y - h) ) {
      
      return (y - mouseY);
      
    } else {
      
      return -1;
      
    }
  }
  
  float readAngle() {
    
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
  
  float readRadius () {
   
    float xm = mouseX; float ym = mouseY;
    float dx = mouseX - xc;
    float dy = mouseY - yc;
    return sqrt(dx*dx + dy*dy);
  }
  
} // class
  
