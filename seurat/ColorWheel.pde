

class ColorWheel extends Widget {
  
  
  ColorWheel(float x_, float y_, float d_, String caption_) {
    
   
    super(x_, y_, d_, d_, caption_);
    
    
  }
  
  
  void display() {
    
    float s = 100;
    float b = 100;
    
    noStroke();
    /*
    rectMode(CORNER);
    fill(128);
    rect(x,y,w,-h);
    */
   
    super.display();
   
    
    rectMode(CENTER);
   
    colorMode(HSB,360,100,100);
    
    for( float angle = 0; angle < 360; angle += 0.5 ) {
      fill(angle, s, b);
      arc(xc, yc, 2*radius, 2*radius, -angle*deg, (-angle + 0.5)*deg);  // XXX: Kludge
    }
    
    colorMode(RGB, 255, 255, 255, 255);
    rectMode(CORNER);
   
    
  }

  color setColorOfBox( Box B ) {
    
    color c = color(0);
 
     if (mouseInside()) {
       
       colorMode(HSB, 360, 1, 1);
      
       c = color(readAngle(), readRadius(), 1);
      
       B.setColor(c);
     
       colorMode(RGB, 255, 255, 255, 255);
       
       // println("Box, r = "+nfc(B.red()),1)+", g = "+nfc(green(B.bg),1)+", b = "+nfc(blue(B.bg),1));
     }
     
     return c;
     
  }   

   
  boolean mouseInside() {
    
    return mouseInsideCircle();
    
  } // 
  

 
} // end class
