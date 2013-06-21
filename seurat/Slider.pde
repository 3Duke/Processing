
class Slider extends Widget {

  String label;
  float maxValue;
  float value, savedValue;
  color indicatorColor;
  int digits = 1;


  Slider(int x_, int y_, int w_, int h_, float mv_, String L_, String caption_) {

    super(x_, y_, w_, h_, caption_);

    maxValue = mv_;
    label = L_;
    caption = caption_;
    value = 0;

    indicatorColor = color(128, 0, 255);
  }


  void display() {

    super.display();

    rectMode(CORNER);

    float displayValue;
    if (mouseInside()) {
      displayValue = w*value/maxValue;
    } 
    else {
      displayValue = w*savedValue/maxValue;
    }

    fill(indicatorColor);
    rect(x, y, displayValue, -h); 

    fill(255, 255, 255);
    textSize(12);
    text(caption, x, y+15);

    fill(255);
    textSize(12);
    text(label +": "+nfc(value, digits), x+10, y-16);
  }

  float read() {

    float val = super.readX();

    if (val == -1) { 
      return -1;
    }

    val = val/w;
    fill(255, 0, 0, 128);
    rectMode(CORNER);
    rect(x, y, w*val, -h);

    value = maxValue*val;
    fill(255);
    textSize(12);
    text(label +": "+nfc(value, 1), x+10, y-16);

    return value;
  }

  int readInteger() {

    float val = read();
    return int(val);
  }


  void setValue(float val) {

    value = val;
    savedValue = val;
  }

  void setIntegerValue(int val) {

    setValue(float(val));
  }

  void saveValue() {

    savedValue = value;
  }
}


class DoubleSlider extends Slider {

  float value2, minValue, savedValue2;

  DoubleSlider (int x_, int y_, int w_, int h_, float mv_, String L_, String caption_) {

    super(x_, y_, w_, h_, mv_, L_, caption_);
  }

  void display() {

    // super.display();

    rectMode(CORNER);

    float displayValue;
    if (mouseInside()) {
      displayValue = w*value/maxValue;
    } 
    else {
      displayValue = w*savedValue/maxValue;
    }

    float displayValue2;
    if (mouseInside()) {
      displayValue2 = w*value2/maxValue;
    } 
    else {
      displayValue2 = w*savedValue2/maxValue;
    }

    fill(0, 0, 255);
    rect(x, y, w, -h);
    fill(indicatorColor);
    rect(x + displayValue2, y, displayValue - displayValue2, -h); 

    fill(255, 255, 255);
    textSize(12);
    text(caption, x, y+15);

    fill(255);
    textSize(12);
    text(label +": "+nfc(value2, 1)+", "+nfc(value, 1), x+10, y-16);
    // text(label +": "+nfc(value,digits), x+10, y-16);
  }

  float read() {

    float val = super.readX();

    if (val == -1) { 
      return -1;
    }

    val = val/w;
    val = maxValue*val;
    float midpoint = (value + value2)/2;

    println("Val2, val = "+nfc(value2, 1)+", "+nfc(value, 1)+"  value read = "+nfc(val, 1));

    if (val >  midpoint ) { 

      value = val;
      savedValue = value;
    } 
    else 
    {
      value2 = val;
      savedValue2 = value2;
    }

    return value;
  }


  void setValue2(float val) {

    value2 = val;
    savedValue2 = val;
  }
}
