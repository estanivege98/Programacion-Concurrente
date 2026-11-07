--Hay un sistema de reconocimiento de huellas dactilares de la policía que tiene 8 Servidores
--para realizar el reconocimiento, cada uno de ellos trabajando con una Base de Datos propia;
--a su vez hay un Especialista que utiliza indefinidamente. El sistema funciona de la siguiente
--manera: el Especialista toma una imagen de una huella (TEST) y se la envía a los servidores
--para que cada uno de ellos le devuelva el código y el valor de similitud de la huella que más
--se asemeja a TEST en su BD; al final del procesamiento, el especialista debe conocer el
--código de la huella con mayor valor de similitud entre las devueltas por los 8 servidores.
--Cuando ha terminado de procesar una huella comienza nuevamente todo el ciclo. Nota:
--suponga que existe una función Buscar(test, código, valor) que utiliza cada Servidor donde
--recibe como parámetro de entrada la huella test, y devuelve como parámetros de salida el
--código y el valor de similitud de la huella más parecida a test en la BD correspondiente.
--Maximizar la concurrencia y no generar demora innecesaria.

Task Type Servidor is
   entry identificarServidor(id: in integer);
End Servidor;
vecServidores : Array (1 .. 8) of Servidor;

Task Especialista is
   Entry EnviarHuella(test: out String);
   Entry RecibirResultados(codigo: in String; valor: in Float);
End Especialista;

Task Body Servidor is
   codigo: String;
   valor: Float;
   test: String;
Begin
   loop
      Especialista.EnviarHuella(test: in String);
      BuscarHuella(test, codigo, valor);
      Especialista.RecibirResultados(codigo, valor);
      -----------------
      Especialista.fin();
   end loop;
End Servidor;

Task Body Especialista is
   test: String;
   codigo: String;
   valor: Float;
   codigoMax: String;
   valorMax: Float := -9999.9;
Begin
   loop
      test := TomarImagen();
      for i in 1 .. 16 loop
         
         Select 
            Accept EnviarHuella(test: out String) do
               test := test;
            end EnviarHuella;
         or
            Accept RecibirResultados(codigo: in String; valor: in Float) do
               if (valor > valorMax) then
                  valorMax := valor;
                  codigoMax := codigo;

               end if;
            end RecibirResultados;
         end Select;
         end loop;
         ----------------- Para que una surcursal no vuelva a mandar un resultado de una huella que ya fue procesada, 
         -- se puede implementar un mecanismo de control adicional, como un registro de huellas procesadas, para evitar duplicados. Esto podría implicar almacenar los códigos de huellas ya procesadas y verificar antes de aceptar nuevos resultados.
         for i in 1 .. 8 loop
            Accept fin();
         end loop;
   end loop;
   
End Especialista;

begin
   null;
end;



