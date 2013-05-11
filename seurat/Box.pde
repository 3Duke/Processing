class Box extends Widget {

  float r, g, b, a;

  String text;

  Box(float x_, float y_, float w_, float h_, String text_) {

    super(x_, y_, w_, h_, "");
    r = 255; 
    g = 0; 
    b = 0; 
    a = 255;
    text = text_;
  }

  void display() {

    super.display();

    fill(255);
    textSize(12);
    text(text, x + 10, y - 12);
  }



  void setRGBAColor( float r, float g, float b, float a ) {

    colorMode(RGB, 255, 255, 255, 255);

    bg = color(r, g, b, a);
  }
}
