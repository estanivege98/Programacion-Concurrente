1) La Concurrencia puede encontrarse en las intersecciones de calles, en la concurrencia de empresas y en la informática en usuarios concurrentes de un SO o un servicio.
2) La concurrencia es la capacidad de ejecutar múltiples actividades en paralelo o simultáneamente, permitiendo a distintos objetos actual al mismo tiempo. 
   En el procesamiento secuencial, se hacen la tareas de a una a la vez, hasta no terminar una no se puede comenzar con la siguiente, esta solución nos fuerza a establecer un estricto orden temporal.
   Por otro lado en la solución concurrente no paralela se dedica una del tiempo a cada tarea, aprovechando tiempos ociosos en la realización de cada uno de ellas =>Concurrencia sin paralelismo de hardware.
   Si es paralela todos los cores trabajan al mismo tiempo haciendo cada uno una única tarea => Concurrencia con paralelismo de hardware. Sigue siendo concurrente, pero además es paralelo.
3) El deadlock significa que dos (o más) procesos se quedan esperando que el otro libere un recurso compartido. Las condiciones o propiedades necesarias para que exista el deadlock son:
	1) Recursos reusables serialmente: los procesos comparten recursos que pueden usar con exclusión mutua.
	2) Adquisición incremental: los procesos mantienen los recursos que poseen mientras esperar adquirir recursos adicionales.
	3) No-preemption: una vez que son adquiridos por un proceso, los recursos no pueden quitarse de manera forzada sino que sólo son liberados voluntariamente.
	4) Espera cíclica: existe una cadena circular (ciclo) de procesos tal que cada uno tiene un recurso que su sucesor en el ciclo está esperando adquirir.
4) La inanición de un proceso significa que no logra acceder a los recursos compartidos. Un ejemplo clásico es el problema del filosofo comedor, donde los filósofos pueden morir de hambre si uno siempre toma los tenedores antes que otro o si se toman por azar, impidiendo que otros obtengan los dos tenedores necesarios para comer.
5) El "no determinismo" se refiere a la falta de un curso de acción o resultado único y predecible, permitiendo múltiples posibilidades. El no-determinismo en la programación concurrente significa que un mismo programa, al ser ejecutado múltiples veces, puede generar diferentes resultados o secuencias de ejecución debido al orden y sincronización variable de los hilos o procesos que se ejecutan simultáneamente.
6) La comunicación entre procesos concurrentes indica el modo en que se organizan y trasmiten datos entre tareas concurrentes. Esta organización requiere especificar protocolos para controlar el progreso y la corrección. Los procesos se comunican mediante pasaje de mensajes o memoria compartida:
	1) Memoria compartida: Los procesos intercambian información sobre la memoria compartida o actúan coordinadamente sobre datos residentes en ella.
	2) Es necesario establecer un canal (lógico o físico) para transmitir información entre procesos.
7) a
	1) Sincronización: es la posesión de información acerca de otro proceso para coordinar actividades. Los procesos se sincronizan:
		1) Sincronización por exclusión mutua: Asegurar que sólo un proceso tenga acceso a un recurso compartido en un instante de tiempo. Si el programa tiene secciones críticas que pueden compartir más de un proceso, la exclusión mutua evita que dos o más procesos puedan encontrarse en la misma sección crítica al mismo tiempo.
		2) Sincronización por condición: Permite bloquear la ejecución de un proceso hasta que se cumpla una condición dada.
	2) Pueden existir mas de un mecanismo de sincronizacion para asegurar la correcta coordinación de las tareas y la integridad de datos. Un ejemplo sería un sistema bancario que usa bloqueos (mutexes) para proteger el saldo de una cuenta de transacciones simultáneas y un semáforo para controlar el acceso a la sala de espera de una sucursal, limitando la cantidad de clientes que pueden estar dentro a la vez.
8) La interferencia significa que un proceso tima una acción que invalida las suposiciones hechas por otro proceso. Para evitar la interferencia en programación concurrente se debe usar mecanismos de sincronización como exclusión mutua (mutexes), semáforos, y barreras, que aseguran que solo un hilo acceda a recursos compartidos a la vez. También se deben evitar los estados mutables compartidos y probar rigurosamente el código, comprendiendo patrones de concurrencia y aplicándolos para coordinar correctamente la ejecución de hilos.
9) Una sentencia de asignación x = e satisface la propiedad de “A lo sumo una vez” si:
	1) e contiene a lo sumo una referencia crítica y x no es referenciada por otro proceso, o
	2) e no contiene referencias críticas, en cuyo caso x puede ser leída por otro proceso.
	Una expresiones e que no está en una sentencia de asignación satisface la propiedad de “A lo sumo una vez” si no contiene más de una referencia crítica. Si una sentencia de asignación cumple la propiedad ASV, entonces su ejecución parece atómica, pues la variable compartida será leída o escrita sólo una vez.
	![[Pasted image 20251001112630.png]]
