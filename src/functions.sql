USE montevideo_noticias;

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
