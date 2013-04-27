
class Slider {


  float x, y; // lower left corner
  float w, h; // with and height
  String label;
  float maxValue;


  Slider(float x_, float y_, float w_, float h_, float mv_, String L_) {

    x = x_; 
    y = y_; 
    w = w_; 
    h = h_;
    maxValue = mv_;
    label = L_;
  }

  void display() {

    fill(0,0,255, 10);
    rectMode(CORNERS);
    rect(x, y, x + w, y - h);
  }

  float read() {

    float value = -1;
    //   && (mouseY < y - h)
    if ( (mouseX > x) && ( mouseX < x + w) && (mouseY > y - h) ) {
      

      value = maxValue*(mouseX - x)/w;
      fill(255);
      textSize(12);
      text(label +": "+nfc(value,1), x+10, y-16);
     
    }
    return value;
  }
}

