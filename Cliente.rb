class Cliente

	attr_accessor :tiempoEspera ,:nombre, :tiempoCaja

	def initialize()
=begin
		aleatorio = Random.new
 		@nombre = aleatorio.rand(97..122).chr
		@tiempoCaja = aleatorio.rand(4..25)
=end

		random_name = %w{a b d e f g h i j k l m n o p q r s t u v w x y z}
		n=random_name.length
		@nombre = random_name[rand(n)]
		@tiempoCaja = rand(4..25)
		@tiempoEspera = 0
	end

	def disminuir_tiempo_caja()
		@tiempoCaja -= 1
	end

#funcion duplicada

=begin
	def aumentar_tiempo_espera()
		@tiempoEspera += 1
	end

=end
end
