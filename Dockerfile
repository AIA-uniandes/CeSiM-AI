FROM osrf/ros:noetic-desktop-full

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install --no-install-recommends software-properties-common git libusb-1.0-0-dev wget zsh net-tools ros-noetic-rqt-joint-trajectory-controller

RUN mkdir -p ${HOME}/catkin_ws/src &&\
	cd ${HOME}/catkin_ws &&\
	echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc &&\
	source /opt/ros/noetic/setup.bash &&\
	git clone https://github.com/UniversalRobots/Universal_Robots_ROS_Driver.git src/Universal_Robots_ROS_Driver &&\
	git clone -b melodic-devel https://github.com/ros-industrial/universal_robot.git src/universal_robot &&\
	apt update -qq &&\
	rosdep update &&\
	rosdep install --from-paths src --ignore-src -y &&\
	catkin_make &&\
	source devel/setup.bash

EXPOSE 50001 50002

ENTRYPOINT [ "./ros_entrypoint.sh" ]

CMD ["bash"]

