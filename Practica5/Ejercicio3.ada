--Se dispone de un sistema compuesto por 1 central y 2 procesos periféricos, que se comunican continuamente. Se requiere modelar su funcionamiento considerando las siguientes condiciones:

--La central siempre comienza su ejecución tomando una señal del proceso 1; luego toma aleatoriamente señales de cualquiera de los dos indefinidamente. Al recibir una señal de proceso 2, recibe señales del mismo proceso durante 3 minutos.
--Los procesos periféricos envían señales continuamente a la central. La señal del proceso 1 será considerada vieja (se deshecha) si en 2 minutos no fue recibida. Si la señal del proceso 2 no puede ser recibida inmediatamente, entonces espera 1 minuto y vuelve a mandarla (no se deshecha).

Procedure Sistema is
   Task central is
      entry recibir_senal_proceso1(senal: IN String);
      entry recibir_senal_proceso2(senal: IN String);
      entry aviso;
   end central;

   task timer is
      entry iniciarTimer;
   end timer;
   task body timer is
   begin
   loop
      accept iniciarTimer;
      delay 180.0; -- Simula el tiempo de espera para la señal vieja
      central.aviso;
   end loop;
   end ;

   task proceso1;
   task body proceso1 is
     senal: text;
   begin
      loop
         senal:= generar_senal();
         select
            central.recibir_senal_proceso1(senal);
         or delay 120.0; -- Tiempo para considerar la señal vieja
            null;
         end select;
      end loop;
   end proceso1;
   
   task proceso2;
   task body proceso2 is
      senal: text;
   begin
         loop
            senal:= generar_senal();
            select
               central.recibir_senal_proceso2(senal);
               senal:= generar_senal();
            else
               delay 60.0; -- Tiempo de espera antes de volver a mandar la señal
            end select;
         end loop;
   end proceso2;

   Task body central is
      fin: Boolean
   begin
      loop
         select
            accept recibir_senal_proceso1 (senal : IN String)
         or
            accept recibir_senal_proceso2 (senal : IN String)
            timer.iniciarTimer;
            fin := False;
            while(not fin) loop
               select
                  when(aviso'COUNT = 0) => accept recibir_senal_proceso2 (senal : IN String) do
                  or 
                     accept aviso do
                     fin := True;
                  end aviso;
               end select;
            end loop;
         end select;
      end loop;
   end central;

Begin 
   null;
end Sistema;

