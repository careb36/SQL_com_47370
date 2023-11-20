-- MySQL dump 10.13  Distrib 8.0.34, for Win64 (x86_64)
--
-- Host: localhost    Database: montevideo_noticias
-- ------------------------------------------------------
-- Server version	8.1.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

/*
Tablas incluidas en el volcado de la base de datos `montevideo_noticias`
1 - articulos
2 - articulos_etiquetas
3 - articulos_log
4 - autores
5 - categorias
6 - comentarios
7 - comentarios_log
8 - etiquetas
9 - permisos
10 - roles_permisos
11 - roles_usuario
12 - suscriptores
13 - usuarios
14 - votos
15 - votos_log
*/

--
-- Dumping data for table `articulos`
--

LOCK TABLES `articulos` WRITE;
/*!40000 ALTER TABLE `articulos` DISABLE KEYS */;
INSERT INTO `articulos` VALUES (1,'Reunión de presidentes: Uruguay y Argentina abordan desafíos económicos','Los presidentes de Uruguay y Argentina se reunieron para discutir cuestiones de interés común, con un enfoque en la economía argentina.',1,1,'Reunión de presidentes: Uruguay y Argentina abordan desafíos económicos','2023-10-05 13:00:00','publicado','https://acortar.link/xeURWz','2023-10-05 13:00:00','2023-10-05 13:00:00'),(2,'Argentina y Uruguay: Presidentes se reúnen para forjar lazos','Los presidentes de Argentina y Uruguay mantuvieron una reunión estratégica para fortalecer las relaciones bilaterales.',2,1,'Argentina y Uruguay: Presidentes se reúnen para forjar lazos','2023-10-06 14:15:00','publicado','https://acortar.link/xeURWz','2023-10-06 14:15:00','2023-10-06 14:15:00'),(3,'Chile y Perú: Presidentes se reúnen para la cooperación regional','Los presidentes de Chile y Perú se encontraron para impulsar la cooperación regional y resolver desafíos comunes.',3,1,'Chile y Perú: Presidentes se reúnen para la cooperación regional','2023-10-07 17:30:00','publicado','https://acortar.link/xeURWz','2023-10-07 17:30:00','2023-10-07 17:30:00'),(4,'Perú y Chile: Presidentes buscan soluciones compartidas','Los presidentes de Perú y Chile se reunieron para buscar soluciones a desafíos compartidos y fortalecer los lazos entre naciones.',4,1,'Perú y Chile: Presidentes buscan soluciones compartidas','2023-10-08 12:45:00','publicado','https://acortar.link/xeURWz','2023-10-08 12:45:00','2023-10-08 12:45:00'),(5,'Histórico partido de tenis: Brasil triunfa sobre Argentina','Brasil logra una histórica victoria en un emocionante partido de tenis contra Argentina.',5,2,'Histórico partido de tenis: Brasil triunfa sobre Argentina','2023-10-09 19:00:00','publicado','https://acortar.link/xeURWz','2023-10-09 19:00:00','2023-10-09 19:00:00'),(6,'Argentina sufre derrota en partido de tenis histórico contra Brasil','Argentina afronta una amarga derrota en un partido de tenis histórico contra Brasil.',6,2,'Argentina sufre derrota en partido de tenis histórico contra Brasil','2023-10-10 21:30:00','publicado','https://acortar.link/xeURWz','2023-10-10 21:30:00','2023-10-10 21:30:00'),(7,'Nuevo iPhone: Un éxito de ventas mundial','El lanzamiento del nuevo iPhone de Apple se convierte en un éxito de ventas global.',7,3,'Nuevo iPhone: Un éxito de ventas mundial','2023-10-11 15:00:00','publicado','https://acortar.link/xeURWz','2023-10-11 15:00:00','2023-10-11 15:00:00'),(8,'Samsung Galaxy: Éxito de ventas en todo el mundo','El Samsung Galaxy se convierte en un éxito de ventas a nivel global.',8,3,'Samsung Galaxy: Éxito de ventas en todo el mundo','2023-10-12 16:45:00','publicado','https://acortar.link/xeURWz','2023-10-12 16:45:00','2023-10-12 16:45:00'),(9,'Realme: Éxito de ventas global con su nuevo celular','El nuevo celular de Realme se vuelve un éxito de ventas a nivel mundial.',5,3,'Realme: Éxito de ventas global con su nuevo celular','2023-10-13 18:15:00','publicado','https://acortar.link/xeURWz','2023-10-13 18:15:00','2023-10-13 18:15:00');
/*!40000 ALTER TABLE `articulos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_articulos_insert` BEFORE INSERT ON `articulos` FOR EACH ROW BEGIN
  INSERT INTO `articulos_log` (`articulo_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'INSERT', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_articulos_update` AFTER UPDATE ON `articulos` FOR EACH ROW BEGIN
  INSERT INTO `articulos_log` (`articulo_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'UPDATE', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `articulos_etiquetas`
--

LOCK TABLES `articulos_etiquetas` WRITE;
/*!40000 ALTER TABLE `articulos_etiquetas` DISABLE KEYS */;
INSERT INTO `articulos_etiquetas` VALUES (1,1),(2,1),(3,1),(4,1),(5,1),(6,1),(7,1),(1,2),(2,2),(3,2),(4,2),(5,2),(6,2);
/*!40000 ALTER TABLE `articulos_etiquetas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `articulos_log`
--

LOCK TABLES `articulos_log` WRITE;
/*!40000 ALTER TABLE `articulos_log` DISABLE KEYS */;
INSERT INTO `articulos_log` VALUES (1,0,'INSERT','2023-11-12 04:27:43'),(2,0,'INSERT','2023-11-12 04:27:43'),(3,0,'INSERT','2023-11-12 04:27:43'),(4,0,'INSERT','2023-11-12 04:27:43'),(5,0,'INSERT','2023-11-12 04:27:43'),(6,0,'INSERT','2023-11-12 04:27:43'),(7,0,'INSERT','2023-11-12 04:27:43'),(8,0,'INSERT','2023-11-12 04:27:43'),(9,0,'INSERT','2023-11-12 04:27:43');
/*!40000 ALTER TABLE `articulos_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `autores`
--

LOCK TABLES `autores` WRITE;
/*!40000 ALTER TABLE `autores` DISABLE KEYS */;
INSERT INTO `autores` VALUES (1,'Juan Pérez','Periodista de investigación','Especialista en temas de corrupción política','Twitter: @juanperez2, Facebook: JuanPérez','juan.perezm2@montevideonoticias.com','1998-05-15 11:30:00','2023-10-23 15:00:00'),(2,'Carlos Rodriguez','Analista de tecnología','Experto en tecnología y ciencia','Twitter: @carlosrodriguez, Instagram: @carlosrodriguez','carlos.rodriguez.m@montevideonoticias.com','2000-04-25 12:45:00','2023-10-23 15:00:00'),(3,'Ana Martinez','Crítica de arte','Especialista en arte y cultura','Twitter: @anamartinez, Instagram: @anamartinez','ana.martinez.t@montevideonoticias.com','2001-04-25 12:45:00','2023-10-23 15:00:00'),(4,'Pedro Sánchez','Economista','Experto en economía y finanzas','Twitter: @pedro2sanchez, Instagram: @pedro2sanchez','pedro2sanchez@montevideonoticias.com','2002-04-25 12:45:00','2023-10-23 15:00:00'),(5,'Luisa Fernández','Médica','Especialista en salud y bienestar','Twitter: @luisafernandez, Instagram: @luisafernandez','luisafernandez21@montevideonoticias.com','2003-04-25 12:45:00','2023-10-23 15:00:00'),(6,'Michael Johnson','Periodista de investigación','Especialista en temas de corrupción política','Twitter: @michaeljohnson, Facebook: MichaelJohnson','michaeljohnson@montevideonoticias.com','2006-04-25 12:45:00','2023-10-23 15:00:00'),(7,'Emily Smith','Escritora de ficción','Autora de varios libros de éxito','Twitter: @emilysmith, Instagram: @emilysmith','emilysmith@montevideonoticias.com','2007-04-25 12:45:00','2023-10-23 15:00:00'),(8,'Christopher Brown','Analista de tecnología','Experto en tecnología y ciencia','Twitter: @christopherbrown, Instagram: @christopherbrown','christopherbrown@montevideonoticias.com','2008-04-25 12:45:00','2023-10-23 15:00:00'),(9,'Jessica Davis','Crítica de arte','Especialista en arte y cultura','Twitter: @jessicadavis, Instagram: @jessicadavis','jessicadavis@montevideonoticias.com','2009-04-25 12:45:00','2023-10-23 15:00:00'),(10,'Luisa Fernández','Médica','Especialista en salud y bienestar','Twitter: @luisafernandez, Instagram: @luisafernandez','luisafernandez@montevideonoticias.com','2011-04-25 12:45:00','2023-10-23 15:00:00'),(11,'Jorge Pérez','Sociólogo','Experto en temas de sociedad y política','Twitter: @jorgeperez2, Instagram: @jorgeperez2','jorgeperez2@montevideonoticias.com','2012-04-25 12:45:00','2023-10-23 15:00:00'),(12,'Marcela González','Periodista de viajes','Experta en turismo y viajes','Twitter: @marcelagonzalez, Instagram: @marcelagonzalez','marcelagonzalez@montevideonoticias.com','2013-04-25 12:45:00','2023-10-23 15:00:00');
/*!40000 ALTER TABLE `autores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Tecnología','Noticias de tecnología y avances científicos','https://acortar.link/xeURWz','1999-07-20 13:15:00','2023-10-23 15:00:00'),(2,'Cultura','Noticias de cultura, arte y espectáculos','https://acortar.link/xeURWz','2001-09-05 14:20:00','2023-10-23 15:00:00'),(3,'Economía','Noticias de economía y finanzas','https://acortar.link/xeURWz','1997-08-18 11:45:00','2023-10-23 15:00:00'),(4,'Política','Noticias de política nacional e internacional','https://acortar.link/xeURWz','2002-01-30 12:30:00','2023-10-23 15:00:00'),(5,'Salud','Noticias de salud y bienestar','https://acortar.link/xeURWz','2003-10-05 13:45:00','2023-10-23 15:00:00'),(6,'Sociedad','Noticias de sociedad y temas de interés general','https://acortar.link/xeURWz','1996-11-15 11:15:00','2023-10-23 15:00:00'),(7,'Turismo','Noticias de turismo y viajes','https://acortar.link/xeURWz','2000-12-28 12:30:00','2023-10-23 15:00:00'),(8,'Ciencia','Noticias de ciencia y tecnología','https://acortar.link/xeURWz','1994-03-10 13:30:00','2023-10-23 15:00:00'),(9,'Educación','Noticias de educación y formación','https://acortar.link/xeURWz','1996-05-20 14:00:00','2023-10-23 15:00:00'),(10,'Medio Ambiente','Noticias de medio ambiente y ecología','https://acortar.link/xeURWz','1997-09-08 11:30:00','2023-10-23 15:00:00'),(11,'Gastronomía','Noticias de gastronomía y cocina','https://acortar.link/xeURWz','1998-03-10 13:30:00','2023-10-23 15:00:00'),(12,'Música','Noticias de música y espectáculos','https://acortar.link/xeURWz','1999-05-20 14:00:00','2023-10-23 15:00:00'),(13,'Cine','Noticias de cine y espectáculos','https://acortar.link/xeURWz','2000-09-08 11:30:00','2023-10-23 15:00:00'),(14,'Televisión','Noticias de televisión y espectáculos','https://acortar.link/xeURWz','2001-03-10 13:30:00','2023-10-23 15:00:00'),(15,'Moda','Noticias de moda y tendencias','https://acortar.link/xeURWz','2002-05-20 14:00:00','2023-10-23 15:00:00');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `comentarios`
--

LOCK TABLES `comentarios` WRITE;
/*!40000 ALTER TABLE `comentarios` DISABLE KEYS */;
INSERT INTO `comentarios` VALUES (1,1,1,'¡Gran artículo! Realmente aprecio la cobertura de estos temas.','2023-10-05 13:30:00','publicado','2023-10-05 13:30:00','2023-10-05 13:30:00'),(2,1,2,'Esto es exactamente lo que necesitaba saber. ¡Gracias!','2023-10-05 14:15:00','publicado','2023-10-05 14:15:00','2023-10-05 14:15:00'),(3,2,3,'Interesante perspectiva. Me gusta cómo se abordan los temas aquí.','2023-10-06 12:45:00','publicado','2023-10-06 12:45:00','2023-10-06 12:45:00'),(4,4,3,'Gracias por compartir información tan valiosa.','2023-10-08 17:00:00','publicado','2023-10-08 17:00:00','2023-10-08 17:00:00'),(5,4,4,'Estoy emocionado por aprender más sobre esto. ¡Sigan así!','2023-10-08 18:30:00','publicado','2023-10-08 18:30:00','2023-10-08 18:30:00'),(6,5,1,'Realmente disfruté leyendo este artículo. ¡Buen trabajo!','2023-10-09 19:45:00','publicado','2023-10-09 19:45:00','2023-10-09 19:45:00'),(7,5,2,'Me encanta cómo se presentan los hechos de manera clara.','2023-10-09 20:15:00','publicado','2023-10-09 20:15:00','2023-10-09 20:15:00'),(8,6,3,'Siempre es un placer leer sus artículos. ¡Manténganlo así!','2023-10-10 15:30:00','publicado','2023-10-10 15:30:00','2023-10-10 15:30:00'),(9,6,4,'Espero con ansias más contenidos de calidad como este.','2023-10-10 16:00:00','publicado','2023-10-10 16:00:00','2023-10-10 16:00:00'),(10,7,1,'Me gusta cómo se abordan temas actuales de manera imparcial.','2023-10-11 13:00:00','publicado','2023-10-11 13:00:00','2023-10-11 13:00:00'),(11,7,2,'Este artículo ha agregado valor a mi día. ¡Gracias!','2023-10-11 13:30:00','publicado','2023-10-11 13:30:00','2023-10-11 13:30:00'),(12,8,3,'Una lectura fascinante. ¡Siguiendo de cerca su trabajo!','2023-10-12 12:30:00','publicado','2023-10-12 12:30:00','2023-10-12 12:30:00'),(13,8,4,'Los artículos como este son una razón para suscribirse. ¡Muy bien!','2023-10-12 13:15:00','publicado','2023-10-12 13:15:00','2023-10-12 13:15:00'),(14,9,1,'Es bueno ver la calidad periodística en cada artículo.','2023-10-13 14:00:00','publicado','2023-10-13 14:00:00','2023-10-13 14:00:00'),(15,9,2,'No puedo esperar para compartir este artículo con amigos. ¡Excelente trabajo!','2023-10-13 14:30:00','publicado','2023-10-13 14:30:00','2023-10-13 14:30:00');
/*!40000 ALTER TABLE `comentarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_comentarios_insert` AFTER INSERT ON `comentarios` FOR EACH ROW BEGIN
  INSERT INTO `comentarios_log` (`comentario_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'INSERT', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_comentarios_delete` BEFORE DELETE ON `comentarios` FOR EACH ROW BEGIN
  INSERT INTO `comentarios_log` (`comentario_id`, `accion`, `fecha_registro`) VALUES (OLD.`id`, 'DELETE', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `comentarios_log`
--

LOCK TABLES `comentarios_log` WRITE;
/*!40000 ALTER TABLE `comentarios_log` DISABLE KEYS */;
INSERT INTO `comentarios_log` VALUES (1,1,'INSERT','2023-11-12 04:27:43'),(2,2,'INSERT','2023-11-12 04:27:43'),(3,3,'INSERT','2023-11-12 04:27:43'),(4,4,'INSERT','2023-11-12 04:27:43'),(5,5,'INSERT','2023-11-12 04:27:43'),(6,6,'INSERT','2023-11-12 04:27:43'),(7,7,'INSERT','2023-11-12 04:27:43'),(8,8,'INSERT','2023-11-12 04:27:43'),(9,9,'INSERT','2023-11-12 04:27:43'),(10,10,'INSERT','2023-11-12 04:27:43'),(11,11,'INSERT','2023-11-12 04:27:43'),(12,12,'INSERT','2023-11-12 04:27:43'),(13,13,'INSERT','2023-11-12 04:27:43'),(14,14,'INSERT','2023-11-12 04:27:43'),(15,15,'INSERT','2023-11-12 04:27:43');
/*!40000 ALTER TABLE `comentarios_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `etiquetas`
--

LOCK TABLES `etiquetas` WRITE;
/*!40000 ALTER TABLE `etiquetas` DISABLE KEYS */;
INSERT INTO `etiquetas` VALUES (1,'Política','2022-03-10 17:45:00','2022-03-10 17:45:00'),(2,'Economía','2022-03-10 17:45:00','2022-03-10 17:45:00'),(3,'Deportes','2022-03-10 17:45:00','2022-03-10 17:45:00'),(4,'Cultura','2022-03-10 17:45:00','2022-03-10 17:45:00'),(5,'Tecnología','2022-03-10 17:45:00','2022-03-10 17:45:00'),(6,'Ciencia','2022-03-10 17:45:00','2022-03-10 17:45:00'),(7,'Salud','2022-03-10 17:45:00','2022-03-10 17:45:00'),(8,'Entretenimiento','2022-03-10 17:45:00','2022-03-10 17:45:00'),(9,'Turismo','2022-03-10 17:45:00','2022-03-10 17:45:00'),(10,'Medio Ambiente','2022-03-10 17:45:00','2022-03-10 17:45:00'),(11,'Gastronomía','2022-03-10 17:45:00','2022-03-10 17:45:00'),(12,'Música','2022-03-10 17:45:00','2022-03-10 17:45:00'),(13,'Cine','2022-03-10 17:45:00','2022-03-10 17:45:00'),(14,'Televisión','2022-03-10 17:45:00','2022-03-10 17:45:00'),(15,'Moda','2022-03-10 17:45:00','2022-03-10 17:45:00'),(16,'Educación','2022-03-10 17:45:00','2022-03-10 17:45:00');
/*!40000 ALTER TABLE `etiquetas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `permisos`
--

LOCK TABLES `permisos` WRITE;
/*!40000 ALTER TABLE `permisos` DISABLE KEYS */;
INSERT INTO `permisos` VALUES (7,'Crear artículos'),(4,'Crear categorías'),(10,'Crear comentarios'),(13,'Crear etiquetas'),(22,'Crear permisos'),(19,'Crear roles'),(16,'Crear suscripciones'),(1,'Crear usuarios'),(25,'Crear votos'),(8,'Editar artículos'),(5,'Editar categorías'),(11,'Editar comentarios'),(14,'Editar etiquetas'),(23,'Editar permisos'),(20,'Editar roles'),(17,'Editar suscripciones'),(2,'Editar usuarios'),(26,'Editar votos'),(9,'Eliminar artículos'),(6,'Eliminar categorías'),(12,'Eliminar comentarios'),(15,'Eliminar etiquetas'),(24,'Eliminar permisos'),(21,'Eliminar roles'),(18,'Eliminar suscripciones'),(3,'Eliminar usuarios'),(27,'Eliminar votos');
/*!40000 ALTER TABLE `permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `roles_permisos`
--

LOCK TABLES `roles_permisos` WRITE;
/*!40000 ALTER TABLE `roles_permisos` DISABLE KEYS */;
INSERT INTO `roles_permisos` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8);
/*!40000 ALTER TABLE `roles_permisos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `roles_usuario`
--

LOCK TABLES `roles_usuario` WRITE;
/*!40000 ALTER TABLE `roles_usuario` DISABLE KEYS */;
INSERT INTO `roles_usuario` VALUES (1,'Administrador'),(3,'Autor'),(2,'Editor'),(5,'Invitado'),(4,'Suscriptor');
/*!40000 ALTER TABLE `roles_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `suscriptores`
--

LOCK TABLES `suscriptores` WRITE;
/*!40000 ALTER TABLE `suscriptores` DISABLE KEYS */;
INSERT INTO `suscriptores` VALUES (1,1),(1,2),(1,3),(1,4),(1,5),(1,6),(1,7),(1,8);
/*!40000 ALTER TABLE `suscriptores` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Ana','Martinez','ana.martinez43@gmail.com','1994-04-04','Peru','Lima','https://acortar.link/xeURWz','1997-09-05 14:20:00','2023-10-23 15:00:00'),(2,'Luis','García','luis.garcia@gmail.com','1985-05-05','Mexico','Ciudad de México','https://acortar.link/xeURWz','1993-08-18 11:45:00','2021-10-23 15:00:00'),(3,'Laura','López','laura.lopez@gmail.com','1988-06-06','España','Madrid','https://acortar.link/xeURWz','1998-01-30 12:30:00','2022-10-23 15:00:00'),(4,'Diego','Fernández','diego.fernandez@gmail.com','1991-07-07','Argentina','Córdoba','https://acortar.link/xeURWz','1992-10-05 13:45:00','2023-10-23 15:00:00'),(5,'Carla','Sanchez','carla.sanchez@gmail.com','1995-08-08','Peru','Arequipa','https://acortar.link/xeURWz','1999-11-15 11:15:00','2022-11-23 15:00:00'),(6,'Michael','Johnson','michael.johnson@gmail.com','1987-09-10','United States','New York','https://acortar.link/xeURWz','1992-12-28 12:30:00','2021-10-23 15:00:00'),(7,'Emily','Smith','emily.smith@gmail.com','1990-11-12','United Kingdom','London','https://acortar.link/xeURWz','1994-03-10 13:30:00','2022-10-23 15:00:00'),(8,'Christopher','Brown','christopher.brown@gmail.com','1989-07-15','Australia','Sydney','https://acortar.link/xeURWz','1996-05-20 14:00:00','2023-10-23 15:00:00'),(9,'Jessica','Davis','jessica.davis@gmail.com','1993-04-22','Canada','Toronto','https://acortar.link/xeURWz','1997-09-08 11:30:00','2022-11-23 15:00:00'),(10,'Pedro','Sánchez','pedrosanchez21@hotmail.com','1994-05-23','Uruguay','Montevideo','https://acortar.link/xeURWz','1998-03-10 13:30:00','2023-10-23 15:00:00'),(11,'Luisa','Fernández','luisafernandez@gmail.com','1995-06-24','Argentina','Buenos Aires','https://acortar.link/xeURWz','1999-05-20 14:00:00','2023-10-23 15:00:00'),(12,'Jorge','Pérez','jorgeperez@outlook.com','1996-07-25','Chile','Santiago','https://acortar.link/xeURWz','2000-09-08 11:30:00','2023-10-23 15:00:00'),(13,'Marcela','González','marcelagonzalez@hotmail.com','1997-08-26','Peru','Lima','https://acortar.link/xeURWz','2001-03-10 13:30:00','2023-10-23 15:00:00');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `votos`
--

LOCK TABLES `votos` WRITE;
/*!40000 ALTER TABLE `votos` DISABLE KEYS */;
INSERT INTO `votos` VALUES (1,1,1,1,'2021-01-15 12:30:00','2021-01-15 12:30:00','2021-01-15 12:30:00'),(2,1,2,-1,'2021-01-15 13:15:00','2021-01-15 13:15:00','2021-01-15 13:15:00'),(3,2,3,1,'2021-02-20 14:45:00','2021-02-20 14:45:00','2021-02-20 14:45:00'),(4,4,3,1,'2021-03-12 17:20:00','2021-03-12 17:20:00','2021-03-12 17:20:00'),(5,4,4,-1,'2021-03-12 18:55:00','2021-03-12 18:55:00','2021-03-12 18:55:00'),(6,5,1,1,'2021-04-05 19:30:00','2021-04-05 19:30:00','2021-04-05 19:30:00'),(7,5,2,-1,'2021-04-05 20:10:00','2021-04-05 20:10:00','2021-04-05 20:10:00'),(8,6,3,1,'2021-05-09 15:15:00','2021-05-09 15:15:00','2021-05-09 15:15:00'),(9,6,4,-1,'2021-05-09 15:45:00','2021-05-09 15:45:00','2021-05-09 15:45:00'),(10,7,1,1,'2021-06-11 13:20:00','2021-06-11 13:20:00','2021-06-11 13:20:00'),(11,7,2,-1,'2021-06-11 13:50:00','2021-06-11 13:50:00','2021-06-11 13:50:00'),(12,8,3,1,'2021-07-18 12:40:00','2021-07-18 12:40:00','2021-07-18 12:40:00'),(13,8,4,-1,'2021-07-18 13:25:00','2021-07-18 13:25:00','2021-07-18 13:25:00'),(14,9,1,1,'2021-08-25 14:10:00','2021-08-25 14:10:00','2021-08-25 14:10:00'),(15,9,2,-1,'2021-08-25 14:35:00','2021-08-25 14:35:00','2021-08-25 14:35:00');
/*!40000 ALTER TABLE `votos` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_votos_insert` AFTER INSERT ON `votos` FOR EACH ROW BEGIN
  INSERT INTO `votos_log` (`voto_id`, `accion`, `fecha_registro`) VALUES (NEW.`id`, 'INSERT', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_votos_delete` BEFORE DELETE ON `votos` FOR EACH ROW BEGIN
  INSERT INTO `votos_log` (`voto_id`, `accion`, `fecha_registro`) VALUES (OLD.`id`, 'DELETE', NOW());
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Dumping data for table `votos_log`
--

LOCK TABLES `votos_log` WRITE;
/*!40000 ALTER TABLE `votos_log` DISABLE KEYS */;
INSERT INTO `votos_log` VALUES (1,1,'INSERT','2023-11-12 04:27:43'),(2,2,'INSERT','2023-11-12 04:27:43'),(3,3,'INSERT','2023-11-12 04:27:43'),(4,4,'INSERT','2023-11-12 04:27:43'),(5,5,'INSERT','2023-11-12 04:27:43'),(6,6,'INSERT','2023-11-12 04:27:43'),(7,7,'INSERT','2023-11-12 04:27:43'),(8,8,'INSERT','2023-11-12 04:27:43'),(9,9,'INSERT','2023-11-12 04:27:43'),(10,10,'INSERT','2023-11-12 04:27:43'),(11,11,'INSERT','2023-11-12 04:27:43'),(12,12,'INSERT','2023-11-12 04:27:43'),(13,13,'INSERT','2023-11-12 04:27:43'),(14,14,'INSERT','2023-11-12 04:27:43'),(15,15,'INSERT','2023-11-12 04:27:43');
/*!40000 ALTER TABLE `votos_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'montevideo_noticias'
--

--
-- Dumping routines for database 'montevideo_noticias'
--
/*!50003 DROP FUNCTION IF EXISTS `obtener_calificacion_promedio` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_calificacion_promedio`(articulo_id INT) RETURNS decimal(4,2)
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE calificacion_promedio DECIMAL(4,2) DEFAULT 0.00;
  SELECT AVG(`voto`) INTO calificacion_promedio FROM `votos` WHERE `articulo_id` = articulo_id;
  RETURN calificacion_promedio;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obtener_cantidad_comentarios` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_cantidad_comentarios`(articulo_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE cantidad_comentarios INT DEFAULT 0;
  SELECT COUNT(*) INTO cantidad_comentarios FROM `comentarios` WHERE `articulo_id` = articulo_id;
  RETURN cantidad_comentarios;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `obtener_cantidad_votos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `obtener_cantidad_votos`(articulo_id INT) RETURNS int
    READS SQL DATA
    DETERMINISTIC
BEGIN
  DECLARE cantidad_votos INT DEFAULT 0;
  SELECT SUM(`voto`) INTO cantidad_votos FROM `votos` WHERE `articulo_id` = articulo_id;
  RETURN cantidad_votos;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `InsertarEliminarArticulo` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `InsertarEliminarArticulo`(
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
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `OrdenarArticulos` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `OrdenarArticulos`(
    IN ordenCampo VARCHAR(50), -- Field by which the articles will be sorted
    IN ordenDireccion VARCHAR(4) -- Direction of sort (ASC or DESC)
)
BEGIN
    SET @query = CONCAT('SELECT * FROM `articulos` ORDER BY ', ordenCampo, ' ', ordenDireccion);
    PREPARE dynamic_query FROM @query;
    EXECUTE dynamic_query;
    DEALLOCATE PREPARE dynamic_query;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-20  0:20:57
