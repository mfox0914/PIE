/*
 Sweeping an Area with a Distance Sensor and Reading Voltage

 By: Michaela Fox and Jade Campbell
*/

#include <Servo.h>

Servo myservo1;
Servo myservo2;  // create Servo object to control a servo

int potpin = A0;  // analog pin used to connect the distance sensor
int val;    // variable to read the value from the analog pin
int sensorValue = 0; // variable to read the distance
float voltage = 0; // variable to hold the analog to voltage value
int pos = 0;       // variable to store the servo position

void setup() {
  myservo1.attach(9);
  myservo2.attach(10);
  Serial.begin(9600);  // start the serial communication
}

void loop() {
  // Sweep from 0 to 180 degrees
  for (pos = 0; pos <= 180; pos += 1) { 
    myservo1.write(pos);
    myservo2.write(pos);              
    delay(15);  // wait 15 ms for the servos to reach the position
    // Read the sensor data (voltage)
    sensorValue = analogRead(potpin);
    voltage = sensorValue * (5.0 / 1023.0);

    // Send servo position and voltage to MATLAB
    Serial.print(pos);    Serial.print(",");
    Serial.println(voltage);

  }

  

  // Sweep from 180 to 0 degrees
  for (pos = 180; pos >= 0; pos -= 1) { 
    myservo1.write(pos);
    myservo2.write(pos);              
    delay(15);  // wait 15 ms for the servos to reach the position

    // Read the sensor data (voltage)
    sensorValue = analogRead(potpin);
    voltage = sensorValue * (5.0 / 1023.0);

    // Send servo position and voltage to MATLAB
    Serial.print(pos);    Serial.print(",");
    Serial.println(voltage);

    
  }
  
}

