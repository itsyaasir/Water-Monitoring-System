#include <LiquidCrystal_I2C.h>
#include <ESP8266WiFi.h>
#include <ArduinoJson.h>
#include <iostream>
#include <string>
#include <HttpClient.h>
#include <NewPing.h>

WiFiClient client;
const char *ssid = "Alpha";
const char *password = "Banshee42";

String token;

unsigned long startMillis; // some global variables available anywhere in the program
unsigned long currentMillis;
const unsigned long period = 1000 * 60 * 2; // 120 seconds

// Define the server address and port
const char *serverAddress = "172.16.0.103";
int serverPort = 3000;

LiquidCrystal_I2C lcd(0x27, 16, 2);

int waterPumpInput = 2;      // Waterpumprelay
int treatmentPumpInput = 13; // treatmentPumprelay

const int waterTrigPin = 14;
const int waterEchoPin = 12;

const int chlorineTrigPin = 15;
const int chlorineEchoPin = 10;

int LedRed = 16;
int LedGreen = 9;
long tankDuration;
long chlorineDuration;

long waterLevelPercentage;
long chlorineLevelPercentage;

int tankLevel;
int chlorineLevel;
const int waterEmpty = 23 + 2;
const int chlorineEmpty = 17 + 2;

NewPing waterSensor(waterTrigPin, waterEchoPin, waterEmpty);
NewPing chlorineSensor(chlorineTrigPin, chlorineEchoPin, chlorineEmpty);

HttpClient httpClient = HttpClient(client, serverAddress, serverPort);

float turbidity;
const int turbidityPin = A0;

void setup()
{
  Serial.begin(115200);
  WiFi.begin(ssid, password);
  Serial.println("Connecting");
  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.print("Connected to WiFi network with IP Address: ");
  Serial.println(WiFi.localIP());

  lcd.begin(16, 2);
  lcd.init();
  lcd.backlight();
  lcd.setCursor(0, 0);

  lcd.print("TANK LEVEL: ");

  lcd.setCursor(0, 1);
  lcd.print("CHL  LEVEL: ");

  pinMode(waterPumpInput, OUTPUT);     // initialize pin as OUTPUT
  pinMode(treatmentPumpInput, OUTPUT); // initialize pin as OUTPUT
  pinMode(waterTrigPin, OUTPUT);       // Sets the trigPin as an Output
  pinMode(waterEchoPin, INPUT);        // Sets the echoPin as an Input
  pinMode(chlorineTrigPin, OUTPUT);    // Sets the trigPin as an Output
  pinMode(chlorineEchoPin, INPUT);     // Sets the echoPin as an Input
  pinMode(LedRed, OUTPUT);
  pinMode(LedGreen, OUTPUT);
  pinMode(turbidityPin, INPUT);

  // Login
  token = login();
  startMillis = millis(); // initial start time
}

