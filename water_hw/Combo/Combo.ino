#include <LiquidCrystal_I2C.h>
#include <ESP8266WiFi.h>
#include <ArduinoHttpClient.h>
#include <ArduinoJson.h>
#include <iostream>
#include <string>
#include <curl/curl.h>

WiFiClient client;
const char *ssid = "Alpha";
const char *password = "Banshee42";

// Define the server address and port
const char *serverAddress = "127.0.0.1";
int serverPort = 3000;

LiquidCrystal_I2C lcd(0x27, 16, 2);

int relayInput = 2; // the input to the relay pin
int relayInput1 = 13;

const int trigPin = 14;
const int echoPin = 12;
const int trigPin1 = 15;
const int echoPin1 = 10;
int LedRed = 16;
int LedGreen = 9;
long duration;
long duration1;
long percentage;
long percentage1;

int distance;
int distance1;

void setup()
{
  Serial.begin(115200); // delay(10);
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED)
  {
    Serial.print("..");
    delay(10);
  }

  lcd.begin(16, 2);
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);

  lcd.print("TANK LEVEL: ");

  lcd.setCursor(0, 1);
  lcd.print("CHL  LEVEL: ");

  pinMode(relayInput, OUTPUT);  // initialize pin as OUTPUT
  pinMode(relayInput1, OUTPUT); // initialize pin as OUTPUT
  pinMode(trigPin, OUTPUT);     // Sets the trigPin as an Output
  pinMode(echoPin, INPUT);      // Sets the echoPin as an Input
  pinMode(trigPin1, OUTPUT);    // Sets the trigPin as an Output
  pinMode(echoPin1, INPUT);     // Sets the echoPin as an Input
  pinMode(LedRed, OUTPUT);
  pinMode(LedGreen, OUTPUT);
}

void loop()
{
  // digitalWrite(relayInput, HIGH); // turn relay on

  digitalWrite(trigPin, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin, LOW);
  duration = pulseIn(echoPin, HIGH);

  digitalWrite(trigPin1, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin1, LOW);
  duration1 = pulseIn(echoPin1, HIGH);

  // Calculating the distance
  distance = duration * 0.034 / 2;
  distance1 = duration1 * 0.034 / 2;
  percentage = (100 - (distance * 100) / (23));
  percentage1 = (100 - (distance1 * 100) / (16));
  // Prints the distance on the Serial Monitor
  Serial.print("Tank : ");
  Serial.println(distance);

  lcd.setCursor(14, 0);
  lcd.print(" ");
  lcd.setCursor(12, 0);
  lcd.print(percentage);
  lcd.setCursor(15, 0);
  lcd.print("%");

  lcd.setCursor(14, 1);
  lcd.print(" ");
  lcd.setCursor(12, 1);
  lcd.print(percentage1);
  lcd.setCursor(15, 1);
  lcd.print("%");

  Serial.print("CHL : ");
  Serial.println(distance1);

  if (distance1 < 8)
  {
    digitalWrite(LedRed, HIGH);
    digitalWrite(LedGreen, LOW);
  }
  else
  {
    digitalWrite(LedGreen, HIGH);
    digitalWrite(LedRed, LOW);
  }

  delay(1000);

  // Print the data to the serial monitor
  Serial.println("Tank Level: " + String(percentage));
  Serial.println("CHL Level: " + String(percentage1));

  // Send the data to the server every 5 minutes
  delay(300000);

  // Send the data to the server
  sendData();
}

// Initialize the HttpClient
HttpClient httpClient = HttpClient(client, serverAddress, serverPort);

String login()
{
  // Create a JSON object to hold the login credentials
  const size_t capacity = JSON_OBJECT_SIZE(2);
  DynamicJsonBuffer jsonBuffer(capacity);
  JsonObject &root = jsonBuffer.createObject();
  root["email"] = "yasir@gmail.com";
  root["password"] = "123456";

  // Serialize the JSON object to a String
  String requestBody;
  root.printTo(requestBody);

  // Send a POST request to the login endpoint with the JSON data in the body
  httpClient.beginRequest();
  httpClient.post("/api/v1/auth/login", "application/json", requestBody);
  int statusCode = httpClient.responseStatusCode();

  // check the status code
  if (statusCode != 200)
  {
    Serial.println("Error logging in");
    return "";
  }

  // Get the response body
  String responseBody = httpClient.responseBody();
  httpClient.endRequest();

  // Parse the response JSON to get the token
  size_t tokenCapacity = JSON_OBJECT_SIZE(1);
  DynamicJsonBuffer tokenJsonBuffer(tokenCapacity);
  JsonObject &tokenRoot = tokenJsonBuffer.parseObject(responseBody);
  String token = tokenRoot["token"].as<String>();

  // Return the token
  return token;
}

// we need to call the sendData function every 5 minutes, it is only for posting data to the server
int sendData()
{
  // login and get the token
  String token = login();

  // Create a JSON object to hold the data
  const size_t capacity = JSON_OBJECT_SIZE(2);
  DynamicJsonBuffer jsonBuffer(capacity);
  JsonObject &root = jsonBuffer.createObject();

  root["temperature"] = 22;
  root["ph"] = 7.5;
  root["turb"] = 0.5;
  root["waterLevel"] = distance;

  // Serialize the JSON object to a String
  String requestBody;
  root.printTo(requestBody);

  // begin the request
  httpClient.beginRequest();

  // add the token to the header
  httpClient.addHeader("x-token", token);
  httpClient.post("/api/v1/stats", "application/json", requestBody); // send the data

  // Send the request and get the response
  int statusCode = httpClient.responseStatusCode();
  // check the status code
  if (statusCode == 200)
  {
    Serial.println("Data sent successfully");
  }
  else
  {
    Serial.println("Error sending data");
  }

  // Close the connection
  httpClient.endRequest();
}