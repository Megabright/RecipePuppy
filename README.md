
Este es el resultado de la prueba RecipePuppy.


He querido poner el foco en la arquitectura creando un modelo de datos para conseguir robustez y escalabilidad:

  - He mapeado el json devuelto por la API en estructuras de Swift
  - También he creado una estructura para las peticiones a la API
  - Las peticiones HTTP estan encapsuladas en su propio controlador
  
  
He implementado dos requisitos opcionales:

  - Paginado
  - Vista de detalle
  
  
No he querido ir más allá con los requisitos opcionales por no alargar el proceso. Cosas por hacer:

  - Buscar ingredientes
  - Introducir validación de datos
  - Pruebas de unidad
