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

void setup()
{
  Serial.begin(9600);
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
} 

void loop()
{
  int a0  = analogRead(A0);
  int a1  = analogRead(A1);
  int a2  = analogRead(A2);

  Serial.println("S,"+String(a0)+","+String(a1)+","+String(a2));

  delay(50); // milliseconds
}
