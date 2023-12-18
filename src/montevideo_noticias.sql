-- ************************************************************************************************
-- ********************************* MONTEVIDEO NOTICIAS ******************************************
-- ************************************************************************************************


-- Crear la base de datos de Montevideo Noticias
CREATE DATABASE montevideo_noticias CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Seleccionar la base de datos de Montevideo Noticias para operar
USE montevideo_noticias;

-- ******************************************************************************************************************
-- *********************************************** USUARIOS *********************************************************
-- ******************************************************************************************************************

-- Crea un nuevo usuario llamado 'usu_lectura' con acceso de solo lectura
CREATE USER 'usu_lectura'@'localhost' IDENTIFIED BY 'readonly12345';

-- Otorgar permiso SELECT (lectura) a 'usu_lectura' en todas las tablas en el esquema montevideo_noticias
GRANT SELECT ON montevideo_noticias.* TO 'usu_lectura'@'localhost';

-- Crea un nuevo usuario llamado 'usu_modifica' con permisos de lectura, inserción y actualización
CREATE USER 'usu_modifica'@'localhost' IDENTIFIED BY 'modify12345';

-- Otorgar permisos SELECT (lectura), INSERT y UPDATE a 'usu_modifica' en todas las tablas en el esquema montevideo_noticias
GRANT SELECT, INSERT, UPDATE ON montevideo_noticias.* TO 'usu_modifica'@'localhost';

-- Para borrar los usuarios
DROP USER 'usu_lectura'@'localhost';
DROP USER 'usu_modifica'@'localhost';
FLUSH PRIVILEGES;

-- ******************************************************************************************************************
-- ****************************** TABLAS PARA LAS ENTIDADES Y RELACIONES ********************************************
-- ******************************************************************************************************************

