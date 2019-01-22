require_relative "Cliente.rb"
require_relative "Caja.rb"
require_relative "Fila.rb"
require_relative "Pintar.rb"



def asignar_filas(cajas, num, filas)
  if(num > 1)
    num.times {|i| filas[i] = Fila.new(cajas[i])}
  elsif(num == 1)
    filas[0] = Fila.new(cajas[0])
  end
end

def pintar(cajas, num_caja, filas)
  for x in 0...num_caja
    if(cajas[x].cliente_caja != nil )
      clien = cajas[x].cliente_caja
      puts " cliente #{clien.nombre} de la caja #{x+1} le faltan #{clien.tiempoCaja} minutos "
    end
  end
  aux = filas[0].cola_clientes.clone
  aux.size.times do |x|
    puts "#{aux[x].nombre} lleva esperando #{aux[x].tiempoEspera} "
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


  when "m"
    puts "selecciono filas multiple"
    largo_filas = Array.new(num_cajas) {0}

    for i in 1...(tiempo)

      if (i == 1 || i%3 == 0)
        num_agregar = 1##Random.new.rand(0..5)
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
              filas[j].pasar_cliente_unicafila(cajas[j])
              tiempo_total += cajas[j].cliente_caja.tiempoEspera
            end
          elsif (cajas[j].cliente_caja.tiempoCaja == 0)
            largo_filas[j] -= 1
            if ( !filas[j].vacia )
              filas[j].pasar_cliente_unicafila(cajas[j])
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
        #pintar(cajas, num_cajas, filas)
        sleep(delta_tiempo) ## aplicamos delta de tiempo

    end

    ## Por ultimo calculamos el promedio del tiempo de espera
    num_cajas.times {|r| tiempo_total += filas[r].calcular_espera()}

    puts "promedio #{tiempo_total/numero_clientes}"
    puts "#{numero_clientes}  total clientes"
    puts "#{tiempo_total} tiempo espera total"





  else
    puts "El comando '#{comando}' no es valido"

  end
