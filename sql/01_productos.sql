/* ============================================================================
   TAREA 1 - BASES DE DATOS  |  EJERCICIO 1: ADMINISTRACION DE PRODUCTOS
   ----------------------------------------------------------------------------
   Caso: "Taller Prisma 3D", una empresa que comercializa insumos y repuestos
         para impresion 3D, necesita administrar los productos que vende.
   ============================================================================ */

-- ----------------------------------------------------------------------------
-- 1) DDL: creacion de la base de datos
-- ----------------------------------------------------------------------------
DROP DATABASE IF EXISTS ej1_taller_prisma3d;
CREATE DATABASE ej1_taller_prisma3d
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_spanish_ci;

USE ej1_taller_prisma3d;

-- ----------------------------------------------------------------------------
-- 2) DDL: creacion de la tabla
--    Entidad unica: producto (el caso no exige relaciones).
-- ----------------------------------------------------------------------------
CREATE TABLE productos (
    id_producto     INT           NOT NULL AUTO_INCREMENT,
    codigo          VARCHAR(20)   NOT NULL,
    nombre          VARCHAR(80)   NOT NULL,
    categoria       VARCHAR(40)   NOT NULL,
    precio          DECIMAL(10,2) NOT NULL,
    stock           INT           NOT NULL DEFAULT 0,
    fecha_ingreso   DATE          NOT NULL,
    PRIMARY KEY (id_producto),
    UNIQUE KEY uq_productos_codigo (codigo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ----------------------------------------------------------------------------
-- 3) DML: carga de datos de prueba
-- ----------------------------------------------------------------------------
INSERT INTO productos (codigo, nombre, categoria, precio, stock, fecha_ingreso) VALUES
('FIL-PLA-BLA', 'Filamento PLA 1.75mm blanco 1kg',      'Filamentos',  24.90,  35, '2026-01-15'),
('FIL-PET-NEG', 'Filamento PETG 1.75mm negro 1kg',      'Filamentos',  31.50,  18, '2026-01-15'),
('FIL-ABS-ROJ', 'Filamento ABS 1.75mm rojo 1kg',        'Filamentos',  28.75,   7, '2026-02-03'),
('RES-STD-GRI', 'Resina estandar gris 1L',              'Resinas',     52.00,  12, '2026-02-03'),
('RES-DEN-TRA', 'Resina dental translucida 500ml',      'Resinas',    145.00,   4, '2026-02-20'),
('BOQ-060-LAT', 'Boquilla de laton 0.6mm',              'Repuestos',    4.20,  80, '2026-03-01'),
('BOQ-040-END', 'Boquilla endurecida 0.4mm',            'Repuestos',   18.90,   9, '2026-03-01'),
('EXT-DIR-V6',  'Extrusor directo V6 completo',         'Repuestos',   89.90,   6, '2026-03-18'),
('PLA-PEI-220', 'Placa flexible PEI 220x220mm',         'Accesorios',  34.00,  22, '2026-04-05'),
('LAV-UV-02',   'Estacion de lavado y curado UV',       'Equipos',    210.00,   3, '2026-04-05'),
('IMP-FDM-01',  'Impresora FDM 220x220x250mm',          'Equipos',    399.99,   5, '2026-05-10'),
('HER-ESP-KIT', 'Kit de esputulas y pinzas',            'Accesorios',   12.50,  40, '2026-05-10'),
('SEC-FIL-01',  'Secador de filamento 2 bobinas',       'Accesorios',   76.40,   8, '2026-06-02'),
('ADH-LAC-01',  'Laca adherente para cama 400ml',       'Consumibles',  9.80,  25, '2026-06-02'),
('ALC-ISO-05',  'Alcohol isopropilico 99% 5L',          'Consumibles', 58.30,   2, '2026-06-20');

/* ============================================================================
   4) CONSULTAS SOLICITADAS
   ============================================================================ */

-- Consulta 1: mostrar todos los productos.
SELECT *
FROM productos
ORDER BY id_producto;

-- Consulta 2: mostrar los productos cuyo precio sea mayor a $50.
SELECT id_producto, codigo, nombre, categoria, precio, stock
FROM productos
WHERE precio > 50
ORDER BY precio DESC;

-- Consulta 3: mostrar los productos que tengan stock menor a 10.
SELECT id_producto, codigo, nombre, categoria, stock, precio
FROM productos
WHERE stock < 10
ORDER BY stock ASC;
