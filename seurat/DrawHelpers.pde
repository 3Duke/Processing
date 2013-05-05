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






void nop() {
} // dummy function, does nothing
