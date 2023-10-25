USE montevideo_noticias;

-- función que hace uso de funciones de SQL para obtener la cantidad de comentarios de un artículo
CREATE FUNCTION obtener_cantidad_comentarios(articulo_id INT) RETURNS INT
BEGIN
  DECLARE cantidad_comentarios INT;
  SELECT COUNT(*) INTO cantidad_comentarios FROM comentarios WHERE articulo_id = articulo_id;
  RETURN cantidad_comentarios;
END;

-- función que hace uso de JOINs para obtener la cantidad de votos de un artículo
CREATE FUNCTION obtener_cantidad_votos(articulo_id INT) RETURNS INT
BEGIN
  DECLARE cantidad_votos INT;
  SELECT SUM(voto) INTO cantidad_votos FROM votos WHERE articulo_id = articulo_id;
  RETURN cantidad_votos;
END;
