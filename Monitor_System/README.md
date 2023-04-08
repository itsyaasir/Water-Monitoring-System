# Water Monitoring System

This project is a water monitoring system that uses an ESP8266 board to measure the water level, chlorine level, and turbidity in a water tank.

## Note

This System can be controlled using a mobile app. The mobile app source code in the same repository.
The mobile app is built using Flutter and Dart. Click [here](../Monitor_App/README.md) to view the mobile app source code. You can get instructions on how to build the mobile app from the README.md file in the mobile app source code.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

### Prerequisites

You need to get the components listed below, and you need to install the Arduino IDE.

### Components

- ESP8266 board
- Ultrasonic sensors
- Turbidity sensor
- Liquid crystal display (LCD)
- Green LED
- Red LED
- pH sensor

### Installing

1. Download the Arduino IDE from <https://www.arduino.cc/en/Main/Software>.
2. Connect the ESP8266 board to your computer using a USB cable.
3. Open the Arduino IDE, and go to File > Preferences.
4. In the Additional Boards Manager URLs field, enter <http://arduino.esp8266.com/stable/package_esp8266com_index.json>, and click OK.
5. Go to Tools > Board > Boards Manager.
6. Search for ESP8266, and click Install.
7. Go to Tools > Board, and select the ESP8266 board.
8. Go to Tools > Port, and select the port that the ESP8266 board is connected to.
9. Clone this repository.
10. Open the `WaterMonitoringSystem.ino` file in the Arduino IDE.
11. Click the Upload button to upload the code to the ESP8266 board.

## Circuit

The circuit is very simple. The ultrasonic sensors are connected to the ESP8266 board's GPIO pins, and the turbidity sensor is connected to the ESP8266 board's analog input pin. The LCD is connected to the ESP8266 board's I2C pins, and the green LED and red LED are connected to the ESP8266 board's GPIO pins. The pH sensor is connected to the ESP8266 board's analog input pin.

## Code

The code is written in the Arduino programming language. The code is divided into two parts: the setup() function and the loop() function.

### Setup

The setup() function is run once when the board is powered on. In this function, the ultrasonic sensors, turbidity sensor, LCD, green LED, and red LED are initialized. The ultrasonic sensors are initialized using the NewPing library, and the LCD is initialized using the LiquidCrystal_I2C library.

### Loop

The loop() function is run repeatedly. In this function, the ultrasonic sensors, turbidity sensor, and pH sensor are read, and the LCD and LEDs are updated. We also send the data to the local server using the ESP8266 board's WiFi module.

## Sensors

- Ultrasonic sensors (NewPing library): The code is using two ultrasonic sensors to measure the water level and chlorine level in the tank. Ultrasonic sensors work by emitting a high-frequency sound pulse and measuring the time it takes for the pulse to bounce back after hitting an object. By measuring the time delay, the distance to the object can be calculated. In this code, the sensors are connected to the ESP8266 board's GPIO pins, and the NewPing library is used to simplify the process of measuring the distance.

- Turbidity sensor: The code is using a turbidity sensor to measure the level of turbidity (cloudiness) in the water. Turbidity is caused by suspended particles in the water, and it can be an indicator of water quality. The sensor works by shining a light through the water and measuring how much of the light is scattered. The more particles there are in the water, the more light will be scattered, and the higher the turbidity reading will be. In this code, the sensor is connected to the ESP8266 board's analog input pin, and the code uses the analogRead() function to read the sensor data.

- Liquid crystal display (LCD): The code is using an LCD to display the tank level and chlorine level as a percentage. The LCD is a type of display that uses liquid crystals to control the amount of light that passes through it. The display is connected to the ESP8266 board's I2C pins, and the LiquidCrystal_I2C library is used to control the display.

- pH sensor: The code is using a pH sensor to measure the pH level in the water. The pH level is a measure of how acidic or basic the water is. The sensor works by measuring the voltage difference between two electrodes. The more acidic the water is, the more negative the voltage will be, and the higher the pH reading will be. In this code, the sensor is connected to the ESP8266 board's analog input pin, and the code uses the analogRead() function to read the sensor data.

## Features

- Water level: The system is able to measure the water level in the tank.
- Chlorine level: The system is able to measure the chlorine level in the tank.
- Turbidity: The system is able to measure the turbidity in the tank.
- pH level: The system is able to measure the pH level in the tank.
- LCD: The system is able to display the water level and chlorine level on an LCD.
- LEDs: The system is able to display the water level and chlorine level using LEDs.

## Future Improvements

- Add a buzzer to alert the user when the water level & Chlorine Level is low.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details
