-- Crear la base de datos de Montevideo Noticias
CREATE DATABASE montevideo_noticias CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Seleccionar la base de datos de Montevideo Noticias
USE montevideo_noticias;

-- Crear la tabla de usuarios
CREATE TABLE IF NOT EXISTS `usuarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) NOT NULL,
  `apellido` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL UNIQUE,
  `fecha_nacimiento` DATE,
  `pais` VARCHAR(100),
  `localidad` VARCHAR(100),
  `foto_perfil` VARCHAR(255),
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de categorías
CREATE TABLE IF NOT EXISTS `categorias` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) UNIQUE NOT NULL,
  `descripcion` TEXT,
  `imagen` VARCHAR(255),
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de autores
CREATE TABLE IF NOT EXISTS `autores` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) NOT NULL,
  `apellido` VARCHAR(255) NOT NULL,
  `biografia` TEXT,
  `redes_sociales` TEXT,
  `email` VARCHAR(255) UNIQUE NOT NULL,
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de artículos
CREATE TABLE IF NOT EXISTS `articulos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `titulo` VARCHAR(255) NOT NULL,
  `cuerpo` TEXT NOT NULL,
  `autor_id` INT,
  `categoria_id` INT,
  `resumen` TEXT,
  `fecha_publicacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado_publicacion` VARCHAR(100),
  `imagen` VARCHAR(255),
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_articulos_autores`
    FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`)
    ON DELETE SET NULL ON UPDATE CASCADE,
  CONSTRAINT `fk_articulos_categorias`
    FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
    ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de comentarios
CREATE TABLE IF NOT EXISTS `comentarios` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `articulo_id` INT,
  `autor_id` INT,
  `cuerpo` TEXT NOT NULL,
  `fecha_publicacion` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `estado_publicacion` VARCHAR(100),
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_comentarios_articulos`
    FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_comentarios_usuarios`
    FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de votos que permite valores negativos
CREATE TABLE IF NOT EXISTS `votos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `articulo_id` INT NOT NULL,
  `autor_id` INT NOT NULL,
  `voto` INT NOT NULL,
  `fecha_voto` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  CONSTRAINT `fk_votos_articulos`
    FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_votos_usuarios`
    FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de etiquetas
CREATE TABLE IF NOT EXISTS `etiquetas` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) UNIQUE NOT NULL,
  `creado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de relación entre artículos y etiquetas
CREATE TABLE IF NOT EXISTS `articulos_etiquetas` (
  `articulo_id` INT NOT NULL,
  `etiqueta_id` INT NOT NULL,
  PRIMARY KEY (`articulo_id`, `etiqueta_id`),
  CONSTRAINT `fk_articulos_etiquetas_articulos`
    FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_articulos_etiquetas_etiquetas`
    FOREIGN KEY (`etiqueta_id`) REFERENCES `etiquetas` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de suscriptores
CREATE TABLE IF NOT EXISTS `suscriptores` (
  `usuario_id` INT NOT NULL,
  `categoria_id` INT NOT NULL,
  PRIMARY KEY (`usuario_id`, `categoria_id`),
  CONSTRAINT `fk_suscriptores_usuarios`
    FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_suscriptores_categorias`
    FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de roles de usuario
CREATE TABLE IF NOT EXISTS `roles_usuario` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) UNIQUE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de permisos
CREATE TABLE IF NOT EXISTS `permisos` (
  `id` INT AUTO_INCREMENT PRIMARY KEY,
  `nombre` VARCHAR(255) UNIQUE NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de relación entre roles y permisos
CREATE TABLE IF NOT EXISTS `roles_permisos` (
  `rol_id` INT NOT NULL,
  `permiso_id` INT NOT NULL,
  PRIMARY KEY (`rol_id`, `permiso_id`),
  CONSTRAINT `fk_roles_permisos_roles`
    FOREIGN KEY (`rol_id`) REFERENCES `roles_usuario` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `fk_roles_permisos_permisos`
    FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id`)
    ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear índices para mejorar el rendimiento de las consultas
CREATE INDEX idx_email_usuarios ON usuarios (email);
CREATE INDEX idx_email_autores ON autores (email);


