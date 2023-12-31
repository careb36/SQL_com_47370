USE montevideo_noticias;

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
