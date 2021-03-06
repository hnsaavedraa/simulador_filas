require_relative "Cliente.rb"
require_relative "Caja.rb"
require_relative "Fila.rb"
require_relative "Pintar.rb"

tiempo_total = 0
numero_clientes = 0
filas = []

def calcular_promedio(tiempo_total, numero_clientes)
  promedio = (tiempo_total* 1.0)/numero_clientes
  return promedio.round(2)
end

def calcular_espera_fila (multiples_filas, filas, num_cajas)
total = 0
  if (!multiples_filas)
    total = filas[0].calcular_espera()
  elsif(multiples_filas)
    num_cajas.times {|n| total += filas[n].calcular_espera()}
  end
return total
end


def generar_clientes (multiples_filas, filas, largo_filas = 0  )
    num_agregar = Random.new.rand(0..5)

    if  !multiples_filas
      num_agregar.times {|n| filas[0].agregar_cliente( Cliente.new())}
    end
    if multiples_filas
      num_agregar.times {|n| pos_min = largo_filas.index(largo_filas.min)
       filas[pos_min].agregar_cliente( Cliente.new())
       largo_filas[pos_min] += 1}
    end
  return num_agregar
end

def validacion_cajas (multiples_filas, filas, cajas, j, largo_filas)
  x = 0
  x = j if multiples_filas
  ## corresponde al tiempo que esperaron los clientes que ya acabaron su compra
  tiempo_cliente_registrado = 0
  if (cajas[j].cliente_caja == nil)
    if ( !filas[x].cola_clientes.size() ==0 )
      filas[x].pasar_cliente(cajas[j])
      tiempo_cliente_registrado += cajas[j].cliente_caja.tiempoEspera
    end
  elsif (cajas[j].cliente_caja.tiempoCaja == 0)
    largo_filas[j] -= 1 if multiples_filas
    if ( !filas[x].cola_clientes.size() ==0 )
      filas[x].pasar_cliente(cajas[j])
      tiempo_cliente_registrado += cajas[j].cliente_caja.tiempoEspera
    else
      cajas[j].cliente_caja = nil
    end
  end
  ## Registramos el paso del tiempo para los clientes en cada caja (Tiempo en caja)
  if(cajas[j].cliente_caja != nil)
    cajas[j].cliente_caja.disminuir_tiempo_caja()
  end
  return tiempo_cliente_registrado
end


system "clear" or system "cls"
puts "--- Simulador de filas ---",
"  Para empezar digite el tipo de fila a simular",
"  u para fila unica o m para filas multiples",
"  seguido de un espacio digite uno a uno los demas parametros",
"  numero de cajas",
"  tiempo de las simulación en minutos (iteraciones).",
"  delta de tiempo deseado para cada iteración",
"          ej: u 5 10 1"

=begin
comandoAux = gets.chomp
comando, *arg = comandoAux.downcase.split /\s/
num_cajas = arg[0].to_i
cajas = Array.new(num_cajas)
tiempo = arg[1].to_i
delta_tiempo = arg[2].to_i
=end

comandoAux = gets.chomp
arg=Array.new()
arg = comandoAux.downcase.split(" ")
comando = arg[0]
num_cajas = arg[1].to_i
cajas = Array.new(num_cajas)
tiempo = arg[2].to_i
delta_tiempo = arg[3].to_i

multiples_filas=false
if comando == "m"
  multiples_filas=true
end

num_cajas.times {|i| cajas[i] = Caja.new()
filas[i] = Fila.new()}
largo_filas = 0
largo_filas = Array.new(num_cajas) {0} if multiples_filas

for i in 1...(tiempo)
  if (i == 1 || i%3 == 0)
    numero_clientes += generar_clientes(multiples_filas,filas,largo_filas )
  end
  for j in 0...num_cajas
    tiempo_total += validacion_cajas(multiples_filas, filas, cajas, j, largo_filas)
  end
  filas[0].aumentar_espera_fila if !multiples_filas
  num_cajas.times {|m| filas[m].aumentar_espera_fila } if multiples_filas
  pintar = Pintar.new(cajas,filas)
  pintar.visualizar()
  sleep(delta_tiempo)
end

tiempo_total += calcular_espera_fila(multiples_filas, filas, num_cajas)
puts "promedio #{calcular_promedio tiempo_total, numero_clientes }"
