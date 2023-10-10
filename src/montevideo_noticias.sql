-- Crear la base de datos Montevideo Noticias
CREATE DATABASE montevideo_noticias;
USE montevideo_noticias;
-- Crear la tabla de artículos
CREATE TABLE `articulos` (
`id` integer PRIMARY KEY,
`titulo` char,
`cuerpo` text,
`autor_id` integer,
`categoria_id` integer,
`creado_en` timestamp,
`actualizado_en` timestamp,
`imagen` varchar(255)
);

-- Crear la tabla de autores
CREATE TABLE `autores` (
`id` integer PRIMARY KEY,
`nombre` char,
`email` char,
`creado_en` timestamp,
`actualizado_en` timestamp
);
-- Crear la tabla de categorías
CREATE TABLE `categorias` (
`id` integer PRIMARY KEY,
`nombre` char,
`creado_en` timestamp,
`actualizado_en` timestamp
);

-- Crear la tabla de comentarios
CREATE TABLE `comentarios` (
`id` integer PRIMARY KEY,
`articulo_id` integer,
`autor_id` integer,
`cuerpo` text,
`creado_en` timestamp,
`actualizado_en` timestamp
);
-- Crear la tabla de votos
CREATE TABLE `votos` (
`id` integer PRIMARY KEY,
`articulo_id` integer,
`autor_id` integer,
`voto` integer,
`creado_en` timestamp,
`actualizado_en` timestamp
);

-- Agregar restricciones de clave foránea
ALTER TABLE `articulos` ADD FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`);
ALTER TABLE `articulos` ADD FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`);
ALTER TABLE `comentarios` ADD FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`);
ALTER TABLE `comentarios` ADD FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`);
ALTER TABLE `votos` ADD FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`);
ALTER TABLE `votos` ADD FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`);