void loop()
{

  currentMillis = millis(); // get the current "time" (actually the number of milliseconds since the program started)

  tankLevel = waterSensor.ping_cm();

  chlorineLevel = chlorineSensor.ping_cm();

  waterLevelPercentage = map(tankLevel, 23, 3, 0, 100);

  chlorineLevelPercentage = map(chlorineLevel, 17, 2, 0, 100);

  turbidity = analogRead(turbidityPin);

  Serial.print("Turbidity : ");
  Serial.println(turbidity);

  // Prints the tankLevel on the Serial Monitor
  Serial.print("Tank : ");
  Serial.println(tankLevel);

  lcd.setCursor(14, 0);
  lcd.print(" ");
  lcd.setCursor(12, 0);
  lcd.print(waterLevelPercentage);
  lcd.setCursor(15, 0);
  lcd.print("%");

  lcd.setCursor(14, 1);
  lcd.print(" ");
  lcd.setCursor(12, 1);
  lcd.print(chlorineLevelPercentage);
  lcd.setCursor(15, 1);
  lcd.print("%");

  Serial.print("CHL : ");
  Serial.println(chlorineLevel);

  if (chlorineLevel < 8)
  {
    digitalWrite(LedRed, HIGH);
    digitalWrite(LedGreen, LOW);
  }
  else
  {
    digitalWrite(LedGreen, HIGH);
    digitalWrite(LedRed, LOW);
  }

  // Toggle
  toggleTreatmentPump();
  toggleWaterPump();

  // Print the data to the serial monitor
  Serial.println("Tank Level: " + String(waterLevelPercentage));
  Serial.println("CHL Level: " + String(chlorineLevelPercentage));

  if (currentMillis - startMillis >= period) // test whether the period has elapsed
  {
    sendData(); // if so, send the data
    startMillis = currentMillis;
  }
}

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
  httpClient.endRequest();

  int statusCode = httpClient.responseStatusCode();
  String responseBody = httpClient.responseBody();

  // check the status code
  if (statusCode != 200)
  {
    Serial.println("Error logging in");
    return "";
  }

  // Parse the response JSON to get the token
  const size_t capacity1 = JSON_OBJECT_SIZE(3) + JSON_OBJECT_SIZE(2) + 2 * JSON_OBJECT_SIZE(1) + 200;
  DynamicJsonBuffer jsonBuffer1(capacity1);
  JsonObject &root1 = jsonBuffer1.parseObject(responseBody);
  Serial.println("Logged in successfully");

  return root1["data"]["token"];
}

// we need to call the sendData function every 2 minutes, it is only for posting data to the server
void sendData()
{
  // Create a JSON object to hold the data
  const size_t capacity = JSON_OBJECT_SIZE(5);
  DynamicJsonBuffer jsonBuffer(capacity);
  JsonObject &root = jsonBuffer.createObject();

  root["chlorineLevel"] = chlorineLevelPercentage;
  root["ph"] = 7.5;
  root["turbidity"] = 22.5;
  root["waterLevel"] = waterLevelPercentage;
  root["token"] = token;

  // Serialize the JSON object to a String
  String requestBody;
  root.printTo(requestBody);
  // add the token to the header
  httpClient.post("/api/v1/stats/new", "application/json", requestBody); //
  httpClient.endRequest();
  int statusCode = httpClient.responseStatusCode();
  String responseBody = httpClient.responseBody();

  if (statusCode == 201)
  {
    Serial.println("Data sent successfully");
  }
  else
  {
    Serial.println("Error sending data");
  }
}

void toggleWaterPump()
{
  // We are getting the status of the water pump from the server to toggle the relay
  httpClient.beginRequest();
  httpClient.get("/api/v1/pumps/waterStatus");
  httpClient.sendHeader("x-token", token);
  httpClient.endRequest();

  int statusCode = httpClient.responseStatusCode();
  String responseBody = httpClient.responseBody();

  size_t tokenCapacity = JSON_OBJECT_SIZE(3);
  DynamicJsonBuffer tokenJsonBuffer(tokenCapacity);
  JsonObject &tokenRoot = tokenJsonBuffer.parseObject(responseBody);
  bool status = tokenRoot["data"].as<bool>();

  if (status)
  {
    digitalWrite(waterPumpInput, HIGH);
  }
  else
  {
    digitalWrite(waterPumpInput, LOW);
  }
}

void toggleTreatmentPump()
{
  // We are getting the status of the water pump from the server to toggle the relay
  httpClient.beginRequest();
  httpClient.get("/api/v1/pumps/treatmentStatus");
  httpClient.sendHeader("x-token", token);
  httpClient.endRequest();

  int statusCode = httpClient.responseStatusCode();
  String responseBody = httpClient.responseBody();

  // Parse the response JSON to get the token
  size_t tokenCapacity = JSON_OBJECT_SIZE(3);
  DynamicJsonBuffer tokenJsonBuffer(tokenCapacity);
  JsonObject &tokenRoot = tokenJsonBuffer.parseObject(responseBody);
  bool status = tokenRoot["data"].as<bool>();

  if (status)
  {
    digitalWrite(treatmentPumpInput, HIGH);
  }
  else
  {
    digitalWrite(treatmentPumpInput, LOW);
  }
}
