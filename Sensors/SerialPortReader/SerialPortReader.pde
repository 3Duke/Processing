
// http://www.jeremyblum.com/2011/02/07/arduino-tutorial-6-serial-communication-and-processing/


// Serial library
import processing.serial.*;
Serial port;
int numberOfInputs = 3;

// Meters
BarMeter redLevelMeter, greenLevelMeter, blueLevelMeter, colorMeter;
TextDisplay textDisplay;

// Messages
PFont f;
String incomingMessage = "";

// Interpreted data
float r, g, b;

void setup() {
  size(350,160);
  
  
  port = new Serial(this, "/dev/tty.usbmodem1411", 9600); 
  port.bufferUntil('\n');
  
  f = createFont("Arial",16,true);
  textFont(f);
  textAlign(LEFT);
  fill(255);
  
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
    
  textDisplay.display(incomingMessage.trim());
  
  parseInput();
     
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

void parseInput() {
  
   String value[] = incomingMessage.split(",");
  if ( value.length == numberOfInputs + 1 ) {
    
     r = float(value[1]);
     g =  float(value[2]);
     b =  float(value[3]);
     
     r = map(r,0,1023,0,255);
     g = map(g,0,1023,0,255);
     b = map(b,0,1023,0,255);
     b = 0;  // temporarily disabled since there is no input on pin A2
   
  }
  
}
