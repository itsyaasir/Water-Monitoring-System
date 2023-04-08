#include <Wire.h>
#include <LiquidCrystal_I2C.h>
LiquidCrystal_I2C lcd(0x27, 16, 2); // 0x27 is the i2c address, while 16 = columns, and 2 = rows.
const int turbiditySensor = A0;
void setup()
{
  pinMode(turbiditySensor, INPUT);
  lcd.init();      // Init the LCD
  lcd.backlight(); // Activate backlight
  lcd.home();

  pinMode(turbiditySensor, INPUT);
}

void loop()
{
  int sensorValue = analogRead(turbiditySensor);
  Serial.println(sensorValue);
  int turbidity = map(sensorValue, 0, 640, 100, 0);
  delay(100);
  lcd.setCursor(0, 0);
  lcd.print("turbidity:");
  lcd.print("   ");
  lcd.setCursor(10, 0);
  lcd.print(turbidity);
  delay(100);
  if (turbidity < 20)
  {
    digitalWrite(2, HIGH);
    digitalWrite(3, LOW);
    digitalWrite(4, LOW);
    lcd.setCursor(0, 1);
    lcd.print(" its CLEAR ");
  }
  if ((turbidity > 20) && (turbidity < 50))
  {
    digitalWrite(2, LOW);
    digitalWrite(3, HIGH);
    digitalWrite(4, LOW);
    lcd.setCursor(0, 1);
    lcd.print(" its CLOUDY ");
  }
  if (turbidity > 50)
  {
    digitalWrite(2, LOW);
    digitalWrite(3, LOW);
    digitalWrite(4, HIGH);
    lcd.setCursor(0, 1);
    lcd.print(" its DIRTY ");
  }
}