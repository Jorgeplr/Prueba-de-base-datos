/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 3: BIBLIOTECA MULTIMEDIA
   ----------------------------------------------------------------------------
   Caso: La mediateca "Sala Lumiere" desea registrar la informacion de sus
         peliculas y de los directores que las dirigieron.
   Relacion: directores 1:N peliculas
   ============================================================================ */

DROP DATABASE IF EXISTS ej3_sala_lumiere;
CREATE DATABASE ej3_sala_lumiere
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej3_sala_lumiere;

-- ----------------------------------------------------------------------------
-- DDL: tablas
-- ----------------------------------------------------------------------------
CREATE TABLE directores (
    id_director     INT         NOT NULL AUTO_INCREMENT,
    nombres         VARCHAR(60) NOT NULL,
    apellidos       VARCHAR(60) NOT NULL,
    nacionalidad    VARCHAR(40) NOT NULL,
    anio_nacimiento SMALLINT    NOT NULL,
    PRIMARY KEY (id_director)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE peliculas (
    id_pelicula      INT          NOT NULL AUTO_INCREMENT,
    titulo           VARCHAR(120) NOT NULL,
    genero           VARCHAR(40)  NOT NULL,
    anio_estreno     SMALLINT     NOT NULL,
    duracion_minutos SMALLINT     NOT NULL,
    idioma           VARCHAR(30)  NOT NULL DEFAULT 'Espanol',
    copias_disponibles TINYINT    NOT NULL DEFAULT 1,
    id_director      INT          NOT NULL,
    PRIMARY KEY (id_pelicula),
    KEY idx_peliculas_genero (genero),
    CONSTRAINT fk_peliculas_director
        FOREIGN KEY (id_director) REFERENCES directores (id_director)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- DML: datos de prueba (titulos y directores ficticios de la mediateca)
-- ----------------------------------------------------------------------------
INSERT INTO directores (nombres, apellidos, nacionalidad, anio_nacimiento) VALUES
('Helena',  'Matamoros', 'Ecuatoriana', 1978),
('Bruno',   'Salcedo',   'Chilena',     1965),
('Amara',   'Okonkwo',   'Nigeriana',   1984),
('Teodoro', 'Rivas',     'Mexicana',    1971),
('Nadia',   'Kirilenko', 'Ucraniana',   1990);

INSERT INTO peliculas (titulo, genero, anio_estreno, duracion_minutos, idioma, copias_disponibles, id_director) VALUES
('El ultimo tren a Latacunga', 'Drama',            2019, 112, 'Espanol', 3, 1),
('Cenizas de sal',             'Drama',            2022,  98, 'Espanol', 2, 1),
('La ruta del condor',         'Documental',       2021, 84,  'Espanol', 4, 2),
('Nieve sobre el desierto',    'Ciencia ficcion',  2023, 131, 'Ingles',  2, 2),
('Kilometro cero',             'Accion',           2018, 105, 'Espanol', 5, 4),
('Lagos de neon',              'Ciencia ficcion',  2024, 118, 'Ingles',  1, 3),
('La casa de las abuelas',     'Comedia',          2020,  92, 'Espanol', 3, 4),
('Ojos de tormenta',           'Suspenso',         2025, 107, 'Ingles',  2, 3),
('Invierno en Odesa',          'Drama',            2024, 124, 'Ucraniano', 1, 5),
('Raiz cuadrada del miedo',    'Suspenso',         2016,  96, 'Espanol', 2, 5),
('Manifiesto de papel',        'Documental',       2026,  78, 'Espanol', 1, 1),
('Orbita baja',                'Ciencia ficcion',  2020, 140, 'Ingles',  2, 2);

/* ============================================================================
   CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar todas las peliculas (con el director que las dirigio).
SELECT p.id_pelicula,
       p.titulo,
       p.genero,
       p.anio_estreno,
       p.duracion_minutos,
       CONCAT(d.nombres, ' ', d.apellidos) AS director
FROM peliculas AS p
INNER JOIN directores AS d ON d.id_director = p.id_director
ORDER BY p.titulo;

-- Consulta 2: mostrar las peliculas estrenadas despues de 2020.
SELECT p.id_pelicula,
       p.titulo,
       p.genero,
       p.anio_estreno,
       CONCAT(d.nombres, ' ', d.apellidos) AS director
FROM peliculas AS p
INNER JOIN directores AS d ON d.id_director = p.id_director
WHERE p.anio_estreno > 2020
ORDER BY p.anio_estreno DESC, p.titulo;

-- Consulta 3: mostrar las peliculas de un genero determinado (Ciencia ficcion).
SELECT p.id_pelicula,
       p.titulo,
       p.anio_estreno,
       p.duracion_minutos,
       p.copias_disponibles,
       CONCAT(d.nombres, ' ', d.apellidos) AS director
FROM peliculas AS p
INNER JOIN directores AS d ON d.id_director = p.id_director
WHERE p.genero = 'Ciencia ficcion'
ORDER BY p.anio_estreno DESC;
