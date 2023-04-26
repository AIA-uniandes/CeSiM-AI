# Utiliza la imagen de ROS Noetic Desktop Full como imagen base
FROM navikey/raspbian-buster:latest

# Establece la shell por defecto que se utilizará en la imagen de Docker
SHELL ["/bin/bash", "-c"]

# Copia el entrypoint customizado en el directorio raiz
COPY ./dockerfiles/bandas/entrypoint.sh /

# Actualiza la lista de paquetes
RUN apt-get update \
    # Instala las dependencias necesarias
    && sudo apt install -y build-essential gdebi unzip \
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

# Crea un directorio temporal
RUN mkdir -p ~/tmp \
    && pushd ~/tmp \
    # Descarga el archivo de instalacion de ROS
    && wget https://github.com/nomumu/ros4raspbian/releases/download/1.0.0/ros4raspbian-melodic-armhf-1.0.0.zip \
    # Descomprime el archivo de instalacion
    && unzip ros4raspbian-melodic-armhf-1.0.0.zip \
    # Ejecuta el archivo de instalacion de ROS
    && gdebi -n  ros4raspbian-melodic-armhf-1.0.0.deb \
    # Elimina el directorio temporal
    && popd \
    # Actualiza las dependencias de ROS
    && rosdep update \
    # Agrega el comando de fuente de ROS a el bashrc
    && echo "source /opt/ros/melodic/setup.bash" >> $WS/.bashrc

# Establece el usuario predeterminado en "cesim-ai"
USER cesim-ai

# Establece el comando de punto de entrada que se ejecutará cuando se inicie el contenedor Docker
ENTRYPOINT ["/entrypoint.sh"]

# Establece el usuario predeterminado en "cesim-ai"
USER cesim-ai

# Establece el comando de entrada al contenedor
CMD ["bash"]


