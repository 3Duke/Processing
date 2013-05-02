// snsor2serial.ino reads data from Arduino's
// analogue pins and sends that data out on the serial port.
// Output to the serial port is like this
//
//       "S,25,123"
//
// Typically a Processing program will read this data
// on on the serial port and will expect lines beginning
// with an "S" followed by comma-number-comma-number.
// This protocal gives the receiving program a way
// to ignore invalid data.
//
// The delay in loop() for sensor reads is set to 10 milliseconds
// so that the receiving program can give "real-time" response.

const int switchPin1 = 2;
const int switchPin2 = 3;
const int switchPin3 = 4;

const int ledPin = 13;
const int greenLEDPin = 8;
const int redLEDPin = 9;
const int greenLEDPin2 = 10;
const int yellowLEDPin = 11;

int switchVal1, switchVal2, switchVal3;

const int report_delay = 50;    // milliseconds between reads, serial write

void setup()
{
  Serial.begin(9600);
  
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);

  pinMode(switchPin1, INPUT);
  pinMode(switchPin2, INPUT);
  pinMode(switchPin3, INPUT);
  
  pinMode(ledPin, OUTPUT);
  pinMode(greenLEDPin, OUTPUT);
  pinMode(redLEDPin, OUTPUT);
  pinMode(greenLEDPin2, OUTPUT);
  pinMode(yellowLEDPin, OUTPUT);
} 

void loop()
{
  
  
  
  if (millis() % report_delay == 0)
  {
    int a0  = analogRead(A0);
    int a1  = analogRead(A1);
    int a2  = analogRead(A2);
    
    switchVal1 = digitalRead(switchPin1);
    switchVal2 = digitalRead(switchPin2);
    switchVal3 = digitalRead(switchPin3);
    
    signalLEDS();
    
    String m1 = String(a0)+","+String(a1)+","+String(a2);
    String m2 = String(switchVal1)+","+String(switchVal2)+","+String(switchVal3);

    Serial.println("S,"+m1+","+m2);
  } 
  
  
    
   // digitalWrite(redLEDPin, HIGH); 
   // digitalWrite(greenLEDPin, HIGH);
  
  testLED();
  
}

void signalLEDS (void) {
  
  if (switchVal3 == 1) { 
      digitalWrite(greenLEDPin, LOW);
      digitalWrite(redLEDPin, HIGH);
    } else if (switchVal3 == 0) { 
      digitalWrite(greenLEDPin, HIGH);
      digitalWrite(redLEDPin, LOW);
    }
    
    if (switchVal1 == 1) { 
      digitalWrite(greenLEDPin2, LOW);
      digitalWrite(yellowLEDPin, HIGH);
    } else if (switchVal1 == 0) { 
      digitalWrite(greenLEDPin2, HIGH);
      digitalWrite(yellowLEDPin, LOW);
    }
    
}

/*
boolean debounce(int pin) {

  boolean state;
  boolean previousState;

  previousState = digitalRead(pin);   // sketch state
  for(int counter = 0; counter < debounceDelay; counter++) 
  {
    delay(1);                        // wait for one millisecond
    state = digitalRead(pin);         // read the pin
    if ( state != previousState )
    {
      counter = 0;                   // reset the counter if the state changes
      previousState = state;         // and save the current state
    }
  } // when the switch state has been stable longer than the debounce period

  return state;
}

*/

void testLED(void) {
  
  if (millis() % 100 == 21) 
  {
    digitalWrite(ledPin, HIGH);
  }
  if (millis() % 400 == 23) 
  {
    digitalWrite(ledPin, LOW);
  }
  
}


