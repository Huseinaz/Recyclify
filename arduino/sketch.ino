#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

const char* ssid = "wifi-name";
const char* password = "wifi-password";
const char* apiUrl = "apiUrl";

const String serverUrl = "serverUrl";


const int buttonPin1 = D7;
const int buttonPin2 = D6;

void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);

  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }

  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

void setup() {
  Serial.begin(115200);

  setup_wifi();

  pinMode(buttonPin1, INPUT_PULLUP);
  pinMode(buttonPin2, INPUT_PULLUP);
}

void loop() {

  int buttonState1 = digitalRead(buttonPin1);
  int buttonState2 = digitalRead(buttonPin2);

  if (buttonState1 == LOW) {
    Serial.println("Button 1 Pressed");
      sendValueToAPI("50");
    delay(3000);
  }

  if (buttonState2 == LOW) {
    Serial.println("Button 2 Pressed");

      sendValueToAPI("100");
    delay(3000);
  }
}

void sendValueToAPI(String value) {
  WiFiClient wifiClient;

  HTTPClient http;

  http.begin(wifiClient, apiUrl);

  http.addHeader("Content-Type", "application/x-www-form-urlencoded");

  String postData = "value=" + value;

  int httpResponseCode = http.POST(postData);

  if (httpResponseCode > 0) {
    Serial.print("HTTP Response code: ");
    Serial.println(httpResponseCode);

    String response = http.getString();
    Serial.println("Response: " + response);
  } else {
    Serial.print("Error sending POST request: ");
    Serial.println(httpResponseCode);
  }

  http.end();
}