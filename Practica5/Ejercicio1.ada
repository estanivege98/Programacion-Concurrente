--Se requiere modelar un puente de un único sentido que soporta hasta 5 unidades de peso.
--El peso de los vehículos depende del tipo: cada auto pesa 1 unidad, cada camioneta pesa 2
--unidades y cada camión 3 unidades. Suponga que hay una cantidad innumerable de
--vehículos (A autos, B camionetas y C camiones). Analice el problema y defina qué tareas,
--recursos y sincronizaciones serán necesarios/convenientes para resolverlo.

--a. Realice la solución suponiendo que todos los vehículos tienen la misma prioridad.
--b. Modifique la solución para que tengan mayor prioridad los camiones que el resto de los
--vehículos

-- INCISO A

Procedure PuenteMismaPrioridad is

TASK Acceso is
   ENTRY AccesoAuto;
   ENTRY AccesoCamioneta;
   ENTRY AccesoCamion;
   ENTRY Salida(Peso : Integer);
END Acceso;

TASK TYPE Auto;
autoyArray: array (1..A) of Auto;

TASK BODY Auto is
BEGIN
   Acceso.AccesoAuto;
   Acceso.Salida(1);
END Auto;

TASK TYPE Camioneta;
camionetayArray: array (1..B) of Camioneta;

TASK BODY Camioneta is
BEGIN
   Acceso.AccesoCamioneta;
   Acceso.Salida(2);
END Camioneta;

TASK TYPE Camion;
camionyArray: array (1..C) of Camion;

TASK BODY Camion is
BEGIN
   Acceso.AccesoCamion;
   Acceso.Salida(3);
END Camion;

TASK BODY Acceso is
   PesoActual : Integer := 0;
BEGIN
   LOOP
      select
         when PesoActual + 1 <= 5 =>
            ACCEPT AccesoAuto do
               PesoActual := PesoActual + 1;
            end AccesoAuto;
      or
         when PesoActual + 2 <= 5 =>
            ACCEPT AccesoCamioneta do
               PesoActual := PesoActual + 2;
            end AccesoCamioneta;
      or
         when PesoActual + 3 <= 5 =>
            ACCEPT AccesoCamion do
               PesoActual := PesoActual + 3;
            end AccesoCamion;
      
      or
      ACCEPT Salida(Peso : Integer) do
         PesoActual := PesoActual - Peso;
         END Salida;
      END SELECT;
   END LOOP;
END Acceso;

BEGIN
   null;
END PuenteMismaPrioridad;

-- INCISO B
Procedure PuentePrioridadCamiones is

TASK Acceso is
   ENTRY AccesoAuto;
   ENTRY AccesoCamioneta;
   ENTRY AccesoCamion;
   ENTRY Salida(Peso : Integer);
END Acceso;

TASK TYPE Auto;
autoyArray: array (1..A) of Auto;

TASK BODY Auto is
BEGIN
   Acceso.AccesoAuto;
   Acceso.Salida(1);
END Auto;

TASK TYPE Camioneta;
camionetayArray: array (1..B) of Camioneta;

TASK BODY Camioneta is
BEGIN
   Acceso.AccesoCamioneta;
   Acceso.Salida(2);
END Camioneta;

TASK TYPE Camion;
camionyArray: array (1..C) of Camion;

TASK BODY Camion is
BEGIN
   Acceso.AccesoCamion;
   Acceso.Salida(3);
END Camion;

TASK BODY Acceso is
   PesoActual : Integer := 0;
BEGIN
   LOOP
      select
         when (PesoActual + 1 <= 5) && (AccesoCamion count = 0) =>
            ACCEPT AccesoAuto do PesoActual := PesoActual + 1;
            end AccesoAuto;
      or
         when (PesoActual + 2 <= 5) && (AccesoCamion count = 0) =>
            ACCEPT AccesoCamioneta do
               PesoActual := PesoActual + 2;
            end AccesoCamioneta;
      or
         when (PesoActual + 3 <= 5) =>
            ACCEPT AccesoCamion do
               PesoActual := PesoActual + 3;
            end AccesoCamion;
      
      or
      ACCEPT Salida(Peso : Integer) do
         PesoActual := PesoActual - Peso;
         END Salida;
      END SELECT;
   END LOOP;
END Acceso;

BEGIN
   null;
END PuentePrioridadCamiones;