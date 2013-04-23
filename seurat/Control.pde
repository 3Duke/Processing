class Control {
  
  int x, y, w, h; // position
  
  int nSegments;
  
  String Labels[];
  
  Control(int x_, int y_, int w_, int h_, int nSegments_, String L_[]) {
    
    x = x_; y = y_; w = w_; h = h_;
    nSegments = nSegments_;
    Labels = L_;
    
    
  }
  
  
  void display() {
    
    rectMode(CORNERS);
    noStroke();
    textSize(18);
    // println("CONTROL: " + x +", "+y+", "+w+", "+h);    
    fill (0, 0, 255, 200);
    noStroke();
    rect(x, y, x + w, y + h);
    
    
    float xx = x;
    float dw = w/nSegments;
    for (int i = 0; i < nSegments; i++) {
      
      fill(i*255/nSegments, 0, 255, 255);
      rect(xx, y, xx + dw, y + h);
      fill(255,255,255,200);
      text(message(i), xx + 12, y + 27); 
      xx = xx + dw;
    }
    
    
  } // end diplay
  
  
  void highLightSegment(int n) {
   
    rectMode(CORNER);
    fill(255,0,0,200);
    float ww = w/nSegments;
    float xx = x + n*ww;
   
    rect(xx, y, xx + ww, y + h
    );
    
  }
  
  
  int segmentSelected() {
    
    int segmentHit = -1;
    
    if ((mouseX > x) && (mouseY > y)) {
      
      if ((mouseX < x + w) && (mouseY < y + h)) {
        
        display();
        
        float dw = w/nSegments;
        float xx = x;
        
        for(int i = 0; i < nSegments; i++) {
          
          if (mouseX > xx) {
            segmentHit = i;
          }
          
          xx = xx + dw;
        } // end for
      }
    }
    
    return segmentHit;
    
  } // end segmentSelected
  
  void react() {
    
    
    if ((mouseX > x) && (mouseY > y)) {
      
      // int segmentHit = -1;
      
      if ((mouseX < x + w) && (mouseY < y + h)) {
        
        display();
    
      
      }// end if
     
     // return segmentHit;
    } // end if
  
  
  } // end react
  
 
  
  String message(int n) {
    
     if (n < Labels.length) {
        return Labels[n];
     } else {
       return "?";
     }
 
  } // end message
  
} // end class
