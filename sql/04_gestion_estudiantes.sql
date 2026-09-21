/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 4: GESTION DE ESTUDIANTES
   ----------------------------------------------------------------------------
   Caso: El "Instituto Superior Antares" necesita administrar a sus estudiantes
         y las matriculas que realizan cada periodo academico.
   Relaciones:
     - carreras    1:N estudiantes
     - estudiantes 1:N matriculas
   ============================================================================ */

CREATE DATABASE ej4_instituto_antares
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej4_instituto_antares;

-- ----------------------------------------------------------------------------
-- DDL: tablas
-- ----------------------------------------------------------------------------
CREATE TABLE carreras (
    id_carrera         INT         NOT NULL AUTO_INCREMENT,
    nombre             VARCHAR(80) NOT NULL,
    modalidad          ENUM('presencial','virtual','hibrida') NOT NULL DEFAULT 'presencial',
    duracion_semestres TINYINT     NOT NULL,
    PRIMARY KEY (id_carrera),
    UNIQUE KEY uq_carreras_nombre (nombre)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE estudiantes (
    id_estudiante    INT         NOT NULL AUTO_INCREMENT,
    cedula           VARCHAR(15) NOT NULL,
    nombres          VARCHAR(60) NOT NULL,
    apellidos        VARCHAR(60) NOT NULL,
    fecha_nacimiento DATE        NOT NULL,
    correo           VARCHAR(90) NOT NULL,
    telefono         VARCHAR(15) NULL,
    ciudad           VARCHAR(40) NOT NULL,
    id_carrera       INT         NOT NULL,
    PRIMARY KEY (id_estudiante),
    UNIQUE KEY uq_estudiantes_cedula (cedula),
    UNIQUE KEY uq_estudiantes_correo (correo),
    CONSTRAINT fk_estudiantes_carrera
        FOREIGN KEY (id_carrera) REFERENCES carreras (id_carrera)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE matriculas (
    id_matricula  INT         NOT NULL AUTO_INCREMENT,
    id_estudiante INT         NOT NULL,
    periodo       VARCHAR(15) NOT NULL,          -- ejemplo: 2026-2S
    fecha         DATE        NOT NULL,
    estado        ENUM('registrada','pagada','anulada') NOT NULL DEFAULT 'registrada',
    PRIMARY KEY (id_matricula),
    UNIQUE KEY uq_matricula_estudiante_periodo (id_estudiante, periodo),
    CONSTRAINT fk_matriculas_estudiante
        FOREIGN KEY (id_estudiante) REFERENCES estudiantes (id_estudiante)
        ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- DML: datos de prueba
-- ----------------------------------------------------------------------------
INSERT INTO carreras (nombre, modalidad, duracion_semestres) VALUES
('Desarrollo de software',      'presencial', 5),
('Diseno multimedia',           'hibrida',    5),
('Redes y telecomunicaciones',  'presencial', 6),
('Marketing digital',           'virtual',    4);

INSERT INTO estudiantes (cedula, nombres, apellidos, fecha_nacimiento, correo, telefono, ciudad, id_carrera) VALUES
('0923451871', 'Andres',   'Pilataxi',  '2004-02-18', 'andres.pilataxi@antares.edu',  '0991234567', 'Quito',      1),
('0918273645', 'Camila',   'Verdugo',   '2003-11-05', 'camila.verdugo@antares.edu',   '0987654321', 'Guayaquil',  1),
('1725489630', 'Joel',     'Naranjo',   '2009-06-30', 'joel.naranjo@antares.edu',     '0965432178', 'Ambato',     1),
('1712398745', 'Valentina','Sarmiento', '2002-09-12', 'valentina.sarmiento@antares.edu','0978451236','Cuenca',    2),
('0604512398', 'Mateo',    'Chimbo',    '2008-12-24', 'mateo.chimbo@antares.edu',     '0954123698', 'Riobamba',   2),
('1309871245', 'Dayana',   'Zambrano',  '2001-04-03', 'dayana.zambrano@antares.edu',  '0993216547', 'Manta',      3),
('0801234567', 'Kevin',    'Caicedo',   '2005-08-21', 'kevin.caicedo@antares.edu',    '0986541237', 'Esmeraldas', 3),
('1104567823', 'Brenda',   'Jaramillo', '2000-01-29', 'brenda.jaramillo@antares.edu', '0971234589', 'Loja',       4),
('0703215698', 'Ismael',   'Tandazo',   '2007-10-16', 'ismael.tandazo@antares.edu',   '0968745123', 'Machala',    4),
('1003698521', 'Fernanda', 'Imbaquingo','1999-05-07', 'fernanda.imbaquingo@antares.edu','0995874123','Ibarra',    1);

INSERT INTO matriculas (id_estudiante, periodo, fecha, estado) VALUES
( 1, '2026-2S', '2026-09-01', 'pagada'),
( 2, '2026-2S', '2026-09-01', 'pagada'),
( 3, '2026-2S', '2026-09-02', 'registrada'),
( 4, '2026-2S', '2026-09-02', 'pagada'),
( 5, '2026-2S', '2026-09-03', 'registrada'),
( 6, '2026-2S', '2026-09-03', 'pagada'),
( 7, '2026-2S', '2026-09-04', 'anulada'),
( 8, '2026-2S', '2026-09-04', 'pagada'),
( 9, '2026-2S', '2026-09-05', 'registrada'),
(10, '2026-2S', '2026-09-05', 'pagada');

/* ============================================================================
   CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar todos los estudiantes.
SELECT *
FROM estudiantes;

-- Consulta 2: mostrar los estudiantes mayores de 18 anios.
-- TIMESTAMPDIFF calcula la edad a partir de la fecha de nacimiento.
SELECT *
FROM estudiantes
WHERE TIMESTAMPDIFF(YEAR, fecha_nacimiento, CURDATE()) > 18;

-- Consulta 3: mostrar los estudiantes de una carrera especifica.
SELECT e.*
FROM estudiantes AS e
INNER JOIN carreras AS c ON c.id_carrera = e.id_carrera
WHERE c.nombre = 'Desarrollo de software';
