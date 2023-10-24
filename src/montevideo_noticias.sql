-- Crear la base de datos Montevideo Noticias
CREATE DATABASE montevideo_noticias;
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

-- Datos de ejemplo para la tabla de usuarios
INSERT INTO usuarios (nombre, apellido, email, fecha_nacimiento, pais, localidad, foto_perfil, creado_en, actualizado_en)
VALUES
('Juan', 'Pérez', 'juan.perez@gmail.com', '1990-01-01', 'Uruguay', 'Montevideo', 'https://acortar.link/xeURWz', NOW(), NOW()),
('María', 'González', 'maria.gonzalez@gmail.com', '1992-02-02', 'Argentina', 'Buenos Aires', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Carlos', 'Rodriguez', 'carlos.rodriguez@gmail.com', '1993-03-03', 'Chile', 'Santiago', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Ana', 'Martinez', 'ana.martinez@gmail.com', '1994-04-04', 'Peru', 'Lima', 'https://acortar.link/xeURWz', NOW(), NOW());


-- Datos de ejemplo para la tabla de categorías
INSERT INTO categorias (nombre, descripcion, imagen, creado_en, actualizado_en)
VALUES
('Actualidad', 'Noticias de actualidad nacional e internacional', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Deportes', 'Noticias deportivas nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Tecnología', 'Noticias de tecnología y avances científicos', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Cultura', 'Noticias de cultura, arte y espectáculos', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Economía', 'Noticias de economía y finanzas', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Política', 'Noticias de política nacional e internacional', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Salud', 'Noticias de salud y bienestar', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Sociedad', 'Noticias de sociedad y temas de interés general', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Turismo', 'Noticias de turismo y viajes', 'https://acortar.link/xeURWz', NOW(), NOW());


-- Datos de ejemplo para la tabla de autores
INSERT INTO autores (nombre, apellido, biografia, redes_sociales, email, creado_en, actualizado_en)
VALUES
('Juan Pérez', 'Periodista de investigación', 'Especialista en temas de corrupción política', 'Twitter: @juanperez, Facebook: JuanPérez', 'juan.perez@gmail.com', NOW(), NOW()),
('María González', 'Escritora de ficción', 'Autora de varios libros de éxito', 'Twitter: @mariagonzalez, Instagram: @mariagonzalez', 'maria.gonzalez@gmail.com', NOW(), NOW()),
('Carlos Rodriguez', 'Analista de tecnología', 'Experto en tecnología y ciencia', 'Twitter: @carlosrodriguez, Instagram: @carlosrodriguez', 'carlos.rodriguez@gmail.com', NOW(), NOW()),
('Ana Martinez', 'Crítica de arte', 'Especialista en arte y cultura', 'Twitter: @anamartinez, Instagram: @anamartinez', 'ana.martinez@gmail.com', NOW(), NOW()),
('Pedro Sánchez', 'Economista', 'Experto en economía y finanzas', 'Twitter: @pedrosanchez, Instagram: @pedrosanchez', 'pedrosanchez@hotmail.com', NOW(), NOW()),
('Luisa Fernández', 'Médica', 'Especialista en salud y bienestar', 'Twitter: @luisafernandez, Instagram: @luisafernandez', 'luisafernandez21@gmail.com', NOW(), NOW()),
('Jorge Pérez', 'Sociólogo', 'Experto en temas de sociedad y política', 'Twitter: @jorgeperez, Instagram: @jorgeperez', 'jorgeperez@yahoo.com.ar', NOW(), NOW()),
('Marcela González', 'Periodista de viajes', 'Experta en turismo y viajes', 'Twitter: @marcelagonzalez, Instagram: @marcelagonzalez', 'marcelagonzalez@adinet.com.uy', NOW(), NOW());


-- Datos de ejemplo para la tabla de artículos
INSERT INTO articulos (titulo, cuerpo, autor_id, categoria_id, resumen, fecha_publicacion, estado_publicacion, imagen, creado_en, actualizado_en)
VALUES
('El presidente de Uruguay se reúne con el presidente de Argentina', 'El presidente de Uruguay se reunió con el presidente de Argentina para tratar temas de interés común', 1, 1, 'El presidente de Uruguay se reunió con el presidente de Argentina para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Argentina se reúne con el presidente de Uruguay', 'El presidente de Argentina se reunió con el presidente de Uruguay para tratar temas de interés común', 2, 1, 'El presidente de Argentina se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Chile se reúne con el presidente de Perú', 'El presidente de Chile se reunió con el presidente de Perú para tratar temas de interés común', 3, 1, 'El presidente de Chile se reunió con el presidente de Perú para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Perú se reúne con el presidente de Chile', 'El presidente de Perú se reunió con el presidente de Chile para tratar temas de interés común', 4, 1, 'El presidente de Perú se reunió con el presidente de Chile para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Brasil ganó un partido de tenis histórico contra Argentina', 5, 2, 'Brasil ganó un partido de tenis histórico contra Argentina', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Argentina pierde partido de tenis historico contra Brasil', 'Argentina perdió un partido de tenis histórico contra Brasil', 6, 2, 'Argentina perdió un partido de tenis histórico contra Brasil', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El nuevo celular de Apple es un éxito de ventas', 'El nuevo celular de Apple es un éxito de ventas en todo el mundo', 7, 3, 'El nuevo celular de Apple es un éxito de ventas en todo el mundo', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El nuevo celular de Samsung es un éxito de ventas', 'El nuevo celular de Samsung es un éxito de ventas en todo el mundo', 8, 3, 'El nuevo celular de Samsung es un éxito de ventas en todo el mundo', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El nuevo celular de Realme es un éxito de ventas', 'El nuevo celular de Realme es un éxito de ventas en todo el mundo', 5, 3, 'El nuevo celular de Realme es un éxito de ventas en todo el mundo', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW());

-- Datos de ejemplo para la tabla de comentarios
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en)
VALUES
(1, 1, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(1, 2, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(2, 3, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(4, 3, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(4, 4, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(5, 1, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(5, 2, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(6, 3, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(6, 4, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(7, 1, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(7, 2, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(8, 3, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(8, 4, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(9, 1, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(9, 2, 'Muy interesante', NOW(), 'publicado', NOW(), NOW());

-- Datos de ejemplo para la tabla de votos
INSERT INTO votos (articulo_id, autor_id, voto, fecha_voto, creado_en, actualizado_en)
VALUES
(1, 1, 1, NOW(), NOW(), NOW()),
(1, 2, -1, NOW(), NOW(), NOW()),
(2, 3, 1, NOW(), NOW(), NOW()),
(4, 3, 1, NOW(), NOW(), NOW()),
(4, 4, -1, NOW(), NOW(), NOW()),
(5, 1, 1, NOW(), NOW(), NOW()),
(5, 2, -1, NOW(), NOW(), NOW()),
(6, 3, 1, NOW(), NOW(), NOW()),
(6, 4, -1, NOW(), NOW(), NOW()),
(7, 1, 1, NOW(), NOW(), NOW()),
(7, 2, -1, NOW(), NOW(), NOW()),
(8, 3, 1, NOW(), NOW(), NOW()),
(8, 4, -1, NOW(), NOW(), NOW()),
(9, 1, 1, NOW(), NOW(), NOW()),
(9, 2, -1, NOW(), NOW(), NOW());

-- Datos de ejemplo para la tabla de etiquetas
INSERT INTO etiquetas (nombre, creado_en, actualizado_en)
VALUES
('Uruguay', NOW(), NOW()),
('Argentina', NOW(), NOW()),
('Chile', NOW(), NOW()),
('Perú', NOW(), NOW()),
('Brasil', NOW(), NOW()),
('Apple', NOW(), NOW()),
('Samsung', NOW(), NOW()),
('Realme', NOW(), NOW());

-- Datos de ejemplo para la tabla de artículos_etiquetas
INSERT INTO articulos_etiquetas (articulo_id, etiqueta_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 3),
(3, 4),
(4, 3),
(4, 4),
(5, 5),
(5, 6),
(6, 5),
(6, 6),
(7, 7),
(7, 8),
(8, 7),
(8, 8),
(9, 9),
(9, 10);

-- Datos de ejemplo para la tabla de suscriptores
INSERT INTO suscriptores (usuario_id, categoria_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(1, 3),
(1, 4),
(2, 3),
(2, 4),
(3, 3),
(3, 4),
(4, 3),
(4, 4);

-- Datos de ejemplo para la tabla de roles de usuario
INSERT INTO roles_usuario (nombre)
VALUES
('Administrador'),
('Editor'),
('Autor'),
('Suscriptor');

-- Datos de ejemplo para la tabla de permisos
INSERT INTO permisos (nombre)
VALUES
('Crear usuarios'),
('Editar usuarios'),
('Eliminar usuarios'),
('Crear categorías'),
('Editar categorías'),
('Eliminar categorías'),
('Crear artículos'),
('Editar artículos'),
('Eliminar artículos'),
('Crear comentarios'),
('Editar comentarios'),
('Eliminar comentarios'),
('Crear etiquetas'),
('Editar etiquetas'),
('Eliminar etiquetas'),
('Crear suscripciones'),
('Editar suscripciones'),
('Eliminar suscripciones');

-- Datos de ejemplo para la tabla de roles_permisos
INSERT INTO roles_permisos (rol_id, permiso_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(4, 7),
(4, 8),
(4, 9),
(4, 10),
(4, 11),
(4, 12),
(4, 13),
(4, 14),
(4, 15),
(4, 16),
(4, 17),
(4, 18);
