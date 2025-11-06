--Se quiere modelar el funcionamiento de un banco, al cual llegan clientes que deben realizar
--un pago y retirar un comprobante. Existe un único empleado en el banco, el cual atiende de
--acuerdo con el orden de llegada.
--a) Implemente una solución donde los clientes llegan y se retiran sólo después de haber sido
--atendidos.
--b) Implemente una solución donde los clientes se retiran si esperan más de 10 minutos para
--realizar el pago.
--c) Implemente una solución donde los clientes se retiran si no son atendidos
--inmediatamente.
--d) Implemente una solución donde los clientes esperan a lo sumo 10 minutos para ser
--atendidos. Si pasado ese lapso no fueron atendidos, entonces solicitan atención una vez más
--y se retiran si no son atendidos inmediatamente.

-- INCISO A

Procedure BancoA is
   TASK TYPE Cliente;
   ClienteArray: array (1..N) of Cliente;

   Task Empleado is
      entry llegada(datos: IN String, resultado OUT String);
   end Empleado;

   task body Cliente is
      datos: String;
      resultado: String;

   begin
      Empleado.llegada(datos, resultado);
   end Cliente;

   Task body Empleado is
      datos: String;
      resultado: String;
      for:1..N loop
         accept llegada(datos: IN String, resultado OUT String) do
            resultado:= resolverPago(datos);
         end llegada;
      end loop;
      end Empleado;

begin
   null;
end BancoA;

-- INCISO B

Procedure BancoB is
   TASK TYPE Cliente;
   ClienteArray: array (1..N) of Cliente;

   Task Empleado is
      entry llegada(datos: IN String, resultado OUT String);
   end Empleado;

   task body Cliente is
      datos: String;
      resultado: String;

   begin
      select
         Empleado.llegada(datos, resultado);
      or
         delay 600.0; -- 10 minutos
         null; -- Se retira sin ser atendido
      end select;
   end Cliente;

   Task body Empleado is
      datos: String;
      resultado: String;
      for:1..N loop
         accept llegada(datos: IN String, resultado OUT String) do
            resultado:= resolverPago(datos);
         end llegada;
      end loop;
      end Empleado;
begin
   null;
end BancoB;

-- INCISO C

Procedure BancoC is

   TASK TYPE Cliente;
   ClienteArray: array (1..N) of Cliente;

   Task Empleado is
      entry llegada(datos: IN String, resultado OUT String);
   end Empleado;

   task body Cliente is
      datos: String;
      resultado: String;
   begin
      Select
         Empleado.llegada(datos, resultado);
      else
         null;
      end select;
   end Cliente;

   Task body Empleado is
      datos: String;
      resultado: String;
      for:1..N loop
         accept llegada(datos: IN String, resultado OUT String) do
            resultado:= resolverPago(datos);
         end llegada;
      end loop;
      end Empleado;
begin
   null;
end BancoC;

-- INCISO D

Procedure BancoD is

   TASK TYPE Cliente;
   ClienteArray: array (1..N) of Cliente;

   Task Empleado is
      entry llegada(datos: IN String, resultado OUT String);
   end Empleado;

   task body Cliente is
      datos: String;
      resultado: String;
   begin
      select
         Empleado.llegada(datos, resultado);
      or
         delay 600.0; -- 10 minutos
         select
            Empleado.llegada(datos, resultado);
         else
            null; -- Se retira sin ser atendido
         end select;
      end select;
   end Cliente;

   Task body Empleado is
      datos: String;
      resultado: String;
      for:1..N loop
         accept llegada(datos: IN String, resultado OUT String) do
            resultado:= resolverPago(datos);
         end llegada;
      end loop;
      end Empleado;
   