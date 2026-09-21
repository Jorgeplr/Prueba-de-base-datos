# Tarea 1 — Bases de datos (MySQL + HeidiSQL)

Asignatura: **Lenguaje informatico para desarrollo de productos**
Unidad 2 — Introduccion a bases de datos para medios digitales
Tipo de actividad: taller de consultas SQL basicas (DDL y DML).

Este repositorio contiene el diseno y los scripts SQL de los **cinco ejercicios**
del enunciado, mas la documentacion para ejecutarlos en HeidiSQL.

---

## Estructura del repositorio

```
.
├── README.md                          Este documento
├── sql/
│   ├── 00_tarea1_completo.sql         Los 5 ejercicios en un solo script
│   ├── 01_productos.sql               Ejercicio 1: administracion de productos
│   ├── 02_estudio_videojuegos.sql     Ejercicio 2: estudio de videojuegos
│   ├── 03_biblioteca_multimedia.sql   Ejercicio 3: biblioteca multimedia
│   ├── 04_gestion_estudiantes.sql     Ejercicio 4: gestion de estudiantes
│   └── 05_torneo_esports.sql          Ejercicio 5: torneo de eSports
└── docs/
    ├── GUIA_HEIDISQL.md               Paso a paso en HeidiSQL (ejecutar, capturar, exportar)
    └── RESULTADOS_CONSULTAS.md        Salida real de las 18 consultas, ya verificada
```

Cada script es **autocontenido**: crea su base de datos, las tablas, los datos de
prueba y al final las consultas solicitadas.

---

## Los cinco ejercicios

### Ejercicio 1 — Administracion de productos
**Base:** `ej1_taller_prisma3d` — caso: taller de insumos para impresion 3D.

| Tabla | Campos principales |
|---|---|
| `productos` | `id_producto`, `codigo`, `nombre`, `categoria`, `precio`, `stock`, `fecha_ingreso` |

Consultas: todos los productos · precio mayor a $50 · stock menor a 10.

### Ejercicio 2 — Estudio de videojuegos
**Base:** `ej2_nube_roja_studio` — caso: estudio independiente "Nube Roja".

| Tabla | Rol |
|---|---|
| `desarrolladores` | Personas del estudio |
| `proyectos` | Juegos en produccion |
| `proyecto_desarrollador` | **Tabla puente** de la relacion N:M |
| `tareas` | Trabajo asignado (N:1 con proyecto y con desarrollador) |

Consultas: desarrolladores de "Space Adventure" · tareas pendientes · tareas por
desarrollador · desarrolladores por proyecto.

### Ejercicio 3 — Biblioteca multimedia
**Base:** `ej3_sala_lumiere` — caso: mediateca "Sala Lumiere".

| Tabla | Rol |
|---|---|
| `directores` | Lado 1 de la relacion |
| `peliculas` | Lado N (`id_director` como clave foranea) |

Consultas: todas las peliculas · estrenadas despues de 2020 · de un genero
determinado (Ciencia ficcion).

### Ejercicio 4 — Gestion de estudiantes
**Base:** `ej4_instituto_antares` — caso: instituto superior con matriculas.

| Tabla | Rol |
|---|---|
| `carreras` | Oferta academica |
| `estudiantes` | Datos personales + carrera |
| `matriculas` | Matricula por periodo (unica por estudiante y periodo) |

Consultas: todos los estudiantes · mayores de 18 anios (con `TIMESTAMPDIFF`) ·
de una carrera especifica.

### Ejercicio 5 — Torneo de eSports
**Base:** `ej5_liga_andina_esports` — caso: "Liga Andina de eSports".

| Tabla | Rol |
|---|---|
| `equipos` | Clubes participantes |
| `jugadores` | N:1 con equipo |
| `torneos` | Competencias con fechas y premio |
| `torneo_equipo` | **Tabla puente** de la relacion N:M |

Consultas: jugadores de "Dragones Digitales" · torneos de este anio · jugadores
por equipo · equipos por torneo.

---

## Como ejecutarlo

Guia detallada en **[`docs/GUIA_HEIDISQL.md`](docs/GUIA_HEIDISQL.md)**. Resumen:

1. Enciende el servidor MySQL (XAMPP → Start en MySQL).
2. Abre HeidiSQL y conecta a `127.0.0.1`, usuario `root`, puerto `3306`.
3. **Archivo → Cargar archivo SQL** y elige `sql/00_tarea1_completo.sql`
   (o el archivo de un ejercicio).
4. Ejecuta el bloque de creacion con `Ctrl + F9`, refresca con `F5` y luego
   corre **cada consulta por separado** para capturar su resultado.

Desde la linea de comandos tambien funciona:

```bash
mysql -u root -p < sql/00_tarea1_completo.sql
```

> Si una base ya existe de una ejecucion anterior, eliminala antes de volver a
> correr el script (en HeidiSQL: clic derecho sobre la base -> Eliminar).

---

## Convenciones aplicadas

Tomadas de las **recomendaciones del enunciado**:

- Nombres de tablas y campos **significativos, en minusculas y sin espacios**
  (`snake_case`): `fecha_ingreso`, `proyecto_desarrollador`, `premio_usd`.
- Casos **propios y no genericos**, evitando los ejemplos tipicos de clase.
- Motor **InnoDB** para que las claves foraneas se apliquen de verdad, y
  charset `utf8mb4` para soportar acentos.
- Claves primarias `INT AUTO_INCREMENT`; claves foraneas declaradas con
  `CONSTRAINT ... FOREIGN KEY` y su regla `ON DELETE` / `ON UPDATE`.
- Relaciones N:M resueltas con **tabla puente** y clave primaria compuesta
  (ejercicios 2 y 5).
- `UNIQUE` en los campos que no deben repetirse (codigo, correo, cedula, nick).
- Consultas ajustadas a lo que pide el enunciado, sin ordenamientos ni columnas
  que no se solicitan.
- Datos de prueba suficientes para que **toda consulta devuelva filas visibles**
  en la captura, incluyendo casos limite (menores de edad que deben quedar
  fuera del filtro, torneos de otros anios, equipos con distinta cantidad de
  jugadores).
- **Todas las consultas fueron ejecutadas y verificadas**; su salida real esta en
  [`docs/RESULTADOS_CONSULTAS.md`](docs/RESULTADOS_CONSULTAS.md).

---

## Entregables de la tarea

- [ ] Documento **PDF** con las capturas de las 17 consultas ejecutadas en HeidiSQL.
- [ ] Archivo **`.sql`** exportado desde HeidiSQL.
- [ ] Ambos dentro de una **carpeta de Drive** compartida con enlace de lectura.

El detalle de como exportar y compartir esta en la seccion 7 y 8 de la guia.

---

## Fuentes consultadas

- Oracle. *MySQL 8.0 Reference Manual* — Data Definition Statements, SELECT, JOIN,
  Aggregate Functions. https://dev.mysql.com/doc/refman/8.0/en/
- Oracle. *MySQL 8.0 Reference Manual — FOREIGN KEY Constraints*.
  https://dev.mysql.com/doc/refman/8.0/en/create-table-foreign-keys.html
- HeidiSQL. *Documentation*. https://www.heidisql.com/help.php
