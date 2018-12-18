require_relative "Caja"

class Fila
  attr_accessor :cola_clientes, :caja_asociada
  def initialize(caja_asociada)
    @cola_clientes = Queue.new()
    @caja_asociada = caja_asociada
  end

  def pasar_cliente()
    cliente_a_caja = cola_clientes.pop
    caja_asociada.pasar(cliente_a_caja)
  end

  def agregar_cliente(cliente_nuevo)
    cola_clientes.push(cliente_nuevo)
  end

  def vacia?()
    if(cola_clientes.empty?)
      return true
    else
      return false
    end
  end

end
