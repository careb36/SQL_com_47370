USE montevideo_noticias;

-- ****************************************************************************************************
-- ************************* Consulta de las principales tablas ***************************************
-- ****************************************************************************************************

SELECT *
FROM articulos;

SELECT *
FROM autores;

SELECT *
FROM categorias;

SELECT *
FROM comentarios;

SELECT *
FROM etiquetas;

SELECT *
FROM permisos;

SELECT *
FROM suscriptores;

SELECT *
FROM usuarios;

SELECT *
FROM votos;

-- visualizar la tabla de hechos
SELECT *
FROM hecho_articulos;

-- Llamar al procedimiento almacenado para realizar la actualización inicial de la tabla de hecho_articulos
CALL ActualizarHechoArticulos();

-- Consultar la tabla nuevamente
SELECT *
FROM hecho_articulos;

-- ****************************************************************************************************
-- ************************* Consulta de vistas *******************************************************
-- ****************************************************************************************************

-- artículos más votados ordenados por la suma total de votos
SELECT *
FROM articulos_mas_votados;

-- artículos con más comentarios ordenados por la cantidad total de comentarios
SELECT *
FROM articulos_mas_comentados;

-- autores con más artículos publicados ordenados por la cantidad total de artículos
SELECT *
FROM autores_mas_productivos;

-- noticias más populares ordenadas por la suma total de votos y comentarios
SELECT *
FROM noticias_mas_populares;

-- usuarios con más comentarios ordenados por la cantidad total de comentarios
SELECT *
FROM usuarios_mas_comentadores;

-- ****************************************************************************************************
-- *************************************** FUNCIONES **************************************************
-- ****************************************************************************************************

-- cantidad de comentarios de un artículo
SELECT obtener_cantidad_comentarios(1);

-- obtener la cantidad de votos de un artículo
SELECT obtener_cantidad_votos(1);

-- obtener la calificación promedio de un artículo
SELECT obtener_calificacion_promedio(1);

-- ****************************************************************************************************
-- ******************************** PROCEDIMIENTOS ALMACENADOS ****************************************
-- ****************************************************************************************************

-- ordenar los artículos por título en orden ascendente
CALL OrdenarArticulos('titulo', 'ASC');

-- ordenarlos por fecha de publicación en orden descendente
CALL OrdenarArticulos('fecha_publicacion', 'DESC');


/*
 Supongamos que necesito insertar un nuevo artículo.
 Proporciono detalles como el título, cuerpo, ID del autor,
 ID de la categoría, resumen, estado de publicación e imagen.
 Por ejemplo:
 */

CALL InsertarEliminarArticulo(
        1,
        'Nuevo Artículo sobre Tecnología',
        'Este es el cuerpo del artículo, donde se discuten aspectos relevantes de la tecnología actual.',
        1, -- Suponiendo que el autor con ID 1 existe
        1, -- Suponiendo que la categoría con ID 1 es Tecnología
        'Resumen del artículo sobre tecnología',
        'publicado',
        'url_imagen.jpg',
        NULL
     );

SELECT *
FROM articulos a
WHERE a.autor_id = 1;

/*
Para eliminar un artículo, solo necesito proporcionar el ID del artículo.
Por ejemplo, para eliminar el artículo con ID 5:
 */

SELECT *
FROM articulos a
WHERE a.id = 5;

CALL InsertarEliminarArticulo(
        2,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        NULL,
        5 -- ID del artículo a eliminar
     );

SELECT *
FROM articulos a
WHERE a.id = 5;
-- deberia de estar eliminado

-- ****************************************************************************************************
-- ******************************** TRIGGERS **********************************************************
-- ****************************************************************************************************

/*
INSERT en articulos: Este trigger se activa antes de insertar un nuevo artículo.
Para probarlo, inserto un nuevo artículo en la tabla articulos.
 */
INSERT INTO articulos (titulo, cuerpo, autor_id, categoria_id, resumen, fecha_publicacion, estado_publicacion, imagen)
VALUES ('Prueba de Trigger', 'Contenido de prueba', 1, 1, 'Resumen de prueba', NOW(), 'publicado', 'url_imagen.jpg');

SELECT *
FROM articulos_log
WHERE articulo_id = LAST_INSERT_ID();

/*
Este trigger se activa después de actualizar un artículo existente.
Actualizo un artículo y verifica que el cambio se registre en articulos_log.
 */

UPDATE articulos
SET titulo = 'Título Actualizado x'
WHERE id = 1;

-- Chequeo comentarios_log
SELECT *
FROM articulos_log;

/* Triggers para DELETE en comentarios
    Este trigger se activa antes de eliminar un comentario.
    Elimino un comentario existente y verifico que la acción se registre en comentarios_log.
 */

-- Chequeo que exista id = 1
SELECT *
FROM comentarios
WHERE id = 1;

DELETE
FROM comentarios
WHERE id = 1;

-- Chequeo comentarios_log
SELECT *
FROM comentarios_log;

/*
Trigger AFTER INSERT en comentarios:
Este trigger se activa después de insertar un nuevo comentario.
Inserto un comentario y verifica que se registre en comentarios_log.
*/
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, estado_publicacion)
VALUES (1, 1, 'Nuevo comentario de prueba', 'publicado');

-- Chequeo comentarios_log
SELECT *
FROM comentarios_log;

/* Trigger BEFORE DELETE en votos:
    Este trigger se activa antes de eliminar un voto.
   Elimino un voto existente y verifico que la acción se registre en votos_log.
 */
DELETE
FROM votos
WHERE id = 1;

-- Chequeo comentarios_log
SELECT *
FROM votos_log;

/*
Trigger AFTER INSERT en votos:
Este trigger se activa después de insertar un nuevo voto.
Inserto un voto y verifico que se registre en votos_log.
 */
INSERT INTO votos (articulo_id, autor_id, voto)
VALUES (1, 1, 1);

-- Chequeo comentarios_log
SELECT *
FROM votos_log;