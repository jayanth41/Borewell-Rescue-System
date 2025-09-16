int EN1 = 9;   // Speed control
int IN1 = 8;   // Direction
int IN2 = 7;   // Direction

void setup() {
  Serial.begin(9600);
  pinMode(EN1, OUTPUT);
  pinMode(IN1, OUTPUT);
  pinMode(IN2, OUTPUT);
  Serial.println("Ready. Send F, B, or S to control motor.");
}

void loop() {
  if (Serial.available()) {
    char cmd = Serial.read();
    if (cmd == 'F') {
      digitalWrite(IN1, HIGH);
      digitalWrite(IN2, LOW);
      analogWrite(EN1, 5);
      Serial.println("Motor Forward");
    }
    else if (cmd == 'B') {
      digitalWrite(IN1, LOW);
      digitalWrite(IN2, HIGH);
      analogWrite(EN1, 5);
      Serial.println("Motor Backward");
    }
    else if (cmd == 'S') {
      analogWrite(EN1, 0);
      Serial.println("Motor Stopped");
    }
  }
}
