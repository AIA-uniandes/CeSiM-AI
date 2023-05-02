# Utiliza la imagen de ROS noetic-perception como imagen base
FROM ros:noetic-perception

# Establece la shell por defecto que se utilizará en la imagen de Docker
SHELL ["/bin/bash", "-c"]

# Copia el entrypoint customizado en el directorio raiz
COPY ./dockerfiles/vision/entrypoint.sh /

# Actualiza la lista de paquetes
RUN apt-get update \
    # Instala las dependencias requeridas
    && apt-get install -y git ros-noetic-usb-cam uvcdynctrl ros-noetic-aruco-ros \
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

RUN mkdir -p ./catkin_ws/src \
    # Cambia el directorio de trabajo a `catkin_ws`
    && cd ./catkin_ws \
    # Agrega el archivo setup.bash de ROS a la secuencia de comandos bashrc del usuario
    && echo "source /opt/ros/noetic/setup.bash" >> $WS/.bashrc

# Establece el usuario predeterminado en "cesim-ai"
USER cesim-ai

# Establece el comando de punto de entrada que se ejecutará cuando se inicie el contenedor Docker
ENTRYPOINT ["/entrypoint.sh"]

# Establece el usuario predeterminado en "cesim-ai"
USER cesim-ai

# Establece el comando de entrada al contenedor
CMD ["bash"]
