///////////////////////////////////////////////////////////////////////////
//
//     HELPER SFOR DRAW
//
///////////////////////////////////////////////////////////////////////////

void displayMessage() {

  noStroke();

  textSize(12);
  // Erase the previous display of frameCount
  fill(frames[0].r, frames[0].g, frames[0].b, 255);
  text(previousMessage, 10, height - 8);
  // Display frameCount
  fill(200);
  previousMessage = message;
  // message = str(frameCount) + ", " + str(round(frameRate));
  text(message, 10, height - 8);
}

void displayFrames () {

  float M = MaxRadius;

  for (int i = 0; i < frames.length; i++) {  // XXX

    frames[i].display(M);
    frames[i].change(200);
    M = inverseGoldenRatio*M;
  }
}

void manageFrameRate() {

  float currentFrameRate = baseFrameRate + 7*sin(TWO_PI*frameCount/20000);
  frameRate(currentFrameRate);
}

void displayControls() {
  
  
  if (switchA == 1) {
    
    colorBox1.display(); 
    colorBox2.display();
  }

  if (controlsActive) {

    control.display();

    colorWheel1.display();
    colorWheel2.display();

    colorBox1.display(); 
    colorBox2.display();

    radiusSlider.display();
    speedSlider.display();

    float radiusRead = radiusSlider.read();
    if (radiusRead > 0) {
      MaxRadius = radiusRead;
    }
    
    float speedRead = speedSlider.read();
    if (speedRead > 0) {
      baseFrameRate = speedRead;
    }
   
  }
}

void nop() {
} // dummy function, does nothing

