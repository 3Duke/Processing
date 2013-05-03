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
       colorAngle1 = float(value[1]);
       colorAngle2 = float(value[2]);  

       colorAngle1 = map(colorAngle1, 0, 1023, 0, 360); 
       colorAngle2 = map(colorAngle2, 0, 1023, 0, 360);
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
    colorMode(HSB, 360, 1, 1);
    color cc = color(colorAngle1, 1, 1);
    colorBox1.setColor(cc);
    
    colorMode(HSB, 360, 1, 1);
    cc = color(colorAngle2, 1, 1);
    println("CA2 = "+nfc(colorAngle2,1));
    colorBox2.setColor(cc);
    
  } else 
  {

    if (particleSize > 0) {
      MaxRadius = particleSize;
    }
    
    if (speedRead > 0) {
      
      baseFrameRate = speedRead;
      manageFrameRate();
      // frameRate(baseFrameRate);
    }
  }
  
}



void serialEvent(Serial port) {
  incomingMessage = port.readStringUntil('\n');
  incomingMessage = incomingMessage.trim();
  // println(incomingMessage);

}
