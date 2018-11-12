# Proyecto-IV mi primer test

require_relative  '../src/medicamento_uno'
require  'test/unit'
require  'test/unit'
require "json" 

class TestMyMedicina <  Test::Unit::TestCase
	
	def setup 
		file = File.read('src/UnMedicamento.json')
		data_hash = JSON.parse(file)
		
		@medicamento = Medicamento.new(data_hash['nombre'], data_hash['prospecto'], data_hash['caducidad'], data_hash['identificador'])
	end

	def test_medicina_datos()
		assert @medicamento.nombre == "antiviral", "el nombre no es correcto"
		assert @medicamento.prospecto == "Este medicamento ayuda a combatir los virus", " prospecto erroneo "
		assert @medicamento.caducidad == "2018-10-10", " Fecha caducidad erronea"
		assert @medicamento.identificador == "001", " identificador erroneo"
	end
	
	def test_med_acabada()	
		refute @medicamento.getContador <= 5 , "solo me quedan 5 de esta medicina"
	end
	
	def test_med_caduca()
		refute @medicamento.caducidad == Time.now.strftime("%F"), "hoy caduca este medicamento"
	end
	
end
