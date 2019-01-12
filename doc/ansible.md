
Ansible es un motor de orquestación muy simple que automatiza toda clase de tareas necesarias para el aprovisionamiento de nuestra maquina. La hemos elegido porque es open-source y por la gran comunidad que la respalda, la [documentación](https://docs.ansible.com/) es excepcional.

Ansible por defecto gestiona las máquinas a través del protocolo SSH.

Una vez instalado puede administrar múltiples máquinas remotas desde un solo lugar. Ansible no deja el software instalado ejecutándose en las máquinas remotas.

**Requisitos de la maquina de control**

- Python 2 ó Python 3.

**Instalación vía Apt(Ubuntu)**

- sudo apt update
- sudo apt install Ansible

### Playbook

Los Playbooks básicamente nos permiten gestionar la configuración del despliegue que vamos a realizar en las máquinas virtuales. En este archivo describimos la configuración, también nos permiten orquestar una serie de pasos o tareas a seguir.

El Playbook se escribe utilizando YAML.

**playbook.yml**

    - hosts: all
      sudo: yes
      remote_user: vagrant   
      tasks:

      - name: Update System
        apt:
          update_cache=yes  
          upgrade=yes  

      - name: Install git
        apt: pkg=git state=present
      - name: Clonar
        git:  repo=https://github.com/mati3/Gestion-Medicamentos-IV.git dest=Gestion-Medicamentos-IV/ clone=yes force=yes  

      - name: Install dependencies
        apt: pkg={{item}} state=latest
        with_items:
          - build-essential
          - ruby
          - rubygems

      - gem:
          name=rake
          state=present

      - name: Install bundle  
        become: yes
        command:
          bash -lc "gem install bundle"

      - bundler:
          state=present
          gemfile=Gestion-Medicamentos-IV/Gemfile
          deployment_mode=yes


Explicamos cada una de las partes:

Hosts en los que vamos a trabajar, tenemos solo uno, así que, le decimos que en todos.

    - hosts: all

Ansible se convierte en sudo.

    sudo: yes

Remote_user gestiona el usuario remoto, es vagrant

    remote_user: vagrant

Tasks indica la lista de tareas que vamos a hacer, el estado que tiene que alcanzar la maquina sobre la que trabajamos. Es una comprobación.

    tasks:

Apt es una orden directa de ansible para ubuntu. Actualizamos el sistema.

    - name: Update System
      apt:
        update_cache=yes  
        upgrade=yes

Compruebamos que el paquete git está presente, si no lo está lo instalará.

    - name: Install git
      apt: pkg=git state=present

Clonamos nuestro repositorio de la asignatura.  
    - name: Clonar
      git:  repo=https://github.com/mati3/Gestion-Medicamentos-IV.git dest=Gestion-Medicamentos-IV/ clone=yes force=yes

Instalamos la última versión de los paquetes "build-essential", "ruby" y "rubygems".

    - name: Install dependencies
      apt: pkg={{item}} state=latest
      with_items:
        - build-essential
        - ruby
        - rubygems

Comprobamos que a gema rake esté presente

    - gem:
        name=rake
        state=present

Instalamos bundle
    - name: Install bundle  
      become: yes
      command:
        bash -lc "gem install bundle"

**- name: Install bundle  
      become=yes -** Decimos que necesitamos privilegios para realizar esta tarea. Instalaremos con sudo.

**command: bash -lc "gem install bundle"** - Ejecutamos la orden directamente en bash. Hemos decidido hacerlo así porque aunque bundle se instalaba, no inicializaba correctamente rbenv.

Bundle

    - bundle:
        state=present
        gemfile=Gestion-Medicamentos-IV/Gemfile
        deployment_mode=yes

**gemfile=Gestion-Medicamentos-IV/Gemfile** - Instala gemas usando un Gemfile en el directorio Gestion-Medicamentos-IV

**deployment_mode=yes** - Solo se aplica si está presente el archivo Gemfile.lock, instalará las gemas, es equivalente a "bundle install"

[Para mas información, tenemos un tutorial a iniciación de Ansible realizado por JJ](https://www.youtube.com/watch?v=gFd9aj78_SM&index=6&list=UUSgBde_pvFNnTsWrT_9Sg1g)
