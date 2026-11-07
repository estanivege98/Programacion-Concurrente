--Una empresa de limpieza se encarga de recolectar residuos en una ciudad por medio de 3 camiones. 
--Hay P personas que hacen reclamos continuamente hasta que uno de los camiones pase por su casa. 
--Cada persona hace un reclamo y espera a lo sumo 15 minutos a que llegue un camión; 
-- si no pasa, vuelve a hacer el reclamo y a esperar a lo sumo 15 minutos a que llegue un camión; 
--y así sucesivamente hasta que el camión llegue y recolecte los residuos. 
-- Sólo cuando un camión llega, es cuando deja de hacer reclamos y se retira. 
--Cuando un camión está libre la empresa lo envía a la casa de la persona que más reclamos ha hecho sin ser atendido. 
--Nota: maximizar la concurrencia.

Procedure Limpieza
   Task Empresa is
      Entry RecibirReclamo(id: in Integer);
      Entry AtenderReclamo(id: in Integer);
   End Empresa;

   Task type Persona is
      entry LlegoCamion;
   End Persona;
   vecPersonas : Array (1 .. P) of Persona;

   task type Camion is
      entry Llegar(id: in Integer);
   End Camion;
   vecCamiones : Array (1 .. 3) of Camion;

   Task Body Persona is
      id: Integer := ObtenerID();
      seguir : Boolean := True;
   Begin
      while (seguir) loop
         Empresa.RecibirReclamo(id);
         Select
            Accept LlegoCamion;
            seguir := False;
         or Delay(900.0); -- 15 minutos en segundos
            -- Si no llega el camión, vuelve a hacer el reclamo
            null;
         end Select;
      end loop;
   End Persona;

   Task Body Camion is
      idPersona: Integer;
   Begin
      loop
         Empresa.AtenderReclamo(idPersona);
         vecPersonas(idPersona).LlegoCamion;
      end loop;
   End Camion;

   Task Body Empresa is
      vecReclamos : Array (1 .. P) of Integer;
      idPersona: Integer;
      maxReclamos: Integer;
      cantReclamos: Integer;
   Begin
      

      
