#!/usr/bin/env python3

import RPi.GPIO as GPIO
import rospy
from std_srvs.srv import SetBool

GPIO.setmode(GPIO.BCM)
GPIO_PIN = 14  # Change this to the GPIO pin you want to control

def handle_gpio_service(req):
    """
    Callback function for handling the GPIO service request
    """
    if req.data:
        # If the request is True, turn on the GPIO pin
        GPIO.output(GPIO_PIN, GPIO.HIGH)
        rospy.loginfo("GPIO pin %d turned on", GPIO_PIN)
    else:
        # If the request is False, turn off the GPIO pin
        GPIO.output(GPIO_PIN, GPIO.LOW)
        rospy.loginfo("GPIO pin %d turned off", GPIO_PIN)
    # Return a response indicating success
    return True, ""

def gpio_service():
    """
    Main function for setting up the GPIO service
    """
    # Initialize the ROS node
    rospy.init_node('gpio_service')

    # Set up the GPIO pin as an output
    GPIO.setup(GPIO_PIN, GPIO.OUT)

    # Create a ROS service for the GPIO pin
    rospy.Service('gpio', SetBool, handle_gpio_service)

    rospy.loginfo("GPIO service ready")

    # Spin the ROS node to wait for incoming requests
    rospy.spin()

if __name__ == '__main__':
    gpio_service()

