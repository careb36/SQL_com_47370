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

-- Vistas

-- Crear la vista de artículos con más votos ordenados por la suma total de votos.
CREATE VIEW articulos_mas_votados AS
SELECT a.id, a.titulo, a.cuerpo, a.autor_id, a.categoria_id, a.resumen, a.fecha_publicacion, a.estado_publicacion, a.imagen, a.creado_en, a.actualizado_en, SUM(v.voto) AS votos
FROM articulos a
INNER JOIN votos v ON a.id = v.articulo_id
GROUP BY a.id
ORDER BY votos DESC;

-- Crear la vista de artículos con más comentarios ordenados por la cantidad total de comentarios.
CREATE VIEW articulos_mas_comentados AS
SELECT a.id, a.titulo, a.cuerpo, a.autor_id, a.categoria_id, a.resumen, a.fecha_publicacion, a.estado_publicacion, a.imagen, a.creado_en, a.actualizado_en, COUNT(c.id) AS comentarios
FROM articulos a
INNER JOIN comentarios c ON a.id = c.articulo_id
GROUP BY a.id
ORDER BY comentarios DESC;

-- Crear la vista de autores con más artículos publicados ordenados por la cantidad total de artículos.
CREATE VIEW autores_mas_productivos AS
SELECT a.id, a.nombre, a.apellido, a.biografia, a.redes_sociales, a.email, a.creado_en, a.actualizado_en, COUNT(ar.id) AS articulos
FROM autores a
INNER JOIN articulos ar ON a.id = ar.autor_id
GROUP BY a.id
ORDER BY articulos DESC;

-- Crear la vista de noticias más populares ordenadas por la suma total de votos y comentarios.
CREATE VIEW noticias_mas_populares AS
SELECT a.id, a.titulo, a.autor_id, a.categoria_id, a.fecha_publicacion, a.estado_publicacion, a.creado_en, a.actualizado_en, SUM(v.voto) AS votos, COUNT(c.id) AS comentarios
FROM articulos a
INNER JOIN votos v ON a.id = v.articulo_id
INNER JOIN comentarios c ON a.id = c.articulo_id
GROUP BY a.id
ORDER BY votos DESC, comentarios DESC;

-- Crear la vista de usuarios con más comentarios ordenados por la cantidad total de comentarios.
CREATE VIEW usuarios_mas_comentadores AS
SELECT u.id, u.nombre, u.apellido, u.email, u.fecha_nacimiento, u.pais, u.localidad, u.foto_perfil, u.creado_en, u.actualizado_en, COUNT(c.id) AS comentarios
FROM usuarios u
INNER JOIN comentarios c ON u.id = c.autor_id
GROUP BY u.id
ORDER BY comentarios DESC;

DELIMITER //

-- función para obtener la cantidad de comentarios de un artículo
CREATE FUNCTION obtener_cantidad_comentarios(articulo_id INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE cantidad_comentarios INT;
  SELECT COUNT(*) INTO cantidad_comentarios FROM comentarios WHERE articulo_id = articulo_id;
  RETURN cantidad_comentarios;
END//

-- función para obtener la cantidad de votos de un artículo
CREATE FUNCTION obtener_cantidad_votos(articulo_id INT) RETURNS INT
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE cantidad_votos INT;
  SELECT SUM(voto) INTO cantidad_votos FROM votos WHERE articulo_id = articulo_id;
  RETURN cantidad_votos;
END//

-- Función para obtener la calificación promedio de un artículo
CREATE FUNCTION obtener_calificacion_promedio(articulo_id INT) RETURNS DECIMAL(4,2)
DETERMINISTIC
READS SQL DATA
BEGIN
  DECLARE calificacion_promedio DECIMAL(4,2);
  SELECT AVG(voto) INTO calificacion_promedio FROM votos WHERE articulo_id = articulo_id;
  RETURN calificacion_promedio;
END//

DELIMITER ;

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

