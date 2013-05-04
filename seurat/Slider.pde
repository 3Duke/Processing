
class Slider {


  float x, y; // lower left corner
  float w, h; // with and height
  String label, caption;
  float maxValue;


  Slider(float x_, float y_, float w_, float h_, float mv_, String L_, String caption_) {

    x = x_; 
    y = y_; 
    w = w_; 
    h = h_;
    maxValue = mv_;
    label = L_;
    caption = caption_;
  }

  void display() {

    fill(0,0,255, 10);
    rectMode(CORNER);
    rect(x, y, w, -h);
    fill(255,255,255);
    textSize(12);
    text(caption, x, y+15);
  }

  float read() {

    float value = -1;
    //   && (mouseY < y - h)
    if ( (mouseX > x) && ( mouseX < x + w) && (mouseY > y - h) ) {
      

      value = (mouseX - x)/w;
      fill(255,0,0, 128);
      rect(x, y, w*value, -h);
      
      value = maxValue*value;
      fill(255);
      textSize(12);
      text(label +": "+nfc(value,1), x+10, y-16);
     
    }
   
    return value;
  }
}
