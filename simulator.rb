require_relative "Cliente.rb"
require_relative "Caja.rb"
require_relative "Fila.rb"
require_relative "Pintar.rb"


def calcular_promedio(tiempo_total, numero_clientes)
  promedio = (tiempo_total* 1.0)/numero_clientes
  return promedio.round(2)
end


def asignar_filas(cajas, num, filas)
  if(num > 1)
    num.times {|i| filas[i] = Fila.new(cajas[i])}
  elsif(num == 1)
    filas[0] = Fila.new(cajas[0])
  end
end



tiempo_total = 0
numero_clientes = 0
filas = []

    #lipiar pantalla
system "clear" or system "cls"
puts "--- Simulador de filas ---",
"  Para empezar digite el tipo de fila a simular",
"  u para fila unica o m para filas multiples",
"  seguido de un espacio digite uno a uno los demas parametros",
"  numero de cajas",
"  tiempo de las simulación en minutos (iteraciones).",
"  delta de tiempo deseado para cada iteración",
"          ej: u 5 10 1"

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
    for i in 1...(tiempo)
      ## Añadimos los clientes nuevos a la fila
      if (i == 1 || i%3 == 0)
        num_agregar = Random.new.rand(0..5)
        num_agregar.times {|n| filas[0].agregar_cliente( Cliente.new())}
        numero_clientes += num_agregar
      end


      ## En cada iteracion vamos caja por caja revisando si esta disponible
      ## O si el cliente en caja esta proximo a terminar su compra
      for j in 0...num_cajas
        if (cajas[j].cliente_caja == nil)
          if ( !filas[0].vacia )
            filas[0].pasar_cliente(cajas[j])
            tiempo_total += cajas[j].cliente_caja.tiempoEspera
          end
        elsif (cajas[j].cliente_caja.tiempoCaja == 0)
          if(!filas[0].vacia)
            filas[0].pasar_cliente(cajas[j])
            tiempo_total += cajas[j].cliente_caja.tiempoEspera
          else
            cajas[j].cliente_caja = nil
          end
        end
        ## Registramos el paso del tiempo para los clientes en cada caja (Tiempo en caja)
        if(cajas[j].cliente_caja != nil)
          cajas[j].cliente_caja.disminuir_tiempo_caja()
        end
      end
      ## acaba el recorrido de cajas
      ## Registramos para cada persona en la fila el paso del tiempo (Tiempo de espera)
      filas[0].aumentar_espera_fila
      pintar = Pintar.new(cajas,filas)
      pintar.visualizar()  ## Metodo de pintado
      sleep(delta_tiempo) ## aplicamos delta de tiempo
    end
    ## Por ultimo calculamos el promedio del tiempo de espera
    tiempo_total += filas[0].calcular_espera()
    puts "promedio #{calcular_promedio(tiempo_total, numero_clientes)}"

  when "m"
    puts "selecciono filas multiple"
    largo_filas = Array.new(num_cajas) {0}
    for i in 1...(tiempo)

        if (i == 1 || i%3 == 0)
          num_agregar = Random.new.rand(0..5)
          num_agregar.times do
            pos = largo_filas.index(largo_filas.min)
            filas[pos].agregar_cliente( Cliente.new())
            largo_filas[pos] += 1
          end
          numero_clientes += num_agregar
        end

        ## recorremos cajas para pasar clientes de  las filas
        for j in 0...num_cajas

          if (cajas[j].cliente_caja == nil)
            if ( !filas[j].vacia )
              filas[j].pasar_cliente(cajas[j])
              tiempo_total += cajas[j].cliente_caja.tiempoEspera
            end
          elsif (cajas[j].cliente_caja.tiempoCaja == 0)
            largo_filas[j] -= 1
            if ( !filas[j].vacia )
              filas[j].pasar_cliente(cajas[j])
              tiempo_total += cajas[j].cliente_caja.tiempoEspera
            else
              cajas[j].cliente_caja = nil
            end
          end
          ## Registramos el paso del tiempo para los clientes en cada caja (Tiempo en caja)
          if(cajas[j].cliente_caja != nil)
            cajas[j].cliente_caja.disminuir_tiempo_caja()
          end
        end
        num_cajas.times {|m| filas[m].aumentar_espera_fila }
        ## apartir de aca el proceso es el mismo, crear metodos
        pintar = Pintar.new(cajas,filas)
        pintar.visualizar()  ## Metodo de pintado
        sleep(delta_tiempo) ## aplicamos delta de tiempo
    end
    ## Por ultimo calculamos el promedio del tiempo de espera
    tiempo_total += filas[0].calcular_espera()

    puts "promedio #{calcular_promedio(tiempo_total, numero_clientes)}"

  else
    puts "El comando '#{comando}' no es valido"

  end
