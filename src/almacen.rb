#!/usr/bin/env python
# -*- coding: utf-8 -*-

#require_relative "medicamento"

	class Almacen
		
		attr_accessor :arrayMedicamentos
		
		@@MAXMEDICAMENTOS = 4
		
		def initialize(medicamentos)
			@arrayMedicamentos = medicamentos
		end
		
		public
		
#		def setComprar(nombre, n)
#			@arrayMedicamentos.nombre
#		end
		
#		def setVender(nombre, n)
#			@arrayMedicamentos.nombre
#		end
		
#		def getCantidad(nombre)
#			return @arrayMedicamentos.nombre.getContador
#		end

		

		def to_s
			cadena = "\n Todos los medicamentos:\n"
			@arrayMedicamentos.each do |j|
				cadena += " #{j.to_s}\n"
			end
			return cadena
		end
		
		def to_s_json
			cadena ="[" + @arrayMedicamentos[0].to_s_json + ","
			cadena +=@arrayMedicamentos[1].to_s_json + ","
			cadena +=@arrayMedicamentos[2].to_s_json + ","
			cadena +=@arrayMedicamentos[3].to_s_json + "]"
			return cadena
		end
	end



