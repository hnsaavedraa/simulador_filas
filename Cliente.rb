class Cliente

	attr_accessor :tiempoEspera ,:nombre, :tiempoCaja 

	def initialize()
		aleatorio = Random.new
		@nombre = aleatorio.rand(26)
		@tiempoCaja = aleatorio.rand(4..25)
		@tiempoEspera = 0
	end

	def diminuir_tiempo_caja()
		@tiempoCaja -= 1
	end

	def aumentar_tiempo_espera()
		@tiempoEspera += 1
	end

end