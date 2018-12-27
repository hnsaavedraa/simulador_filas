class Pintar

    attr_accessor :arrayCajas, :arrayFilas

    def initialize (arrayCajas, arrayFilas)
        @arrayCajas = arrayCajas
        @arrayFilas = arrayFilas

    end

    def visualizar
        visualCajas = ""
        visualClientes = ""

        arrayCajas.each do |caja|
            visualCajas.concat("|C| ")
            if(caja.cliente_caja != nil )
                visualClientes.concat(" #{caja.cliente_caja.nombre}  ")
            else
                visualClientes.concat("    ")
            end
        end

        puts "---------------------------",
             visualCajas, visualClientes, ""

        colaLarga = 0
        arrayFilas.each do |fila|
            if fila.cola_clientes.length > colaLarga
                colaLarga = fila.cola_clientes.length
            end
        end

        colaLarga.times do |numero|
            visualFilas = ""
            arrayFilas.each do |fila|
                if(!fila.cola_clientes[numero].nil?)
                    visualFilas.concat("|#{fila.cola_clientes[numero].nombre}| ")
                else
                    visualFilas.concat("    ")
                end
            end
            puts visualFilas
        end

    end
end

