-- Inciso A

Procedure PuenteMismaPrioridad is 

TASK Puente is
    ENTRY AccesoAuto;
    ENTRY AccesoCamioneta;
    ENTRY AccesoCamion;
    ENTRY Salida(p: integer);
END Acceso;

TASK TYPE Auto;
autoyArray: array (1..A) of Auto;

TASK BODY Auto is
BEGIN
    Puente.AccesoAuto;
    Puente.Salida(1)
END Auto;

TASK TYPE Camioneta;
camionetaArray: array (1..B) of Camioneta;

TASK BODY Camioneta is
BEGIN
    Puente.AccesoCamioneta;
    Puente.Salida(2)
END Camioneta;

TASK TYPE Camion;
camionArray: array (1..C) of Camion;

TASK BODY Camion is
BEGIN
    Puente.AccesoCamion()
    Puente.Salida(3)
END Camion;

TASK BODY Puente is
pesoAct: integer := 0;
BEGIN
    LOOP
        SELECT
            WHEN pesoAct + 1 <= 5 => ACCEPT AccesoAuto do
                pesoAct := pesoAct + 1;
            END AccesoAuto;
        OR
            WHEN pesoAct + 2 <= 5 => ACCEPT AccesoCamioneta do
                pesoAct := pesoAct + 2;
            END AccesoCamioneta;
        OR
            WHEN pesoAct + 3 <= 5 => ACCEPT AccesoCamion do
                pesoAct := pesoAct + 3;
            END AccesoCamioneta;
        OR
            ACCEPT Salida(peso : integer) do
                pesoAct := pesoAct - peso;
            END Salida;
        END SELECT;
    END LOOP;
END Puente;

BEGIN 
    null;
END PuenteMismaPrioridad;

-- Inciso B
Procedure PuentePrioridadCamiones is
TASK Puente is
    ENTRY AccesoAuto;
    ENTRY AccesoCamioneta;
    ENTRY AccesoCamion;
    ENTRY Salida(p: integer);
END Acceso;

TASK TYPE Auto;
autoyArray: array (1..A) of Auto;

TASK BODY Auto is
BEGIN
    Puente.AccesoAuto;
    Puente.Salida(1)
END Auto;

TASK TYPE Camioneta;
camionetaArray: array (1..B) of Camioneta;

TASK BODY Camioneta is
BEGIN
    Puente.AccesoCamioneta;
    Puente.Salida(2);
END Camioneta;

TASK TYPE Camion;
camionArray: array (1..C) of Camion;

TASK BODY Camion is
BEGIN
    Puente.AccesoCamion()
    Puente.Salida(3)
END Camion;

TASK BODY Puente is
pesoAct: integer := 0;
BEGIN
      LOOP
         SELECT
            WHEN (pesoAct + 1 <= 5) AND (AccesoCamion'Count = 0) => ACCEPT AccesoAuto do
               pesoAct := pesoAct + 1;
            END AccesoAuto;
            OR
            WHEN (pesoAct + 2 <= 5) AND (AccesoCamion'Count = 0) => ACCEPT AccesoCamioneta do
               pesoAct := pesoAct + 2;
            END AccesoCamioneta;
            OR
            WHEN (pesoAct + 3 <= 5) => ACCEPT AccesoCamion do
               pesoAct := pesoAct + 3;
            END AccesoCamion;
            OR
            ACCEPT Salida(peso : integer) do
               pesoAct := pesoAct - peso;
            END Salida;
         END SELECT;
      END LOOP;
END Puente;

BEGIN 
    null;
END PuentePrioridadCamiones;
