# Proyecto-IV mi primer test

require_relative  'src/funciones'
require  'test/unit'
 
class  TestFunciones  <  Test::Unit::TestCase

  def setup # codigo antes de cada prueba
  	@claseLocal = Funciones.new(2)
  end
 
  def  test_simple 
  	assert_equal(true, @claseLocal.metodo )
    assert_equal(4, @claseLocal.add(2) )
    assert_equal(6, @claseLocal.multiply(3) ) 
    assert @claseLocal.multiply(3) == 6 , " se espera que sea multiplo"
  end
  
  def teardown
  	# codigo despues de cada prueba
  end
  
 
end
