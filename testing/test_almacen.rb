# Proyecto-IV mi primer test

require_relative  '../src/medicamento_uno'
require_relative  '../src/almacen'
require  'test/unit'
require  'test/unit'
require "json" 

class TestMyAlmacen <  Test::Unit::TestCase
	
	def setup 
		file2 = File.read('src/TodosLosMedicamentos.json')
		data_hash2 = JSON.parse(file2)
		@medicamentos = []
		i=0
		data_hash2.each do |value|
			@medicamentos[i] = Medicamento.new(value['nombre'], value['prospecto'], value['caducidad'], value['identificador'])
			i=i+1
		end
		@almacen = Almacen.new(@medicamentos)
	end

	def test_datos()
		assert @almacen.arrayMedicamentos[0].nombre == "antiviral", "el nombre no es correcto"
		assert @almacen.arrayMedicamentos[0].prospecto == " Este medicamento ayuda a combatir los virus ", " prospecto erroneo "
		assert @almacen.arrayMedicamentos[0].caducidad == "20/02/2022", " Fecha caducidad erronea"
		assert @almacen.arrayMedicamentos[0].identificador == "001", " identificador erroneo"
		
		assert @almacen.arrayMedicamentos[1].nombre == "anestésico", "el nombre no es correcto"
		assert @almacen.arrayMedicamentos[1].prospecto == " con este medicamento no te duele na ", " prospecto erroneo "
		assert @almacen.arrayMedicamentos[1].caducidad == "03/03/2033", " Fecha caducidad erronea"
		assert @almacen.arrayMedicamentos[1].identificador == "002", " identificador erroneo"
		
		assert @almacen.arrayMedicamentos[2].nombre == "analgésico", "el nombre no es correcto"
		assert @almacen.arrayMedicamentos[2].prospecto == " Con este medicamento te sientes mejor ", " prospecto erroneo "
		assert @almacen.arrayMedicamentos[2].caducidad == "31/11/2018", " Fecha caducidad erronea"
		assert @almacen.arrayMedicamentos[2].identificador == "003", " identificador erroneo"
		
		assert @almacen.arrayMedicamentos[3].nombre == "anitalergico", "el nombre no es correcto"
		assert @almacen.arrayMedicamentos[3].prospecto == " Este medicamento te ayuda con las alergias ", " prospecto erroneo "
		assert @almacen.arrayMedicamentos[3].caducidad == "31/01/2019", " Fecha caducidad erronea"
		assert @almacen.arrayMedicamentos[3].identificador == "004", " identificador erroneo"
	end
	
	def test_acabada()	
		assert @almacen.getMaxMedicamentos == 4 , "numero incorrecto de MAX medicamentos"
		assert @almacen.arrayMedicamentos.length == 4, "numero incorrecto de medicamentos"
		
	end
	
	def test_caduca()
		refute @almacen.arrayMedicamentos[0].caducidad == Time.now.strftime("%F"), "hoy caduca este medicamento"
		refute @almacen.arrayMedicamentos[1].caducidad == Time.now.strftime("%F"), "hoy caduca este medicamento"
		refute @almacen.arrayMedicamentos[2].caducidad == Time.now.strftime("%F"), "hoy caduca este medicamento"
		refute @almacen.arrayMedicamentos[3].caducidad == Time.now.strftime("%F"), "hoy caduca este medicamento"
	end
	
end
