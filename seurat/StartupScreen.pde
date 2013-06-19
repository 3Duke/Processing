
void startupScreen() {
  
 if (frameCount < 60) {
   mainDisplayOn = false;
 } else {
   mainDisplayOn = true;
 }
 
  if (frameCount < 2) {
    
    fill(255,125,0);
    textSize(20);
    text("Op. 3, no. 1", 255, 70);
    
  }
  
  if ((frameCount > 30) && (frameCount < 170)) {

    fill(255,125,0);
    textSize(80);
    text("Bebop in C", 250, 250);
  }
  if ((frameCount > 50) && (frameCount < 110)) {
    fill(0,0,255);
    textSize(50);
    text("Jim Carlson", 300, 400); 
  }
  if ((frameCount > 50) && (frameCount < 110)) {
    
    fill(20,20,40);
    ellipse(530,485,120,120);
    fill(0,0,255);
    ellipse(560,485,40,40);
    rectMode(CENTER);
    // rect(530,485,5,120);
    rectMode(CORNER);
    
    fill(0,0,255);
    text("Offcenter Studios", 600, 500);
    text("2013", 1000, 560); 
    
     
  }
  textSize(18);
}
