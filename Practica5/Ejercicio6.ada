Procedure Playa is

   task Administrador is
      entry CalcularGanador(idEquipo: in integer; monto: in integer);
      entry IdentificarGanador(ganador: out integer);
   end Administrador;

   task type equipo is
      entry Ident(id: in integer);
      entry Llegada;
      entry Comenzar;
      entry SumarMonedas(monto: in integer);
   end equipo;
   vecEquipos : array (1 .. 5) of equipo;
   task body equipo is
      montoTotal : integer := 0;
      idEquipo : integer;
   begin
      accept Ident(id: in integer) do
         idEquipo := id;
      end Ident;
      for i in 1 .. 4 loop
         accept llegada;
      end loop;
      for i in 1 .. 4 loop
         accept Comenzar;
      end loop;
      for i in 1 .. 4 loop
         accept SumarMonedas(monto: in integer) do
            montoTotal := montoTotal + monto;
         end SumarMonedas;
      end loop;
      Administrador.CalcularGanador(idEquipo, montoTotal);
   end equipo;

   task type Persona;
   vecPersonas : array (1 .. 20) of Persona;
   task body Persona is
      idEquipo : integer := obtenerIdEquipo();
      monto: integer := 0;
      equipoGanador : integer;
   begin
      vecEquipos(idEquipo).Llegada;
      vecEquipos(idEquipo).Comenzar;
      for i in 1 .. 15 loop
         monto := monto + obtenerMonedas();
      end loop;
      vecEquipos(idEquipo).SumarMonedas(monto);
      Administrador.IdentificarGanador(equipoGanador);
      if (equipoGanador = idEquipo) then
         imprimirMensaje("Felicidades, su equipo ha ganado!");
      else
         imprimirMensaje("Lo sentimos, su equipo no ha ganado.");
      end if;
   end Persona;

   task body Administrador is
      equipoGanador: integer := 0;
      montoMaximo: integer := 0;
   begin
      for i in 1 .. 5 loop
            accept CalcularGanador(idEquipo: in integer; monto: in integer) do
               if (monto > montoMaximo) then
                  montoMaximo := monto;
                  equipoGanador := idEquipo;
               end if;
            end CalcularGanador;
      end loop;
      for i in 1 .. 20 loop
         accept IdentificarGanador(ganador: out integer) do
            ganador := equipoGanador;
         end IdentificarGanador;
      end loop;
   end Administrador;



begin
   for i in 1 .. 5 loop
      vecEquipos(i).Ident(i);
   end loop;
end Playa;
