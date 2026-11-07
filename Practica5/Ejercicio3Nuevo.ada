--Se dispone de un sistema compuesto por 1 central y 2 procesos periféricos, que se comunican continuamente. Se requiere modelar su funcionamiento considerando las
--siguientes condiciones:
-- - La central siempre comienza su ejecución tomando una señal del proceso 1; luego toma aleatoriamente señales de cualquiera de los dos indefinidamente. Al recibir una
-- señal de proceso 2, recibe señales del mismo proceso durante 3 minutos.
-- - Los procesos periféricos envían señales continuamente a la central. La señal del
-- proceso 1 será considerada vieja (se deshecha) si en 2 minutos no fue recibida. Si la
-- señal del proceso 2 no puede ser recibida inmediatamente, entonces espera 1 minuto y
-- vuelve a mandarla (no se deshecha).

PROCEDURE Sistema is
   TASK Central is
      ENTRY RecibirSenal1(senal: IN String);
      ENTRY RecibirSenal2(senal: IN String);
      ENTRY Aviso;
   END Central;

   TASK Proceso1;
   TASK Proceso2;
   
   TASK Timer IS
      ENTRY IniciarTimer;
   END Timer;

   TASK BODY Timer IS
      BEGIN
         LOOP
            ACCEPT IniciarTimer;
            DELAY(180.0); -- 3 minutos
         Central.Aviso;
         END LOOP;
   END Timer;

   

   TASK BODY Proceso1 IS
      senial: String;
   BEGIN
      LOOP
         senial := CrearSenial();
         SELECT
            Central.RecibirSenal1(senial);
         OR DELAY(120.0); -- 2 minutos
            -- Señal vieja, se deshecha
            NULL;
         END SELECT;
      END LOOP;
   END Proceso1;

   TASK BODY Proceso2 IS
      senial: String;
   BEGIN
      senial := CrearSenial();
      LOOP
         SELECT
            Central.RecibirSenal2(senial);
            senial := CrearSenial();
         ELSE
            DELAY(60.0); -- 1 minuto
            -- Espera 1 minuto y vuelve a mandar la señal
         END SELECT;
      END LOOP;
   END Proceso2;

   TASK BODY Central IS
      fin: boolean
   BEGIN
      ACCEPT RecibirSenal1(senal: IN String) DO
      LOOP
         SELECT
            ACCEPT RecibirSenal1(senal: IN String) DO
               -- Procesar señal del proceso 1
            END RecibirSenal1;
         OR
            ACCEPT RecibirSenal2(senal: IN String) DO
               -- Procesar señal del proceso 2
               Timer.IniciarTimer;
               fin := false;
               WHILE NOT fin LOOP
                  SELECT
                     WHEN (Aviso'Count = 0) => 
                        ACCEPT RecibirSenal2(senal: IN String);
                     OR
                        ACCEPT Aviso DO
                           fin := true;
                        END Aviso;
                  END SELECT;
               END LOOP;
            END RecibirSenal2;
         END SELECT;
      END LOOP;
   END Central;