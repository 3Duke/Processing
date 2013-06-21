
void relativeTextSize(float s) {
  
  textSize( parameters.displayScaleFactor*s);
  
}


void startupScreen() {
  
  float F =  parameters.displayScaleFactor;
  float hm = parameters.horizontalFrameMargin, vm = parameters.verticalFrameMargin;
  float x = hm, y = vm;
  
 if (frameCount < 60) {
   mainDisplayOn = false;
 } else {
   mainDisplayOn = true;
 }
 
  if (frameCount < 2) {
    
    fill(255,125,0);
    x = x + F*10; y = y + F*25;
    text("Etude 1 (Op 3 no 1)", x, y);
    
  }
  
  if ((frameCount > 30) && (frameCount < 170)) {

    fill(255,125,0);
    relativeTextSize(80);
    x = x + F*100; y = y + F*220;
    text("Bebop in C", x, y);
  }
  if ((frameCount > 50) && (frameCount < 110)) {
    fill(0,0,255);
    relativeTextSize(50);
    x = x + F*175;
    y = y + F*200;
    text("Jim Carlson", x, y); 
  }
  if ((frameCount > 50) && (frameCount < 110)) {
    
    fill(20,20,40);
    x = x + F*100; y = y + F*50;
    ellipse(x,y,F*120,F*120);
    fill(0,0,255);
    x = x + F*30; 
    ellipse(x,y,F*40,F*40); // x + 30
    rectMode(CENTER);
    // rect(530,485,5,120);
    rectMode(CORNER);
    
    fill(0,0,255);
    x = x + F*40; y = y + F*20;
    text("Offcenter Studios", x, y);
    x = x + 3F*90; y = y +F* 85;
    text("2013", x, y); 
    
     
  }
  relativeTextSize(18);
}
