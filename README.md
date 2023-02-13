# Water Level and Water Quality Sensor for Arduino and Raspberry Pi

This project provides a solution for monitoring the water level and quality of a water body, such as a pond, lake, or river. The project utilizes both Arduino and Raspberry Pi hardware, along with accompanying software, to gather and process data. The data is then displayed on a user-friendly interface for easy interpretation.

## Hardware Requirements

- Arduino Uno R3
- Raspberry Pi (any model)
- Water level sensor
- Water quality sensor (e.g. pH, temperature, conductivity, etc.)
- Wires and Breadboard
- Software Requirements
- Arduino Integrated Development Environment (IDE)
- Python 3.x0
- Flask (web framework for Python)
- SQLite (database software)

## Getting Started

Connect the water level and quality sensors to the Arduino board using the wiring diagram provided in the documentation.

Upload the provided Arduino code to the board to start collecting data from the sensors. The data is then sent to the Raspberry Pi through serial communication.

Install the required software on the Raspberry Pi, including Python 3, Flask, and SQLite.

Run the provided Python script on the Raspberry Pi to process the data received from the Arduino and store it in an SQLite database.

Start the Flask web server to serve the user interface. The user interface allows you to view the water level and quality data in real-time, as well as historical data.

## Conclusion

This project provides a simple and effective solution for monitoring the water level and quality of a water body. With the provided hardware and software, you can easily collect, process, and visualize the data for use in various applications, such as environmental monitoring and research.

Please refer to the documentation for further information on hardware assembly and software setup. If you have any questions or concerns, feel free to reach out to the project developers for assistance.
