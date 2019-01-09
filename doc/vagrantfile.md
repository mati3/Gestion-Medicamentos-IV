
Vagrant es una herramienta que nos ayuda a crear y manejar máquinas virtuales con un mismo entorno de trabajo. Nos permite definir los servicios a instalar así como también sus configuraciones. Puede trabajar en entornos locales o como es nuestro caso en remoto (en Azure).

Vagrant se encarga de proporcionar las características con las que debe crearse una maquina virtual. Para poder trabajar con las máquinas virtuales es necesario que también instalamos VirtualBox.

[Vagrantfile](https://www.vagrantup.com/docs/vagrantfile/):

La función principal de Vagrantfile es describir el tipo de máquina requerida para un proyecto y cómo configurar y aprovisionar estas máquinas.

El orden de los pasos correctos para instalar Vagrant con Azure, serían:

* vagrant plugin install vagrant-azure

*	vagrant box add azure https://github.com/msopentech/vagrant-azure/raw/master/dummy.box

*	vagrant init

*	Acceder a la carpeta de tu proyecto y abrir el archivo Vagrantfile

*	Modificar su interior para que contengan los datos a continuación indicados.


		Vagrant.configure("2") do |config|

		  config.vm.box = "azure"

		  config.ssh.private_key_path = '~/.ssh/id_rsa'

		  config.vm.provider :azure do |azure, override|

		    azure.tenant_id = ENV['AZURE_TENANT_ID']
		    azure.client_id = ENV['AZURE_CLIENT_ID']
		    azure.client_secret = ENV['AZURE_CLIENT_SECRET']
		    azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']

		    azure.vm_image = ''
		    azure.resource_group_name = 'ivgestiongroup'
		    azure.location = 'westeurope'
		    azure.vm_size = 'Standard_DS1_v2'
		    azure.tcp_endpoints = '80'

		  end

		  config.vm.provision :ansible do |ansible|
		      ansible.playbook = "provision/playbook.yml"
		  end


Explicamos cada elemento integrado en Vagrantfile:

**config.vm.box = "azure" -** indica la maquina que vamos a configurar, como vamos a levantar la maquina directamente en Azure, así lo indicamos. Para poder usar vagrant con Azure hemos tenido que añadir la siguiente orden:

		vagrant box add azure https://github.com/msopentech/vagrant-azure/raw/master/dummy.box

**config.ssh.private_key_path = '~/.ssh/id_rsa' -** la ruta a la clave privada que se usará para SSH en la máquina invitada. Por defecto, esta es la clave privada que se envía con Vagrant es insegura. Esto es útil, por ejemplo, si usa la clave privada predeterminada para reiniciar la máquina, pero quiere reemplazarla con una clave más segura más adelante.

**config.vm.provider :azure do |azure, override| -** datos para azure.


	azure.tenant_id = ENV['AZURE_TENANT_ID']
	azure.client_id = ENV['AZURE_CLIENT_ID']
	azure.client_secret = ENV['AZURE_CLIENT_SECRET']
	azure.subscription_id = ENV['AZURE_SUBSCRIPTION_ID']

	Hay varias formas de sacar las variables de entorno de Azure, en mi opinión la mejor es conforme creamos nuestra aplicación, "az ad sp create-for-rbac --name ivgestion" nos devolverá algo como lo siguiente:

		{
		  "appId": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx", #directorio predeterminado registros de aplicacion (versión preliminar)
		  "displayName": "ivgestion",
		  "name": "http://ivgestion",
		  "password": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx",
		  "tenant": "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
		}

Por si queda alguna duda estos datos corresponden a los anteriores de la siguiente manera:

	azure.tenant_id = "tenant":
	azure.client_id = "appId":
	azure.client_secret = "password":

**azure.subscription_id =** Para conocer tu suscripción a Azure usa la orden "azure account list". Para conocer que suscripción usas con tu aplicación usa "azure account show"

**Importante**: Todas estas variables no pueden estár expuestas en ningún documento, así que para poder usarlas como variable de entorno las introduciremos en nuestro equipo de la siguiente forma:

	export AZURE_TENANT_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
	export AZURE_CLIENT_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
	export AZURE_CLIENT_SECRET="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
	export AZURE_SUBSCRIPTION_ID="xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"


**azure.vm_image = 'b39f27a8b8c64d52b05eac6a62ebad85__Ubuntu-16_04-LTS-amd64-server-20181023-en-us-30GB ' -** imagen elegida para la maquina virtual, para elegir la imagen, primero nos hemos informado de las imagenes disponibles en la localización elegida, con "az vm image list --location westeurope --offer Ubuntu "

		You are viewing an offline list of images, use --all to retrieve an up-to-date list
		[
		  {
		    "offer": "UbuntuServer",
		    "publisher": "Canonical",
		    "sku": "16.04-LTS",
		    "urn": "Canonical:UbuntuServer:16.04-LTS:latest",
		    "urnAlias": "UbuntuLTS",
		    "version": "latest"
		  }
		]

con esta información volvemos a preguntar con "az vm image list --location westeurope --publisher Canonical --offer UbuntuServer --sku 16.04-LTS --all --output table
"

		Offer         Publisher    Sku        Urn                                               Version
		------------  -----------  ---------  ------------------------------------------------  ---------------
		UbuntuServer  Canonical    16.04-LTS  Canonical:UbuntuServer:16.04-LTS:16.04.201611220  16.04.201611220
		UbuntuServer  Canonical    16.04-LTS  Canonical:UbuntuServer:16.04-LTS:16.04.201611300  16.04.201611300
		UbuntuServer  Canonical    16.04-LTS  Canonical:UbuntuServer:16.04-LTS:16.04.201612050  16.04.201612050
		UbuntuServer  Canonical    16.04-LTS  Canonical:UbuntuServer:16.04-LTS:16.04.201612140  16.04.201612140

Como me han quedado dudas de que maquina usar contrasto la información anterior con "azure vm image list | grep -i ubuntu-16 ". [Para mas información](https://docs.microsoft.com/es-es/azure/virtual-machines/linux/cli-ps-findimage)

**azure.resource_group_name = 'ivgestiongroup' -** nombre del grupo de gestión de mi aplicación.

**azure.location = 'westeurope' -** región donde quieres desplegar tu máquina en azure, puedes obtener esa información con el comando "azure vm location list", en nuestro caso es 'North Europe'.

**azure.vm_size = 'Standard_DS1_v2' -** tamaño de la maquina virtual, hemos elegido una que está disponible dentro de la región elegida, la que me puede ocasionar menor gasto. [Información de los tamaños de las maquinas](https://docs.microsoft.com/es-es/azure/virtual-machines/windows/sizes-general)

Link: [Que maquinas virtuales hay disponibles por regiones](https://azure.microsoft.com/es-es/global-infrastructure/services/?products=virtual-machines)

**azure.tcp_endpoints = '80' -** abre el puerto 80 en el cortafuegos de nuestra aplicación alojada en Azure, sin esto no tendríamos respuesta en nuestro navegador.

**Nota:** tienes que cerciorarte de que la información del Vagrantfile es concordante, lo explicamos con un ejemplo, el tamaño de la imagen elegida tiene que ser posible desplegar-la en la localización que se ha indicado.
