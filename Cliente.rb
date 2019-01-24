class Cliente

	attr_accessor :tiempoEspera ,:nombre, :tiempoCaja

	def initialize()
		aleatorio = Random.new
		@nombre = aleatorio.rand(97..122).chr
		@tiempoCaja = aleatorio.rand(4..25)
		@tiempoEspera = 0
		
		@nombre = "s" if @nombre == "c" 
	end

	def disminuir_tiempo_caja()
		@tiempoCaja -= 1
	end

	def aumentar_tiempo_espera()
		@tiempoEspera += 1
	end

end
