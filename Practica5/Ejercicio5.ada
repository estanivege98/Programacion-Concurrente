Procedure SistemaUniversitario is
   -- Declaracion de tipos
   task Servidor is
      entry RecibirDocumento(Doc : in String Rta : out boolean);
   end Servidor;

   task type Usuario;
   vecUsuario : array (1 .. U) of Usuario;
   task body usuario is
      Doc : String;
      Rta : boolean;
   begin
      doc := GenerarDocumento();
      Rta := true;
      while (rta) loop
         select
            Servidor.RecibirDocumento(doc, rta);
         if(rta) then
            doc := GenerarDocumento();
         end if;
         or
            delay 120.0;
         delay 60.0;
         end select;
      end loop;
   end usuario;

   task body Servidor is
   begin
      loop
         accept recibirDocumento(doc : in String, rta : out boolean) do
            rta := ProcesarDocumento(doc);
         end recibirDocumento;
      end loop;
   end Servidor;

   begin
      null;
   end SistemaUniversitario;