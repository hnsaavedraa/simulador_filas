require_relative "Cliente.rb"
require_relative "Caja.rb"
require_relative "Fila.rb"

#cliente = Cliente.new()
#caja = Caja.new()
#fila = Fila.new()
filas = []
def imprimir()
end

def iterador()
end

def calcular_promedio()
  return tiempo_total/numero_clientes
end


def asignar_filas(cajas, num, filas)
  if(num > 1)
  num.times {|i| filas[i] = Fila.new(cajas[i])}
  elsif(num == 1)
    filas[0] = Fila.new(cajas)
  end
end

tiempo_total = 0
numero_clientes = 0


    #lipiar pantalla
    system "clear" or system "cls"
    puts "--- Simulador de filas ---",
         "  Para empezar digite el tipo de fila a simular",
         "  u para fila unica o m para filas multiples",
         "  seguido de un espacio digite uno a uno los demas parametros",
         "  numero de cajas",
         "  tiempo de las simulación en minutos (iteraciones).",
         "  delta de tiempo deseado para cada iteración",

         " ej: u 5 10 1"

    comandoAux = gets.chomp
    comando, *arg = comandoAux.downcase.split /\s/
    num_cajas = arg[0].to_i
    tiempo = arg[1].to_i
    delta_tiempo = arg[2].to_i
    cajas = Array.new(num_cajas)
    num_cajas.times {|i| cajas[i] = Caja.new()}
    asignar_filas(cajas,num_cajas, filas)
    case comando
    when "s","S","9"
        seccion = "0"

    when "u"
        puts "selecciono fila unica"
        puts "cajas #{num_cajas} tiempo #{tiempo} delta #{delta_tiempo}"
        for i in 1...(tiempo+1)
          if (i == 1 || i%3 == 0)
            num_agregar = Random.new.rand(0..5)
            num_agregar.times {|n| filas[0].agregar_cliente( Cliente.new())}
          end
          for j in 0...num_cajas

            if (cajas[j].cliente_caja == nil )
              cajas[j].cliente_caja = filas[0].cola_clientes.pop
              puts "perro"
            elsif (cajas[j].cliente_caja.tiempoCaja == 0)
              cajas[j].cliente_caja = filas[0].cola_clientes.pop
            end
          end
        end


    when "m"
        puts "selecciono filas multiple"

    else
        puts "El comando '#{comando}' no es valido"

    end

## crear arreglos (cajas , filas , record clientes)
##ciclo iteraciones
