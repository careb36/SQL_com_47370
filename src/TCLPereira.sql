USE montevideo_noticias;

-- Transacciones

-- Iniciar la transacción
START TRANSACTION;
-- Eliminar registros de la tabla 'articulos' relacionados con 'Política'
DELETE FROM articulos WHERE categoria_id = (SELECT id FROM categorias WHERE nombre = 'Política');
-- Para deshacer los cambios (ejecutar si es necesario revertir la transacción)
-- ROLLBACK;
-- Aplicar los cambios de forma permanente
COMMIT;

-- Iniciar la transacción
START TRANSACTION;
-- Insertar nuevos comentarios en 'comentarios'
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en) VALUES (1, 1, 'Interesante artículo sobre política', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en) VALUES (2, 2, 'Muy buen artículo', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en) VALUES (3, 3, 'Excelente artículo', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en) VALUES (4, 4, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
-- Crear un savepoint después del cuarto comentario
SAVEPOINT SP1;
-- Insertar los comentarios restantes
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en) VALUES (5, 5, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en) VALUES (6, 6, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en) VALUES (7, 7, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en) VALUES (8, 8, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
-- Crear un savepoint
SAVEPOINT SP2;
-- Eliminar el savepoint de los primeros 4 comentarios
-- ROLLBACK TO SAVEPOINT SP1;
-- Finalizar la transacción aplicar cambios de forma permanente
COMMIT;