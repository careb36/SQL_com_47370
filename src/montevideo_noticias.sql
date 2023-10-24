-- Crear la base de datos Montevideo Noticias
CREATE DATABASE montevideo_noticias;
USE montevideo_noticias;

-- Crear la tabla de usuarios
CREATE TABLE `usuarios` (
  `id` integer PRIMARY KEY,
  `nombre` char,
  `apellido` char,
  `email` char UNIQUE NOT NULL,
  `fecha_nacimiento` date,
  `pais` char,
  `localidad` char,
  `foto_perfil` varchar(255),
  `creado_en` timestamp NOT NULL,
  `actualizado_en` timestamp NOT NULL
);

-- Crear la tabla de categorías
CREATE TABLE `categorias` (
  `id` integer PRIMARY KEY,
  `nombre` char UNIQUE NOT NULL,
  `descripcion` text,
  `imagen` varchar(255),
  `creado_en` timestamp NOT NULL,
  `actualizado_en` timestamp NOT NULL
);

-- Crear la tabla de autores
CREATE TABLE `autores` (
  `id` integer PRIMARY KEY,
  `nombre` char,
  `apellido` char,
  `biografia` text,
  `redes_sociales` text,
  `email` char UNIQUE NOT NULL,
  `creado_en` timestamp NOT NULL,
  `actualizado_en` timestamp NOT NULL
);

-- Crear la tabla de artículos
CREATE TABLE `articulos` (
  `id` integer PRIMARY KEY,
  `titulo` char,
  `cuerpo` text,
  `autor_id` integer,
  `categoria_id` integer,
  `resumen` text,
  `fecha_publicacion` timestamp,
  `estado_publicacion` char,
  `imagen` varchar(255),
  `creado_en` timestamp NOT NULL,
  `actualizado_en` timestamp NOT NULL,
  FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`),
  FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
);

-- Crear la tabla de comentarios
CREATE TABLE `comentarios` (
  `id` integer PRIMARY KEY,
  `articulo_id` integer,
  `autor_id` integer,
  `cuerpo` text,
  `fecha_publicacion` timestamp,
  `estado_publicacion` char,
  `creado_en` timestamp NOT NULL,
  `actualizado_en` timestamp NOT NULL,
  FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`),
  FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`)
);

-- Crear la tabla de votos
CREATE TABLE `votos` (
  `id` integer PRIMARY KEY,
  `articulo_id` integer,
  `autor_id` integer,
  `voto` tinyint UNSIGNED,
  `fecha_voto` timestamp,
  `creado_en` timestamp NOT NULL,
  `actualizado_en` timestamp NOT NULL,
  FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`),
  FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`)
);

-- Crear la tabla de etiquetas
CREATE TABLE `etiquetas` (
  `id` integer PRIMARY KEY,
  `nombre` char UNIQUE NOT NULL,
  `creado_en` timestamp NOT NULL,
  `actualizado_en` timestamp NOT NULL
);

-- Crear la tabla de artículos_etiquetas para relacionar etiquetas con artículos
CREATE TABLE `articulos_etiquetas` (
  `articulo_id` integer,
  `etiqueta_id` integer,
  PRIMARY KEY (`articulo_id`, `etiqueta_id`),
  FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`),
  FOREIGN KEY (`etiqueta_id`) REFERENCES `etiquetas` (`id`)
);

-- Crear la tabla de suscriptores
CREATE TABLE `suscriptores` (
  `usuario_id` integer,
  `categoria_id` integer,
  PRIMARY KEY (`usuario_id`, `categoria_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
);

-- Crear la tabla de roles de usuario
CREATE TABLE `roles_usuario` (
  `id` integer PRIMARY KEY,
  `nombre` char UNIQUE NOT NULL
);

-- Crear la tabla de permisos
CREATE TABLE `permisos` (
  `id` integer PRIMARY KEY,
  `nombre` char UNIQUE NOT NULL
);

-- Crear la tabla de roles_permisos para relacionar roles y permisos
CREATE TABLE `roles_permisos` (
  `rol_id` integer,
  `permiso_id` integer,
  PRIMARY KEY (`rol_id`, `permiso_id`),
  FOREIGN KEY (`rol_id`) REFERENCES `roles_usuario` (`id`),
  FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id`)
);

-- Crear índices para mejorar el rendimiento de las consultas
CREATE INDEX idx_email_usuarios ON usuarios (email);
CREATE INDEX idx_email_autores ON autores (email);

