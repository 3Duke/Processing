///////////////////////////////////////////////////////////////////////////
//
//     HELPER SFOR DRAW
//
///////////////////////////////////////////////////////////////////////////

void displayMessage() {

  noStroke();

  textSize(12);
  // Erase the previous display of frameCount
  fill(frameSet.red(0), frameSet.green(0), frameSet.blue(0), 255); // XXX
  text(previousMessage, 10, height - 8);
  // Display frameCount
  fill(200);
  previousMessage = message;
  // message = str(frameCount) + ", " + str(round(frameRate));
  text(message, 10, height - 8);
}



void manageFrameRate(float newFrameRate) {
  // changes frame rate
  baseFrameRate = newFrameRate;
  float currentFrameRate = baseFrameRate + 7*sin(TWO_PI*frameCount/20000);
  frameRate(currentFrameRate);
}

void displayControls1 () {
  
  control.display();

    colorWheel1.display();
    colorWheel2.display();

    colorBox1.display(); 
    colorBox2.display();
    
    fileControlBox.display();
    textControlBox.display();

    radiusSlider.display();
    speedSlider.display();

    radiusSlider.read();
    speedSlider.read();
   
}

void displayControls2() {
  
   alphaSlider.display();
   alphaSlider.read();
   
   minLevelSlider.display();
   maxLevelSlider.display();
  
}

void hideControls () {
  
  if (screenControlsOn) {
    fill(0);
    rectMode(CORNER);
    // rect(0,0, WIDTH, controlMargin);
    rect(0,HEIGHT - controlMargin + displayMargin -10, displayWidth, 200);
  }

}


void displayControls() {
  

  if (switchA == 1) { colorBox1.display();   colorBox2.display();  }
  
  if (controlsActive) { displayControls1(); } 
  
  if (controlsActive2) { displayControls2(); } 
 
  if ((!controlsActive) && (!controlsActive2)) { hideControls(); }
  
  
}

void nop() {
} // dummy function, does nothing
