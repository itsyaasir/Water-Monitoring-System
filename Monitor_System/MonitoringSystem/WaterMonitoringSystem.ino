// Import the required libraries
#include <LiquidCrystal_I2C.h>
#include <ESP8266WiFi.h>
#include <ArduinoJson.h>
#include <HttpClient.h>
#include <NewPing.h>

// Define the WiFi credentials
const char *ssid = "Alpha";
const char *password = "Banshee42";

// Define the IP address and port of the server
const char *serverAddress = "172.16.0.103";
int serverPort = 3000;

// Define User credentials
const String email = "yasir@gmail.com";
const String userPassword = "123456";

// Define the pins used for the water and chlorine level sensors, pumps, and LEDs
const int waterTrigPin = 14;
const int waterEchoPin = 12;
const int chlorineTrigPin = 15;
const int chlorineEchoPin = 10;
int waterPumpInput = 2;
int treatmentPumpInput = 13;
int LedRed = 16;
int LedGreen = 9;
const int turbidityPin = A0;

// Define some global variables used for timing
unsigned long startMillis;
unsigned long currentMillis;
const unsigned long period = 1000 * 60 * 2; // 120 seconds

// Define some variables used to store data
long tankDuration;
long chlorineDuration;
long waterLevelPercentage;
long chlorineLevelPercentage;
int tankLevel;
int chlorineLevel;
float turbidity;
String token;

// Define the HTTP client object and the WiFi client object
WiFiClient client;
HttpClient httpClient = HttpClient(client, serverAddress, serverPort);

// Define the LCD object
LiquidCrystal_I2C lcd(0x27, 16, 2);

// Define the NewPing objects for the water and chlorine sensors
NewPing waterSensor(waterTrigPin, waterEchoPin);
NewPing chlorineSensor(chlorineTrigPin, chlorineEchoPin);

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

  pinMode(waterPumpInput, OUTPUT);
  pinMode(treatmentPumpInput, OUTPUT);
  pinMode(waterTrigPin, OUTPUT);
  pinMode(waterEchoPin, INPUT);
  pinMode(chlorineTrigPin, OUTPUT);
  pinMode(chlorineEchoPin, INPUT);
  pinMode(LedRed, OUTPUT);
  pinMode(LedGreen, OUTPUT);
  pinMode(turbidityPin, INPUT);

  token = login();
  startMillis = millis();
}

void loop()
{

  currentMillis = millis(); // get the current "time" (actually the number of milliseconds since the program started)

  tankLevel = waterSensor.ping_cm();

  chlorineLevel = chlorineSensor.ping_cm();

  waterLevelPercentage = map(tankLevel, 23, 3, 0, 100);

  chlorineLevelPercentage = map(chlorineLevel, 17, 2, 0, 100);

  turbidity = analogRead(turbidityPin);
  turbidity = map(turbidityPin, 0, 640, 100, 0);

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

  toggleTreatmentPump();
  toggleWaterPump();

  Serial.println("Tank Level: " + String(waterLevelPercentage));
  Serial.println("CHL Level: " + String(chlorineLevelPercentage));

  // Send data to the server every 2 minutes
  if (currentMillis - startMillis >= period)
  {
    sendData();
    startMillis = currentMillis;
  }
}

/// @brief Login to the server and get the token
/// @return The token
/// @info The token is used to authenticate the user for subsequent requests
String login()
{
  // Create a JSON object to hold the login credentials
  const size_t capacity = JSON_OBJECT_SIZE(2);
  DynamicJsonBuffer jsonBuffer(capacity);
  JsonObject &root = jsonBuffer.createObject();
  root["email"] = email;
  root["password"] = userPassword;

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

/// @brief Send the data to the server
/// @param void
/// @info The data should be a JSON object
void sendData()
{
  // Create a JSON object to hold the data
  const size_t capacity = JSON_OBJECT_SIZE(5);
  DynamicJsonBuffer jsonBuffer(capacity);
  JsonObject &root = jsonBuffer.createObject();

  root["chlorineLevel"] = chlorineLevelPercentage;
  root["ph"] = 7.5;
  root["turbidity"] = turbidity;
  root["waterLevel"] = waterLevelPercentage;
  root["token"] = token;

  String requestBody;
  root.printTo(requestBody);
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

/// @brief This function toggle the water pump
/// @param void
/// @return void
/// @note This function is called in the loop function
void toggleWaterPump()
{
  // We are getting the status of the water pump from the server to toggle the relay
  httpClient.beginRequest();
  httpClient.get("/api/v1/pumps/waterStatus"); // get the status of the water pump
  httpClient.sendHeader("x-token", token);     // add the token to the header
  httpClient.endRequest();

  int statusCode = httpClient.responseStatusCode();
  String responseBody = httpClient.responseBody();

  size_t tokenCapacity = JSON_OBJECT_SIZE(3);
  DynamicJsonBuffer tokenJsonBuffer(tokenCapacity);
  JsonObject &tokenRoot = tokenJsonBuffer.parseObject(responseBody);
  bool status = tokenRoot["data"].as<bool>();

  if (status)
  {
    digitalWrite(waterPumpInput, HIGH); // turn on the water pump
  }
  else
  {
    digitalWrite(waterPumpInput, LOW); // turn off the water pump
  }
}

/// @brief This function toggle the treatment pump
/// @param void
/// @return void
/// @note This function is called in the loop function
void toggleTreatmentPump()
{

  httpClient.beginRequest();
  httpClient.get("/api/v1/pumps/treatmentStatus"); // get the status of the treatment pump
  httpClient.sendHeader("x-token", token);         // add the token to the header
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
    digitalWrite(treatmentPumpInput, HIGH); // turn on the treatment pump
  }
  else
  {
    digitalWrite(treatmentPumpInput, LOW); // turn off the treatment pump
  }
}
