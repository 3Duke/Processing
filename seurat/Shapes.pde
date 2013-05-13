

class SEStar {

  float x, y, r;
  color c;
  int n;

  SEStar(float x_, float y_, float r_, int n_, color c_) {

    x = x_; 
    y  = y_; 
    r = r_; 
    n = n_; 
    c = c_;
  }

  void display() {

    stroke(c);

    float angle = 0;
    float dAngle = TWO_PI/n;



    beginShape();


    for (int i = 0; i < n; i ++) {

      vertex(x, y);
      vertex(x + r*cos(angle), y + r*sin(angle));
      angle += dAngle;
      println(angle);
    }

    endShape();
  }
}
