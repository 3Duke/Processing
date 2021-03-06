class Widget {

  float x, y;        // position: upper left corner
  float w, h;        // diemsnsions
  float xc, yc;      // coordinates of center
  float radius;      // radius
  color bg;          // background color
  String caption;
  boolean highlighted;
  String text;

  Widget(float x_, float y_, float w_, float h_, String caption_) {

    x = x_; 
    y = y_;
    w = w_; 
    h = h_;
    caption = caption_;
    text = "";
   

    bg = color(0, 0, 255);

    // Calculated values:
    radius = min(w, h)/2;
    xc = x + radius;
    yc = y - radius;

    highlighted = false;
  }
  
  void setText(String text_) {
    text = text_;
  }

  void setColor( color c ) {
    colorMode(RGB, 255, 255, 255);
    printColor(c, "Widget");
    bg = c;
  }

  float red() {

    return bg >> 16 & 0xFF;
  }

  float green() {

    return bg >> 8 & 0xFF;
  }

  float blue() {

    return bg & 0xFF;
  }

  void report(String label) {

    rectMode(CORNER);
    // println(label+": r = "+nfc(red(),0)+", g = "+nfc(green(),0)+", b = "+nfc(blue(),0));
    println(label+": corner = "+x+","+y+"   w = "+w+",  h = "+h+" --- center = "+xc+", "+yc);
  }

  void display() {

    rectMode(CORNER);
    colorMode(RGB, 255, 255, 255);

    if (!highlighted) {
      fill(bg);
    } 
    else {
      fill(0);
      highlighted = false;  // turn off on next cycle
    }
    noStroke();

    rectMode(CORNER);
    rect(x, y, w, -h); 

    fill(255);
    textSize(12);
    text(caption, x, y+15);
    
    fill(255);
    textSize(12);
    text(text, x + 10, y - 12);
  }

  boolean mouseInside() {

    if ( (mouseX > x) && ( mouseX < x + w) && (mouseY > y - h) ) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }

  boolean mouseInsideCircle() {

    rectMode(CORNER);
    int mx = mouseX;
    int my = mouseY;
    float d2 = squaredDistance(xc, yc, mx, my);
    float distance = sqrt(d2);


    if ( distance < radius ) 
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }


  float readX() {

    if ( (mouseX > x) && ( mouseX < x + w) && (mouseY > y - h) ) {

      return (mouseX - x);
    } 
    else {

      return -1;
    }
  }

  float readY() {

    if ( (mouseX > x) && ( mouseX < x + w) && (mouseY > y - h) ) {

      return (y - mouseY);
    } 
    else {

      return -1;
    }
  }

  float readAngle() {

    float xm = mouseX; 
    float ym = mouseY;

    float tan_ = -(ym - yc)/(xm - xc);  // infinities?

    float angle = 360*atan(tan_)/(2*3.14159265);

    if ((ym - yc > 0) && (xm - xc > 0)) { // Quadran1 IV

      angle = 360 + angle;
    }

    if ((ym - yc > 0) && (xm - xc < 0)) { // Quadrant III

      angle = 180 + angle;
    }

    if ((yc - ym > 0) && (xm - xc < 0)) { // Quadrant II

      angle =  180 + angle;
    }
    println("Angle: "+nfc(angle, 0));
    return angle;
  }

  float readRadius () {

    float dx = mouseX - xc;
    float dy = mouseY - yc;
    return sqrt(dx*dx + dy*dy);
  }

  void highLight() {

    highlighted = true;
  }
} // class
