
#require 'json'
#require_relative "medicamento_uno" # comentar

	class Almacen
		
		attr_accessor :arrayMedicamentos, :medActual
		
		@@MAXMEDICAMENTOS = 4
		
		def initialize(medicamentos)
			@arrayMedicamentos = medicamentos
			@medActual = nil
		end
		
		public
		
		def setComprar(med, n)
			med.setCompro(n)
			@arrayMedicamentos.each do |j|
				if j.nombre == med.nombre
					j = med
				end
			end
		end
		
		def setVender(med, n)
			med.setVendo(n)
			@arrayMedicamentos.each do |j|
				if j.nombre == med.nombre
					j = med
				end
			end
		end
		
		def setMedActual(med) # decido poner este metodo para recorrer el array una sola vez
			@arrayMedicamentos.each do |j|
				if j.nombre == med.nombre
					@medActual = med
				end
			end
		end
		
		def setNombre(n)
			@medActual.nombre = n
		end
		
		def getNombre
			@medActual.nombre
		end
		
		def setProspecto(n)
			@medActual.prospecto = n
		end
		
		def getProspecto
			@medActual.prospecto
		end
		
		def setCaducidad(n)
			@medActual.caducidad = n
		end
		
		def getCaducidad
			@medActual.caducidad
		end
		
		def setIdentificador(n)
			@medActual.identificador = n
		end

		def getIdentificador
			@medActual.identificador
		end

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

#### Para probar desde la misma clase ####
=begin
public
def main
	file2 = File.read('../src/TodosLosMedicamentos.json')
    data_hash2 = JSON.parse(file2)
    @medicamentos = []
    i=0
    data_hash2.each do |value|
    	@medicamentos[i] = Medicamento.new(value['nombre'], value['prospecto'], value['caducidad'], value['identificador'])
    	i=i+1
    end
    @almacen = Almacen.new(@medicamentos)
    @almacen.setComprar(@medicamentos[0],5)
	puts @almacen.to_s
end

Almacen.main

=end

