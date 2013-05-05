class SelectorBox extends Widget {
  
  // int x, y, w, h; // position
  
  int nSegments;
  
  String Labels[];
  
  SelectorBox(int x_, int y_, int w_, int h_, int nSegments_, String L_[]) {
    
    super(x_, y_, w_, h_, "Shape");
    
    nSegments = nSegments_;
    Labels = L_;
    
  }
  
  
  void display() {
    
    super.display();
    
    rectMode(CORNER);
    noStroke();
    textSize(18);
   
    
    float xx = x;
    float dw = w/nSegments;
    for (int i = 0; i < nSegments; i++) {
      
      fill(i*255/nSegments, 0, 255, 255);
      rect(xx, y, dw,   -h);
      fill(255,255,255,200);
      text(message(i), xx + 12, y - 13); 
      xx = xx + dw;
    }
    
    
  } // end diplay
  
  
  void highLightSegment(int n) {
   
    rectMode(CORNER);
    fill(255,0,0,200);
    float ww = w/nSegments;
    float xx = x + n*ww;

    rect(xx, y, ww, -h);
    
  }
  
  
  int segmentSelected0() {
    
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
  
  int segmentSelected() {
    
    float x = super.readX();
    
    if (x == -1) { return -1; }
    
    int n = int(nSegments*x/w);
    
    return n;
    
  } 
  
  
  int react() 
  {
     int segmentSelected = controller.shapeSelector.segmentSelected();

       
     if (segmentSelected  > -1) 
     {
       highLightSegment(segmentSelected);
       return segmentSelected;
       
     } else {
       
        return -1;
     }
  }
  
 
  
  String message(int n) {
    
     if (n < Labels.length) {
        return Labels[n];
     } else {
       return "?";
     }
 
  } // end message
  
} // end class
