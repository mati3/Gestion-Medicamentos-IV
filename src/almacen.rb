
#require 'json'
#require_relative "medicamento_uno" # comentar

	class Almacen
		
		attr_accessor :arrayMedicamentos, :MAXMEDICAMENTOS
		
		@@MAXMEDICAMENTOS = 4
		
		def initialize(medicamentos)
			@arrayMedicamentos = medicamentos
		end
		
		public
		
		def getMaxMedicamentos
			@@MAXMEDICAMENTOS
		end
		
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
		
		def to_json_nombres
			cadena ="[" + @arrayMedicamentos[0].nombre + ","
			cadena +=@arrayMedicamentos[1].nombre + ","
			cadena +=@arrayMedicamentos[2].nombre + ","
			cadena +=@arrayMedicamentos[3].nombre + "]"
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

