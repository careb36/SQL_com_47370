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


-- Crear tabla de registro para artículos
CREATE TABLE `articulos_log` (
  `log_id` INT AUTO_INCREMENT PRIMARY KEY,
  `articulo_id` INT,
  `accion` VARCHAR(255),
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Trigger BEFORE para artículos (antes de la operación)
DELIMITER //
CREATE TRIGGER before_articulos_insert
BEFORE INSERT ON `articulos`
FOR EACH ROW
BEGIN
  INSERT INTO `articulos_log` (`articulo_id`, `accion`) VALUES (NEW.`id`, 'INSERT');
END;
//
DELIMITER ;

-- Trigger AFTER para artículos (después de la operación)
DELIMITER //
CREATE TRIGGER after_articulos_update
AFTER UPDATE ON `articulos`
FOR EACH ROW
BEGIN
  INSERT INTO `articulos_log` (`articulo_id`, `accion`) VALUES (NEW.`id`, 'UPDATE');
END;
//
DELIMITER ;

-- Crear tabla de registro para comentarios
CREATE TABLE `comentarios_log` (
  `log_id` INT AUTO_INCREMENT PRIMARY KEY,
  `comentario_id` INT,
  `accion` VARCHAR(255),
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Trigger BEFORE para comentarios (antes de la operación)
DELIMITER //
CREATE TRIGGER before_comentarios_delete
BEFORE DELETE ON `comentarios`
FOR EACH ROW
BEGIN
  INSERT INTO `comentarios_log` (`comentario_id`, `accion`) VALUES (OLD.`id`, 'DELETE');
END;
//
DELIMITER ;

-- Trigger AFTER para comentarios (después de la operación)
DELIMITER //
CREATE TRIGGER after_comentarios_insert
AFTER INSERT ON `comentarios`
FOR EACH ROW
BEGIN
  INSERT INTO `comentarios_log` (`comentario_id`, `accion`) VALUES (NEW.`id`, 'INSERT');
END;
//
DELIMITER ;

USE montevideo_noticias;

-- Datos de ejemplo para la tabla de usuarios con fechas aleatorias para el campo creado_en
INSERT INTO usuarios (nombre, apellido, email, fecha_nacimiento, pais, localidad, foto_perfil, creado_en, actualizado_en)
VALUES
('Ana', 'Martinez', 'ana.martinez43@gmail.com', '1994-04-04', 'Peru', 'Lima', 'https://acortar.link/xeURWz', '1997-09-05 11:20:00', '2023-10-23 12:00:00'),
('Luis', 'García', 'luis.garcia@gmail.com', '1985-05-05', 'Mexico', 'Ciudad de México', 'https://acortar.link/xeURWz', '1993-08-18 08:45:00', '2021-10-23 12:00:00'),
('Laura', 'López', 'laura.lopez@gmail.com', '1988-06-06', 'España', 'Madrid', 'https://acortar.link/xeURWz', '1998-01-30 09:30:00', '2022-10-23 12:00:00'),
('Diego', 'Fernández', 'diego.fernandez@gmail.com', '1991-07-07', 'Argentina', 'Córdoba', 'https://acortar.link/xeURWz', '1992-10-05 10:45:00', '2023-10-23 12:00:00'),
('Carla', 'Sanchez', 'carla.sanchez@gmail.com', '1995-08-08', 'Peru', 'Arequipa', 'https://acortar.link/xeURWz', '1999-11-15 08:15:00', '2022-11-23 12:00:00'),
('Michael', 'Johnson', 'michael.johnson@gmail.com', '1987-09-10', 'United States', 'New York', 'https://acortar.link/xeURWz', '1992-12-28 09:30:00', '2021-10-23 12:00:00'),
('Emily', 'Smith', 'emily.smith@gmail.com', '1990-11-12', 'United Kingdom', 'London', 'https://acortar.link/xeURWz', '1994-03-10 10:30:00', '2022-10-23 12:00:00'),
('Christopher', 'Brown', 'christopher.brown@gmail.com', '1989-07-15', 'Australia', 'Sydney', 'https://acortar.link/xeURWz', '1996-05-20 11:00:00', '2023-10-23 12:00:00'),
('Jessica', 'Davis', 'jessica.davis@gmail.com', '1993-04-22', 'Canada', 'Toronto', 'https://acortar.link/xeURWz', '1997-09-08 08:30:00', '2022-11-23 12:00:00'),
('Pedro', 'Sánchez', 'pedrosanchez21@hotmail.com', '1994-05-23', 'Uruguay', 'Montevideo', 'https://acortar.link/xeURWz', '1998-03-10 10:30:00', '2023-10-23 12:00:00'),
('Luisa', 'Fernández', 'luisafernandez@gmail.com', '1995-06-24', 'Argentina', 'Buenos Aires', 'https://acortar.link/xeURWz', '1999-05-20 11:00:00', '2023-10-23 12:00:00'),
('Jorge', 'Pérez', 'jorgeperez@outlook.com', '1996-07-25', 'Chile', 'Santiago', 'https://acortar.link/xeURWz', '2000-09-08 08:30:00', '2023-10-23 12:00:00'),
('Marcela', 'González', 'marcelagonzalez@hotmail.com', '1997-08-26', 'Peru', 'Lima', 'https://acortar.link/xeURWz', '2001-03-10 10:30:00', '2023-10-23 12:00:00');

-- Datos de ejemplo para la tabla de categorías
INSERT INTO categorias (nombre, descripcion, imagen, creado_en, actualizado_en)
VALUES
('Tecnología', 'Noticias de tecnología y avances científicos', 'https://acortar.link/xeURWz', '1999-07-20 10:15:00', '2023-10-23 12:00:00'),
('Cultura', 'Noticias de cultura, arte y espectáculos', 'https://acortar.link/xeURWz', '2001-09-05 11:20:00', '2023-10-23 12:00:00'),
('Economía', 'Noticias de economía y finanzas', 'https://acortar.link/xeURWz', '1997-08-18 08:45:00', '2023-10-23 12:00:00'),
('Política', 'Noticias de política nacional e internacional', 'https://acortar.link/xeURWz', '2002-01-30 09:30:00', '2023-10-23 12:00:00'),
('Salud', 'Noticias de salud y bienestar', 'https://acortar.link/xeURWz', '2003-10-05 10:45:00', '2023-10-23 12:00:00'),
('Sociedad', 'Noticias de sociedad y temas de interés general', 'https://acortar.link/xeURWz', '1996-11-15 08:15:00', '2023-10-23 12:00:00'),
('Turismo', 'Noticias de turismo y viajes', 'https://acortar.link/xeURWz', '2000-12-28 09:30:00', '2023-10-23 12:00:00'),
('Ciencia', 'Noticias de ciencia y tecnología', 'https://acortar.link/xeURWz', '1994-03-10 10:30:00', '2023-10-23 12:00:00'),
('Educación', 'Noticias de educación y formación', 'https://acortar.link/xeURWz', '1996-05-20 11:00:00', '2023-10-23 12:00:00'),
('Medio Ambiente', 'Noticias de medio ambiente y ecología', 'https://acortar.link/xeURWz', '1997-09-08 08:30:00', '2023-10-23 12:00:00'),
('Gastronomía', 'Noticias de gastronomía y cocina', 'https://acortar.link/xeURWz', '1998-03-10 10:30:00', '2023-10-23 12:00:00'),
('Música', 'Noticias de música y espectáculos', 'https://acortar.link/xeURWz', '1999-05-20 11:00:00', '2023-10-23 12:00:00'),
('Cine', 'Noticias de cine y espectáculos', 'https://acortar.link/xeURWz', '2000-09-08 08:30:00', '2023-10-23 12:00:00'),
('Televisión', 'Noticias de televisión y espectáculos', 'https://acortar.link/xeURWz', '2001-03-10 10:30:00', '2023-10-23 12:00:00'),
('Moda', 'Noticias de moda y tendencias', 'https://acortar.link/xeURWz', '2002-05-20 11:00:00', '2023-10-23 12:00:00');


-- Datos de ejemplo para la tabla de autores
INSERT INTO autores (nombre, apellido, biografia, redes_sociales, email, creado_en, actualizado_en)
VALUES
('Juan Pérez', 'Periodista de investigación', 'Especialista en temas de corrupción política', 'Twitter: @juanperez2, Facebook: JuanPérez', 'juan.perezm2@montevideonoticias.com', '1998-05-15 08:30:00', '2023-10-23 12:00:00'),
('Carlos Rodriguez', 'Analista de tecnología', 'Experto en tecnología y ciencia', 'Twitter: @carlosrodriguez, Instagram: @carlosrodriguez', 'carlos.rodriguez.m@montevideonoticias.com', '2000-04-25 09:45:00', '2023-10-23 12:00:00'),
('Ana Martinez', 'Crítica de arte', 'Especialista en arte y cultura', 'Twitter: @anamartinez, Instagram: @anamartinez', 'ana.martinez.t@montevideonoticias.com', '2001-04-25 09:45:00', '2023-10-23 12:00:00'),
('Pedro Sánchez', 'Economista', 'Experto en economía y finanzas', 'Twitter: @pedro2sanchez, Instagram: @pedro2sanchez', 'pedro2sanchez@montevideonoticias.com', '2002-04-25 09:45:00', '2023-10-23 12:00:00'),
('Luisa Fernández', 'Médica', 'Especialista en salud y bienestar', 'Twitter: @luisafernandez, Instagram: @luisafernandez', 'luisafernandez21@montevideonoticias.com', '2003-04-25 09:45:00', '2023-10-23 12:00:00'),
('Michael Johnson', 'Periodista de investigación', 'Especialista en temas de corrupción política', 'Twitter: @michaeljohnson, Facebook: MichaelJohnson', 'michaeljohnson@montevideonoticias.com', '2006-04-25 09:45:00', '2023-10-23 12:00:00'),
('Emily Smith', 'Escritora de ficción', 'Autora de varios libros de éxito', 'Twitter: @emilysmith, Instagram: @emilysmith', 'emilysmith@montevideonoticias.com', '2007-04-25 09:45:00', '2023-10-23 12:00:00'),
('Christopher Brown', 'Analista de tecnología', 'Experto en tecnología y ciencia', 'Twitter: @christopherbrown, Instagram: @christopherbrown', 'christopherbrown@montevideonoticias.com', '2008-04-25 09:45:00', '2023-10-23 12:00:00'),
('Jessica Davis', 'Crítica de arte', 'Especialista en arte y cultura', 'Twitter: @jessicadavis, Instagram: @jessicadavis', 'jessicadavis@montevideonoticias.com', '2009-04-25 09:45:00', '2023-10-23 12:00:00'),
('Luisa Fernández', 'Médica', 'Especialista en salud y bienestar', 'Twitter: @luisafernandez, Instagram: @luisafernandez', 'luisafernandez@montevideonoticias.com', '2011-04-25 09:45:00', '2023-10-23 12:00:00'),
('Jorge Pérez', 'Sociólogo', 'Experto en temas de sociedad y política', 'Twitter: @jorgeperez2, Instagram: @jorgeperez2', 'jorgeperez2@montevideonoticias.com', '2012-04-25 09:45:00', '2023-10-23 12:00:00'),
('Marcela González', 'Periodista de viajes', 'Experta en turismo y viajes', 'Twitter: @marcelagonzalez, Instagram: @marcelagonzalez', 'marcelagonzalez@montevideonoticias.com', '2013-04-25 09:45:00', '2023-10-23 12:00:00');


-- Datos de ejemplo para la tabla de artículos
INSERT INTO articulos (titulo, cuerpo, autor_id, categoria_id, resumen, fecha_publicacion, estado_publicacion, imagen, creado_en, actualizado_en)
VALUES
('Reunión de presidentes: Uruguay y Argentina abordan desafíos económicos', 'Los presidentes de Uruguay y Argentina se reunieron para discutir cuestiones de interés común, con un enfoque en la economía argentina.', 1, 1, 'Reunión de presidentes: Uruguay y Argentina abordan desafíos económicos', '2023-10-05 10:00:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-05 10:00:00', '2023-10-05 10:00:00'),
('Argentina y Uruguay: Presidentes se reúnen para forjar lazos', 'Los presidentes de Argentina y Uruguay mantuvieron una reunión estratégica para fortalecer las relaciones bilaterales.', 2, 1, 'Argentina y Uruguay: Presidentes se reúnen para forjar lazos', '2023-10-06 11:15:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-06 11:15:00', '2023-10-06 11:15:00'),
('Chile y Perú: Presidentes se reúnen para la cooperación regional', 'Los presidentes de Chile y Perú se encontraron para impulsar la cooperación regional y resolver desafíos comunes.', 3, 1, 'Chile y Perú: Presidentes se reúnen para la cooperación regional', '2023-10-07 14:30:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-07 14:30:00', '2023-10-07 14:30:00'),
('Perú y Chile: Presidentes buscan soluciones compartidas', 'Los presidentes de Perú y Chile se reunieron para buscar soluciones a desafíos compartidos y fortalecer los lazos entre naciones.', 4, 1, 'Perú y Chile: Presidentes buscan soluciones compartidas', '2023-10-08 09:45:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-08 09:45:00', '2023-10-08 09:45:00'),
('Histórico partido de tenis: Brasil triunfa sobre Argentina', 'Brasil logra una histórica victoria en un emocionante partido de tenis contra Argentina.', 5, 2, 'Histórico partido de tenis: Brasil triunfa sobre Argentina', '2023-10-09 16:00:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-09 16:00:00', '2023-10-09 16:00:00'),
('Argentina sufre derrota en partido de tenis histórico contra Brasil', 'Argentina afronta una amarga derrota en un partido de tenis histórico contra Brasil.', 6, 2, 'Argentina sufre derrota en partido de tenis histórico contra Brasil', '2023-10-10 18:30:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-10 18:30:00', '2023-10-10 18:30:00'),
('Nuevo iPhone: Un éxito de ventas mundial', 'El lanzamiento del nuevo iPhone de Apple se convierte en un éxito de ventas global.', 7, 3, 'Nuevo iPhone: Un éxito de ventas mundial', '2023-10-11 12:00:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-11 12:00:00', '2023-10-11 12:00:00'),
('Samsung Galaxy: Éxito de ventas en todo el mundo', 'El Samsung Galaxy se convierte en un éxito de ventas a nivel global.', 8, 3, 'Samsung Galaxy: Éxito de ventas en todo el mundo', '2023-10-12 13:45:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-12 13:45:00', '2023-10-12 13:45:00'),
('Realme: Éxito de ventas global con su nuevo celular', 'El nuevo celular de Realme se vuelve un éxito de ventas a nivel mundial.', 5, 3, 'Realme: Éxito de ventas global con su nuevo celular', '2023-10-13 15:15:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-13 15:15:00', '2023-10-13 15:15:00');
    
-- Datos de ejemplo para la tabla de comentarios
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en)
VALUES
(1, 1, '¡Gran artículo! Realmente aprecio la cobertura de estos temas.', '2023-10-05 10:30:00', 'publicado', '2023-10-05 10:30:00', '2023-10-05 10:30:00'),
(1, 2, 'Esto es exactamente lo que necesitaba saber. ¡Gracias!', '2023-10-05 11:15:00', 'publicado', '2023-10-05 11:15:00', '2023-10-05 11:15:00'),
(2, 3, 'Interesante perspectiva. Me gusta cómo se abordan los temas aquí.', '2023-10-06 09:45:00', 'publicado', '2023-10-06 09:45:00', '2023-10-06 09:45:00'),
(4, 3, 'Gracias por compartir información tan valiosa.', '2023-10-08 14:00:00', 'publicado', '2023-10-08 14:00:00', '2023-10-08 14:00:00'),
(4, 4, 'Estoy emocionado por aprender más sobre esto. ¡Sigan así!', '2023-10-08 15:30:00', 'publicado', '2023-10-08 15:30:00', '2023-10-08 15:30:00'),
(5, 1, 'Realmente disfruté leyendo este artículo. ¡Buen trabajo!', '2023-10-09 16:45:00', 'publicado', '2023-10-09 16:45:00', '2023-10-09 16:45:00'),
(5, 2, 'Me encanta cómo se presentan los hechos de manera clara.', '2023-10-09 17:15:00', 'publicado', '2023-10-09 17:15:00', '2023-10-09 17:15:00'),
(6, 3, 'Siempre es un placer leer sus artículos. ¡Manténganlo así!', '2023-10-10 12:30:00', 'publicado', '2023-10-10 12:30:00', '2023-10-10 12:30:00'),
(6, 4, 'Espero con ansias más contenidos de calidad como este.', '2023-10-10 13:00:00', 'publicado', '2023-10-10 13:00:00', '2023-10-10 13:00:00'),
(7, 1, 'Me gusta cómo se abordan temas actuales de manera imparcial.', '2023-10-11 10:00:00', 'publicado', '2023-10-11 10:00:00', '2023-10-11 10:00:00'),
(7, 2, 'Este artículo ha agregado valor a mi día. ¡Gracias!', '2023-10-11 10:30:00', 'publicado', '2023-10-11 10:30:00', '2023-10-11 10:30:00'),
(8, 3, 'Una lectura fascinante. ¡Siguiendo de cerca su trabajo!', '2023-10-12 09:30:00', 'publicado', '2023-10-12 09:30:00', '2023-10-12 09:30:00'),
(8, 4, 'Los artículos como este son una razón para suscribirse. ¡Muy bien!', '2023-10-12 10:15:00', 'publicado', '2023-10-12 10:15:00', '2023-10-12 10:15:00'),
(9, 1, 'Es bueno ver la calidad periodística en cada artículo.', '2023-10-13 11:00:00', 'publicado', '2023-10-13 11:00:00', '2023-10-13 11:00:00'),
(9, 2, 'No puedo esperar para compartir este artículo con amigos. ¡Excelente trabajo!', '2023-10-13 11:30:00', 'publicado', '2023-10-13 11:30:00', '2023-10-13 11:30:00');

-- Datos de ejemplo para la tabla de votos
INSERT INTO votos (articulo_id, autor_id, voto, fecha_voto, creado_en, actualizado_en)
VALUES
(1, 1, 1, '2021-01-15 09:30:00', '2021-01-15 09:30:00', '2021-01-15 09:30:00'),
(1, 2, -1, '2021-01-15 10:15:00', '2021-01-15 10:15:00', '2021-01-15 10:15:00'),
(2, 3, 1, '2021-02-20 11:45:00', '2021-02-20 11:45:00', '2021-02-20 11:45:00'),
(4, 3, 1, '2021-03-12 14:20:00', '2021-03-12 14:20:00', '2021-03-12 14:20:00'),
(4, 4, -1, '2021-03-12 15:55:00', '2021-03-12 15:55:00', '2021-03-12 15:55:00'),
(5, 1, 1, '2021-04-05 16:30:00', '2021-04-05 16:30:00', '2021-04-05 16:30:00'),
(5, 2, -1, '2021-04-05 17:10:00', '2021-04-05 17:10:00', '2021-04-05 17:10:00'),
(6, 3, 1, '2021-05-09 12:15:00', '2021-05-09 12:15:00', '2021-05-09 12:15:00'),
(6, 4, -1, '2021-05-09 12:45:00', '2021-05-09 12:45:00', '2021-05-09 12:45:00'),
(7, 1, 1, '2021-06-11 10:20:00', '2021-06-11 10:20:00', '2021-06-11 10:20:00'),
(7, 2, -1, '2021-06-11 10:50:00', '2021-06-11 10:50:00', '2021-06-11 10:50:00'),
(8, 3, 1, '2021-07-18 09:40:00', '2021-07-18 09:40:00', '2021-07-18 09:40:00'),
(8, 4, -1, '2021-07-18 10:25:00', '2021-07-18 10:25:00', '2021-07-18 10:25:00'),
(9, 1, 1, '2021-08-25 11:10:00', '2021-08-25 11:10:00', '2021-08-25 11:10:00'),
(9, 2, -1, '2021-08-25 11:35:00', '2021-08-25 11:35:00', '2021-08-25 11:35:00');

-- Datos de ejemplo para la tabla de etiquetas
INSERT INTO etiquetas (nombre, creado_en, actualizado_en)
VALUES
('Política', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Economía', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Deportes', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Cultura', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Tecnología', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Ciencia', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Salud', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Entretenimiento', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Turismo', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Medio Ambiente', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Gastronomía', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Música', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Cine', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Televisión', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Moda', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
('Educación', '2022-03-10 14:45:00', '2022-03-10 14:45:00');


-- Datos de ejemplo para la tabla de artículos_etiquetas
INSERT INTO articulos_etiquetas (articulo_id, etiqueta_id)
VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 2),
(3, 1),
(3, 2),
(4, 1),
(4, 2),
(5, 1),
(5, 2),
(6, 1),
(6, 2),
(7, 1);

-- Datos de ejemplo para la tabla de suscriptores
INSERT INTO suscriptores (usuario_id, categoria_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8);

-- Datos de ejemplo para la tabla de roles de usuario
INSERT INTO roles_usuario (nombre)
VALUES
('Administrador'),
('Editor'),
('Autor'),
('Suscriptor'),
('Invitado');

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
('Eliminar suscripciones'),
('Crear roles'),
('Editar roles'),
('Eliminar roles'),
('Crear permisos'),
('Editar permisos'),
('Eliminar permisos'),
('Crear votos'),
('Editar votos'),
('Eliminar votos');

-- Datos de ejemplo para la tabla de roles_permisos
INSERT INTO roles_permisos (rol_id, permiso_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8);

-- SELECT * FROM montevideo_noticias.articulos_log;
-- SELECT * FROM montevideo_noticias.comentarios_log;