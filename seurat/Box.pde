class Box {
  
 float x, y, w, h;
 float r, g, b, a;

 Box(float x_, float y_, float w_, float h_) {
  
   x = x_; y = y_; w = w_; h = h_;
   r = 255; g = 0; b = 0; a = 255;
   
 }
 
 
 void display() {
   
   fill(r,g,b,a);
   println("box ("+ frameCount + ") :"+x+", "+y+", "+w+", "+h);
   rect(x,  y, x + w, y + h); 
    
 }
  
  
  
}
