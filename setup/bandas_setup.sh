#!/bin/bash
mkdir -p ~/catkin_ws/src
cp -r ~/CeSiM-AI/CeSiM-AI-Proyectos/control-bandas/conveyor_service ~/catkin_ws/src/
cd ~/catkin_ws
catkin_make
