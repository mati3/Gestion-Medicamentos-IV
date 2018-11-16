# Proyecto-IV

## Explicación del Proyecto

Vamos a hacer una base de datos de medicamentos para un hospital o similar, se podrá consultar datos de los propios medicamentos como por ejemplo el prospecto de un medicamento determinado, cantidad que queda de cada medicamento, estadísticas de consumo, ademas si es posible haremos un sistema que nos avise cuando no quedan existencias suficientes de un medicamento o si se aproxima mucho su fecha de caducidad.

## Herramientas

* Usaremos Ruby como lenguaje de programación.
* Hemos usado contenedores Docker para ejecutar nuestra aplicación. Nuestro contenedor Docker lo alojamos en Docker Hub, un repositorio donde mantener imágenes de Docker. Docker Hub es open source bajo la licencia de Apache.
* El despliegue en la nube se ha echo con Heroku, es gratuito y no nos pide tantos tramites para su uso.
* Para la integración continua hemos usado [Travis-CI](https://travis-ci.com/), hemos elegido este sistema porque se activa automáticamente al hacer un push a nuestro repositorio git, además, es gratuito.
* Como framework para servicios web hemos decidido usar [sinatra](http://sinatrarb.com/), es open source, es flexible y rápido, además su uso es muy simple.
* Tenemos RubyGems como sistema para gestionar bibliotecas.
* Como editor de texto ya tenemos Atom.
* La base de datos a usar será alguna de las siguientes: MySQL, MariaDB, PostgreSQL, Mongodb .

### Desarrollo del proyecto:

Vamos a testear la clase "funciones" incluida en nuestro directorio "/src", la cual crea un nuevo objeto medicamento con los atributos que le corresponden (nombre, prospecto, fecha caducidad, id).

Lo primero que hacemos es añadir la integración continua con [Travis-CI](https://travis-ci.com/), Enlace a el badge de Travis : [![Build Status](https://travis-ci.com/mati3/Gestion-Medicamentos-IV.svg?branch=master)](https://travis-ci.com/mati3/Gestion-Medicamentos-IV)

Para instalar clonamos este repositorio

  * git clone https://github.com/mati3/Gestion-Medicamentos-IV.git

Para testear en local la clase poner en terminal la siguiente orden:

  * rake

El test nos avisará si algun atributo no es el esperado, asi como si un medicamento está caducado o tenemos menos de 5 unidades de ese medicamento. El test se ejecuta con un solo medicamento, habria que hacer un test para cada medicamento que queramos incluir en nuestra base de datos.

### Despliegue en heroku [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://app-gestion-medicamentos.herokuapp.com/)

Necesitamos los archivos procfile y config.ru, estos ficheros contienen información de configuración y se localizan en el directorio raíz del proyecto.

Procfile es un archivo de texto simple que describe los componentes necesarios para ejecutar una aplicación. Es la forma de decirle a Heroku cómo ejecutar sus aplicaciones.

Para iniciar nuestra aplicación modular usaremos config.ru, el cual nos permite usar cualquier handler Rack, en nuestro caso Heroku.

Enlace a nuestra documentación del despliegue en [Heroku](https://github.com/mati3/Gestion-Medicamentos-IV/blob/master/doc/heroku.md)

Para ejecutar en local:

    Probar un fichero:
      * ruby myapp.rb

    Probar aplicación desde directorio raiz:
      * rackup

    Probar desde Heroku:
      * Heroku local web

Ejecutar en la web:

      * heroku open.


Podemos añadir diferentes rutas al deploy:

      /medicamento
      /listaMedicamentos
      /nombres

Nota: Si el enlace de Heroku sale Forbidden, recargar la pagina.

### Docker y DockerHub

**Despliegue en el contenedor [![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://docker-gestion-iv.herokuapp.com/status)**

Enlace a la documentación [Docker](https://github.com/mati3/Gestion-Medicamentos-IV/blob/master/doc/docker.md) del Proyecto

Enlace a la documentación de [DockerHub](https://github.com/mati3/Gestion-Medicamentos-IV/blob/master/doc/docker-hub.md) del Proyecto

Enlace a [despliegue en Heroku](https://github.com/mati3/Gestion-Medicamentos-IV/blob/master/doc/docker-heroku.md) de nuestro contenedor Docker, alojado en DockerHub

Enlace a [DockerHub](https://hub.docker.com/r/mati331/gestion-medicamentos-iv/)


**Nota:** hemos añadido log de acceso y error a nuestra aplicación, estas se van guardando en "/sinatra/log/error.log" y en "/sinatra/log/access.log"
