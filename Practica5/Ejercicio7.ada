--Se debe calcular el valor promedio de un vector de 1 millón de números enteros que se
--encuentra distribuido entre 10 procesos Worker (es decir, cada Worker tiene un vector de
--100 mil números). Para ello, existe un Coordinador que determina el momento en que se
--debe realizar el cálculo de este promedio y que, además, se queda con el resultado. Nota:
--maximizar la concurrencia; este cálculo se hace una sola vez.

TASK type Worker;
vecWorkers : Array (1 .. 10) of Worker;

TASK TYPE Coordinador is
   ENTRY ComenzarCalculo;
   ENTRY ObtenerPromedio(resultado: OUT integer);
END Coordinador;

task body worker is
   vecNumeros : Array (1 .. 100000) of integer := InicializarVector();
   promedio : integer := 0;
begin
   Coordinador.ComenzarCalculo;
   for i in 1 .. 100000 loop
      promedio := promedio + vecNumeros(i);
   end loop;
   Coordinador.ObtenerPromedio(promedio);
end worker;

task body coordinador is
   vecWorkers : Array (1 .. 10) of Worker;
   promedioTotal : integer := 0;
   cantTotal : integer := 0;
begin
   
   for i in 1 .. 10 loop
      accept ComenzarCalculo;
   end loop;
   for i in 1 .. 10 loop
      accept ObtenerPromedio(resultado: out integer) do
         cantTotal := cantTotal + resultado;
      end ObtenerPromedio;
   end loop;
   promedioTotal := cantTotal / 1000000;
   imprimirPromedio(promedioTotal);
end coordinador;