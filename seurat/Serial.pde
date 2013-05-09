  ///////////////////////////////////////////////////////////////////////////
//
//     SERIAL
//
///////////////////////////////////////////////////////////////////////////


void parseSerialData(int n_serial_inputs) {
   
  println(incomingMessage);
  String value[] = incomingMessage.split(",");
  
  
    // Example of data format for serial data (a string):
    // "S,123.4,8,9"
    // In this case nFields = 3
    // The first field is "S".  Its presence confirms
    // the validity of the string received.
    
    
     // Get digital inputs:
     switchA = int(value[4]);
     switchB = int(value[5]);
     switchC = int(value[6]);
    
    if (value.length == n_serial_inputs + 1) { 
     
     if (switchA == 1) // Manage bank 1 -- colors
     {
       controller.c1 = convertReading2color(value[1]);
       controller.c2 = convertReading2color(value[2]);
       
     } 
    else  // Manage bank 0 -- speed, size, 
    {
      particleSize = float(value[1]);
      speedRead = float(value[2]);
      
      particleSize = map(particleSize, 0, 1023, 1, 300);
      speedRead = map(speedRead, 0, 1023, 1, 300);
     }
   
     
    }
    
}



void reactToData () 
{         
    
  colorMode(HSB, 360, 1, 1);   
  // color c = color(colorAngle1, 1, 1);
  // message = "angle = "+colorAngle1+"speed = "+speedRead +"    A = "+ switchA+" B = "+switchB+" C = "+switchC;      
  colorMode(RGB, 255, 255, 255, 255);
   
  
  if (switchA == 1)  // Bank 1 --- manage colors
  {
    controller.updateColorBoxes();
    frameSet.setColorTori2(); 
  } 
  else 
  {
    if (particleSize > 0) {
      frameSet.maxRadius = particleSize;
    }   
    if (speedRead > 0) {
      manageFrameRate(speedRead);
      
    }
  }
  
}


// Read data on serial port one line at a time
// and post it to the string variable incomingMessage.
// In draw (), handleSerialInput() will process
// incomingMessage:  

void serialEvent(Serial port) {
  incomingMessage = port.readStringUntil('\n');
  incomingMessage = incomingMessage.trim();
  // println(incomingMessage);

}

float convertReading(String input, float MAX) {
  
  return map(float(input), 0, 1023, 0, MAX);
  
}

color convertReading2color(String input) {
  
  float hue  = map(float(input), 0, 1023, 0, 360);
  colorMode(HSB, 360, 1, 1);
  return color(hue, 1, 1);
}