-- chequear el formato de correo electronico para prevenir inyecciones de SQL
ALTER TABLE usuarios ADD CONSTRAINT chk_email_format 
CHECK (email REGEXP '^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

-- Vistas
-- Crear una vista de los artículos más votados ordenados por la suma total de votos.

CREATE OR REPLACE VIEW `articulos_mas_votados` AS
SELECT 
  a.`id`, 
  a.`titulo`, 
  a.`cuerpo`, 
  a.`autor_id`, 
  a.`categoria_id`, 
  a.`resumen`, 
  a.`fecha_publicacion`, 
  a.`estado_publicacion`, 
  a.`imagen`, 
  a.`creado_en`, 
  a.`actualizado_en`, 
  SUM(v.`voto`) AS `votos`
FROM `articulos` a
JOIN `votos` v ON a.`id` = v.`articulo_id`
GROUP BY a.`id`
ORDER BY `votos` DESC;

-- Crear una vista de los artículos con más comentarios ordenados por la cantidad total de comentarios.
CREATE OR REPLACE VIEW `articulos_mas_comentados` AS
SELECT 
  a.`id`, 
  a.`titulo`, 
  a.`cuerpo`, 
  a.`autor_id`, 
  a.`categoria_id`, 
  a.`resumen`, 
  a.`fecha_publicacion`, 
  a.`estado_publicacion`, 
  a.`imagen`, 
  a.`creado_en`, 
  a.`actualizado_en`, 
  COUNT(c.`id`) AS `comentarios`
FROM `articulos` a
JOIN `comentarios` c ON a.`id` = c.`articulo_id`
GROUP BY a.`id`
ORDER BY `comentarios` DESC;

-- Crear una vista de los autores con más artículos publicados ordenados por la cantidad total de artículos.
CREATE OR REPLACE VIEW `autores_mas_productivos` AS
SELECT 
  a.`id`, 
  a.`nombre`, 
  a.`apellido`, 
  a.`biografia`, 
  a.`redes_sociales`, 
  a.`email`, 
  a.`creado_en`, 
  a.`actualizado_en`, 
  COUNT(ar.`id`) AS `articulos`
FROM `autores` a
JOIN `articulos` ar ON a.`id` = ar.`autor_id`
GROUP BY a.`id`
ORDER BY `articulos` DESC;

-- Crear una vista de las noticias más populares ordenadas por la suma total de votos y comentarios.
CREATE OR REPLACE VIEW `noticias_mas_populares` AS
SELECT 
  a.`id`, 
  a.`titulo`, 
  a.`autor_id`, 
  a.`categoria_id`, 
  a.`fecha_publicacion`, 
  a.`estado_publicacion`, 
  a.`creado_en`, 
  a.`actualizado_en`, 
  SUM(v.`voto`) AS `votos`, 
  COUNT(c.`id`) AS `comentarios`
FROM `articulos` a
JOIN `votos` v ON a.`id` = v.`articulo_id`
JOIN `comentarios` c ON a.`id` = c.`articulo_id`
GROUP BY a.`id`
ORDER BY `votos` DESC, `comentarios` DESC;

-- Crear una vista de los usuarios con más comentarios ordenados por la cantidad total de comentarios.
CREATE OR REPLACE VIEW `usuarios_mas_comentadores` AS
SELECT 
  u.`id`, 
  u.`nombre`, 
  u.`apellido`, 
  u.`email`, 
  u.`fecha_nacimiento`, 
  u.`pais`, 
  u.`localidad`, 
  u.`foto_perfil`, 
  u.`creado_en`, 
  u.`actualizado_en`, 
  COUNT(c.`id`) AS `comentarios`
FROM `usuarios` u
JOIN `comentarios` c ON u.`id` = c.`autor_id`
GROUP BY u.`id`
ORDER BY `comentarios` DESC;

-- Funciones

DELIMITER //

-- Función para obtener la cantidad de comentarios de un artículo
CREATE FUNCTION `obtener_cantidad_comentarios`(articulo_id INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE cantidad_comentarios INT DEFAULT 0;
  SELECT COUNT(*) INTO cantidad_comentarios FROM `comentarios` WHERE `articulo_id` = articulo_id;
  RETURN cantidad_comentarios;
END//

-- Función para obtener la cantidad de votos de un artículo
CREATE FUNCTION `obtener_cantidad_votos`(articulo_id INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE cantidad_votos INT DEFAULT 0;
  SELECT SUM(`voto`) INTO cantidad_votos FROM `votos` WHERE `articulo_id` = articulo_id;
  RETURN cantidad_votos;
END//

-- Función para obtener la calificación promedio de un artículo
CREATE FUNCTION `obtener_calificacion_promedio`(articulo_id INT) RETURNS DECIMAL(4,2)
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE calificacion_promedio DECIMAL(4,2) DEFAULT 0.00;
  SELECT AVG(`voto`) INTO calificacion_promedio FROM `votos` WHERE `articulo_id` = articulo_id;
  RETURN calificacion_promedio;
END//

DELIMITER ;

-- Procedimientos

DELIMITER //

-- Procedimiento para ordenar artículos
CREATE PROCEDURE `OrdenarArticulos`(
    IN ordenCampo VARCHAR(50), -- Field by which the articles will be sorted
    IN ordenDireccion VARCHAR(4) -- Direction of sort (ASC or DESC)
)
BEGIN
    SET @query = CONCAT('SELECT * FROM `articulos` ORDER BY ', ordenCampo, ' ', ordenDireccion);
    PREPARE dynamic_query FROM @query;
    EXECUTE dynamic_query;
    DEALLOCATE PREPARE dynamic_query;
END //

-- Procedimiento para insertar o eliminar un artículo
CREATE PROCEDURE `InsertarEliminarArticulo`(
    IN accion INT, -- 1 to insert, 2 to delete
    IN tituloArt VARCHAR(255), -- Article's title (for insertion)
    IN cuerpoArt TEXT, -- Body of the article (for insertion)
    IN autorID INT, -- Author's ID (for insertion)
    IN categoriaID INT, -- Category ID (for insertion)
    IN resumenArt TEXT, -- Article's summary (for insertion)
    IN estadoArt ENUM('publicado', 'borrador'), -- Publication state (for insertion)
    IN imagenArt VARCHAR(255), -- Image URL (for insertion)
    IN articuloID INT -- Article ID (for deletion)
)
BEGIN
    IF accion = 1 THEN
        -- Insert a new article
        INSERT INTO `articulos` (titulo, cuerpo, autor_id, categoria_id, resumen, fecha_publicacion, estado_publicacion, imagen, creado_en, actualizado_en)
        VALUES (tituloArt, cuerpoArt, autorID, categoriaID, resumenArt, NOW(), estadoArt, imagenArt, NOW(), NOW());
    ELSEIF accion = 2 THEN
        -- Delete an article by ID
        DELETE FROM `articulos` WHERE `id` = articuloID;
    ELSE
        -- Invalid action
        SELECT 'Invalid action. Use 1 to insert or 2 to delete.';
    END IF;
END //

DELIMITER ;

-- Triggers

-- Crear una tabla para los logs de articulos
CREATE TABLE IF NOT EXISTS `articulos_log` (
  `log_id` INT AUTO_INCREMENT PRIMARY KEY,
  `articulo_id` INT NOT NULL,
  `accion` VARCHAR(100) NOT NULL,
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Triggers for articles

-- Trigger BEFORE INSERT para los artículos
DELIMITER //
CREATE TRIGGER `before_articulos_insert`
BEFORE INSERT ON `articulos`
FOR EACH ROW
BEGIN
  INSERT INTO `articulos_log` (`articulo_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'INSERT', NOW());
END;
//
DELIMITER ;

-- Trigger AFTER UPDATE para los artículos
DELIMITER //
CREATE TRIGGER `after_articulos_update`
AFTER UPDATE ON `articulos`
FOR EACH ROW
BEGIN
  INSERT INTO `articulos_log` (`articulo_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'UPDATE', NOW());
END;
//
DELIMITER ;

-- Crear la tabla de log de comentarios
CREATE TABLE IF NOT EXISTS `comentarios_log` (
  `log_id` INT AUTO_INCREMENT PRIMARY KEY,
  `comentario_id` INT NOT NULL,
  `accion` VARCHAR(100) NOT NULL,
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Crear la tabla de log de votos
CREATE TABLE IF NOT EXISTS `votos_log` (
  `log_id` INT AUTO_INCREMENT PRIMARY KEY,
  `voto_id` INT NOT NULL,
  `accion` VARCHAR(100) NOT NULL,
  `fecha_registro` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Triggers para comentarios

-- Trigger BEFORE DELETE para los comentarios
DELIMITER //
CREATE TRIGGER `before_comentarios_delete`
BEFORE DELETE ON `comentarios`
FOR EACH ROW
BEGIN
  INSERT INTO `comentarios_log` (`comentario_id`, `accion`, `fecha_registro`) VALUES (OLD.`id`, 'DELETE', NOW());
END;
//
DELIMITER ;

-- Trigger AFTER INSERT para los comentarios
DELIMITER //
CREATE TRIGGER `after_comentarios_insert`
AFTER INSERT ON `comentarios`
FOR EACH ROW
BEGIN
  INSERT INTO `comentarios_log` (`comentario_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'INSERT', NOW());
END;
//
DELIMITER ;

-- Triggers for votes

-- Trigger BEFORE DELETE para los votos
DELIMITER //
CREATE TRIGGER `before_votos_delete`
BEFORE DELETE ON `votos`
FOR EACH ROW
BEGIN
  INSERT INTO `votos_log` (`voto_id`, `accion`, `fecha_registro`) VALUES (OLD.`id`, 'DELETE', NOW());
END;
//
DELIMITER ;

-- Trigger AFTER INSERT para los votos
DELIMITER //
CREATE TRIGGER `after_votos_insert`
AFTER INSERT ON `votos`
FOR EACH ROW
BEGIN
  INSERT INTO `votos_log` (`voto_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'INSERT', NOW());
END;
//
DELIMITER ;








