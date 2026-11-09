-- Ejercicio 1
Process Cliente[id: 0..C-1] {
   int Tel
   Admin!hayPedido(id)
   Empleado?respuesta(Tel)
   }

Process Empleado{
   int idCliente;
   int tel;
   for int i : 0..C-1 {
      Admin!pedidoTrabajo();
      Admin?hayPedido(idCliente)
      tel = obtenerTelefono(idCliente)
      Cliente[idCliente]!respuesta(tel)
   }
   
   }

Process Admin{
   int idCliente;
   Cola c;
   int recibidos = 0;
   do
     // Permite encolar solo hasta recibir a los C clientes
      [] recibidos < C; Cliente[*]?hayPedido(idCliente) -> 
            c.push(idCliente);
            recibidos++;
            
      // Desencola y envía mientras haya elementos en la cola
      [] not c.empty(); Empleado?pedidoTrabajo() -> 
            Empleado!hayPedido(c.pop());
   od
   // Cuando "recibidos" llega a C (falla la 1ra guarda) y la cola se 
   // vacía (falla la 2da guarda), el ciclo se rompe y el proceso termina.
   }
-- Ejercicio 2

Procedure ServidorPedidos is
Task Servidor is
	Entry PedidoUrgente(sec1: in string, sec2: in string, res: out integer);
	Entry PedidoRegular(sec1: in string, sec2: in string, res: out integer);
end Servidor;

Task Type Cliente;
vecCliente: array [0 .. C-1] of Cliente;

Task body Cliente is
	sec1: String
	sec2: String
	res: Integer
	prioridad: integer
	Begin
		Loop
			prioridad = obtenerPrioridad();
         sec1 := obtenerSecuencia1();
         sec2 := obtenerSecuencia2();
			
			if(prioridad = 0) then
				Servidor.PedidoUrgente(sec1, sec2, res)
				else
               select
                  Servidor.PedidoRegular(sec1, sec2, res)
               or 
                  delay 1800.0;
			      end Select;
         end if;
		end loop;
	end Cliente;
	
Task body Servidor is
	begin
		loop
			Select
				Accept PedidoUrgente(sec1: in String, sec2: in String, res: out Integer) do
					res = Analizar(sec1, sec2)
				end PedidoUrgente
				or When(PedidoUrgente'count = 0) => 
					Accept PedidoRegular(sec1: in String, sec2: in String, res: out Integer) do
						res = Analizar(sec1, sec2)
					end PedidoRegular
            else delay 300.0;
			end Select;
		end loop;
	end Servidor;
begin
	null;
end ServidorPedidos;