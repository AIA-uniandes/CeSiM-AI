# Utiliza la imagen de ROS Noetic Desktop Full como imagen base
FROM osrf/ros:noetic-desktop-full

# Establece la shell por defecto que se utilizará en la imagen de Docker
SHELL ["/bin/bash", "-c"]

# Copia el entrypoint customizado en el directorio raiz
COPY ./dockerfiles/base/entrypoint.sh /

# Elimina el script de entrypoint existente para utilizar uno personalizado
RUN rm /ros_entrypoint.sh \
    # Actualiza la lista de paquetes, actualiza los paquetes instalados y actualiza la distribución
    && apt-get update && apt-get upgrade -y\
    # Instala las dependencias necesarias
    && apt-get -y install --no-install-recommends software-properties-common git libusb-1.0-0-dev wget zsh net-tools ros-noetic-rqt-joint-trajectory-controller vim ros-noetic-catkin python3-catkin-tools python3-osrf-pycommon python3-wstool\
    # Limpia la caché de paquetes para liberar espacio en disco
    && apt-get clean \
    # Elimina los paquetes no utilizados para liberar espacio en disco
    && apt-get autoremove

# Crea un nuevo usuario `cesim-ai` con contraseña `cesim-ai` y lo agrega al grupo `sudo`
RUN useradd -ms /bin/bash cesim-ai -g sudo \
    && echo "cesim-ai:cesim-ai" | chpasswd

# Establece la variable de entorno `WS` a `/home/cesim-ai`
ENV WS=/home/cesim-ai

# Establece el directorio de trabajo en `WS`
WORKDIR $WS

# Copia el archivo `ur3_robot_calibration.yaml` y 'entrypoint.sh'  al directorio de trabajo
COPY ./calibration/ur3_robot_calibration.yaml .

# Configura el espacio de trabajo de catkin y clona los repositorios de Git necesarios
RUN mkdir -p ./catkin_ws/src \
    # Cambia el directorio de trabajo a `catkin_ws`
    && cd ./catkin_ws \
    # Agrega el archivo setup.bash de ROS a la secuencia de comandos bashrc del usuario
    && echo "source /opt/ros/noetic/setup.bash" >> $WS/.bashrc \
    # Fuente el archivo setup.bash de ROS
    && source /opt/ros/noetic/setup.bash \
    # Clona el repositorio Universal Robots ROS Driver
    && git clone https://github.com/UniversalRobots/Universal_Robots_ROS_Driver.git src/Universal_Robots_ROS_Driver \
    # Clona el repositorio universal_robot
    && git clone -b melodic-devel https://github.com/ros-industrial/universal_robot.git src/universal_robot \
    # Actualiza la lista de paquetes
    && apt update -qq \
    # Actualiza la información del paquete rosdep
    && rosdep update \
    # Instala las dependencias necesarias
    && rosdep install --from-paths src --ignore-src -y \
    # Construye el espacio de trabajo catkin
    && catkin_make \
    # Agrega el archivo setup.bash del espacio de trabajo catkin al archivo bashrc del usuario
    && echo "source ~/catkin_ws/devel/setup.bash" >> $WS/.bashrc \
    # Cambia los permisos de acceso del directorio catkin
    && chown cesim-ai:sudo -R $WS/catkin_ws/

# Establece el comando de punto de entrada que se ejecutará cuando se inicie el contenedor Docker
ENTRYPOINT ["/entrypoint.sh"]

# Establece el usuario predeterminado en "cesim-ai"
USER cesim-ai

# Establece el comando de entrada al contenedor
CMD ["bash"]
