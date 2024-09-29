Buenas practicas para el parcial:  

- Respetar nombres de atributos y métodos (Mayúsculas / Minúsculas, plurales, etc.)

- Utilizar nombres descriptivos en atributos, variables y parámetros

- Respetar firma de los métodos (Visibilidad, Tipo de dato de retorno, Nombre, Parámetros)

- Redefinir el toString correctamente para imprimir cada clase (POLIMORFISMO)

- Redefinir y sobrecargar el equals para comparar dos objetos de la misma clase (SOBRECARGA)

- Comparación de fechas sumando y restando un dia no es buena practica

- Los métodos deben tener un único retorno

- Las búsquedas de valores únicos se hacen con un While y doble corte de control

- Las búsquedas de múltiples resultados se pueden hacer con for o con while.

- Cortar el for con un BREAK, con un RETURN o actualizar el iterador al ultimo valor es MALA PRACTICA

- Las validaciones de dato van en el SET de la clase

- Las validaciones de elemento repetido van en la clase que contiene a la lista (En el agregar).

- Las comparaciones entre tipos de clase se realizan con EQUALS

- Las comparaciones entre tipos de dato primitivos se realizan con ==.

- Los atributos de las clases son privados, los métodos públicos (aunque pueden haber métodos privados tambien)

- El método traer devuelve NULL si no encuentra (No devuelve una excepción)

- Inicialización de las listas en constructor con ArrayList del tipo de dato de la lista

- El constructor de la clase Sistema no recibe parámetros

- Calculo automático de próximo ID en listas

- Los IDs de las listas que comiencen en 1 en vez de en 0.

- Reutilizar métodos. Ejemplo: calcularSubTotal() : float / calcularTotal() : float

- En los Tests, solo instanciar una clase Sistema, agregar elementos a las listas y buscarlos para utilizarlos.