USE montevideo_noticias;

-- Datos de ejemplo para la tabla de usuarios

INSERT INTO usuarios (nombre, apellido, email, fecha_nacimiento, pais, localidad, foto_perfil, creado_en, actualizado_en)
VALUES
('Juan', 'Pérez', 'juan.perez@gmail.com', '1990-01-01', 'Uruguay', 'Montevideo', 'https://acortar.link/xeURWz', NOW(), NOW()),
('María', 'González', 'maria.gonzalez@gmail.com', '1992-02-02', 'Argentina', 'Buenos Aires', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Pedro', 'López', 'pedro.lopez@gmail.com', '1994-03-03', 'Brasil', 'Río de Janeiro', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Carlos', 'Fernández', 'carlos.fernandez@gmail.com', '1996-04-04', 'España', 'Madrid', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Laura', 'Martínez', 'laura.martinez@gmail.com', '1998-05-05', 'México', 'Ciudad de México', 'https://acortar.link/xeURWz', NOW(), NOW()),
('José', 'Rodríguez', 'jose.rodriguez@gmail.com', '2000-06-06', 'Colombia', 'Bogotá', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Ana', 'Gómez', 'ana.gomez@gmail.com', '2002-07-07', 'Perú', 'Lima', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Marcelo', 'Fernández', 'marcelofernandez@hotmail.com' , '2004-08-08', 'Chile', 'Santiago', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Sofía', 'Martínez', 'sofimartinez@yahoo.com', '2006-09-09', 'Venezuela', 'Caracas', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Jorge', 'Rodríguez', 'jorgerodriguez@hotmail.com', '2008-10-10', 'Ecuador', 'Quito', 'https://acortar.link/xeURWz', NOW(), NOW()),
('María', 'Gómez', 'mariagomez@yahoo.com', '2010-11-11', 'Bolivia', 'La Paz', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Marcela', 'Fernández', 'marcelafernandez@gmail.com', '2012-12-12', 'Paraguay', 'Asunción', 'https://acortar.link/xeURWz', NOW(), NOW());

-- Datos de ejemplo para la tabla de categorías

INSERT INTO categorias (nombre, descripcion, imagen, creado_en, actualizado_en)
VALUES
('Actualidad', 'Noticias de actualidad nacional e internacional', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Deportes', 'Noticias deportivas nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Cultura', 'Noticias culturales nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Economía', 'Noticias económicas nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Tecnología', 'Noticias tecnológicas nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Salud', 'Noticias de salud nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Ciencia', 'Noticias de ciencia nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Política', 'Noticias políticas nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Opinión', 'Artículos de opinión', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Entrevistas', 'Entrevistas a personalidades nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Reportajes', 'Reportajes nacionales e internacionales', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Investigación', 'Artículos de investigación', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Debates', 'Debates sobre temas de actualidad', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Humor', 'Artículos de humor', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Viajes', 'Artículos sobre viajes', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Gastronomía', 'Artículos sobre gastronomía', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Música', 'Artículos sobre música', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Cine', 'Artículos sobre cine', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Televisión', 'Artículos sobre televisión', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Literatura', 'Artículos sobre literatura', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Arte', 'Artículos sobre arte', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Diseño', 'Artículos sobre diseño', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Arquitectura', 'Artículos sobre arquitectura', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Moda', 'Artículos sobre moda', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Fotografía', 'Artículos sobre fotografía', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Videojuegos', 'Artículos sobre videojuegos', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Deportes', 'Artículos sobre deportes', 'https://acortar.link/xeURWz', NOW(), NOW());

-- Datos de ejemplo para la tabla de autores

INSERT INTO autores (nombre, apellido, biografia, redes_sociales, email, creado_en, actualizado_en)
VALUES
('Juan Pérez', 'Periodista de investigación', 'Especialista en temas de corrupción política', 'Twitter: @juanperez, Facebook: JuanPérez', 'juan.perez@gmail.com', NOW(), NOW()),
('María González', 'Escritora de ficción', 'Autora de varios libros de éxito', 'Twitter: @mariagonzalez, Instagram: @mariagonzalez', 'maria.gonzalez@gmail.com', NOW(), NOW()),
('Pedro López', 'Fotógrafo de guerra', 'Reconocido por su trabajo en zonas de conflicto', 'Twitter: @pedrolopez, Instagram: @pedrolopez', 'pedro.lopez@gmail.com', NOW(), NOW()),
('Carlos Fernández', 'Periodista deportivo', 'Cubre el fútbol español', 'Twitter: @carlosfernandez, Instagram: @carlosfernandez', 'carlos.fernandez@gmail.com', NOW(), NOW()),
('Laura Martínez', 'Periodista de investigación', 'Especialista en temas de corrupción política', 'Twitter: @lauramartinez, Facebook: LauraMartínez', NOW(), NOW()),
('José Rodríguez', 'Escritor de ficción', 'Autor de varios libros de éxito', 'Twitter: @joserodriguez, Instagram: @joserodriguez', NOW(), NOW()),
('Ana Gómez', 'Fotógrafa de guerra', 'Reconocida por su trabajo en zonas de conflicto', 'Twitter: @anagomez, Instagram: @anagomez', NOW(), NOW()),
('Marcelo Fernández', 'Periodista deportivo', 'Cubre el fútbol italiano', 'Twitter: @marcelofernandez, Instagram: @marcelofernandez', NOW(), NOW()),
('Sofía Martínez', 'Periodista de investigación', 'Especialista en temas de corrupción política', 'Twitter: @sofiamartinez, Facebook: SofiaMartínez', NOW(), NOW()),
('Jorge Rodríguez', 'Escritor de ficción', 'Autor de varios libros de éxito', 'Twitter: @jorgerodriguez, Instagram: @jorgerodriguez', NOW(), NOW()),
('María Gómez', 'Fotógrafa de guerra', 'Reconocida por su trabajo en zonas de conflicto', 'Twitter: @mariagomez, Instagram: @mariagomez', NOW(), NOW()),
('Marcela Fernández', 'Periodista deportivo', 'Cubre el fútbol ingles', 'Twitter: @marcelafernandez, Instagram: @marcelafernandez', NOW(), NOW()),
('Sofía Martínez', 'Periodista de investigación', 'Especialista en temas de corrupción política', 'Twitter: @sofiamartinez, Facebook: SofiaMartínez', NOW(), NOW()),
('Jorge Rodríguez', 'Escritor de ficción', 'Autor de varios libros de éxito', 'Twitter: @jorgerodriguez, Instagram: @jorgerodriguez', NOW(), NOW()),
('María Gómez', 'Fotógrafa de guerra', 'Reconocida por su trabajo en zonas de conflicto', 'Twitter: @mariagomez, Instagram: @mariagomez', NOW(), NOW()),
('Marcela Fernández', 'Periodista deportivo', 'Cubre el fútbol frances', 'Twitter: @marcelafernandez, Instagram: @marcelafernandez', NOW(), NOW());

-- Datos de ejemplo para la tabla de articulos

INSERT INTO articulos (titulo, cuerpo, autor_id, categoria_id, resumen, fecha_publicacion, estado_publicacion, imagen, creado_en, actualizado_en)
VALUES
('El presidente de Uruguay se reúne con el presidente de Argentina', 'El presidente de Uruguay se reunió con el presidente de Argentina para tratar temas de interés común', 1, 1, 'El presidente de Uruguay se reunió con el presidente de Argentina para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Argentina se reúne con el presidente de Uruguay', 'El presidente de Argentina se reunió con el presidente de Uruguay para tratar temas de interés común', 2, 1, 'El presidente de Argentina se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Brasil se reúne con el presidente de Uruguay', 'El presidente de Brasil se reunió con el presidente de Uruguay para tratar temas de interés común', 3, 1, 'El presidente de Brasil se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de España se reúne con el presidente de Uruguay', 'El presidente de España se reunió con el presidente de Uruguay para tratar temas de interés común', 4, 1, 'El presidente de España se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de México se reúne con el presidente de Uruguay', 'El presidente de México se reunió con el presidente de Uruguay para tratar temas de interés común', 5, 1, 'El presidente de México se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Colombia se reúne con el presidente de Uruguay', 'El presidente de Colombia se reunió con el presidente de Uruguay para tratar temas de interés común', 6, 1, 'El presidente de Colombia se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Perú se reúne con el presidente de Uruguay', 'El presidente de Perú se reunió con el presidente de Uruguay para tratar temas de interés común', 7, 1, 'El presidente de Perú se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Chile se reúne con el presidente de Uruguay', 'El presidente de Chile se reunió con el presidente de Uruguay para tratar temas de interés común', 8, 1, 'El presidente de Chile se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Venezuela se reúne con el presidente de Uruguay', 'El presidente de Venezuela se reunió con el presidente de Uruguay para tratar temas de interés común', 9, 1, 'El presidente de Venezuela se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Ecuador se reúne con el presidente de Uruguay', 'El presidente de Ecuador se reunió con el presidente de Uruguay para tratar temas de interés común', 10, 1, 'El presidente de Ecuador se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Bolivia se reúne con el presidente de Uruguay', 'El presidente de Bolivia se reunió con el presidente de Uruguay para tratar temas de interés común', 11, 1, 'El presidente de Bolivia se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El presidente de Paraguay se reúne con el presidente de Uruguay', 'El presidente de Paraguay se reunió con el presidente de Uruguay para tratar temas de interés común', 12, 1, 'El presidente de Paraguay se reunió con el presidente de Uruguay para tratar temas de interés común', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Avances en la tecnología 5G prometen una revolución en las comunicaciones', 'Los avances en la tecnología 5G están a punto de cambiar la forma en que nos comunicamos y conectamos con el mundo.', 13, 2, 'Los avances en la tecnología 5G prometen una revolución en las comunicaciones.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Descubren una nueva especie de insecto en la selva amazónica', 'Científicos han identificado una nueva especie de insecto en la selva amazónica, lo que podría tener un impacto significativo en la ecología de la región.', 14, 3, 'Nueva especie de insecto descubierta en la selva amazónica.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El mundo del entretenimiento se prepara para los premios anuales', 'Las estrellas de cine, música y televisión se reúnen para la gala de los premios anuales, donde se reconocen los logros sobresalientes en el mundo del entretenimiento.', 15, 4, 'Los premios anuales reúnen a las celebridades del entretenimiento.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Descubre las maravillas del turismo en el Caribe', 'Explora las hermosas playas, la cultura y la gastronomía del Caribe en este artículo que te guiará a través de las maravillas de la región.', 16, 5, 'Turismo en el Caribe: Una experiencia inolvidable.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Nuevas investigaciones sobre el cambio climático', 'Científicos presentan hallazgos recientes sobre el cambio climático y sus efectos en el planeta. Las advertencias son claras: debemos tomar medidas.', 17, 6, 'Investigaciones sobre el cambio climático.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Los secretos de la cocina mediterránea', 'Descubre los sabores y secretos de la cocina mediterránea, una de las más saludables y deliciosas del mundo.', 18, 7, 'Cocina mediterránea: Sabores únicos y saludables.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Avances en la exploración espacial', 'Las misiones espaciales recientes han revelado datos sorprendentes sobre nuestro sistema solar y más allá. La exploración espacial está en auge.', 19, 8, 'Avances en la exploración del espacio.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El mundo de los deportes: Noticias y eventos destacados', 'Mantente al día con las últimas noticias y eventos destacados en el mundo del deporte, desde fútbol hasta baloncesto y más.', 20, 9, 'Resumen de noticias y eventos deportivos.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('El equipo de fútbol local gana el campeonato nacional', 'El equipo de fútbol local celebró su victoria en el campeonato nacional, emocionando a los fanáticos de todo el país.', 21, 9, 'El equipo de fútbol local se corona campeón nacional.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Nueva estrella del tenis surge en el escenario mundial', 'Un joven tenista se destaca en los torneos internacionales, generando expectación sobre su futuro en el tenis profesional.', 22, 9, 'Una nueva estrella del tenis emerge en el escenario mundial.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW()),
('Empieza la temporada de la NBA con emocionantes partidos', 'La temporada de la NBA ha comenzado con partidos emocionantes y expectativas sobre qué equipos se destacarán este año.', 23, 9, 'Inicio de la temporada de la NBA con emocionantes partidos.', NOW(), 'publicado', 'https://acortar.link/xeURWz', NOW(), NOW());

-- Datos de ejemplo para la tabla de comentarios

INSERT INTO comentarios (articulo_id, autor_id, cuerpo, fecha_publicacion, estado_publicacion, creado_en, actualizado_en)
VALUES
(1, 1, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(1, 2, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(1, 3, 'Me gustó mucho', NOW(), 'publicado', NOW(), NOW()),
(2, 4, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(2, 5, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(2, 6, 'Me gustó mucho', NOW(), 'publicado', NOW(), NOW()),
(3, 7, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(3, 8, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(3, 9, 'Me gustó mucho', NOW(), 'publicado', NOW(), NOW()),
(4, 10, 'Excelente artículo', NOW(), 'publicado', NOW(), NOW()),
(4, 11, 'Muy interesante', NOW(), 'publicado', NOW(), NOW()),
(4, 12, 'Me gustó mucho', NOW(), 'publicado', NOW(), NOW());

-- Datos de ejemplo para la tabla de votos

INSERT INTO votos (articulo_id, autor_id, voto, fecha_voto, creado_en, actualizado_en)
VALUES
(1, 1, 1, NOW(), NOW(), NOW()),
(1, 2, 1, NOW(), NOW(), NOW()),
(1, 3, 1, NOW(), NOW(), NOW()),
(2, 4, 1, NOW(), NOW(), NOW()),
(2, 5, 1, NOW(), NOW(), NOW()),
(2, 6, 1, NOW(), NOW(), NOW()),
(3, 7, 1, NOW(), NOW(), NOW()),
(3, 8, 1, NOW(), NOW(), NOW()),
(3, 9, 1, NOW(), NOW(), NOW()),
(4, 10, 1, NOW(), NOW(), NOW()),
(4, 11, 1, NOW(), NOW(), NOW()),
(4, 12, 1, NOW(), NOW(), NOW()),
(5, 13, 1, NOW(), NOW(), NOW()),
(5, 14, 1, NOW(), NOW(), NOW()),
(5, 15, 1, NOW(), NOW(), NOW()),
(6, 16, 1, NOW(), NOW(), NOW()),
(6, 17, 1, NOW(), NOW(), NOW()),
(6, 18, 1, NOW(), NOW(), NOW()),
(7, 19, 1, NOW(), NOW(), NOW()),
(7, 20, 1, NOW(), NOW(), NOW()),
(7, 21, 1, NOW(), NOW(), NOW()),
(8, 22, 1, NOW(), NOW(), NOW()),
(8, 23, 1, NOW(), NOW(), NOW());

-- Datos de ejemplo para la tabla de etiquetas

INSERT INTO etiquetas (nombre, creado_en, actualizado_en)
VALUES
('Uruguay', NOW(), NOW()),
('Argentina', NOW(), NOW()),
('Brasil', NOW(), NOW()),
('España', NOW(), NOW()),
('México', NOW(), NOW()),
('Colombia', NOW(), NOW()),
('Perú', NOW(), NOW()),
('Chile', NOW(), NOW()),
('Venezuela', NOW(), NOW()),
('Ecuador', NOW(), NOW()),
('Bolivia', NOW(), NOW()),
('Paraguay', NOW(), NOW()),
('Actualidad', NOW(), NOW()),
('Deportes', NOW(), NOW()),
('Cultura', NOW(), NOW()),
('Economía', NOW(), NOW()),
('Tecnología', NOW(), NOW()),
('Salud', NOW(), NOW()),
('Ciencia', NOW(), NOW()),
('Política', NOW(), NOW()),
('Opinión', NOW(), NOW()),
('Entrevistas', NOW(), NOW()),
('Reportajes', NOW(), NOW()),
('Investigación', NOW(), NOW()),
('Debates', NOW(), NOW()),
('Humor', NOW(), NOW()),
('Viajes', NOW(), NOW()),
('Gastronomía', NOW(), NOW()),
('Música', NOW(), NOW()),
('Cine', NOW(), NOW()),
('Televisión', NOW(), NOW()),
('Literatura', NOW(), NOW()),
('Arte', NOW(), NOW()),
('Diseño', NOW(), NOW()),
('Arquitectura', NOW(), NOW()),
('Moda', NOW(), NOW()),
('Fotografía', NOW(), NOW()),
('Videojuegos', NOW(), NOW()),
('Deportes', NOW(), NOW());

-- Datos de ejemplo para la tabla de articulos_etiquetas

INSERT INTO articulos_etiquetas (articulo_id, etiqueta_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(3, 9),
(4, 10),
(4, 11),
(4, 12);

-- Datos de ejemplo para la tabla de suscriptores

INSERT INTO suscriptores (usuario_id, categoria_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(2, 4),
(2, 5),
(2, 6),
(3, 7),
(3, 8),
(3, 9),
(4, 10),
(4, 11),
(4, 12);

-- Datos de ejemplo para la tabla de roles de usuario

INSERT INTO roles_usuario (nombre)
VALUES
('Administrador'),
('Editor'),
('Autor'),
('Suscriptor');

-- Datos de ejemplo para la tabla de permisos

INSERT INTO permisos (nombre)
VALUES
('Crear usuarios'),
('Editar usuarios'),
('Eliminar usuarios'),
('Crear categorías'),
('Editar categorías'),
('Eliminar categorías'),
('Crear autores'),
('Editar autores'),
('Eliminar autores'),
('Crear artículos'),
('Editar artículos'),
('Eliminar artículos'),
('Crear comentarios'),
('Editar comentarios'),
('Eliminar comentarios'),
('Crear votos'),
('Editar votos'),
('Eliminar votos'),
('Crear etiquetas'),
('Editar etiquetas'),
('Eliminar etiquetas'),
('Crear suscriptores'),
('Editar suscriptores'),
('Eliminar suscriptores'),
('Crear roles de usuario'),
('Editar roles de usuario'),
('Eliminar roles de usuario'),
('Crear permisos'),
('Editar permisos'),
('Eliminar permisos');

-- Datos de ejemplo para la tabla de roles_permisos

INSERT INTO roles_permisos (rol_id, permiso_id)
VALUES
(1, 1),
(1, 2),
(1, 3),
(1, 4),
(1, 5),
(1, 6),
(1, 7),
(1, 8),
(1, 9),
(1, 10),
(1, 11),
(1, 12);