###isKindOfClass métodos alternativos
Hacer un cast con as? y sino lanzar un error

###¿Dónde guardarías los datos en local?
En la carpeta Documents de la App

###¿Cómo persistir la propiedad isFavorite de un libro?
Por orden de sencillez:
    1.- Usando NSUserDefaults
    2.- Modificando el json local y añadiendo una propiedad más a cada libro
    3.- Core Data

###¿Cómo enviar la modificación de la propiedad isFavorite?
Se puede usar cualquier método de envio de mensajes:
    1.- Notificaciones
    2.- Delegado
    3.- KVO
    4.- Target/Action
Dentro de estas he decidido usar nofiticaciones ya que necesito enviar este evento a varios objetos a la vez.

###¿reloadData si o no?
Desde el punto de vista de rendimiento en la mayoría de casos no existe diferencia ya que no se recarga toda la tabla sino aquella parte de la tabla visible. Hay otros métodos como reloadSections y reloadRowAtIndex pero tienen animaciones y consumen mas recursos. La otra opción es recibir una notificación en la celda y actualizar los datos manualmente. En este caso he usado ambos métodos ya que reloadData me facilita el echo de añadir/borrar la sección de favoritos y para actualizar las celdas utilizo notificaciones.

###¿AGTSimplePDFViewController actualización?
He usado notificaciones para actualizar su contenido.

###¿Qué funcionalidades le añadirías?
    1.- Poder editar las celdas para modificar sus datos, título, etc.
    2.- Busqueda en la tabla
    3.- Edición y visualización del pdf de forma nativa por ejemplo con PSPDFKit
    4.- Posibilidad de compartir anotaciones con otras personas
    5.- Integración con iCloud o otro cloud de terceros(Parse, AWS, AZure...)
    6.- Posibilidad de Gamificar la lectura compartiendo y dando "premios" en base a un porcentaje/velocidad de lectura de un libro.
    7.- Posibilidad de puntuar los libros con algún componente social.


