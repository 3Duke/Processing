

// http://arduino.cc/en/Reference/EsploraLibrary

#include <Esplora.h>

void setup()
{
  Serial.begin(9600);
} 

void loop()
{
  int potValue = Esplora.readSlider();
  int lightValue = Esplora.readLightSensor();
  int tempValue = Esplora.readTemperature(DEGREES_F);
  int micLevel = Esplora.readMicrophone();
  int joystickX = Esplora.readJoystickX();
 

  
  potValue = map(potValue, 0, 1023, 0, 255);
  lightValue = map(lightValue, 0, 1023, 0, 255);
  //tempValue = map(tempValue, 20, 40, 0, 255);
  micLevel = map(micLevel, 0, 1023, 0, 255);
  joystickX = map(joystickX, -512, 512, 0, 255);
  
  
  
  Serial.println(String(potValue)+","+lightValue+","+joystickX);

  delay(10);
}
