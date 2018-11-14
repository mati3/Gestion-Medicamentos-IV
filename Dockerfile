FROM ruby:latest
MAINTAINER Matilde Cabrera <mati331@correo.ugr.es>

# lanzar errores si Gemfile ha sido modificado desde Gemfile.lock
RUN bundle config --global frozen 1


COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

# Comando predeterminado, ejecutando la aplicación como un servicio
CMD ["bundle", "rackup", "config.ru"]
