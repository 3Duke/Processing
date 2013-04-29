
// http://www.jeremyblum.com/2011/02/07/arduino-tutorial-6-serial-communication-and-processing/
// Learning Processing
// Daniel Shiffman
// http://www.learningprocessing.com

// Example 19-1: Simple therapy server

// Import the net libraries
import processing.serial.*;
Serial port;

BarMeter redLevelMeter, greenLevelMeter, blueLevelMeter, colorMeter;
TextDisplay textDisplay;

// Used to indicate a new message has arrived
float newMessageColor = 255;
PFont f;
String incomingMessage = "";

void setup() {
  size(350,160);
  
  
  port = new Serial(this, "/dev/tty.usbmodem1411", 9600); 
  port.bufferUntil('\n');
  
  
  f = createFont("Arial",16,true);
  
  redLevelMeter = new BarMeter(10, 10, 200, 30, 255);
  redLevelMeter.setColor(255,0,0);
  redLevelMeter.inset = 3;
  
  greenLevelMeter = new BarMeter(10, 45, 200, 30, 255);
  greenLevelMeter.setColor(0,255,0);
  greenLevelMeter.inset = 3;
  
  blueLevelMeter = new BarMeter(10, 80, 200, 30, 255);
  blueLevelMeter.setColor(0,0,255);
  blueLevelMeter.inset = 3;
  
  colorMeter = new BarMeter(240, 10, 100, 100, 1);
  
  textDisplay = new TextDisplay(10, 130, 325, 30);
  
  noStroke();
  background(0);
}

void draw() {
  
  textFont(f);
  textAlign(LEFT);
  fill(255);
  
  
  textDisplay.display(incomingMessage.trim());
    
  float r, g, b;
  r = 0; g = 0; b = 0;

    
  String value[] = incomingMessage.split(",");
  if ( value.length == 3 ) {
     r = float(value[0]);
     g =  float(value[1]);
     b =  float(value[2]);
    //  b = 255 - r;
  }

  
  redLevelMeter.display(r);
  greenLevelMeter.display(g);
  blueLevelMeter.display(b);
  
  colorMeter.setBackgroundColor(r,g,b);
  colorMeter.display(0);
  
}  // draw


void serialEvent(Serial port) {
  incomingMessage = port.readStringUntil('\n');
  println(incomingMessage);

}
