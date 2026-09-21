/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 2: ESTUDIO DE VIDEOJUEGOS
   ----------------------------------------------------------------------------
   Caso: "Nube Roja Studio" necesita registrar sus desarrolladores, los
         proyectos en los que trabajan y las tareas asignadas, para saber quien
         participa en cada proyecto y controlar el avance del trabajo.
   Relaciones:
     - proyectos  N:M  desarrolladores  -> tabla puente proyecto_desarrollador
     - tareas      N:1  proyectos
     - tareas      N:1  desarrolladores
   ============================================================================ */

-- ----------------------------------------------------------------------------
-- 1) DDL: base de datos
-- ----------------------------------------------------------------------------
DROP DATABASE IF EXISTS ej2_nube_roja_studio;
CREATE DATABASE ej2_nube_roja_studio
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej2_nube_roja_studio;

-- ----------------------------------------------------------------------------
-- 2) DDL: tablas
-- ----------------------------------------------------------------------------
CREATE TABLE desarrolladores (
    id_desarrollador INT         NOT NULL AUTO_INCREMENT,
    nombres          VARCHAR(60) NOT NULL,
    apellidos        VARCHAR(60) NOT NULL,
    rol              VARCHAR(40) NOT NULL,
    correo           VARCHAR(90) NOT NULL,
    fecha_ingreso    DATE        NOT NULL,
    PRIMARY KEY (id_desarrollador),
    UNIQUE KEY uq_desarrolladores_correo (correo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE proyectos (
    id_proyecto   INT         NOT NULL AUTO_INCREMENT,
    nombre        VARCHAR(80) NOT NULL,
    plataforma    VARCHAR(40) NOT NULL,
    fecha_inicio  DATE        NOT NULL,
    estado        ENUM('planificacion','desarrollo','pruebas','publicado') NOT NULL DEFAULT 'desarrollo',
    PRIMARY KEY (id_proyecto),
    UNIQUE KEY uq_proyectos_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabla puente: resuelve la relacion muchos a muchos.
CREATE TABLE proyecto_desarrollador (
    id_proyecto      INT NOT NULL,
    id_desarrollador INT NOT NULL,
    horas_semana     INT NOT NULL DEFAULT 40,
    PRIMARY KEY (id_proyecto, id_desarrollador),
    CONSTRAINT fk_pd_proyecto
        FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_pd_desarrollador
        FOREIGN KEY (id_desarrollador) REFERENCES desarrolladores (id_desarrollador)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE tareas (
    id_tarea         INT          NOT NULL AUTO_INCREMENT,
    titulo           VARCHAR(120) NOT NULL,
    estado           ENUM('pendiente','en_progreso','completada') NOT NULL DEFAULT 'pendiente',
    prioridad        ENUM('baja','media','alta') NOT NULL DEFAULT 'media',
    fecha_limite     DATE         NOT NULL,
    id_proyecto      INT          NOT NULL,
    id_desarrollador INT          NOT NULL,
    PRIMARY KEY (id_tarea),
    CONSTRAINT fk_tareas_proyecto
        FOREIGN KEY (id_proyecto) REFERENCES proyectos (id_proyecto)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_tareas_desarrollador
        FOREIGN KEY (id_desarrollador) REFERENCES desarrolladores (id_desarrollador)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 3) DML: datos de prueba
-- ----------------------------------------------------------------------------
INSERT INTO desarrolladores (nombres, apellidos, rol, correo, fecha_ingreso) VALUES
('Mariela', 'Cordova',  'Programadora gameplay', 'mariela.cordova@nuberoja.dev', '2023-03-06'),
('Ignacio', 'Vasquez',  'Artista 3D',            'ignacio.vasquez@nuberoja.dev', '2023-07-17'),
('Sofia',   'Benitez',  'Disenadora de niveles', 'sofia.benitez@nuberoja.dev',   '2024-01-08'),
('Damian',  'Loor',     'Programador de motor',  'damian.loor@nuberoja.dev',     '2024-05-20'),
('Renata',  'Aguirre',  'Disenadora de sonido',  'renata.aguirre@nuberoja.dev',  '2025-02-10'),
('Tomas',   'Quispe',   'QA tester',             'tomas.quispe@nuberoja.dev',    '2025-09-01');

INSERT INTO proyectos (nombre, plataforma, fecha_inicio, estado) VALUES
('Space Adventure',   'PC / Steam',      '2025-04-01', 'desarrollo'),
('Raices de Niebla',  'Nintendo Switch', '2025-11-12', 'planificacion'),
('Duelo de Faroles',  'Movil Android',   '2024-08-19', 'pruebas');

INSERT INTO proyecto_desarrollador (id_proyecto, id_desarrollador, horas_semana) VALUES
(1, 1, 40),   -- Space Adventure  <- Mariela
(1, 2, 30),   -- Space Adventure  <- Ignacio
(1, 4, 40),   -- Space Adventure  <- Damian
(1, 6, 20),   -- Space Adventure  <- Tomas
(2, 3, 35),   -- Raices de Niebla <- Sofia
(2, 5, 25),   -- Raices de Niebla <- Renata
(3, 1, 10),   -- Duelo de Faroles <- Mariela
(3, 3, 15);   -- Duelo de Faroles <- Sofia

INSERT INTO tareas (titulo, estado, prioridad, fecha_limite, id_proyecto, id_desarrollador) VALUES
('Implementar salto con impulso variable', 'completada',  'alta',  '2026-07-10', 1, 1),
('Corregir colisiones en la nave madre',   'pendiente',   'alta',  '2026-10-02', 1, 1),
('Modelar asteroides de fondo',            'en_progreso', 'media', '2026-10-15', 1, 2),
('Optimizar carga de escenas',             'pendiente',   'alta',  '2026-09-30', 1, 4),
('Plan de pruebas del nivel 3',            'pendiente',   'media', '2026-10-20', 1, 6),
('Bocetar el bosque de niebla',            'en_progreso', 'media', '2026-11-05', 2, 3),
('Grabar ambiente de lluvia',              'pendiente',   'baja',  '2026-11-18', 2, 5),
('Musica del menu principal',              'completada',  'media', '2026-08-22', 2, 5),
('Ajustar dificultad de los faroles',      'pendiente',   'media', '2026-09-28', 3, 3),
('Reparar guardado en la nube',            'en_progreso', 'alta',  '2026-10-08', 3, 1);

/* ============================================================================
   4) CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar todos los desarrolladores asignados al proyecto "Space Adventure".
SELECT d.id_desarrollador,
       CONCAT(d.nombres, ' ', d.apellidos) AS desarrollador,
       d.rol,
       pd.horas_semana,
       p.nombre AS proyecto
FROM desarrolladores AS d
INNER JOIN proyecto_desarrollador AS pd ON pd.id_desarrollador = d.id_desarrollador
INNER JOIN proyectos AS p              ON p.id_proyecto        = pd.id_proyecto
WHERE p.nombre = 'Space Adventure'
ORDER BY d.apellidos;

-- Consulta 2: listar todas las tareas pendientes.
SELECT t.id_tarea,
       t.titulo,
       t.prioridad,
       t.fecha_limite,
       p.nombre AS proyecto,
       CONCAT(d.nombres, ' ', d.apellidos) AS responsable
FROM tareas AS t
INNER JOIN proyectos AS p       ON p.id_proyecto        = t.id_proyecto
INNER JOIN desarrolladores AS d ON d.id_desarrollador   = t.id_desarrollador
WHERE t.estado = 'pendiente'
ORDER BY t.fecha_limite;

-- Consulta 3: contar cuantas tareas tiene asignado cada desarrollador.
-- Se usa LEFT JOIN para que tambien aparezcan los que tienen 0 tareas.
SELECT CONCAT(d.nombres, ' ', d.apellidos) AS desarrollador,
       d.rol,
       COUNT(t.id_tarea) AS total_tareas
FROM desarrolladores AS d
LEFT JOIN tareas AS t ON t.id_desarrollador = d.id_desarrollador
GROUP BY d.id_desarrollador, desarrollador, d.rol
ORDER BY total_tareas DESC, desarrollador;

-- Consulta 4: mostrar los proyectos y la cantidad de desarrolladores que participan en cada uno.
SELECT p.id_proyecto,
       p.nombre AS proyecto,
       p.plataforma,
       p.estado,
       COUNT(pd.id_desarrollador) AS total_desarrolladores
FROM proyectos AS p
LEFT JOIN proyecto_desarrollador AS pd ON pd.id_proyecto = p.id_proyecto
GROUP BY p.id_proyecto, p.nombre, p.plataforma, p.estado
ORDER BY total_desarrolladores DESC;
