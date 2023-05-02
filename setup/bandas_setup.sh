#!/bin/bash
mkdir -p ~/catkin_ws/src
cp ~/CeSiM-AI/CeSiM-AI-Proyectos/control-bandas ~/catkin_ws/src/
cd ~/catkin_ws
catkin_make
