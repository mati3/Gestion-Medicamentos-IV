# coding: utf-8

from fabric.api import *

def Remove():
	run('sudo rm -rf ./Gestion-Medicamentos-IV')

def Install():
	Remove()
	run('git clone https://github.com/mati3/Gestion-Medicamentos-IV.git')
	run('cd Gestion-Medicamentos-IV && bundle install')
	
def Run():
	run('cd Gestion-Medicamentos-IV && sudo bundle exec rackup',pty=False)

def Update():
	Install()
	Run()



