### Desarrollo del proyecto:

**Lo primero que hacemos es añadir la integración continua con [Travis-CI](https://travis-ci.com/), me doy de alta con la cuenta de git y enlazo mi proyecto.**

Añadimos a nuestro proyecto el archivo .travis.yml

      language: ruby
      rvm:
       - 2.3.1
      before_install:
       - gem install inspec
       - gem install bundle
       - bundle install

      script:
      inspec exec test.rb

 Enlace a el badge de Travis : [![Build Status](https://travis-ci.com/mati3/Gestion-Medicamentos-IV.svg?branch=master)](https://travis-ci.com/mati3/Gestion-Medicamentos-IV)

**Vamos a hacer un desarrollo basado en pruebas, para el marco de test, ruby usa [rspec](https://github.com/rspec/rspec):**

* gem install rspec

* rspec --init

* rspec test_prueba.rb

**Para el gestor de versiones usamos [nvm](https://github.com/rvm/ubuntu_rvm):**

* sudo apt-get install software-properties-common

* sudo apt-add-repository -y ppa:rael-gc/rvm

* sudo apt-get update

* sudo apt-get install rvm

* rvm install ruby

* rvm use 2.3.7version_elegida

* ruby test_prueba.rb

**Automatizamos la ejecución de nuestros test, para ello instalamos [rake](https://github.com/ruby/rake):**

* gem install rake

Añadimos a nuestro proyecto un archivo rakefile:

      task default: %w[test]

      task :test do
        ruby "test/unittest.rb"
      end
