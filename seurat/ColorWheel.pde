

class ColorWheel extends Widget {

  float deg = 2*PI/360;

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

    colorMode(HSB, 360, 100, 100);

    for ( float angle = 0; angle < 360; angle += 0.5 ) {
      fill(angle, s, b);
      arc(xc, yc, 2*radius, 2*radius, -angle*deg, (-angle + 0.5)*deg);  // XXX: Kludge
    }

    colorMode(RGB, 255, 255, 255, 255);
    rectMode(CORNER);
  }

  color read() {

    colorMode(HSB, 360, 1, 1);

    color c = color(readAngle(), readRadius(), 1);

    colorMode(RGB, 255, 255, 255);

    return c;
  }

  boolean mouseInside() {

    return mouseInsideCircle();
  } //
} // end class
