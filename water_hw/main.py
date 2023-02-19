# Import libraries
from __future__ import print_function
import os
import glob

from water_hw import login, Stats
import RPi.GPIO as GPIO
import Adafruit_ADS1x15
import time
import datetime
import socket
import csv
import paho.mqtt.publish as publish
import psutil
import string


# Load one wire communication device kernel module
os.system('modprobe w1-gpio')
os.system('modprobe w1-therm')
base_dir = '/sys/bus/w1/devices/'  # Direction to scan devices
# Scan and storing device id
device_folder = glob.glob(base_dir + '28*')[0]
device_file = device_folder + '/w1_slave'

adc = Adafruit_ADS1x15.ADS1015()


# Get pH value from sensor
def get_ph_value():
    raw_ph_value = adc.read_adc(0, gain=1)
    ph_value_int = raw_ph_value * 3.8 / 1030 / 6
    ph_value = ph_value_int * 3.3
    return ph_value


# Get the Turbidity value
def get_turbidity_value():
    raw_turbidity = adc.read_adc(1, gain=2/3)
    turbidity_value = raw_turbidity / 100

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
        return temp_c




def upload_stats():
    token = login()
    temp = read_temp()
    ph = get_ph_value()
    turb = get_turbidity_value()

    # Upload stats to the server
    with Stats(token) as stats:
        stats.upload({
            "temperature": temp,
            "ph": ph,
            "turb": turb
        })

def main():
    while True:
        upload_stats()
        time.sleep(300)
