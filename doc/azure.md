
## Despliegue de la aplicación en Azure.


### Ansible

Lo primero que hacemos es una prueba en local para gestionar con ansible una maquina virtual creada con vagran que clone nuestro repositorio e instale todo lo necesario.

Con Vagrant init tenemos nuestro archivo Vagrantfile, el cual modificamos para que quede así:

    Vagrant.configure("2") do |config|

      config.vm.box = "bento/ubuntu-18.04"
      config.vm.network "forwarded_port", guest: 4567, host: 80, host_ip: "0.0.0.0"

      config.vm.provision "ansible" do |ansible|
          ansible.sudo = true
          ansible.playbook = "ansible.yml"
          ansible.verbose = "v"
          ansible.host_key_checking = false
      end

Instalo ansible con: sudo apt install ansible

Genero archivo ansible playbook.yml el cual queda así:

      - hosts: all
      sudo: yes
      remote_user: vagrant   
      tasks:
      - name: Actualizar sistema
      apt: update_cache=yes     	
      - name: Install git
      apt: pkg=git state=present
      - name: Clonar
      git:  repo=https://github.com/mati3/Gestion-Medicamentos-IV.git dest=Gestion-Medicamentos-IV/ clone=yes force=yes  
      - name: Build-essential
      apt: pkg=build-essential state=present     
      - name: Instala Ruby
      apt: pkg=ruby state=present
      - gem:
          name=sinatra
          state=latest
      - gem:
          name=bundle
          state=latest

Nota: Para errores  en la sintaxis de [YAML](http://wiki.ess3.net/yaml). Errores varios con [vagrant y ansible](http://databaseindex.blogspot.com/2018/03/)

Ejecuto en terminal: vagrant up, vagrant ssh, cd /vagrant, compruebo que esta todo instalado. Primera parte realizada.

![imagen](img/a_26.png)

![imagen](img/a_25.png)

### Configuración Azure

Ya tenemos cuenta en Azure aunque no le hayamos dado uso, así que, lo primero que hacemos es instalar el cliente [(Azure-Cli)](https://docs.microsoft.com/es-es/cli/azure/install-azure-cli-apt?view=azure-cli-latest) para la creación y orquestación de maquinas virtuales en el propio Azure. Esto nos ha dado bastantes problemas, al final la solución buena para mi fue:


**Ejecutamos el siguiente comando :**

    sudo apt-get update & sudo apt-get install -y libssl-dev libffi-dev & sudo apt-get install -y python-dev

**Instalamos azure-cli con:**

    curl -L https://aka.ms/InstallAzureCli | bash

Con az login la propia terminal te da un codigo de autentificación y la web donde tienes que ponerlo.

![imagen](img/a_07.png)

Podemos comprobar nuestras suscripciones con:

    azure account list

ó

    az account list

![imagen](img/a_09.png)

Para obtener los detalles de la suscripción activa:

    az account show

![imagen](img/a_08.png)

[Link a comandos az](https://docs.microsoft.com/en-us/cli/azure/account?view=azure-cli-latest)

Vemos que no tenemos el certificado en la imagen anterior.

**Preparamos el entorno de Cli de Azure en modo [Service Manager](https://docs.microsoft.com/es-es/azure/azure-resource-manager/resource-manager-deployment-model).**

Modelo de despliegue basado en el Servicio, el Cloud Service actua como un contenedor para hospedar los servicios, con todos sus componentes, ya sean interfaces de red, Direcciones IP públicas, nombres DNS, así como balanceador/equilibrador de carga, Endpoints de acceso ya sea via Powershell, RDP o SSH.
Asimismo se agrega el almacenamiento necesario donde ubicar los discos duros virtuales para una máquina virtual, incluido el sistema operativo, discos de datos temporales y adicionales, se incluiría una red virtual opcional que actúa como un contenedor adicional, en el que se puede crear una estructura de subredes y designar la subred en la que se encuentra nuestro Cloud Service. [Link a la explicación](http://blogs.itpro.es/rtejero/2017/11/24/azure-service-manager-asm-vs-azure-resource-manager-arm-hagomigrome-actualizo/)

    azure config mode asm

Acto seguido descargo el archivo de configuración de publicación que se utiliza para autenticar a través de autenticación basada en certificados para las API de ASM.

    azure account download

![imagen](img/a_10.png)

Nos dirigimos al link que nos muestra la terminal. Validamos y descargamos:

![imagen](img/a_11.png)

![imagen](img/a_12.png)

Importamos el archivo descargado, las credendiales.

![imagen](img/a_13.png)

Como podemos ver ya si tenemos el certificado.

![imagen](img/a_06.png)

Ahora vamos con la seguridad. Aprovechamos los conocimientos adquiridos en SPSI. Creamos un certificado autofirmado llamado "azurecert.key"

![imagen](img/a_14.png)

**Certificado:**

Como azure no admite certificados .pem, cambiamos el formato del certificado a un .cert, al que llamamos "azurecert.cer"

Para los certificados, quitar permisos del archivo y solo permitir leer el archivo al propietario.

![imagen](img/a_15.png)

Subimos el archivo a Azure, [guia para subir un certificado](https://docs.microsoft.com/es-es/azure/azure-api-management-certs)

![imagen](img/a_16.png)

![imagen](img/a_17.png)

![imagen](img/a_18.png)

Si queremos asignarle roles, como mínimo seremos colaborador. Centro de acceso (IAM) -> Agregar asignación de roles.

![imagen](img/a_21.png)

### Vagrant

Vamos a usar vagrant para crear y manejar nuestra maquina virtual en Azure, necesitamos un archivo Vagrantfile, con el cual definiremos el tipo de maquina requerida para nuestro proyecto y la aprovisionaremos.

[Nuestro Vagrantfile](../Vagrantfile)

[Link a la documentación detallada de vagrant](vagrantfile.md)

Creamos la maquina virtual y todo lo necesario en Azure desde nuestra terminal:

![imagen](img/y_01.png)

![imagen](img/y_02.png)

### Fabric

Para facilitar la implementación y la administración usamos Fabric, lo con la orden "sudo pip install -U 'fabric<2' " creamos una carpeta llamada "despliegue" donde generamos nuestro "fabfile.py", el cual queda con el siguiente aspecto:


      from fabric.api import *


      def Instalar():
      	""" Clonar repositorio """

      	run('git clone https://github.com/mati3/Gestion-Medicamentos-IV.git')

      	run('sudo apt-get update')
      	run('sudo apt-get upgrade')
      	run('sudo apt install build-essential')
      	run('sudo apt install ruby')
      	run('sudo gem install sinatra')
      	run('sudo gem install bundle')
      	run('cd Gestion-Medicamentos-IV && bundle install')

      def Eliminar():
      	""" Eliminar el repositorio """

      	run('sudo rm -rf ./Gestion-Medicamentos-IV')

      def Iniciar():
      	""" Run """
      	run('cd Gestion-Medicamentos-IV && bundle exec rackup')

### Ejecución

Para probar la ejecución de nuestra aplicación con Fabric ejecutamos desde terminal:

fab -f despliegue/fabfile.py -H vagrant@ivgestion-ip.cloudapp.azure.com Iniciar

Vamos al navegador y probamos:

![imagen](img/y_04.png)
