require_relative "Caja"

class Fila
  attr_accessor :cola_clientes
  def initialize()
    @cola_clientes = Array.new()
  end

  def pasar_cliente(caja)
    cliente_a_caja = cola_clientes.delete_at(0)
    caja.pasar(cliente_a_caja)
  end



  def agregar_cliente(cliente_nuevo)
    cola_clientes.push(cliente_nuevo)
  end

  def vacia()
    if(cola_clientes.size() == 0)
      return true
    else
      return false
    end
  end

  def aumentar_espera_fila()
    cola_clientes.size.times do |x|
      cola_clientes[x].aumentar_tiempo_espera()
    end
  end

  def calcular_espera()
    suma = 0
    for x in 0...cola_clientes.size
      suma += cola_clientes[x].tiempoEspera
    end
    return suma
  end

end
