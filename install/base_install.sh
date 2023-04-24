#!/bin/bash
cd ~/catkin_ws/src
catkin_create_pkg moveit_python_interface std_msgs rospy roscpp
mkdir ~/catkin_ws/src/moveit_python_interface/scripts
cp ~/CeSiM-AI/CeSiM-AI-Proyectos/control-brazo/moveit_pyhon_interface.py ~/catkin_ws/src/moveit_python_interface/scripts
cd ~/catkin_ws
catkin_make
