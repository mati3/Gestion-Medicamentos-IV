
## Instalación de Docker

Seguimos la guía de [docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/). O la guía del blog de [ubuntu](https://ubunlog.com/como-instalar-docker-en-ubuntu-18-04-y-derivados/)

Primero limpiamos de distribuciones antiguas de docker

![imagen](img/docker_01.png)

añadimos la clave gpg, verificamos la huella digital, por ultimo añadimos el repositorio al sistema:

![imagen](img/docker_02.png)

Actualizamos el sistema.

Instalamos con "sudo apt-get install docker-ce" y reiniciamos

Verificamos que se ha instalado con éxito y que está activo:

![imagen](img/docker_03.png)

![imagen](img/docker_04.png)

Creo un Dockerfile. En mi caso creamos un [Dockerfile para ruby](https://docs.docker.com/samples/library/ruby/#create-a-dockerfile-in-your-ruby-app-project)

			FROM ruby:2.5
			MAINTAINER Matilde Cabrera <mati331@correo.ugr.es>

			# lanzar errores si Gemfile ha sido modificado desde Gemfile.lock
			RUN bundle config --global frozen 1

			COPY Gemfile Gemfile.lock ./
			RUN bundle install

			COPY . .

			# Comando predeterminado, ejecutando la aplicación como un servicio
			CMD ["bundle", "rackup", "config.ru", "-p", "80", "-s","--host", "0.0.0.0"]

Este fichero indica a Docker las dependencias y demás herramientas que necesita nuestra aplicación tener instaladas en el contenedor para que funcione.

Hacemos la prueba en [local](https://colaboratorio.net/davidochobits/sysadmin/2018/crear-imagenes-medida-docker-dockerfile/):

Creamos el contenedor con nuestro Dockerfile:

![imagen](img/docker-ruby.png)

Vemos que está la imagen creada:

![imagen](img/docker-images.png)

Arrancamos la imagen para la prueba en local, vemos que si esta todo dentro del contenedor creado

![imagen](img/docker-run.png)

Probamos los servicios desde el contenedor, los test con rake y la aplicación con rackup:

![imagen](img/docker-rake.png)

Ahora nos daremos de alta en Docker Hub para poder desplegar el contenedor en un Paas. Enlace a la [documentación](https://github.com/mati3/Gestion-Medicamentos-IV/blob/master/doc/docker-hub_heroku.md)
