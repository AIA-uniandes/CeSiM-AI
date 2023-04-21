# CeSiM-AI

CeSiM-AI es un proyecto integral que combina bandas transportadoras de simulación multiproceso, el brazo robótico UR3 y la visión computacional. Este proyecto establece una arquitectura básica y modular para el desarrollo de otros proyectos en robótica, automatización e industriales.
Los proyectos que implementan este repositorio son:
* [Empaquetamiento](https://github.com/AIA-uniandes/CeSiM-AI/tree/main/doc/Empaquetamiento)
* [Protección a ciberataques](https://github.com/AIA-uniandes/CeSiM-AI/tree/main/doc/ciberataques)
* [Modelamiento de estacionamiento para vehículos eléctricos](https://github.com/AIA-uniandes/CeSiM-AI/tree/main/doc/Estacionamiento_VE)

![](/doc/imgs/montaje-completo.jpg)

Este proyecto está construido sobre imágenes de Docker y ROS para permitir la modularidad, compatibilidad y flexibilidad en el uso de los recursos desarrollados. Las imágenes se encuentran publicadas en el [Dockerhub del AIA](https://hub.docker.com/repository/docker/aiaindustrial/cesim-ai/general) y cuentan con todas las dependencias y archivos necesarios para correr los proyectos desarrollados. Cada dispositivo utilizado cuenta con su respectiva imagen de docker. Si desea extender las capacidades de la imagen suministrada, dirígase a [dockerfiles](/dockerfiles).

Algunos enlaces de interés:
- [¿Qué es Docker?](https://www.ibm.com/co-es/cloud/learn/docker)
- [¿Qué es un contenedor? (Inglés)](https://www.docker.com/resources/what-container/)
- [¿Qué es ROS?](http://wiki.ros.org/es/ROS/Introduccion)

## Base
Este dispositivo es la central de cómputo de el proyecto y se encarga de correr los entornos de simulación y visualización, realizar la planeación y ejecución de rutas del brazo robótico y correr los algoritmos específicos de cada proyecto (empaquetamiento, etc). La imagen de este dispositivo es la más pesada **(~4GB)** ya que esta basada en la imagen completa de escritorio de ROS. Se espera adicionalmente que el equipo cuente con buenos recursos de cómputo.

Algunos enlaces de interés sobre la imagen base, los drivers y librerias:
- [Imagenes oficiales de ROS](https://hub.docker.com/r/osrf/ros)
- [Driver de ROS para robots UR](https://github.com/UniversalRobots/Universal_Robots_ROS_Driver)
- [Documentación de MoveIt! (Planeador de movimiento de ROS)](https://ros-planning.github.io/moveit_tutorials/)

Nota: La imagen de la base esta configurada para el brazo robótico del laboratorio AIA. Cualquier otro brazo requeriría de extraer la configuración del brazo y reemplazarla con la existente en la imagen.

### Instalación - Base
0. El dispositivo debe contar con Docker para poder correr las imagenes y crear los contenedores. Para hacerlo revisar el los siguientes hipervínculos para [Ubuntu](https://docs.docker.com/engine/install/ubuntu/) y [Windows](https://docs.docker.com/desktop/install/windows-install/) y [Mac](https://docs.docker.com/desktop/install/mac-install/).

#### Linux

1. Hacer pull de la imagen del repositorio del AIA:
    ```bash
    sudo docker pull aiaindustrial/cesim-ai:base
    ```
2. Permitir la conexión con un display de docker (debe realizarse cada vez que reinicia el dispositivo):
    ```bash
    xhost +local:docker
    ```
3. Correr el contenedor. Modo interactivo (-it), con el mismo stack de red de el host (--network=host), privilegios extendidos (--privileged), variable de entorno (-e DISPLAY) y mapeo de X11 para transferir información de display entre el host y el contenedor(/tmp/.X11-unix:/tmp/.X11-unix). Esta instrucción borra el contenedor después de la salida, para mantener el contenedor y los archivos modificados/creados se debe quitar el flag de remover (--rm).
    ```bash
    sudo docker run -it --rm --network=host --privileged -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix aiaindustrial/cesim-ai:base
    ```
4. Para abrir otra sesión de bash del contenedor, se abre una nueva terminal y se imprimen los nomrbres e identificadores de los contenedores generados recientemente:
    ```bash
    sudo docker ps -l
    ```
    Con el ID del contenedor que se corre en el paso anterior, se abre una nueva sesión interactiva de bash con:
    ```bash
    sudo docker exec -it <ID_DEL_CONTENEDOR> bash
    ```
5. Para detener el contenedor se debe ejecutar el comando "exit" en el terminal donde se ejecutó el comando "run"

#### Windows

1. Instalar [VcXsrv](https://sourceforge.net/projects/vcxsrv/). Una vez instalado ejecutar el aplicativo **XLaunch** y seleccionar el ajuste "Disable access control" en la ventana de "Extra settings":

    ![](/doc/imgs/xlaunch.png)

    El resto de ajustes deben permanecer en el ajuste predeterminado.
    
2. En un terminal (CMD) con permisos de administrador, hacer pull de la imagen del repositorio del AIA:
    ```bash
    docker pull aiaindustrial/cesim-ai:base
    ```
3. Correr el contenedor. Modo interactivo (-it), con el mismo stack de red de el host (--network=host), privilegios extendidos (--privileged) y variable de entorno (-e DISPLAY) asignada a la IP del host. Esta instrucción borra el contenedor después de la salida, para mantener el contenedor y los archivos modificados/creados se debe quitar el flag de remover (--rm).
    ```bash
    docker run -it --rm --network=host --privileged -e DISPLAY=<IP_HOST>:0.0 aiaindustrial/cesim-ai:base                      
    ```
4. Para abrir otra sesión de bash del contenedor, se abre una nueva terminal y se imprimen los nomrbres e identificadores de los contenedores generados recientemente:
    ```bash
    docker ps -l
    ```
    Con el ID del contenedor que se corre en el paso anterior, se abre una nueva sesión interactiva de bash con:
    ```bash
    docker exec -it <ID_DEL_CONTENEDOR> bash
    ```
5. Para detener el contenedor se debe ejecutar el comando "exit" en el terminal donde se ejecutó el comando "run"

#### Mac

1. Instalar [XQuartz](https://www.xquartz.org/). Una vez instalado ejecutar el aplicativo **XQuartz** y seleccionar el ajuste "Allow connections from network client" en la ventana de "Security" en las preferencias del aplicativo:

    ![](/doc/imgs/xquartz.png)

    El resto de ajustes deben permanecer en el ajuste predeterminado.
2. En una terminal, permitir la conexión con un display de docker (debe realizarse cada vez que reinicia el dispositivo):
    ```bash
    xhost +localhost
    ```
3. Hacer pull de la imagen del repositorio del AIA:
    ```bash
    docker pull aiaindustrial/cesim-ai:base
    ```
3. Correr el contenedor. Modo interactivo (-it), con el mismo stack de red de el host (--network=host), privilegios extendidos (--privileged) y variable de entorno (-e DISPLAY) asignada a la IP del host. Esta instrucción borra el contenedor después de la salida, para mantener el contenedor y los archivos modificados/creados se debe quitar el flag de remover (--rm).
    ```bash
    docker run -it --rm --network=host --privileged -e DISPLAY=host.docker.internal:0 aiaindustrial/cesim-ai:base                      
    ```
4. Para abrir otra sesión de bash del contenedor, se abre una nueva terminal y se imprimen los nomrbres e identificadores de los contenedores generados recientemente:
    ```bash
    docker ps -l
    ```
    Con el ID del contenedor que se corre en el paso anterior, se abre una nueva sesión interactiva de bash con:
    ```bash
    docker exec -it <ID_DEL_CONTENEDOR> bash
    ```
5. Para detener el contenedor se debe ejecutar el comando "exit" en el terminal donde se ejecutó el comando "run"

### Uso - Ejemplo con brazo
0. Asegurarse que el brazo UR3 este encendido, tenga una dirección IP asignada y que la configuración en PolyScope "Program Robot>Installation>EtherNet/IP Adapter" este **deshabilitada**.
1. Iniciar el driver del brazo:
    ```bash
    roslaunch ur_robot_driver ur3_bringup.launch robot_ip:=<IP_ROBOT> kinematics_config:=${HOME}/ur3_robot_calibration.yaml
    ```
2. Correr el programa precargado "ExternalControl" en el PolyScope de el brazo. Asegurarse que la IP del programa de PolyScope coincida con la IP del computador base.
3. (Nueva terminal) Iniciar el planeador de moveIt:
    ```bash
    roslaunch ur3_moveit_config moveit_planning_execution.launch
    ```
4. (Nueva terminal) Correr la interfaz de RViz:
    ```bash
    roslaunch ur3_moveit_config moveit_rviz.launch rviz_config:=$(rospack find ur3_moveit_config)/launch/moveit.rviz
    ```
## Licencia

MIT




