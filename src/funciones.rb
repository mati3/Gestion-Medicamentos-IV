#!/usr/bin/env python
# -*- coding: utf-8 -*-


class Medicamento
	
	@@contador = 10 # suponemos pedido mínimo 
	
	def initialize(nomb, prosp, cad, ident)
		@nombre = nomb
		@prospecto = prosp
		@caducidad = cad
		@identificador = ident
		setMasContador()
	end
	
	public
	
	def setNombre(n)
		@nombre = n
	end
	
	def getNombre()
		return @nombre
	end

	def setProspecto(p)
		@prospecto = p
	end

	def getProspecto()
		return @prospecto
	end
		
	def setCaducidad(cad)
		@caducidad = cad
	end

	def getCaducidad()
		return @caducidad
	end
		
	def setMasContador()
		@@contador = @@contador+1
	end

	def setMenosContador()
		@@contador = @@contador-1
	end

	def getContador()
		return @@contador
	end
		
	def setIdentificador(i)
		@identificador = i
	end

	def getIdentificador()
		return @identificador
	end

	def to_s
		cadena = " Medicamento: nombre: #{@nombre}
		Prospecto : #{@prospecto}
		Caducidad : #{@caducidad}
		Identificador: #{ @identificador}"
		return cadena
	end
	
	def to_s_json
		{"nombre" => @nombre ,
		"prospecto" => @prospecto,
		"caducidad" => @caducidad,
		"identificador" => @identificador}.to_json
	end
end


