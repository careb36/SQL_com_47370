-- Seleccionar la base de datos de Montevideo Noticias
USE montevideo_noticias;

-- Crea un nuevo usuario llamado 'usu_lectura' con acceso de solo lectura
CREATE USER 'usu_lectura'@'localhost' IDENTIFIED BY 'readonly12345';

-- Otorgar permiso SELECT (lectura) a 'usu_lectura' en todas las tablas en el esquema montevideo_noticias
GRANT SELECT ON montevideo_noticias.* TO 'usu_lectura'@'localhost';

-- Crea un nuevo usuario llamado 'usu_modifica' con permisos de lectura, inserción y actualización
CREATE USER 'usu_modifica'@'localhost' IDENTIFIED BY 'modify12345';

-- Otorgar permisos SELECT (lectura), INSERT y UPDATE a 'usu_modifica' en todas las tablas en el esquema montevideo_noticias
GRANT SELECT, INSERT, UPDATE ON montevideo_noticias.* TO 'usu_modifica'@'localhost';
