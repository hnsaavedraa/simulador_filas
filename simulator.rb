require_relative "Cliente.rb"
require_relative "Caja.rb"
require_relative "Fila.rb"

#cliente = Cliente.new()
#caja = Caja.new()
#fila = Fila.new()

def imprimir()
end

def iterador()
end

def calcular_promedio()
end

while true
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

    case comando
    when "s","S","9"
        seccion = "0"
        break
    when "u"
        puts "selecciono fila unica"
        puts "cajas #{num_cajas} tiempo #{tiempo} delta #{delta_tiempo}"
        gets.chomp
    when "m"
        puts "selecciono filas multiple"
        gets.chomp

    else
        puts "El comando '#{comando}' no es valido"
        gets.chomp
    end
end
## crear arreglos (cajas , filas , record clientes)
##ciclo iteraciones
