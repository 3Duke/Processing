// Sensor2Serial-Esplora.ino reads data from Esplora's
// sensors and sends that data out on the serial port.
// In this example, the linear potentiomeeter and
// joystickX values are read and sent in one line
// like this:
//
//       "S,25,123"
//
// Typically a Processing program will read this data
// on on the serial port and will expect lines beginning
// with an "S" followed by comma-number-comma-number.
// This protocal gives the receiving program a way
// to ignore invalid data.

// http://arduino.cc/en/Reference/EsploraLibrary

#include <Esplora.h>

void setup()
{
  Serial.begin(9600);
} 

void loop()
{
  int potValue = Esplora.readSlider();     // range: 0-1023
  int joystickX = Esplora.readJoystickX(); // range: -512 to 512
  
 
  
  /**
  int tempValue = Esplora.readTemperature(DEGREES_F);
  int micLevel = Esplora.readMicrophone();
  int lightValue = Esplora.readLightSensor();
  **/

  Serial.println("S,"+String(potValue)+","+String(joystickX));

  delay(10);
}