10) a
	1) En la tercera se cumple porque se accede solamente a una referencia critica. La primera y segunda no cumple porque hace referencia a dos variables criticas o mas.
11) Acciones atómicas incondicionales: se ejecutan sin considerar ninguna condición previa. Siempre se realizan de manera atómica, independientemente de las circunstancias. <X=1>. Condicionales: se ejecutan cuando se cumple con una cierta condición previa. < await S; x=1> o <"await S"> (sin mayúscula).
12) rta
	1) Seguridad (safety): Esta propiedad se refiere a la garantía de que "nada malo le ocurre al proceso" o, en otras palabras, que no se producen estados inconsistentes o resultados incorrectos debido a la ejecución concurrente.
		1) Una falla de seguridad indica que algo anda mal.
		2) Ejemplos: exclusión mutua, ausencia de interferencia entre procesos, partial correctness.
	2) Vida (liveness): Esta propiedad se relaciona con la garantía de que "eventualmente ocurre algo bueno con una actividad". Se enfoca en asegurarse de que los procesos no queden bloqueados (deadlocks) y que las actividades puedan avanzar y completarse.
		1) Una falla de vida indica que las cosas se dejan de ejecutar.
		2) Ejemplos: terminación, asegurar que un pedido de servicio será atendido, que un mensaje llega a destino, que un proceso eventualmente alcanzara su SC, etc. => Dependen de las políticas de scheduling.
13) Una política de scheduling se refiere a un conjunto de reglas y algoritmos utilizados
	para determinar cuál será el próximo proceso o hilo que se ejecutará en un sistema
	concurrente o en un sistema operativo. Cuando se habla de ejecutar el próximo
	proceso o hilo, se esta hablando de ejecutar las acciones atómicas de dicho proceso.
	
	Fairness se relaciona con la equidad en la ejecución de procesos o hilos en un sistema
	concurrente. Se esfuerza por garantizar que todos los procesos tengan la oportunidad
	de avanzar y realizar sus operaciones, evitando situaciones de bloqueo o inanición.
	
	Fairness trata de garantizar que los procesos tengan chance de avanzar, sin importar lo
	que hagan los demás, es decir, que se ejecuten acciones atómicas de todos lo procesos.
	
	Tipos de Fairness:
	Fairness Incondicional. Una política de scheduling es incondicionalmente fair si toda
	acción atómica incondicional que es elegible eventualmente es ejecutada.
	
	Fairness Débil. Una política de scheduling es débilmente fair si es incondicionalmente
	fair y toda acción atómica condicional que se vuelve elegible eventualmente es
	ejecutada si su guarda se convierte en true y de allí en adelante permanece true.
	
	Fairness Fuerte. Una política de scheduling es fuertemente fair si es
	incondicionalmente fair y toda acción atómica condicional que se vuelve elegible
	eventualmente es ejecutada si su guarda es true con infinita frecuencia.
	
	Fairness incondicional: significa que todas las tareas que están listas para ejecutarse
	eventualmente se ejecutan, sin importar si son condicionales o no.
	
	Fairness débil: significa que además de la fairness incondicional, las tareas
	condicionales que se vuelven elegibles se ejecutan, siempre y cuando su condición se
	mantenga verdadera hasta que la tarea sea asignada.
	
	Fairness fuerte: significa que además de la fairness incondicional, las tareas
	condicionales que se vuelven elegibles se ejecutan, incluso si su condición cambia de
	valor muchas veces.
17) Algoritmo Tie-Breaker (2 procesos): protocolo de SC que requiere scheduling sólo
débilmente fair y no usa instrucciones especiales  más complejo para n procesos.
Usa una variable por cada proceso para indicar que el proceso comenzó a ejecutar su
protocolo de entrada a la sección crítica, y una variable adicional para romper empates,
indicando qué proceso fue el último en comenzar dicha entrada.
Demora (quita prioridad) al último en comenzar su entry protocol.

Algoritmo Ticket: se reparten números y se espera a que sea el turno.
Los procesos toman un número mayor que el de cualquier otro que espera ser atendido;
luego esperan hasta que todos los procesos con número más chico han sido atendidos.