-- Crear la tabla de usuarios
CREATE TABLE IF NOT EXISTS `usuarios`
(
    `id`               INT AUTO_INCREMENT PRIMARY KEY,
    `nombre`           VARCHAR(50)  NOT NULL,
    `apellido`         VARCHAR(50)  NOT NULL,
    `email`            VARCHAR(100) NOT NULL UNIQUE,
    `fecha_nacimiento` DATE,
    `pais`             VARCHAR(100),
    `localidad`        VARCHAR(100),
    `foto_perfil`      VARCHAR(255),
    `creado_en`        TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `actualizado_en`   TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de categorías
CREATE TABLE IF NOT EXISTS `categorias`
(
    `id`             INT AUTO_INCREMENT PRIMARY KEY,
    `nombre`         VARCHAR(50) UNIQUE NOT NULL,
    `descripcion`    TEXT,
    `imagen`         VARCHAR(255),
    `creado_en`      TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `actualizado_en` TIMESTAMP          NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de autores
CREATE TABLE IF NOT EXISTS `autores`
(
    `id`             INT AUTO_INCREMENT PRIMARY KEY,
    `nombre`         VARCHAR(50)         NOT NULL,
    `apellido`       VARCHAR(50)         NOT NULL,
    `biografia`      TEXT,
    `redes_sociales` TEXT,
    `email`          VARCHAR(255) UNIQUE NOT NULL,
    `creado_en`      TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `actualizado_en` TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de artículos
CREATE TABLE IF NOT EXISTS `articulos`
(
    `id`                 INT AUTO_INCREMENT PRIMARY KEY,
    `titulo`             VARCHAR(255) NOT NULL,
    `cuerpo`             TEXT         NOT NULL,
    `autor_id`           INT,
    `categoria_id`       INT,
    `resumen`            TEXT,
    `fecha_publicacion`  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `estado_publicacion` VARCHAR(100),
    `imagen`             VARCHAR(255),
    `creado_en`          TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `actualizado_en`     TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_articulos_autores`
        FOREIGN KEY (`autor_id`) REFERENCES `autores` (`id`)
            ON DELETE SET NULL ON UPDATE CASCADE,
    CONSTRAINT `fk_articulos_categorias`
        FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
            ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de comentarios
CREATE TABLE IF NOT EXISTS `comentarios`
(
    `id`                 INT AUTO_INCREMENT PRIMARY KEY,
    `articulo_id`        INT,
    `autor_id`           INT,
    `cuerpo`             TEXT      NOT NULL,
    `fecha_publicacion`  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `estado_publicacion` VARCHAR(100),
    `creado_en`          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `actualizado_en`     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_comentarios_articulos`
        FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_comentarios_usuarios`
        FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de votos que permite valores negativos
CREATE TABLE IF NOT EXISTS `votos`
(
    `id`             INT AUTO_INCREMENT PRIMARY KEY,
    `articulo_id`    INT       NOT NULL,
    `autor_id`       INT       NOT NULL,
    `voto`           INT       NOT NULL,
    `fecha_voto`     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `actualizado_en` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT `fk_votos_articulos`
        FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_votos_usuarios`
        FOREIGN KEY (`autor_id`) REFERENCES `usuarios` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de etiquetas
CREATE TABLE IF NOT EXISTS `etiquetas`
(
    `id`             INT AUTO_INCREMENT PRIMARY KEY,
    `nombre`         VARCHAR(255) UNIQUE NOT NULL,
    `creado_en`      TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `actualizado_en` TIMESTAMP           NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de relación entre artículos y etiquetas
CREATE TABLE IF NOT EXISTS `articulos_etiquetas`
(
    `articulo_id` INT NOT NULL,
    `etiqueta_id` INT NOT NULL,
    PRIMARY KEY (`articulo_id`, `etiqueta_id`),
    CONSTRAINT `fk_articulos_etiquetas_articulos`
        FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_articulos_etiquetas_etiquetas`
        FOREIGN KEY (`etiqueta_id`) REFERENCES `etiquetas` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de suscriptores
CREATE TABLE IF NOT EXISTS `suscriptores`
(
    `usuario_id`   INT NOT NULL,
    `categoria_id` INT NOT NULL,
    PRIMARY KEY (`usuario_id`, `categoria_id`),
    CONSTRAINT `fk_suscriptores_usuarios`
        FOREIGN KEY (`usuario_id`) REFERENCES `usuarios` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_suscriptores_categorias`
        FOREIGN KEY (`categoria_id`) REFERENCES `categorias` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de roles de usuario
CREATE TABLE IF NOT EXISTS `roles_usuario`
(
    `id`     INT AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(50) UNIQUE NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de permisos
CREATE TABLE IF NOT EXISTS `permisos`
(
    `id`     INT AUTO_INCREMENT PRIMARY KEY,
    `nombre` VARCHAR(50) UNIQUE NOT NULL
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Crear la tabla de relación entre roles y permisos
CREATE TABLE IF NOT EXISTS `roles_permisos`
(
    `rol_id`     INT NOT NULL,
    `permiso_id` INT NOT NULL,
    PRIMARY KEY (`rol_id`, `permiso_id`),
    CONSTRAINT `fk_roles_permisos_roles`
        FOREIGN KEY (`rol_id`) REFERENCES `roles_usuario` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT `fk_roles_permisos_permisos`
        FOREIGN KEY (`permiso_id`) REFERENCES `permisos` (`id`)
            ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ******************************************************************************************************************
-- *********************************************** TABLAS DE HECHOS *************************************************
-- ******************************************************************************************************************

-- Para artículos
CREATE TABLE IF NOT EXISTS `hecho_articulos`
(
    `hecho_id`             INT AUTO_INCREMENT PRIMARY KEY,
    `articulo_id`          INT  NOT NULL,
    `fecha`                DATE NOT NULL,
    `cantidad_votos`       INT DEFAULT 0,
    `cantidad_comentarios` INT DEFAULT 0,
    `promedio_votos`       DECIMAL(3, 2),
    FOREIGN KEY (`articulo_id`) REFERENCES `articulos` (`id`)
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ******************************************************************************************************************
-- *********************************************** TABLAS LOGS ******************************************************
-- ******************************************************************************************************************

-- Para comentarios
CREATE TABLE IF NOT EXISTS `comentarios_log`
(
    `log_id`         INT AUTO_INCREMENT PRIMARY KEY,
    `comentario_id`  INT          NOT NULL,
    `accion`         VARCHAR(100) NOT NULL,
    `fecha_registro` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Para votos
CREATE TABLE IF NOT EXISTS `votos_log`
(
    `log_id`         INT AUTO_INCREMENT PRIMARY KEY,
    `voto_id`        INT          NOT NULL,
    `accion`         VARCHAR(100) NOT NULL,
    `fecha_registro` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- Para articulos
CREATE TABLE IF NOT EXISTS `articulos_log`
(
    `log_id`         INT AUTO_INCREMENT PRIMARY KEY,
    `articulo_id`    INT          NOT NULL,
    `accion`         VARCHAR(100) NOT NULL,
    `fecha_registro` TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE = InnoDB
  DEFAULT CHARSET = utf8mb4;

-- ******************************************************************************************************************
-- ******************************************** INDICES *************************************************************
-- ******************************************************************************************************************

-- Crear índices para mejorar el rendimiento de las consultas
CREATE INDEX idx_email_usuarios ON usuarios (email);
CREATE INDEX idx_email_autores ON autores (email);


-- chequear el formato de correo electronico para prevenir inyecciones de SQL
ALTER TABLE usuarios
    ADD CONSTRAINT chk_email_format
        CHECK (email REGEXP '^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');


-- ******************************************************************************************************************
-- *********************************************** VISTAS ***********************************************************
-- ******************************************************************************************************************

-- Crear una vista de los artículos más votados ordenados por la suma total de votos.
CREATE OR REPLACE VIEW `articulos_mas_votados` AS
SELECT a.`id`,
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
SELECT a.`id`,
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
SELECT a.`id`,
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
SELECT a.`id`,
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
SELECT u.`id`,
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

-- ******************************************************************************************************************
-- *********************************************** FUNCIONES ********************************************************
-- ******************************************************************************************************************

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
CREATE FUNCTION `obtener_calificacion_promedio`(articulo_id INT) RETURNS DECIMAL(4, 2)
    DETERMINISTIC
    READS SQL DATA
BEGIN
    DECLARE calificacion_promedio DECIMAL(4, 2) DEFAULT 0.00;
    SELECT AVG(`voto`) INTO calificacion_promedio FROM `votos` WHERE `articulo_id` = articulo_id;
    RETURN calificacion_promedio;
END//

DELIMITER ;

-- ******************************************************************************************************************
-- *********************************************** PROCEDIMIENTOS ***************************************************
-- ******************************************************************************************************************

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
    IN estadoArt ENUM ('publicado', 'borrador'), -- Publication state (for insertion)
    IN imagenArt VARCHAR(255), -- Image URL (for insertion)
    IN articuloID INT -- Article ID (for deletion)
)
BEGIN
    IF accion = 1 THEN
        -- Insert a new article
        INSERT INTO `articulos` (titulo, cuerpo, autor_id, categoria_id, resumen, fecha_publicacion, estado_publicacion,
                                 imagen, creado_en, actualizado_en)
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

-- ******************************************************************************************************************
-- *********************************************** TRIGGERS *********************************************************
-- ******************************************************************************************************************

-- Triggers para artículos

-- Trigger BEFORE INSERT
DELIMITER //
CREATE TRIGGER `before_articulos_insert`
    BEFORE INSERT
    ON `articulos`
    FOR EACH ROW
BEGIN
    INSERT INTO `articulos_log` (`articulo_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'INSERT', NOW());
END;
//
DELIMITER ;

-- Trigger AFTER UPDATE
DELIMITER //
CREATE TRIGGER `after_articulos_update`
    AFTER UPDATE
    ON `articulos`
    FOR EACH ROW
BEGIN
    INSERT INTO `articulos_log` (`articulo_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'UPDATE', NOW());
END;
//
DELIMITER ;

-- Triggers para comentarios

-- Trigger BEFORE DELETE
DELIMITER //
CREATE TRIGGER `before_comentarios_delete`
    BEFORE DELETE
    ON `comentarios`
    FOR EACH ROW
BEGIN
    INSERT INTO `comentarios_log` (`comentario_id`, `accion`, `fecha_registro`) VALUES (OLD.`id`, 'DELETE', NOW());
END;
//
DELIMITER ;

-- Trigger AFTER INSERT
DELIMITER //
CREATE TRIGGER `after_comentarios_insert`
    AFTER INSERT
    ON `comentarios`
    FOR EACH ROW
BEGIN
    INSERT INTO `comentarios_log` (`comentario_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'INSERT', NOW());
END;
//
DELIMITER ;

-- Triggers para la tabla votos

-- Trigger BEFORE DELETE
DELIMITER //
CREATE TRIGGER `before_votos_delete`
    BEFORE DELETE
    ON `votos`
    FOR EACH ROW
BEGIN
    INSERT INTO `votos_log` (`voto_id`, `accion`, `fecha_registro`) VALUES (OLD.`id`, 'DELETE', NOW());
END;
//
DELIMITER ;

-- Trigger AFTER INSERT
DELIMITER //
CREATE TRIGGER `after_votos_insert`
    AFTER INSERT
    ON `votos`
    FOR EACH ROW
BEGIN
    INSERT INTO `votos_log` (`voto_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'INSERT', NOW());
END;
//
DELIMITER ;

-- ******************************************************************************************************************
-- ******************************* INSERCION DE DATOS DE EJEMPLO ****************************************************
-- ******************************************************************************************************************

-- Datos de ejemplo para la tabla de usuarios con fechas aleatorias para el campo creado_en
INSERT INTO usuarios (nombre, apellido, email, fecha_nacimiento, pais, localidad, foto_perfil, creado_en,
                      actualizado_en)
VALUES ('Ana', 'Martinez', 'ana.martinez43@gmail.com', '1994-04-04', 'Peru', 'Lima', 'https://acortar.link/xeURWz',
        '1997-09-05 11:20:00', '2023-10-23 12:00:00'),
       ('Luis', 'García', 'luis.garcia@gmail.com', '1985-05-05', 'Mexico', 'Ciudad de México',
        'https://acortar.link/xeURWz', '1993-08-18 08:45:00', '2021-10-23 12:00:00'),
       ('Laura', 'López', 'laura.lopez@gmail.com', '1988-06-06', 'España', 'Madrid', 'https://acortar.link/xeURWz',
        '1998-01-30 09:30:00', '2022-10-23 12:00:00'),
       ('Diego', 'Fernández', 'diego.fernandez@gmail.com', '1991-07-07', 'Argentina', 'Córdoba',
        'https://acortar.link/xeURWz', '1992-10-05 10:45:00', '2023-10-23 12:00:00'),
       ('Carla', 'Sanchez', 'carla.sanchez@gmail.com', '1995-08-08', 'Peru', 'Arequipa', 'https://acortar.link/xeURWz',
        '1999-11-15 08:15:00', '2022-11-23 12:00:00'),
       ('Michael', 'Johnson', 'michael.johnson@gmail.com', '1987-09-10', 'United States', 'New York',
        'https://acortar.link/xeURWz', '1992-12-28 09:30:00', '2021-10-23 12:00:00'),
       ('Emily', 'Smith', 'emily.smith@gmail.com', '1990-11-12', 'United Kingdom', 'London',
        'https://acortar.link/xeURWz', '1994-03-10 10:30:00', '2022-10-23 12:00:00'),
       ('Christopher', 'Brown', 'christopher.brown@gmail.com', '1989-07-15', 'Australia', 'Sydney',
        'https://acortar.link/xeURWz', '1996-05-20 11:00:00', '2023-10-23 12:00:00'),
       ('Jessica', 'Davis', 'jessica.davis@gmail.com', '1993-04-22', 'Canada', 'Toronto', 'https://acortar.link/xeURWz',
        '1997-09-08 08:30:00', '2022-11-23 12:00:00'),
       ('Pedro', 'Sánchez', 'pedrosanchez21@hotmail.com', '1994-05-23', 'Uruguay', 'Montevideo',
        'https://acortar.link/xeURWz', '1998-03-10 10:30:00', '2023-10-23 12:00:00'),
       ('Luisa', 'Fernández', 'luisafernandez@gmail.com', '1995-06-24', 'Argentina', 'Buenos Aires',
        'https://acortar.link/xeURWz', '1999-05-20 11:00:00', '2023-10-23 12:00:00'),
       ('Jorge', 'Pérez', 'jorgeperez@outlook.com', '1996-07-25', 'Chile', 'Santiago', 'https://acortar.link/xeURWz',
        '2000-09-08 08:30:00', '2023-10-23 12:00:00'),
       ('Marcela', 'González', 'marcelagonzalez@hotmail.com', '1997-08-26', 'Peru', 'Lima',
        'https://acortar.link/xeURWz', '2001-03-10 10:30:00', '2023-10-23 12:00:00');

-- Datos de ejemplo para la tabla de categorías
INSERT INTO categorias (nombre, descripcion, imagen, creado_en, actualizado_en)
VALUES ('Tecnología', 'Noticias de tecnología y avances científicos', 'https://acortar.link/xeURWz',
        '1999-07-20 10:15:00', '2023-10-23 12:00:00'),
       ('Cultura', 'Noticias de cultura, arte y espectáculos', 'https://acortar.link/xeURWz', '2001-09-05 11:20:00',
        '2023-10-23 12:00:00'),
       ('Economía', 'Noticias de economía y finanzas', 'https://acortar.link/xeURWz', '1997-08-18 08:45:00',
        '2023-10-23 12:00:00'),
       ('Política', 'Noticias de política nacional e internacional', 'https://acortar.link/xeURWz',
        '2002-01-30 09:30:00', '2023-10-23 12:00:00'),
       ('Salud', 'Noticias de salud y bienestar', 'https://acortar.link/xeURWz', '2003-10-05 10:45:00',
        '2023-10-23 12:00:00'),
       ('Sociedad', 'Noticias de sociedad y temas de interés general', 'https://acortar.link/xeURWz',
        '1996-11-15 08:15:00', '2023-10-23 12:00:00'),
       ('Turismo', 'Noticias de turismo y viajes', 'https://acortar.link/xeURWz', '2000-12-28 09:30:00',
        '2023-10-23 12:00:00'),
       ('Ciencia', 'Noticias de ciencia y tecnología', 'https://acortar.link/xeURWz', '1994-03-10 10:30:00',
        '2023-10-23 12:00:00'),
       ('Educación', 'Noticias de educación y formación', 'https://acortar.link/xeURWz', '1996-05-20 11:00:00',
        '2023-10-23 12:00:00'),
       ('Medio Ambiente', 'Noticias de medio ambiente y ecología', 'https://acortar.link/xeURWz', '1997-09-08 08:30:00',
        '2023-10-23 12:00:00'),
       ('Gastronomía', 'Noticias de gastronomía y cocina', 'https://acortar.link/xeURWz', '1998-03-10 10:30:00',
        '2023-10-23 12:00:00'),
       ('Música', 'Noticias de música y espectáculos', 'https://acortar.link/xeURWz', '1999-05-20 11:00:00',
        '2023-10-23 12:00:00'),
       ('Cine', 'Noticias de cine y espectáculos', 'https://acortar.link/xeURWz', '2000-09-08 08:30:00',
        '2023-10-23 12:00:00'),
       ('Televisión', 'Noticias de televisión y espectáculos', 'https://acortar.link/xeURWz', '2001-03-10 10:30:00',
        '2023-10-23 12:00:00'),
       ('Moda', 'Noticias de moda y tendencias', 'https://acortar.link/xeURWz', '2002-05-20 11:00:00',
        '2023-10-23 12:00:00');


-- Datos de ejemplo para la tabla de autores
INSERT INTO autores (nombre, apellido, biografia, redes_sociales, email, creado_en, actualizado_en)
VALUES ('Juan Pérez', 'Periodista de investigación', 'Especialista en temas de corrupción política',
        'Twitter: @juanperez2, Facebook: JuanPérez', 'juan.perezm2@montevideonoticias.com', '1998-05-15 08:30:00',
        '2023-10-23 12:00:00'),
       ('Carlos Rodriguez', 'Analista de tecnología', 'Experto en tecnología y ciencia',
        'Twitter: @carlosrodriguez, Instagram: @carlosrodriguez', 'carlos.rodriguez.m@montevideonoticias.com',
        '2000-04-25 09:45:00', '2023-10-23 12:00:00'),
       ('Ana Martinez', 'Crítica de arte', 'Especialista en arte y cultura',
        'Twitter: @anamartinez, Instagram: @anamartinez', 'ana.martinez.t@montevideonoticias.com',
        '2001-04-25 09:45:00', '2023-10-23 12:00:00'),
       ('Pedro Sánchez', 'Economista', 'Experto en economía y finanzas',
        'Twitter: @pedro2sanchez, Instagram: @pedro2sanchez', 'pedro2sanchez@montevideonoticias.com',
        '2002-04-25 09:45:00', '2023-10-23 12:00:00'),
       ('Luisa Fernández', 'Médica', 'Especialista en salud y bienestar',
        'Twitter: @luisafernandez, Instagram: @luisafernandez', 'luisafernandez21@montevideonoticias.com',
        '2003-04-25 09:45:00', '2023-10-23 12:00:00'),
       ('Michael Johnson', 'Periodista de investigación', 'Especialista en temas de corrupción política',
        'Twitter: @michaeljohnson, Facebook: MichaelJohnson', 'michaeljohnson@montevideonoticias.com',
        '2006-04-25 09:45:00', '2023-10-23 12:00:00'),
       ('Emily Smith', 'Escritora de ficción', 'Autora de varios libros de éxito',
        'Twitter: @emilysmith, Instagram: @emilysmith', 'emilysmith@montevideonoticias.com', '2007-04-25 09:45:00',
        '2023-10-23 12:00:00'),
       ('Christopher Brown', 'Analista de tecnología', 'Experto en tecnología y ciencia',
        'Twitter: @christopherbrown, Instagram: @christopherbrown', 'christopherbrown@montevideonoticias.com',
        '2008-04-25 09:45:00', '2023-10-23 12:00:00'),
       ('Jessica Davis', 'Crítica de arte', 'Especialista en arte y cultura',
        'Twitter: @jessicadavis, Instagram: @jessicadavis', 'jessicadavis@montevideonoticias.com',
        '2009-04-25 09:45:00', '2023-10-23 12:00:00'),
       ('Luisa Fernández', 'Médica', 'Especialista en salud y bienestar',
        'Twitter: @luisafernandez, Instagram: @luisafernandez', 'luisafernandez@montevideonoticias.com',
        '2011-04-25 09:45:00', '2023-10-23 12:00:00'),
       ('Jorge Pérez', 'Sociólogo', 'Experto en temas de sociedad y política',
        'Twitter: @jorgeperez2, Instagram: @jorgeperez2', 'jorgeperez2@montevideonoticias.com', '2012-04-25 09:45:00',
        '2023-10-23 12:00:00'),
       ('Marcela González', 'Periodista de viajes', 'Experta en turismo y viajes',
        'Twitter: @marcelagonzalez, Instagram: @marcelagonzalez', 'marcelagonzalez@montevideonoticias.com',
        '2013-04-25 09:45:00', '2023-10-23 12:00:00'),
       ('Roberto', 'García', 'Experto en economía internacional', 'Twitter: @robertogarcia',
        'roberto.garcia@montevideonoticias.com', '2014-03-15 09:00:00', '2023-10-23 12:00:00'),
       ('Marta', 'Rodríguez', 'Especialista en medio ambiente', 'Instagram: @martarodriguez',
        'marta.rodriguez@montevideonoticias.com', '2015-04-20 10:00:00', '2023-10-23 12:00:00'),
       ('Carlos', 'López', 'Periodista deportivo', 'Facebook: CarlosLopez', 'carlos.lopez@montevideonoticias.com',
        '2016-05-25 11:00:00', '2023-10-23 12:00:00'),
       ('Sofía', 'Martínez', 'Experta en tecnologías emergentes', 'LinkedIn: sofiamartinez',
        'sofia.martinez@montevideonoticias.com', '2017-06-30 12:00:00', '2023-10-23 12:00:00'),
       ('Daniel', 'Fernández', 'Crítico de cine y teatro', 'Twitter: @danielfernandez',
        'daniel.fernandez@montevideonoticias.com', '2018-07-15 13:00:00', '2023-10-23 12:00:00'),
       ('Laura', 'Gomez', 'Experta en salud pública', 'Instagram: @lauragomez', 'laura.gomez@montevideonoticias.com',
        '2019-08-20 14:00:00', '2023-10-23 12:00:00'),
       ('Antonio', 'Ruiz', 'Especialista en historia latinoamericana', 'Facebook: AntonioRuiz',
        'antonio.ruiz@montevideonoticias.com', '2020-09-10 15:00:00', '2023-10-23 12:00:00'),
       ('Elena', 'Vazquez', 'Periodista en temas de educación', 'Twitter: @elenavazquez',
        'elena.vazquez@montevideonoticias.com', '2021-10-05 16:00:00', '2023-10-23 12:00:00'),
       ('Pedro', 'Molina', 'Analista político', 'LinkedIn: pedromolina', 'pedro.molina@montevideonoticias.com',
        '2022-11-20 17:00:00', '2023-10-23 12:00:00'),
       ('Carmen', 'Hernández', 'Experta en gastronomía y nutrición', 'Instagram: @carmenhernandez',
        'carmen.hernandez@montevideonoticias.com', '2023-01-15 09:00:00', '2023-10-23 12:00:00'),
       ('Federico', 'Alvarez', 'Especialista en seguridad informática', 'Twitter: @federicoalvarez',
        'federico.alvarez@montevideonoticias.com', '2023-02-20 10:00:00', '2023-10-23 12:00:00'),
       ('Isabel', 'Morales', 'Periodista en temas sociales', 'Facebook: IsabelMorales',
        'isabel.morales@montevideonoticias.com', '2023-03-25 11:00:00', '2023-10-23 12:00:00'),
       ('Juan', 'Díaz', 'Experto en finanzas y mercados internacionales', 'LinkedIn: juandiaz',
        'juan.diaz@montevideonoticias.com', '2023-04-30 12:00:00', '2023-10-23 12:00:00'),
       ('Lucía', 'Ramírez', 'Periodista cultural', 'Instagram: @luciaramirez', 'lucia.ramirez@montevideonoticias.com',
        '2023-05-15 13:00:00', '2023-10-23 12:00:00'),
       ('Gabriel', 'Torres', 'Especialista en temas de energías renovables', 'Twitter: @gabrieltorres',
        'gabriel.torres@montevideonoticias.com', '2023-06-20 14:00:00', '2023-10-23 12:00:00');


-- Datos de ejemplo para la tabla de artículos
INSERT INTO articulos (titulo, cuerpo, autor_id, categoria_id, resumen, fecha_publicacion, estado_publicacion, imagen,
                       creado_en, actualizado_en)
VALUES ('Reunión de presidentes: Uruguay y Argentina abordan desafíos económicos',
        'Los presidentes de Uruguay y Argentina se reunieron para discutir cuestiones de interés común, con un enfoque en la economía argentina.',
        1, 1, 'Reunión de presidentes: Uruguay y Argentina abordan desafíos económicos', '2023-10-05 10:00:00',
        'publicado', 'https://acortar.link/xeURWz', '2023-10-05 10:00:00', '2023-10-05 10:00:00'),
       ('Argentina y Uruguay: Presidentes se reúnen para forjar lazos',
        'Los presidentes de Argentina y Uruguay mantuvieron una reunión estratégica para fortalecer las relaciones bilaterales.',
        2, 1, 'Argentina y Uruguay: Presidentes se reúnen para forjar lazos', '2023-10-06 11:15:00', 'publicado',
        'https://acortar.link/xeURWz', '2023-10-06 11:15:00', '2023-10-06 11:15:00'),
       ('Chile y Perú: Presidentes se reúnen para la cooperación regional',
        'Los presidentes de Chile y Perú se encontraron para impulsar la cooperación regional y resolver desafíos comunes.',
        3, 1, 'Chile y Perú: Presidentes se reúnen para la cooperación regional', '2023-10-07 14:30:00', 'publicado',
        'https://acortar.link/xeURWz', '2023-10-07 14:30:00', '2023-10-07 14:30:00'),
       ('Perú y Chile: Presidentes buscan soluciones compartidas',
        'Los presidentes de Perú y Chile se reunieron para buscar soluciones a desafíos compartidos y fortalecer los lazos entre naciones.',
        4, 1, 'Perú y Chile: Presidentes buscan soluciones compartidas', '2023-10-08 09:45:00', 'publicado',
        'https://acortar.link/xeURWz', '2023-10-08 09:45:00', '2023-10-08 09:45:00'),
       ('Histórico partido de tenis: Brasil triunfa sobre Argentina',
        'Brasil logra una histórica victoria en un emocionante partido de tenis contra Argentina.', 5, 2,
        'Histórico partido de tenis: Brasil triunfa sobre Argentina', '2023-10-09 16:00:00', 'publicado',
        'https://acortar.link/xeURWz', '2023-10-09 16:00:00', '2023-10-09 16:00:00'),
       ('Argentina sufre derrota en partido de tenis histórico contra Brasil',
        'Argentina afronta una amarga derrota en un partido de tenis histórico contra Brasil.', 6, 2,
        'Argentina sufre derrota en partido de tenis histórico contra Brasil', '2023-10-10 18:30:00', 'publicado',
        'https://acortar.link/xeURWz', '2023-10-10 18:30:00', '2023-10-10 18:30:00'),
       ('Nuevo iPhone: Un éxito de ventas mundial',
        'El lanzamiento del nuevo iPhone de Apple se convierte en un éxito de ventas global.', 7, 3,
        'Nuevo iPhone: Un éxito de ventas mundial', '2023-10-11 12:00:00', 'publicado', 'https://acortar.link/xeURWz',
        '2023-10-11 12:00:00', '2023-10-11 12:00:00'),
       ('Samsung Galaxy: Éxito de ventas en todo el mundo',
        'El Samsung Galaxy se convierte en un éxito de ventas a nivel global.', 8, 3,
        'Samsung Galaxy: Éxito de ventas en todo el mundo', '2023-10-12 13:45:00', 'publicado',
        'https://acortar.link/xeURWz', '2023-10-12 13:45:00', '2023-10-12 13:45:00'),
       ('Realme: Éxito de ventas global con su nuevo celular',
        'El nuevo celular de Realme se vuelve un éxito de ventas a nivel mundial.', 5, 3,
        'Realme: Éxito de ventas global con su nuevo celular', '2023-10-13 15:15:00', 'publicado',
        'https://acortar.link/xeURWz', '2023-10-13 15:15:00', '2023-10-13 15:15:00'),
       ('Innovación en Energías Renovables', 'Explorando las últimas tendencias en energías renovables.', 9, 4,
        'Innovación en Energías Renovables', '2023-10-14 09:00:00', 'publicado', 'https://acortar.link/xeURWz',
        '2023-10-14 09:00:00', '2023-10-14 09:00:00')
        ,
       ('Nuevas Tendencias en la Moda Sostenible', 'La moda se encuentra con la sostenibilidad.', 10, 5,
        'Nuevas Tendencias en la Moda Sostenible', '2023-10-15 10:30:00', 'publicado', 'https://acortar.link/xeURWz',
        '2023-10-15 10:30:00', '2023-10-15 10:30:00')
        ,
       ('Avances en la IA y el Aprendizaje Automático', 'IA y aprendizaje automático revolucionando la tecnología.', 11,
        3, 'Avances en la IA', '2023-10-16 11:00:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-16 11:00:00',
        '2023-10-16 11:00:00')
        ,
       ('El Futuro de la Medicina Digital', 'Innovaciones en el campo de la medicina digital.', 12, 6,
        'Medicina Digital', '2023-10-17 12:00:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-17 12:00:00',
        '2023-10-17 12:00:00')
        ,
       ('Impacto del Cambio Climático en la Agricultura',
        'Análisis del cambio climático y su impacto en la agricultura.', 13, 7, 'Cambio Climático y Agricultura',
        '2023-10-18 08:00:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-18 08:00:00', '2023-10-18 08:00:00')
        ,
       ('Explorando el Espacio: Nuevos Descubrimientos', 'Descubrimientos recientes en la exploración espacial.', 14, 8,
        'Exploración Espacial', '2023-10-19 09:30:00', 'publicado', 'https://acortar.link/xeURWz',
        '2023-10-19 09:30:00', '2023-10-19 09:30:00')
        ,
       ('Crecimiento de las Ciudades Inteligentes', 'El avance de las ciudades inteligentes en el mundo moderno.', 15,
        3, 'Ciudades Inteligentes', '2023-10-20 10:45:00', 'publicado', 'https://acortar.link/xeURWz',
        '2023-10-20 10:45:00', '2023-10-20 10:45:00')
        ,
       ('Innovación en Transporte Eléctrico', 'La revolución del transporte eléctrico.', 16, 4, 'Transporte Eléctrico',
        '2023-10-21 11:30:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-21 11:30:00', '2023-10-21 11:30:00')
        ,
       ('Descubrimientos en Biotecnología', 'Avances recientes en el campo de la biotecnología.', 17, 6,
        'Biotecnología', '2023-10-22 12:15:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-22 12:15:00',
        '2023-10-22 12:15:00')
        ,
       ('Revolución de las Fintech', 'Las fintech y su impacto en el sector financiero.', 18, 5, 'Fintech',
        '2023-10-23 13:00:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-23 13:00:00', '2023-10-23 13:00:00')
        ,
       ('Tecnologías Emergentes en Educación', 'Cómo las nuevas tecnologías están transformando la educación.', 19, 9,
        'Educación y Tecnología', '2023-10-24 14:00:00', 'publicado', 'https://acortar.link/xeURWz',
        '2023-10-24 14:00:00', '2023-10-24 14:00:00')
        ,
       ('Desarrollo Sostenible y Empresas', 'Las empresas y su papel en el desarrollo sostenible.', 20, 10,
        'Empresas y Sostenibilidad', '2023-10-25 15:30:00', 'publicado', 'https://acortar.link/xeURWz',
        '2023-10-25 15:30:00', '2023-10-25 15:30:00')
        ,
       ('Avances en Robótica', 'La evolución y el futuro de la robótica.', 21, 3, 'Robótica', '2023-10-26 16:45:00',
        'publicado', 'https://acortar.link/xeURWz', '2023-10-26 16:45:00', '2023-10-26 16:45:00')
        ,
       ('Realidad Virtual en el Entretenimiento',
        'El impacto de la realidad virtual en la industria del entretenimiento.', 22, 8, 'Realidad Virtual',
        '2023-10-27 17:00:00', 'publicado', 'https://acortar.link/xeURWz', '2023-10-27 17:00:00', '2023-10-27 17:00:00')
        ,
       ('Tendencias Globales en Alimentación', 'Explorando las tendencias actuales en la industria alimentaria.', 23, 7,
        'Alimentación y Tendencias', '2023-10-28 18:15:00', 'publicado', 'https://acortar.link/xeURWz',
        '2023-10-28 18:15:00', '2023-10-28 18:15:00');

-- Datos de ejemplo para la tabla de comentarios
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en,
                         actualizado_en)
VALUES (1, 1, '¡Gran artículo! Realmente aprecio la cobertura de estos temas.', '2023-10-05 10:30:00', 'publicado',
        '2023-10-05 10:30:00', '2023-10-05 10:30:00'),
       (1, 2, 'Esto es exactamente lo que necesitaba saber. ¡Gracias!', '2023-10-05 11:15:00', 'publicado',
        '2023-10-05 11:15:00', '2023-10-05 11:15:00'),
       (2, 3, 'Interesante perspectiva. Me gusta cómo se abordan los temas aquí.', '2023-10-06 09:45:00', 'publicado',
        '2023-10-06 09:45:00', '2023-10-06 09:45:00'),
       (4, 3, 'Gracias por compartir información tan valiosa.', '2023-10-08 14:00:00', 'publicado',
        '2023-10-08 14:00:00', '2023-10-08 14:00:00'),
       (4, 4, 'Estoy emocionado por aprender más sobre esto. ¡Sigan así!', '2023-10-08 15:30:00', 'publicado',
        '2023-10-08 15:30:00', '2023-10-08 15:30:00'),
       (5, 1, 'Realmente disfruté leyendo este artículo. ¡Buen trabajo!', '2023-10-09 16:45:00', 'publicado',
        '2023-10-09 16:45:00', '2023-10-09 16:45:00'),
       (5, 2, 'Me encanta cómo se presentan los hechos de manera clara.', '2023-10-09 17:15:00', 'publicado',
        '2023-10-09 17:15:00', '2023-10-09 17:15:00'),
       (6, 3, 'Siempre es un placer leer sus artículos. ¡Manténganlo así!', '2023-10-10 12:30:00', 'publicado',
        '2023-10-10 12:30:00', '2023-10-10 12:30:00'),
       (6, 4, 'Espero con ansias más contenidos de calidad como este.', '2023-10-10 13:00:00', 'publicado',
        '2023-10-10 13:00:00', '2023-10-10 13:00:00'),
       (7, 1, 'Me gusta cómo se abordan temas actuales de manera imparcial.', '2023-10-11 10:00:00', 'publicado',
        '2023-10-11 10:00:00', '2023-10-11 10:00:00'),
       (7, 2, 'Este artículo ha agregado valor a mi día. ¡Gracias!', '2023-10-11 10:30:00', 'publicado',
        '2023-10-11 10:30:00', '2023-10-11 10:30:00'),
       (8, 3, 'Una lectura fascinante. ¡Siguiendo de cerca su trabajo!', '2023-10-12 09:30:00', 'publicado',
        '2023-10-12 09:30:00', '2023-10-12 09:30:00'),
       (8, 4, 'Los artículos como este son una razón para suscribirse. ¡Muy bien!', '2023-10-12 10:15:00', 'publicado',
        '2023-10-12 10:15:00', '2023-10-12 10:15:00'),
       (9, 1, 'Es bueno ver la calidad periodística en cada artículo.', '2023-10-13 11:00:00', 'publicado',
        '2023-10-13 11:00:00', '2023-10-13 11:00:00'),
       (9, 2, 'No puedo esperar para compartir este artículo con amigos. ¡Excelente trabajo!', '2023-10-13 11:30:00',
        'publicado', '2023-10-13 11:30:00', '2023-10-13 11:30:00');

-- Datos de ejemplo para la tabla de votos
INSERT INTO votos (articulo_id, autor_id, voto)
VALUES (1, 1, 1),
       (1, 2, -1),
       (2, 3, 1),
       (4, 5, 1),
       (4, 4, -1),
       (5, 6, 1),
       (5, 2, -1),
       (6, 3, 1),
       (6, 4, -1),
       (7, 1, 1),
       (7, 6, -1),
       (8, 3, 1),
       (8, 4, -1),
       (9, 7, 1),
       (9, 2, -1);

-- Datos de ejemplo para la tabla de etiquetas
INSERT INTO etiquetas (nombre, creado_en, actualizado_en)
VALUES ('Política', '2022-03-10 14:45:00', '2022-03-10 14:45:00'),
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
VALUES (1, 1),
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
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (1, 5),
       (1, 6),
       (1, 7),
       (1, 8);

-- Datos de ejemplo para la tabla de roles de usuario
INSERT INTO roles_usuario (nombre)
VALUES ('Administrador'),
       ('Editor'),
       ('Autor'),
       ('Suscriptor'),
       ('Invitado');

-- Datos de ejemplo para la tabla de permisos
INSERT INTO permisos (nombre)
VALUES ('Crear usuarios'),
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
VALUES (1, 1),
       (1, 2),
       (1, 3),
       (1, 4),
       (1, 5),
       (1, 6),
       (1, 7),
       (1, 8);

-- Datos de ejemplo para la tabla hecho_articulos
INSERT INTO hecho_articulos (articulo_id, fecha, cantidad_votos, cantidad_comentarios, promedio_votos)
VALUES (18, '2022-10-30', 30, 5, 0.5),
       (19, '2022-11-15', 17, 9, 0.85),
       (20, '2022-12-20', 4, 3, 0.33),
       (21, '2023-01-25', 50, 2, 0.5),
       (22, '2023-02-28', 13, 7, 0.77),
       (23, '2023-03-30', 19, 9, 0.9),
       (24, '2023-04-10', 70, 5, 0.43);


-- ******************************************************************************************************************
-- *************************************** TRANSACCIONES ************************************************************
-- ******************************************************************************************************************

-- Iniciar la transacción
START TRANSACTION;
-- Eliminar registros de la tabla 'articulos' relacionados con 'Política'
DELETE
FROM articulos
WHERE categoria_id = (SELECT id FROM categorias WHERE nombre = 'Política');
-- Para deshacer los cambios (ejecutar si es necesario revertir la transacción)
-- ROLLBACK;
-- Aplicar los cambios de forma permanente
COMMIT;

-- Iniciar la transacción
START TRANSACTION;

-- Insertar nuevos comentarios en 'comentarios'
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en,
                         actualizado_en)
VALUES (1, 1, 'Interesante artículo sobre política', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00',
        '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en,
                         actualizado_en)
VALUES (2, 2, 'Muy buen artículo', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en,
                         actualizado_en)
VALUES (3, 3, 'Excelente artículo', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en,
                         actualizado_en)
VALUES (4, 4, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');

-- Crear un savepoint después del cuarto comentario
SAVEPOINT SP1;

-- Insertar los comentarios restantes
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en,
                         actualizado_en)
VALUES (5, 5, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en,
                         actualizado_en)
VALUES (6, 6, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en,
                         actualizado_en)
VALUES (7, 7, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');
INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en,
                         actualizado_en)
VALUES (8, 8, 'Muy interesante', '2023-11-01 10:00:00', 'publicado', '2023-11-01 10:00:00', '2023-11-01 10:00:00');

-- Crear un savepoint
SAVEPOINT SP2;

-- Eliminar el savepoint de los primeros 4 comentarios

-- ROLLBACK TO SAVEPOINT SP1;

-- Finalizar la transacción aplicar cambios de forma permanente
COMMIT;

-- Script para actualizar la tabla de hechos diariamente
DELIMITER //

CREATE PROCEDURE `ActualizarHechoArticulos`()
BEGIN
    INSERT INTO `hecho_articulos` (`articulo_id`, `fecha`, `cantidad_votos`, `cantidad_comentarios`, `promedio_votos`)
    SELECT a.`id`,
           CURRENT_DATE(),
           (SELECT COUNT(*) FROM `votos` WHERE `articulo_id` = a.`id`)                 AS votos_count,
           (SELECT COUNT(*) FROM `comentarios` WHERE `articulo_id` = a.`id`)           AS comentarios_count,
           (SELECT COALESCE(AVG(`voto`), 0) FROM `votos` WHERE `articulo_id` = a.`id`) AS voto_promedio
    FROM `articulos` a
    ON DUPLICATE KEY UPDATE `cantidad_votos`       = (SELECT COUNT(*) FROM `votos` WHERE `articulo_id` = a.`id`),
                            `cantidad_comentarios` = (SELECT COUNT(*) FROM `comentarios` WHERE `articulo_id` = a.`id`),
                            `promedio_votos`       = (SELECT COALESCE(AVG(`voto`), 0)
                                                      FROM `votos`
                                                      WHERE `articulo_id` = a.`id`);
END;

//
DELIMITER ;


