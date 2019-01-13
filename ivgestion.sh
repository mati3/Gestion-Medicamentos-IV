#!/bin/bash

vagrant up --provider=azure

#para poder ejecutar todo de una vez, hay que darle un nombre en vagrant "ivgestion"
fab -f despliegue/fabfile.py -H vagrant@ivgestion.westeurope.cloudapp.azure.com Run
