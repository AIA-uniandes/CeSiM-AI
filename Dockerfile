FROM osrf/ros:noetic-desktop-full

SHELL ["/bin/bash", "-c"]

RUN rm /ros_entrypoint.sh

RUN apt-get update && apt-get -y upgrade

RUN apt-get -y install --no-install-recommends software-properties-common git libusb-1.0-0-dev wget zsh net-tools ros-noetic-rqt-joint-trajectory-controller

RUN useradd -ms /bin/bash cesim-ai

WORKDIR /home/cesim-ai

COPY ./entrypoint.sh ./ur3_robot_calibration.yaml .

RUN mkdir -p ./catkin_ws/src &&\
	cd ./catkin_ws &&\
	echo "source /opt/ros/noetic/setup.bash" >> /home/cesim-ai/.bashrc &&\
	source /opt/ros/noetic/setup.bash &&\
	git clone https://github.com/UniversalRobots/Universal_Robots_ROS_Driver.git src/Universal_Robots_ROS_Driver &&\
	git clone -b melodic-devel https://github.com/ros-industrial/universal_robot.git src/universal_robot &&\
	apt update -qq &&\
	rosdep update &&\
	rosdep install --from-paths src --ignore-src -y &&\
	catkin_make &&\
	echo "source ~/catkin_ws/devel/setup.bash" >> /home/cesim-ai/.bashrc
	
USER cesim-ai

ENTRYPOINT [ "./entrypoint.sh" ]

CMD ["bash"]

