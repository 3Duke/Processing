
class Slider extends Widget {

  String label;
  float maxValue;
  float value;
  color indicatorColor;


  Slider(float x_, float y_, float w_, float h_, float mv_, String L_, String caption_) {

    super(x_, y_, w_, h_, caption_);
  
    maxValue = mv_;
    label = L_;
    caption = caption_;
    value = 0;
    
    indicatorColor = color(128,0,255);
  }
  
  
  void display() {

    super.display();
    
    rectMode(CORNER);
     
    float displayValue = w*value/maxValue;
    fill(indicatorColor);
    rect(x, y, displayValue, -h); 
    
    fill(255,255,255);
    textSize(12);
    text(caption, x, y+15);
    
    fill(255);
    textSize(12);
    text(label +": "+nfc(value,1), x+10, y-16); 
    
   
  }

  float read() {

    float val = super.read();
    
    if (val == -1) { return -1; }

      val = val/w;
      fill(255,0,0, 128);
      rect(x, y, w*val, -h);
      
      value = maxValue*val;
      fill(255);
      textSize(12);
      text(label +": "+nfc(value,1), x+10, y-16);
   
    return value;
  }
 
  
}
