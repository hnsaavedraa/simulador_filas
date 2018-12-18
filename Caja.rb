class Caja
   attr_accessor :cliente_caja
   def initialize()
     @cliente_caja = nil
   end

   def pasar(cliente)
     @cliente_caja = cliente
   end
end
