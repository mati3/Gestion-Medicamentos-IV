#!/usr/bin/env python
# -*- coding: utf-8 -*-


class Medicamento
	
	attr_accessor :nombre, :prospecto, :caducidad, :identificador
		
	def initialize(nomb, prosp, cad, ident)
		@nombre = nomb
		@prospecto = prosp
		@caducidad = cad
		@identificador = ident
		@contador = 0
		setCompro(10)
	end
	
	public
			
	def setMasContador()
		@contador = @contador+1
	end

	def setMenosContador()
		@contador = @contador-1
	end

	def setCompro(n)
		@contador = @contador+n
	end

	def setVendo(n)
		@contador = @contador-n
	end

	def getContador()
		return @contador
	end

	def to_s
		cadena = " Medicamento: nombre: #{@nombre}
		Prospecto : #{@prospecto}
		Caducidad : #{@caducidad}
		Identificador: #{ @identificador}
		contador: #{ @contador}"
		return cadena
	end
	
	def to_s_json
		{"nombre" => @nombre ,
		"prospecto" => @prospecto,
		"caducidad" => @caducidad,
		"identificador" => @identificador,
		"contador" => getContador}.to_json
	end
end


