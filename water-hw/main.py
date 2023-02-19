# Import libraries
from __future__ import print_function
import os
import glob
import RPi.GPIO as GPIO
import Adafruit_ADS1x15
import time
import datetime
import socket
import csv
import paho.mqtt.publish as publish
import psutil
import string

GPIO.setmode(GPIO.BCM)
GPIO.setwarnings(False)
GPIO.setup(17, GPIO.OUT)
GPIO.setup(18, GPIO.OUT)
GPIO.setup(19, GPIO.OUT)
GPIO.setup(20, GPIO.OUT)
GPIO.setup(21, GPIO.OUT)
GPIO.setup(22, GPIO.OUT)
GPIO.setup(23, GPIO.OUT)
GPIO.setup(24, GPIO.OUT)
GPIO.setup(25, GPIO.OUT)
GPIO.setup(26, GPIO.OUT)
# Load one wire communication device kernel module
os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')
base_dir = '/sys/bus/w1/devices/'  # Direction to scan devices
# Scan and storing device id
device_folder = glob.glob(base_dir + '28*')[0]
device_file = device_folder + '/w1_slave'

# The ThingSpeak Channel ID.
channelID = ""  # Give your own channel id
# write API Key for the channel
writeAPIKey = "writeapikeydemo"

# The Hostname of the ThingSpeak MQTT broker.
mqttHost = "mqtt.thingspeak.com"

# You can use any Username.
mqttUsername = "usernamedemo"

mqttAPIKey = "apikeydemo"

# Set the transport mode to WebSockets.
tTransport = "websockets"
tPort = 80

# Create the topic string.
topic = "channels/" + channelID + "/publish/" + writeAPIKey

adc = Adafruit_ADS1x15.ADS1015()


def think_speak(arg_1, arg_2, arg_3):
    clientID = ''
    # build the payload string.
    payload = "field1=" + str(arg_1) + "&field2=" + \
        str(arg_2) + "&field3=" + str(arg_3)
    # attempt to publish this data to the topic.
    try:
        publish.single(topic, payload, hostname=mqttHost, transport=tTransport, port=tPort,
                       auth={'username': mqttUsername, 'password': mqttAPIKey})

    except:
        print("There was an error while publishing the data.")


# Get pH value from sensor
def get_ph_value():
    raw_ph_value = adc.read_adc(0, gain=1)
    ph_value_int = raw_ph_value * 3.8 / 1030 / 6
    ph_value = ph_value_int * 3.3
    if ph_value > 8.50:
        GPIO.output(18, GPIO.HIGH)
        GPIO.output(19, GPIO.LOW)
        GPIO.output(20, GPIO.LOW)
    elif ph_value < 6.5:
        GPIO.output(18, GPIO.LOW)
        GPIO.output(19, GPIO.HIGH)
        GPIO.output(20, GPIO.LOW)
    else:
        GPIO.output(18, GPIO.LOW)
        GPIO.output(19, GPIO.LOW)
        GPIO.output(20, GPIO.HIGH)
    return ph_value


# Get the Turbidity value
def get_turbidity_value():
    raw_turbidity = adc.read_adc(1, gain=2/3)
    turbidity_value = raw_turbidity / 100
    if turbidity_value > 5:
        GPIO.output(21, GPIO.HIGH)
        GPIO.output(22, GPIO.LOW)
        GPIO.output(23, GPIO.LOW)
    elif turbidity_value < 5:
        GPIO.output(21, GPIO.LOW)
        GPIO.output(22, GPIO.LOW)
        GPIO.output(23, GPIO.HIGH)
    return turbidity_value


# Read raw data from the DS18B20 sensor
def read_temp_raw():
    file_object = open(device_file, 'r')  # open device file in reading mood
    lines = file_object.readlines()
    file_object.close()
    return lines  # Return data lines from the file


# Calculation of raw data to actual data
def read_temp():
    lines = read_temp_raw()
    while lines[0].strip()[-3:] != 'YES':  # Ignore first line
        time.sleep(0.2)
        lines = read_temp_raw()
    equals_pos = lines[1].find('t=')  # Find temperature in details
    if equals_pos != -1:
        temp_string = lines[1][equals_pos + 2:]
        temp_c = float(temp_string) / 1000.0  # Convert to celsius
        temp_f = temp_c * 9.0 / 5.0 + 32.0  # Convert to fahrenheit
        now = datetime.datetime.now()  # Getting current timestamp from the system
        if temp_c >= 35:
            GPIO.output(24, GPIO.HIGH)
            GPIO.output(25, GPIO.LOW)
            GPIO.output(26, GPIO.LOW)
        elif temp_c >= 10:
            GPIO.output(24, GPIO.LOW)
            GPIO.output(25, GPIO.HIGH)
            GPIO.output(26, GPIO.LOW)
        else:
            GPIO.output(24, GPIO.LOW)
            GPIO.output(25, GPIO.LOW)
            GPIO.output(26, GPIO.HIGH)
        return temp_c


'''def warning():
    if (turbidity_value>9) :
        GPIO.output(17, GPIO.LOW)
        print("Water is very clean to drink")
    elif (turbidity_value>6 and turbidity_value<=9) :
        GPIO.output(17, GPIO.LOW)
        print("whater is normal clean to drink")
    if (ph_value>7.50) :
        GPIO.output(17, GPIO.HIGH)
        print("Water alkalinity high")
    elif (ph_value<6.89) :
        GPIO.output(17, GPIO.HIGH)
        print("whater acidity hight")
    if (temp_c >= 35):
        GPIO.output(17, GPIO.HIGH)
        print("Water is not healthy to drink")
'''

''''# Write CSV file
def write_csv(sen_name,time_date,cel_temp,far_temp,ip):
    file = open("/home/pi/ds18b20_data_log.csv","a")                         # Location of the file
    file.write("%s, %s, %.0f, %.0f, %s, %s\n" % (sen_name, time_date, cel_temp, far_temp, mac_add, ip))
    file.close()'''


def main():
    while True:
        temp_c = read_temp()
        ph_value = get_ph_value()
        turb_value = get_turbidity_value()
        think_speak(temp_c, ph_value, turb_value)
        print("Water Temperature: ", temp_c, "C\npH Level: ",
              ph_value, "\nTurbidity Level: ", turb_value)
        if ph_value > 8.5 or ph_value < 6.5 or turb_value >= 5:
            GPIO.output(17, GPIO.HIGH)
            print("Water is not healthy to drink..")
            print("For more information see the monitoring board and console display!!!")
        elif temp_c >= 23:
            GPIO.output(18, GPIO.HIGH)
            print("Water is healthy but too hot to drink!!")
        elif temp_c <= 10:
            GPIO.output(19, GPIO.HIGH)
            print("water is healthy but very cold to drink!!!")
        else:
            GPIO.output(17, GPIO.LOW)
            GPIO.output(20, GPIO.HIGH)
            print("Water is healthy to drink!\nHave a nice time!!!")
        time.sleep(10)
