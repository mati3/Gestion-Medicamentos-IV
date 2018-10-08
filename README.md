# Proyecto-IV

## Explicación del Proyecto

Vamos a hacer una base de datos de medicamentos para un hospital o similar, se podrá consultar datos de los propios medicamentos como por ejemplo el prospecto de un medicamento determinado, cantidad que queda de cada medicamento, estadísticas de consumo, ademas si es posible haremos un sistema que nos avise cuando no quedan existencias suficientes de un medicamento o si se aproxima mucho su fecha de caducidad.

## Herramientas

* Usaremos Ruby como lenguaje de programación.
* Como editor de texto ya tenemos Atom.
* La base de datos a usar será alguna de las siguientes: MySQL, MariaDB, PostgreSQL .
* Tenemos RubyGems como sistema para gestionar bibliotecas.
* Para hacer el despliegue en la nube intentaremos usar Azure
* Como framework para servicios web hemos decidido usar [sinatra](http://sinatrarb.com/), es open source, es flexible y rápido, además su uso es muy simple.
* Para la integración continua hemos usado [Travis-CI](https://travis-ci.com/), hemos elegido este sistema porque se activa automáticamente al hacer un push a nuestro repositorio git, además, es gratuito.

### Desarrollo del proyecto:

Vamos a testear la clase "funciones" incluida en nuestro directorio "/src", la cual crea un nuevo objeto medicamento con los atributos que le corresponden (nombre, prospecto, fecha caducidad, id).

Lo primero que hacemos es añadir la integración continua con [Travis-CI](https://travis-ci.com/), Enlace a el badge de Travis : [![Build Status](https://travis-ci.com/mati3/Gestion-Medicamentos-IV.svg?branch=master)](https://travis-ci.com/mati3/Gestion-Medicamentos-IV)

Para instalar clonamos este repositorio

  * git clone https://github.com/mati3/Gestion-Medicamentos-IV.git

Para testear en local la clase poner en terminal la siguiente orden:

  * rake

El test nos avisará si algun atributo no es el esperado, asi como si un medicamento está caducado o tenemos menos de 5 unidades de ese medicamento. El test se ejecuta con un solo medicamento, habria que hacer un test para cada medicamento que queramos incluir en nuestra base de datos.
