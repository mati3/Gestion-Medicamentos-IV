
## Despliegue en Heroku de nuestro contenedor Docker, alojado en DockerHub

Seguimos [esta](https://medium.com/travis-on-docker/how-to-run-dockerized-apps-on-heroku-and-its-pretty-great-76e07e610e22) guía.

Obtenemos un token de heroku:

![imagen](img/heroku-token1.png)

Usamos el token que nos da Heroku para iniciar sesión en el registro de Docker:

    docker login --username=_ --password={token_anterior} registry.heroku.com

![imagen](img/docker-login1.png)

Nota: el correo electrónico y el nombre de usuario son en realidad el guión bajo, no los cambies.

Para finalizar subimos nuestra imagen:

    docker build -t registry.heroku.com/${YOUR_APP_NAME}/web .
    docker push registry.heroku.com/${YOUR_APP_NAME}/web

![imagen](img/docker-build.png)

![imagen](img/docker-push.png)

Comprobamos desde Heroku:
