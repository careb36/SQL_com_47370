USE montevideo_noticias;

DELIMITER //

CREATE PROCEDURE OrdenarArticulos(
    IN ordenCampo VARCHAR(50), -- Campo por el que se ordenarán los articulos
    IN ordenDireccion VARCHAR(4) -- Dirección del orden (ASC o DESC)
)
BEGIN
    SET @query = CONCAT('SELECT * FROM articulos ORDER BY ', ordenCampo, ' ', ordenDireccion);
    PREPARE dynamic_query FROM @query;
    EXECUTE dynamic_query;
    DEALLOCATE PREPARE dynamic_query;
END //

DELIMITER ;

-- Descomentar para testear llamadas al SP:
-- CALL OrdenarArticulos('fecha_publicacion', 'ASC');
-- CALL OrdenarArticulos('fecha_publicacion', 'DESC');
-- CALL OrdenarArticulos('creado_en', 'ASC');
-- CALL OrdenarArticulos('creado_en', 'DESC');
-- CALL OrdenarArticulos('autor_id', 'ASC');
-- CALL OrdenarArticulos('autor_id', 'DESC');

DELIMITER //

CREATE PROCEDURE InsertarEliminarArticulo(
    IN accion INT, -- 1 para insertar, 2 para eliminar
    IN tituloArt VARCHAR(255), -- Título del artículo (para inserción)
    IN cuerpoArt TEXT, -- Cuerpo del artículo (para inserción)
    IN autorID INT, -- ID del autor (para inserción)
    IN categoriaID INT, -- ID de la categoría (para inserción)
    IN resumenArt TEXT, -- Resumen del artículo (para inserción)
    IN estadoArt ENUM('publicado', 'borrador'), -- Estado de publicación (para inserción)
    IN imagenArt VARCHAR(255), -- URL de la imagen (para inserción)
    IN articuloID INT -- ID del artículo (para eliminación)
)
BEGIN
    IF accion = 1 THEN
        -- Insertar un nuevo artículo
        INSERT INTO articulos (titulo, cuerpo, autor_id, categoria_id, resumen, fecha_publicacion, estado_publicacion, imagen, creado_en, actualizado_en)
        VALUES (tituloArt, cuerpoArt, autorID, categoriaID, resumenArt, NOW(), estadoArt, imagenArt, NOW(), NOW());
    ELSEIF accion = 2 THEN
        -- Eliminar un artículo por ID
        DELETE FROM articulos WHERE id = articuloID;
    ELSE
        -- Acción no válida
        SELECT 'Acción no válida. Usar 1 para insertar o 2 para eliminar.';
    END IF;
END //

DELIMITER ;

-- Llamada al procedimiento para insertar un nuevo artículo
CALL InsertarEliminarArticulo(1, 'UNA MÁS A LA LISTA', 'Este jueves, la vela tuvo una nueva jornada de actividad en los Juegos Panamericanos de Santiago de Chile 2023 en la Cofradía Náutica del Pacífico, en las aguas de Valparaíso. Dolores Moreira compitió en la clase Ilca 6, ex láser radial, y gracias a su gran actuación aseguró su clasificación a los Juegos Olímpicos de Paris 2024.

La uruguaya fue cuarta y segunda en las dos regatas del día de hoy y se ubica en la cuarta colocación de la general con 36 puntos, por lo que se clasificó a la medal race, en la que competirá por la medalla de bronce, debido a que ya no cuenta con posibilidades de alcanzar el oro o la plata.

Había dos cupos para los países de Centro y Sudamérica a los Juegos Olímpicos, sin contar a Argentina, que ya estaba clasificada. En la medal race estarán las embarcaciones de Estados Unidos, Canadá, Argentina, Uruguay y Perú, por lo que la sanducera ya consiguió el cupo a la cita máxima del deporte. 

De esta manera, la clase Ilca 6 de vela se suma a la clase 49er, al rugby seven, al ciclismo masculino en la prueba de ruta (un cupo) y al maratón de atletismo (un cupo) como los deportes ya clasificados que representarán a Uruguay en Paris 2024.

FútbolUy. Seguinos en Twitter @futbolportaluy', 1, 2, 'Panamericanos: Dolores Moreira logró la clasificación a los Juegos Olímpicos en vela', 'publicado', 'https://imagenes.montevideo.com.uy/imgnoticias/202310/_W933_80/860875.jpg');

CALL OrdenarArticulos('fecha_publicacion', 'DESC'); -- Llamada al SP para visualizar los articulos y verificar cual eliminar
CALL InsertarEliminarArticulo(2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 10); -- Llamada al procedimiento para eliminar un artículo por su numero de id
CALL OrdenarArticulos('fecha_publicacion', 'DESC'); -- Llamada al SP para visualizar los articulos y verificar el que acabamos de eliminar