# Dockerfiles
Para ampliar las capacidades y funcionalidades de las imágenes, puede utilizar los Dockerfile suministrados para construir imágenes nuevas. Es recomendable solo hacer esto si desea desarrollar un nuevo proyecto que requiera nuevas dependencias, configuraciones de imagen diferentes o una imagen base diferente. La documentación para escribir Dockerfiles la puede encontrar en:
- [Mejores prácticas para escribir Dockerfiles](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)

Para construir una nueva imagen, primero clone el repositorio y acceda a la carpeta del Dockerfile:

```bash
git clone https://github.com/AIA-uniandes/CeSiM-AI.git
cd CeSiM-AI/dockerfiles/<IMAGEN_A_MODIFICAR>
```
Use su editor de texto preferido para modificar el Dockerfile:
```bash
vi Dockerfile
```
Realice los cambios que necesite y guarde el archivo. Luego puede construir la imagen usando:
```bash
sudo docker build -t <ETIQUETA> .
```
Después de construirse, puede listar las imágenes con:
```bash
sudo docker images
```
Ejecute la imagen con el comando "run" y con flags necesarios para su proyecto:
```bash
sudo docker run <ETIQUETA>
```

