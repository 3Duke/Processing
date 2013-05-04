

class ColorWheel extends Widget {
  
  float r;
  
  
  ColorWheel(float x_, float y_, float r_, String caption_) {
    
    super(x_, y_, r_, r_, caption_);
    r = r_;
    
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

  void setColorOfBox( Box B ) {
 
     if (mouseInside()) {
       
       colorMode(HSB, 360, 1, 1);
      
       color c = color(readAngle(), readRadius(), 1);
      
       B.setColor(c);
     
       colorMode(RGB, 255, 255, 255, 255);
       
       println("Box, r = "+nfc(red(B.bg),1)+", g = "+nfc(green(B.bg),1)+", b = "+nfc(blue(B.bg),1));
     }
     
  }   

   
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
  

 
} // end class
