-- Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar
-- un pago y retirar un comprobante. Existe un único empleado en el banco, el cual atiende de
-- acuerdo con el orden de llegada.
-- a) Implemente una solución donde los clientes llegan y se retiran sólo después de haber sido atendidos.
-- b) Implemente una solución donde los clientes se retiran si esperan más de 10 minutos para realizar el pago.
-- c) Implemente una solución donde los clientes se retiran si no son atendidos inmediatamente.
-- d) Implemente una solución donde los clientes esperan a lo sumo 10 minutos para seratendidos. Si pasado ese lapso no fueron atendidos, 
-- entonces solicitan atención una vez más y se retiran si no son atendidos inmediatamente.

-- INCISO A
PROCEDURE BancoA IS
   TASK TYPE Cliente;
   
   ClienteArray: ARRAY (1..N) OF Cliente;

   TASK Empleado IS
      ENTRY llegada(datos: IN String, resultado OUT String);
   END Empleado;

   TASK BODY Cliente IS
      datos: String;
      resultado: String;
   
   BEGIN
      Empleado.llegada(datos, resultado);
   END Cliente;

   TASK BODY Empleado IS
      FOR i IN 1..N LOOP
         ACCEPT llegada(datos: in String, resultado OUT String) DO
            resultado := resolverPago(datos);
         END llegada;
      END LOOP;
   END Empleado;
BEGIN
   NULL;
END BancoA;

-- INCISO B
PROCEDURE BancoB IS
   TASK TYPE Cliente;
   ClienteArray: ARRAY (1..N) OF Cliente;

   TASK Empleado IS
      ENTRY llegada(datos: IN String, resultado OUT String);
   END Empleado;

    TASK BODY Cliente IS
      datos: String;
      resultado: String;
   
   BEGIN
      SELECT 
         Empleado.llegada(datos, resultado);
      OR DELAY 10 MINUTES;
         -- Cliente se retira si espera más de 10 minutos
         NULL;
      END SELECT;
   END Cliente;

   TASK BODY Empleado IS
      FOR i IN 1..N LOOP
         ACCEPT llegada(datos: in String, resultado OUT String) DO
            resultado := resolverPago(datos);
         END llegada;
      END LOOP;
   END Empleado;
BEGIN
   NULL;
END BancoB;

-- INCISO C
PROCEDURE BancoC IS
   TASK TYPE Cliente;
   ClienteArray: ARRAY (1..N) OF Cliente;
   
   TASK Empleado IS
      ENTRY llegada(datos: IN String, resultado OUT String);
   END Empleado;

   TASK BODY Cliente IS
      datos: String;
      resultado: String;
   BEGIN
      SELECT
         Empleado.llegada(datos, resultado);
      OR
         -- Cliente se retira si no es atendido inmediatamente
         NULL;
      END SELECT;
   END Cliente;

   TASK BODY Empleado IS
      FOR i IN 1..N LOOP
         ACCEPT llegada(datos: in String, resultado OUT String) DO
            resultado := resolverPago(datos);
         END llegada;
      END LOOP;
   END Empleado;
BEGIN
   NULL;
END BancoC;

-- INCISO D
PROCEDURE BancoD IS
   TASK TYPE Cliente;
   ClienteArray: ARRAY (1..N) OF Cliente;

   TASK Empleado IS
      ENTRY llegada(datos: IN String, resultado OUT String);
   END Empleado;

   TASK BODY Cliente IS
      datos: String;
      resultado: String;
   BEGIN
      SELECT
         Empleado.llegada(datos, resultado);
      OR DELAY 10 MINUTES;
         -- Cliente solicita atención una vez más
         SELECT
            Empleado.llegada(datos, resultado);
         OR
            -- Cliente se retira si no es atendido inmediatamente
            NULL;
         END SELECT;
      END SELECT;
   END Cliente;

   TASK BODY Empleado IS
      FOR i IN 1..N LOOP
         ACCEPT llegada(datos: in String, resultado OUT String) DO
            resultado := resolverPago(datos);
         END llegada;
      END LOOP;
   END Empleado;
BEGIN
   NULL;
END BancoD;