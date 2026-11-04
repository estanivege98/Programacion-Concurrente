PROCEDURE Clinica IS
   TASK TYPE Persona;
   PersonaArray: ARRAY (1..P) OF Persona;

   TASK TYPE Enfermera;
   EnfermeraArray: ARRAY (1..E) OF Enfermera;

   TASK Doctor IS
      ENTRY RecibirPedidoE(pedido: IN String);
      ENTRY RecibirPedidoP(pedido: IN String);
   END Doctor;

   TASK Escritorio IS
      ENTRY DejarNota(nota: IN String);
      ENTRY RevisarNota(nota: IN OUT String);
   END Escritorio;

   TASK BODY Persona IS
      pedido: String;
      cantIntentos: Integer := 0;
      continuar: Boolean := True;
   BEGIN
      pedido := GenerarPedido();
      WHILE ((cantIntentos < 3) AND (continuar)) LOOP
         SELECT
            Doctor.RecibirPedidoP(pedido);
            continuar := False;
         OR DELAY 300.0;
            cantIntentos := cantIntentos + 1;
            IF (cantIntentos < 3) THEN DELAY 600.0; END IF;
         END SELECT;
      END LOOP;
   END Persona;

   TASK BODY Enfermera IS
      pedido: String;
   BEGIN
      LOOP
         pedido := GenerarPedido();
         SELECT
            Doctor.RecibirPedidoE(pedido);
         ELSE 
            Escritorio.DejarNota(pedido);
         END SELECT;
      END LOOP;
   END Enfermera;

   TASK BODY Escritorio IS
      pedidos: Cola;
   BEGIN
      LOOP
         SELECT
            ACCEPT DejarNota(nota: IN String) DO
               pedidos.Encolar(nota);
            END DejarNota;
         OR
            WHEN(not pedidos.Vacia) => ACCEPT RevisarNota(nota: IN OUT String) DO
               nota := pedidos.Desencolar();
            END RevisarNota;
         END SELECT;
      END LOOP;
   END Escritorio;

   TASK BODY Doctor IS
   trabajo, nota, pedidoE: String;
BEGIN
   LOOP
      SELECT
         ACCEPT RecibirPedidoP(pedido: IN String) DO
            trabajo := AtenderCliente(pedido);
         END RecibirPedidoP;
      OR
         WHEN (RecibirPedidoP'Count = 0) =>
            ACCEPT RecibirPedidoE(pedido: IN String) DO
               pedidoE := pedido;
            END RecibirPedidoE;
            trabajo := AtenderEnfermera(pedidoE);
      ELSE
         SELECT
            Escritorio.RevisarNota(nota);
            trabajo := ProcesarNotaEsc(nota);
         ELSE
            NULL;
         END SELECT;
      END SELECT;
   END LOOP;
END Doctor;
