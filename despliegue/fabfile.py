# coding: utf-8

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
	run('cd Gestion-Medicamentos-IV && sudo bundle exec rackup',pty=False)
	

"""
#!/bin/bash

vagrant up --provider=azure

fab -f despliegue/fabfile.py -H vagrant@ivgestion-ip.cloudapp.azure.com Eliminar
fab -f despliegue/fabfile.py -H vagrant@ivgestion-ip.cloudapp.azure.com Instalar
fab -f despliegue/fabfile.py -H vagrant@ivgestion-ip.cloudapp.azure.com Iniciar

"""
