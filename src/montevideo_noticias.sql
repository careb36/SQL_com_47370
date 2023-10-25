-- Crear la base de datos Montevideo Noticias
CREATE DATABASE montevideo_noticias;

-- Seleccionar la base de datos Montevideo Noticias
USE montevideo_noticias;

-- Crear la tabla de usuarios
CREATE TABLE `usuarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255),
  `apellido` VARCHAR(255),
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `fecha_nacimiento` DATE,
  `pais` VARCHAR(255),
  `localidad` VARCHAR(255),
  `foto_perfil` VARCHAR(255),
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla de categorías
CREATE TABLE `categorias` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) UNIQUE NOT NULL,
  `descripcion` TEXT,
  `imagen` VARCHAR(255),
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla de autores
CREATE TABLE `autores` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255),
  `apellido` VARCHAR(255),
  `biografia` TEXT,
  `redes_sociales` TEXT,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla de artículos
CREATE TABLE `articulos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `titulo` VARCHAR(255),
  `cuerpo` TEXT,
  `autor_id` INT,
  `categoria_id` INT,
  `resumen` TEXT,
  `fecha_publicacion` TIMESTAMP,
  `estado_publicacion` VARCHAR(255),
  `imagen` VARCHAR(255),
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`),
  FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
);

-- Crear la tabla de comentarios
CREATE TABLE `comentarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `articulo_id` INT,
  `autor_id` INT,
  `cuerpo` TEXT,
  `fecha_publicacion` TIMESTAMP,
  `estado_publicacion` VARCHAR(255),
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`),
  FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`)
);

-- Modificar la tabla de votos para permitir valores negativos
CREATE TABLE `votos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `articulo_id` INT,
  `autor_id` INT,
  `voto` INT,
  `fecha_voto` TIMESTAMP,
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`),
  FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`)
);

-- Crear la tabla de etiquetas
CREATE TABLE `etiquetas` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) UNIQUE NOT NULL,
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Crear la tabla de artículos_etiquetas para relacionar etiquetas con artículos
CREATE TABLE `articulos_etiquetas` (
  `articulo_id` INT,
  `etiqueta_id` INT,
  PRIMARY KEY (`articulo_id`, `etiqueta_id`),
  FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`),
  FOREIGN KEY (`etiqueta_id`) REFERENCES `etiquetas` (`id`)
);

-- Crear la tabla de suscriptores
CREATE TABLE `suscriptores` (
  `usuario_id` INT,
  `categoria_id` INT,
  PRIMARY KEY (`usuario_id`, `categoria_id`),
  FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`),
  FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
);

-- Crear la tabla de roles de usuario
CREATE TABLE `roles_usuario` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) UNIQUE NOT NULL
);

-- Crear la tabla de permisos
CREATE TABLE `permisos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) UNIQUE NOT NULL
);

-- Crear la tabla de roles_permisos para relacionar roles y permisos
CREATE TABLE `roles_permisos` (
  `rol_id` INT,
  `permiso_id` INT,
  PRIMARY KEY (`rol_id`, `permiso_id`),
  FOREIGN KEY (`rol_id`) REFERENCES `roles_usuario` (`id`),
  FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id`)
);

-- Crear índices para mejorar el rendimiento de las consultas
CREATE INDEX idx_email_usuarios ON usuarios (email);
CREATE INDEX idx_email_autores ON autores (email);