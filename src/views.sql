USE montevideo_noticias;

-- Vistas

-- Crear la vista de artículos con más votos 
CREATE VIEW articulos_mas_votados AS
SELECT a.id, a.titulo, a.cuerpo, a.autor_id, a.categoria_id, a.resumen, a.fecha_publicacion, a.estado_publicacion, a.imagen, a.creado_en, a.actualizado_en, SUM(v.voto) AS votos
FROM articulos a
INNER JOIN votos v ON a.id = v.articulo_id
GROUP BY a.id
ORDER BY votos DESC;

-- Crear la vista de artículos con más comentarios
CREATE VIEW articulos_mas_comentados AS
SELECT a.id, a.titulo, a.cuerpo, a.autor_id, a.categoria_id, a.resumen, a.fecha_publicacion, a.estado_publicacion, a.imagen, a.creado_en, a.actualizado_en, COUNT(c.id) AS comentarios
FROM articulos a
INNER JOIN comentarios c ON a.id = c.articulo_id
GROUP BY a.id
ORDER BY comentarios DESC;

-- Crear la vista de autores con más artículos publicados
CREATE VIEW autores_mas_productivos AS
SELECT a.id, a.nombre, a.apellido, a.biografia, a.redes_sociales, a.email, a.creado_en, a.actualizado_en, COUNT(ar.id) AS articulos
FROM autores a
INNER JOIN articulos ar ON a.id = ar.autor_id
GROUP BY a.id
ORDER BY articulos DESC;

-- Crear la vista de noticias más populares
CREATE VIEW noticias_mas_populares AS
SELECT a.id, a.titulo, a.autor_id, a.categoria_id, a.fecha_publicacion, a.estado_publicacion, a.creado_en, a.actualizado_en, SUM(v.voto) AS votos, COUNT(c.id) AS comentarios
FROM articulos a
INNER JOIN votos v ON a.id = v.articulo_id
INNER JOIN comentarios c ON a.id = c.articulo_id
GROUP BY a.id
ORDER BY votos DESC, comentarios DESC;

-- Crear la vista de usuarios con más comentarios
CREATE VIEW usuarios_mas_comentadores AS
SELECT u.id, u.nombre, u.apellido, u.email, u.fecha_nacimiento, u.pais, u.localidad, u.foto_perfil, u.creado_en, u.actualizado_en, COUNT(c.id) AS comentarios
FROM usuarios u
INNER JOIN comentarios c ON u.id = c.autor_id
GROUP BY u.id
ORDER BY comentarios DESC;
