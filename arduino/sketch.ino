#include <Arduino.h>

const int buttonPin1 = D7;
const int buttonPin2 = D6;

void setup() {
  Serial.begin(115200);

  pinMode(buttonPin1, INPUT_PULLUP);
  pinMode(buttonPin2, INPUT_PULLUP);
}

void loop() {
  
  int buttonState1 = digitalRead(buttonPin1);
  int buttonState2 = digitalRead(buttonPin2);

  if (buttonState1 == LOW) {
    Serial.println("Button 1 Pressed");
    delay(3000);
  }

  if (buttonState2 == LOW) {
    Serial.println("Button 2 Pressed");
    delay(3000);
  }
}
