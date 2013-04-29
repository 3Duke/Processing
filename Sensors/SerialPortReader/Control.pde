class BarMeter {
  
  float x, y, w, h;
  float level;
  float maxLevel;
  float br, bg, bb, dr, dg, db; // background and display colors
  float inset;
  
  BarMeter( float x_, float y_, float w_, float h_, float maxLevel_) {
    
    x = x_; y = y_; w = w_; h = h_;
    
    br = 80; bg = 80; bb = 80;
    dr = 255; dg = 0; db = 0;
   
    inset  = 0;
    maxLevel = maxLevel_;
    
  }
  
  void setBackgroundColor(float r_, float g_, float b_) {
    
   br = r_; bg = g_; bb = b_; 
   
  }
  
  void setColor(float r_, float g_, float b_) {
    
   dr = r_;  dg = g_; db = b_; 
   
  }
  
  void display(float level_) {
    
    level = level_;
    
    rectMode(CORNER);
    fill(br, bg, bb);
    rect(x,y,w,h);
    fill(dr, dg, db);
    
    float relativeLevel = (level/maxLevel);
    float displayLevel = relativeLevel*(w - 2*inset);
    rect(x + inset, y + inset, displayLevel, h - 2*inset);
  }
  
}

class TextDisplay {
  
  float x, y, w, h;
  String message;
  float textGray, bgGray;
  
  TextDisplay(float x_, float y_, float w_, float h_) {
    
    x = x_; y = y_; w = w_; h = h_;
    
    bgGray = 0;
    textGray = 255;
    
  }
  
  void display(String m_) {
    
    fill(bgGray);
    rectMode(CORNER);
    rect(x,y,w,h);
    fill(textGray);
    textSize(14);
    text(m_,x + 5,y + 19);
  }
  
  
}
