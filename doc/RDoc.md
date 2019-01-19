
## Instalación de RDoc

**Buscar en los servidores remotos**

	 $ gem query --remote --name-matches rdoc

**Instalarla de la siguiente manera**

	 $ gem install --remote rdoc

**Comprobar que realmente se instalo la gema rdoc**

	$ gem list --local



### Formatos de Documentación

		= Cabecera de Primer nivel

		== Cabecera de Segundo nivel

		=== Cabecera de Tercer nivel

		etiqueta:: para hacer referencia a una etiqueta o label

		‘*’ o ‘-‘ Para crear elementos de una lista

		\# Para crear elementos en una lista enumerada

		\_italic_ para aquellas palabras en cursiva

		\*negrita* para aquellas palabras que deseamos resaltar

		+codigo+ para resaltar fragmentos de código


**Para obtener su documentación podemos hacerlo de la siguiente manera:**

	* $ rdoc --main -o documento ejemplo_rdoc.rb

**Para un proyecto entero, dentro de la raíz principal ejecutar:**

	 $ rdoc --all -o documentacion

Para mas información [rdoc en git](https://github.com/ruby/rdoc)
