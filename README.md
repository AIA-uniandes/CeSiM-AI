# CeSiM-AI
CeSiM-AI es un proyecto integral que incorpora las bandas transportadoras de simulación multiprocesos, el [brazo robótico UR3](https://www.universal-robots.com/cb3/) y la visión computacional. Este proyecto establece una arquitectura base y modular para el desarrollo de otros proyectos de robótica, automatización y procesos industriales. 

Los proyectos que implementan este repositorio son:
* [Empaquetamiento](https://github.com/AIA-uniandes/CeSiM-AI)
* [Protección a ciber-ataques](https://github.com/AIA-uniandes/CeSiM-AI)
* [Modelamiento de estacionamiento para vehículos eléctricos](https://github.com/AIA-uniandes/CeSiM-AI)

![](/doc/imgs/montaje-completo.jpg)

Este proyecto está construido sobre imágenes de [Docker](https://www.docker.com/resources/what-container/)  y [ROS](https://www.ros.org/blog/why-ros/) para permitir la modularidad, compatibilidad y flexibilidad en el uso de los recursos desarrollados. Las imágenes se encuentran publicadas en el [Dockerhub del AIA](https://hub.docker.com/repository/docker/aiaindustrial/cesim-ai/general) y cuentan con todas las dependencias y archivos necesarios para correr los proyectos desarrollados. Cada dispositivo utilizado cuenta con su respectiva imagen de docker. Si desea extender las capacidades de la imagen suministrada, dirígase a [dockerfiles](/dockerfiles).

## Base
Este dispositivo es la central de cómputo de el proyecto y se encarga de realizar la planeación y ejecución de rutas del brazo robótico, correr los algoritmos de visión computacional y correr los algoritmos específicos de cada proyecto (empaquetamiento, etc). La imagen de este dispositivo es la más pesada ya que esta basada en la imagen completa de escritorio de ROS. Se espera adicionalmente que el equipo cuente con buenos recursos de cómputo.

Nota: La imagen de la base esta configurada para el brazo robótico del laboratorio AIA. Cualquier otro brazo requeriría de extraer la configuración del brazo y reemplazarla con la existente en la imagen.

### Instalación - Base
0. El dispositivo debe contar con Docker para poder correr las imagenes y crear los contenedores. Para hacerlo revisar el los siguientes hipervínculos para [Ubuntu](https://docs.docker.com/engine/install/ubuntu/) y [Windows](https://docs.docker.com/desktop/install/windows-install/) y [Mac](https://docs.docker.com/desktop/install/mac-install/).

#### Linux

1. Hacer pull de la imagen del repositorio del AIA
    ```bash
    docker pull aiaindustrial/cesim-ai:base
    ```
2. Permitir la conexión con un display de docker (debe realizarse cada vez que reinicia el dispositivo)
    ```bash
    xhost +local:docker
    ```
3. Correr el contenedor. Modo interactivo (-it), con el mismo stack de red de el host (--network=host), privilegios extendidos (--privileged), variable de entorno (-e DISPLAY) y mapeo de X11 para transferir información de display entre el host y el contenedor(/tmp/.X11-unix:/tmp/.X11-unix). Esta instrucción borra el contenedor después de la salida, para mantener el contenedor y los archivos modificados/creados se debe quitar el flag de remover (--rm).
    ```bash
    sudo docker run -it --rm --network=host --privileged -e DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix aiaindustrial/cesim-ai:base
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




