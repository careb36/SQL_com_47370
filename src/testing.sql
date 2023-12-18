-- Llamar al procedimiento almacenado para realizar la actualización inicial
CALL ActualizarHechoArticulos();

-- Descomentar para visualizar las siguientes tablas

-- visualizar la tabla de hechos
SELECT *
FROM hecho_articulos;

-- Visualizar todas las tablas principales
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
