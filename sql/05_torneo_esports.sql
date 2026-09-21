/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 5: TORNEO DE ESPORTS
   ----------------------------------------------------------------------------
   Caso: La organizacion "Liga Andina de eSports" administra equipos, jugadores
         y torneos. Necesita controlar que jugadores pertenecen a cada equipo y
         que equipos participan en cada torneo.
   Relaciones:
     - equipos 1:N jugadores
     - torneos N:M equipos -> tabla puente torneo_equipo
   ============================================================================ */

CREATE DATABASE ej5_liga_andina_esports
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej5_liga_andina_esports;

-- ----------------------------------------------------------------------------
-- DDL: tablas
-- ----------------------------------------------------------------------------
CREATE TABLE equipos (
    id_equipo       INT         NOT NULL AUTO_INCREMENT,
    nombre          VARCHAR(60) NOT NULL,
    ciudad          VARCHAR(40) NOT NULL,
    fecha_fundacion DATE        NOT NULL,
    entrenador      VARCHAR(80) NOT NULL,
    PRIMARY KEY (id_equipo),
    UNIQUE KEY uq_equipos_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE jugadores (
    id_jugador   INT         NOT NULL AUTO_INCREMENT,
    nick         VARCHAR(30) NOT NULL,
    nombre_real  VARCHAR(80) NOT NULL,
    rol          VARCHAR(30) NOT NULL,
    edad         TINYINT     NOT NULL,
    id_equipo    INT         NOT NULL,
    PRIMARY KEY (id_jugador),
    UNIQUE KEY uq_jugadores_nick (nick),
    CONSTRAINT fk_jugadores_equipo
        FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE torneos (
    id_torneo    INT           NOT NULL AUTO_INCREMENT,
    nombre       VARCHAR(80)   NOT NULL,
    juego        VARCHAR(50)   NOT NULL,
    fecha_inicio DATE          NOT NULL,
    fecha_fin    DATE          NOT NULL,
    sede         VARCHAR(60)   NOT NULL,
    premio_usd   DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (id_torneo),
    UNIQUE KEY uq_torneos_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla puente: un torneo tiene varios equipos y un equipo juega varios torneos.
CREATE TABLE torneo_equipo (
    id_torneo       INT     NOT NULL,
    id_equipo       INT     NOT NULL,
    grupo           CHAR(1) NOT NULL,
    posicion_final  TINYINT NULL,     -- NULL mientras el torneo no termina
    PRIMARY KEY (id_torneo, id_equipo),
    CONSTRAINT fk_te_torneo
        FOREIGN KEY (id_torneo) REFERENCES torneos (id_torneo)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_te_equipo
        FOREIGN KEY (id_equipo) REFERENCES equipos (id_equipo)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- DML: datos de prueba
-- ----------------------------------------------------------------------------
INSERT INTO equipos (nombre, ciudad, fecha_fundacion, entrenador) VALUES
('Dragones Digitales', 'Quito',      '2019-03-14', 'Rodrigo Maldonado'),
('Pumas Binarios',     'Guayaquil',  '2020-07-25', 'Silvia Arteaga'),
('Kondor Esports',     'Cuenca',     '2018-11-02', 'Jonathan Peralta'),
('Neon Manabi',        'Manta',      '2021-05-19', 'Karla Mendoza');

INSERT INTO jugadores (nick, nombre_real, rol, edad, id_equipo) VALUES
('drk_flame',   'Alejandro Salazar',  'Carry',      22, 1),
('valkiria99',  'Michelle Andrade',   'Support',    24, 1),
('n0ct4',       'Bryan Montenegro',   'Mid laner',  20, 1),
('ceniza',      'Paola Trujillo',     'Offlaner',   23, 1),
('ironpaw',     'Steven Ochoa',       'Jungla',     21, 1),
('puma_zero',   'Erick Bravo',        'Carry',      19, 2),
('lince_azul',  'Nicole Palacios',    'Support',    25, 2),
('mecha_gye',   'Christian Solorzano','Mid laner',  22, 2),
('kondorx',     'Luis Cabrera',       'Carry',      26, 3),
('andina',      'Jazmin Uyaguari',    'Support',    23, 3),
('cuenca_bot',  'Diego Vintimilla',   'Jungla',     20, 3),
('neon_wave',   'Anthony Cedeno',     'Carry',      18, 4),
('marea_alta',  'Melany Pincay',      'Support',    21, 4);

INSERT INTO torneos (nombre, juego, fecha_inicio, fecha_fin, sede, premio_usd) VALUES
('Copa Andina Invierno', 'League of Legends', '2025-06-10', '2025-06-22', 'Quito',     8000.00),
('Clasico Digital',      'Valorant',          '2026-03-05', '2026-03-15', 'Guayaquil',12000.00),
('Altura Open',          'Dota 2',            '2026-08-12', '2026-08-24', 'Cuenca',   15000.00),
('Costa Showdown',       'Valorant',          '2026-11-07', '2026-11-16', 'Manta',     9500.00),
('Liga Sur Masters',     'League of Legends', '2027-02-01', '2027-02-12', 'Loja',     20000.00);

INSERT INTO torneo_equipo (id_torneo, id_equipo, grupo, posicion_final) VALUES
(1, 1, 'A', 2),
(1, 3, 'A', 1),
(2, 1, 'A', 1),
(2, 2, 'A', 3),
(2, 4, 'B', 2),
(3, 1, 'B', 4),
(3, 2, 'A', 1),
(3, 3, 'A', 2),
(4, 2, 'A', NULL),
(4, 4, 'A', NULL),
(5, 1, 'A', NULL),
(5, 3, 'B', NULL);

/* ============================================================================
   CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar los jugadores del equipo "Dragones Digitales".
SELECT j.*
FROM jugadores AS j
INNER JOIN equipos AS e ON e.id_equipo = j.id_equipo
WHERE e.nombre = 'Dragones Digitales';

-- Consulta 2: listar los torneos programados para este anio.
SELECT *
FROM torneos
WHERE YEAR(fecha_inicio) = YEAR(CURDATE());

-- Consulta 3: contar cuantos jugadores tiene cada equipo.
SELECT e.nombre AS equipo, COUNT(j.id_jugador) AS total_jugadores
FROM equipos AS e
LEFT JOIN jugadores AS j ON j.id_equipo = e.id_equipo
GROUP BY e.id_equipo, e.nombre;

-- Consulta 4: mostrar que equipos participan en cada torneo.
SELECT t.nombre AS torneo, e.nombre AS equipo
FROM torneos AS t
INNER JOIN torneo_equipo AS te ON te.id_torneo = t.id_torneo
INNER JOIN equipos AS e        ON e.id_equipo  = te.id_equipo;
