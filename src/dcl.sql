USE mysql;
SHOW tables;
SELECT * FROM user;

SHOW GRANTS FOR root@localhost;

-- *.* = esquema . tabla
GRANT ALL ON *.* TO montevideo_noticias@localhost IDENTIFIED BY '123456';

-- Crear un nuevo usuario y asignarle privilegios
CREATE USER 'nuevo_usuario'@'localhost' IDENTIFIED BY 'contrasena';

-- Conceder privilegios SELECT, INSERT y UPDATE en todas las tablas de una base de datos
GRANT SELECT, INSERT, UPDATE ON nombre_base_de_datos.* TO 'nuevo_usuario'@'localhost';

-- Revocar un privilegio específico (por ejemplo, DELETE) de un usuario
REVOKE DELETE ON nombre_base_de_datos.* FROM 'nuevo_usuario'@'localhost';

-- Revocar todos los privilegios de un usuario
REVOKE ALL PRIVILEGES ON nombre_base_de_datos.* FROM 'nuevo_usuario'@'localhost';

-- Ver los privilegios otorgados a un usuario
SHOW GRANTS FOR 'nuevo_usuario'@'localhost';

-- Eliminar un usuario
DROP USER 'nuevo_usuario'@'localhost';

-- Cambiar la contraseña de un usuario
ALTER USER 'nuevo_usuario'@'localhost' IDENTIFIED BY 'nueva_contrasena';

-- Concede permiso SELECT en una tabla específica a un usuario
GRANT SELECT ON nombre_base_de_datos.nombre_tabla TO 'usuario'@'host';

-- Concede permiso SELECT en todas las columnas de una tabla específica a un usuario
GRANT SELECT (columna1, columna2) ON nombre_base_de_datos.nombre_tabla TO 'usuario'@'host';

-- Concede permisos SELECT e INSERT en todas las tablas de una base de datos
GRANT SELECT, INSERT ON nombre_base_de_datos.* TO 'usuario'@'host';

-- Concede permiso SELECT en una columna específica en todas las tablas de una base de datos
GRANT SELECT (columna1) ON nombre_base_de_datos.* TO 'usuario'@'host';
