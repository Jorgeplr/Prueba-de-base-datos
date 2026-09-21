# Guia: como ejecutar las consultas en HeidiSQL

Documento aparte con el paso a paso para montar las bases de datos de la
Tarea 1, ejecutar las consultas, tomar las capturas del informe y exportar el
archivo `.sql` que se entrega.

---

## 1. Requisitos previos

| Herramienta | Para que sirve | Donde se obtiene |
|---|---|---|
| Servidor MySQL | Guarda las bases de datos | XAMPP, Laragon o MySQL Installer |
| HeidiSQL | Cliente grafico con el que se escriben y ejecutan las consultas | https://www.heidisql.com/download.php |

Si usas **XAMPP**, abre el *Control Panel* y pulsa **Start** en el modulo
**MySQL** antes de abrir HeidiSQL. Sin el servidor encendido, HeidiSQL no puede
conectarse.

---

## 2. Crear la sesion de conexion

1. Abre HeidiSQL. Se muestra el **Administrador de sesiones**.
2. Pulsa **Nueva** (abajo a la izquierda) y ponle un nombre, por ejemplo
   `localhost - tarea1`.
3. Completa los datos de la pestana **Ajustes**:

   | Campo | Valor habitual |
   |---|---|
   | Tipo de red | la opcion TCP/IP para MySQL (es la que viene por defecto) |
   | Nombre de host / IP | `127.0.0.1` |
   | Usuario | `root` |
   | Contrasena | vacia en XAMPP; la que definiste si instalaste MySQL aparte |
   | Puerto | `3306` |

4. Pulsa **Guardar** y luego **Abrir**.

> Si sale el error `Can't connect to MySQL server on '127.0.0.1'`, el servidor
> no esta encendido o el puerto no es el 3306.

---

## 3. Importar la base de datos desde el archivo `.sql`

Importar significa tomar un archivo `.sql` y ejecutarlo en el servidor para que
las bases, las tablas y los datos queden creados. Hay cuatro formas; con
cualquiera queda igual.

### Opcion A - abrir el archivo en el editor (recomendada para la tarea)

Conviene cuando quieres ver el codigo y ejecutar los bloques por partes, que es
lo que necesitas para tomar las capturas.

1. Menu **Archivo → Cargar archivo SQL...** (`Ctrl + O`).
2. Elige el script:
   - `sql/00_tarea1_completo.sql` para crear los cinco ejercicios de una vez, o
   - `sql/01_productos.sql`, `sql/02_...` para trabajar ejercicio por ejercicio.
3. Si HeidiSQL pregunta por la codificacion, deja **UTF-8**.
4. El contenido aparece en la pestana **Consulta**, listo para ejecutarse
   (seccion 4).

### Opcion B - importar el archivo directamente (sin abrirlo)

Conviene cuando el `.sql` es grande o solo quieres que la base quede montada de
una vez, sin revisar el codigo.

1. Menu **Archivo → Ejecutar archivo(s) SQL...**
2. Selecciona el `.sql` y confirma la codificacion **UTF-8**.
3. HeidiSQL lo ejecuta de corrido y muestra el avance en una ventana de
   progreso. Al terminar, pulsa **F5** en el arbol de la izquierda para ver las
   bases nuevas.

> Esta es tambien la forma de **volver a importar** un `.sql` que exportaste
> antes (el de la seccion 8) en otra computadora o despues de formatear.

### Opcion C - importar desde la linea de comandos

Sin abrir HeidiSQL, desde CMD o PowerShell:

```bat
mysql -u root -p < ruta\al\archivo\00_tarea1_completo.sql
```

Si el archivo **no** trae el `CREATE DATABASE` adentro (por ejemplo un export
de una sola base), primero crea la base y luego indicale a que base importar:

```bat
mysql -u root -p -e "CREATE DATABASE ej1_taller_prisma3d;"
mysql -u root -p ej1_taller_prisma3d < ej1_taller_prisma3d_export.sql
```

En XAMPP, si el comando `mysql` no se reconoce, ubicate primero en la carpeta
del programa:

```bat
cd C:\xampp\mysql\bin
```

### Opcion D - copiar y pegar

Abre el `.sql` con el Bloc de notas, copia todo y pegalo en la pestana
**Consulta** de HeidiSQL.

### Comprobar que la importacion funciono

Pulsa **F5** sobre el panel izquierdo. Deben aparecer las bases
`ej1_taller_prisma3d`, `ej2_nube_roja_studio`, `ej3_sala_lumiere`,
`ej4_instituto_antares` y `ej5_liga_andina_esports`, cada una con sus tablas
adentro. Tambien puedes comprobarlo con una consulta:

```sql
SHOW DATABASES;
USE ej1_taller_prisma3d;
SHOW TABLES;
SELECT COUNT(*) FROM productos;
```

---

## 4. Ejecutar el script

| Accion | Atajo | Boton en la barra |
|---|---|---|
| Ejecutar **todo** el script | `F9` | triangulo azul |
| Ejecutar **solo la consulta seleccionada** | `Ctrl + F9` | triangulo con la hoja |
| Ejecutar desde el cursor hasta el final | `Shift + F9` | — |

Flujo recomendado para la tarea:

1. Selecciona con el mouse el bloque de `CREATE DATABASE` + `CREATE TABLE` +
   `INSERT` de un ejercicio y pulsa **`Ctrl + F9`**. Esto construye la base y
   carga los datos.
2. Pulsa **F5** sobre el panel izquierdo para refrescar el arbol de bases de
   datos. Debe aparecer, por ejemplo, `ej1_taller_prisma3d`.
3. Haz doble clic en esa base para seleccionarla (queda en negrita: es la base
   activa).
4. Ahora selecciona **una sola consulta** (desde el `SELECT` hasta el `;`) y
   pulsa **`Ctrl + F9`**. El resultado sale en la rejilla inferior.

> **Importante para las capturas:** ejecuta las consultas de una en una. Si
> pulsas `F9` con todo el script, HeidiSQL abre varias pestanas de resultados
> (`Resultado #1`, `#2`, ...) y es mas dificil mostrar que consulta produjo que
> tabla.

### Ejemplo completo: las 3 consultas del ejercicio 1

1. Carga `sql/01_productos.sql` (seccion 3, opcion A).
2. Selecciona desde `CREATE DATABASE ej1_taller_prisma3d` hasta el punto y coma
   del ultimo `INSERT`, y pulsa **`Ctrl + F9`**. En la barra inferior debe decir
   que las sentencias se ejecutaron sin errores.
3. Pulsa **F5** en el arbol de la izquierda y haz **doble clic** sobre
   `ej1_taller_prisma3d`. El nombre queda en negrita.
4. Baja hasta la primera consulta y **selecciona unicamente estas tres lineas**:

   ```sql
   SELECT *
   FROM productos;
   ```

5. Pulsa **`Ctrl + F9`**. Abajo aparece la rejilla con los 15 productos y, en la
   barra de estado, algo como `15 filas`. **Esa es tu captura de la consulta 1.**
6. Repite con la consulta 2 (`WHERE precio > 50`, devuelve 7 filas) y con la
   consulta 3 (`WHERE stock < 10`, devuelve 8 filas).
7. Pasa al siguiente ejercicio: carga su archivo, ejecuta su bloque de creacion,
   activa su base con doble clic y corre sus consultas igual.

### Que base activar en cada ejercicio

| Ejercicio | Archivo | Base que debes activar | Consultas |
|---|---|---|---|
| 1 | `sql/01_productos.sql` | `ej1_taller_prisma3d` | 3 |
| 2 | `sql/02_estudio_videojuegos.sql` | `ej2_nube_roja_studio` | 4 |
| 3 | `sql/03_biblioteca_multimedia.sql` | `ej3_sala_lumiere` | 3 |
| 4 | `sql/04_gestion_estudiantes.sql` | `ej4_instituto_antares` | 3 |
| 5 | `sql/05_torneo_esports.sql` | `ej5_liga_andina_esports` | 4 |

> Si olvidas activar la base correcta, HeidiSQL responde `No database selected`
> o te muestra datos de otro ejercicio. Revisa siempre cual esta en negrita
> antes de capturar.

---

## 5. Escribir y ejecutar tus propias consultas

Una vez importada la base, puedes consultarla cuando quieras sin volver a abrir
el script.

1. En el arbol de la izquierda, **doble clic sobre la base** que vas a consultar
   (queda en negrita: es la base activa). Tambien sirve escribir
   `USE ej1_taller_prisma3d;` y ejecutarlo.
2. Abre una pestana de consulta nueva: **Ctrl + T**, o la pestana **Consulta**
   de la parte superior.
3. Escribe tu consulta y pulsa **`Ctrl + F9`** con el cursor dentro de ella.

Ejemplos sobre las bases de esta tarea:

```sql
-- Ver que columnas tiene una tabla antes de consultarla
DESCRIBE productos;

-- Filtrar por un rango
SELECT * FROM productos WHERE precio BETWEEN 20 AND 100;

-- Buscar por texto parcial
SELECT * FROM peliculas WHERE titulo LIKE '%neon%';

-- Contar filas
SELECT COUNT(*) AS total_estudiantes FROM estudiantes;
```

Cosas utiles del editor:

- **Autocompletado:** escribe el nombre de la tabla, un punto, y HeidiSQL
  sugiere las columnas.
- **Pestana Datos:** haz clic en una tabla del arbol y luego en la pestana
  **Datos** para ver y editar las filas sin escribir SQL.
- **Ver los resultados completos:** si una consulta devuelve muchas filas,
  HeidiSQL muestra las primeras; el boton **Mostrar todo** de la barra inferior
  carga el resto.
- **Exportar la rejilla:** clic derecho sobre los resultados →
  **Exportar datos de la rejilla**, para llevarlos a Excel o a un archivo CSV.

---

## 6. Errores frecuentes y como resolverlos

| Mensaje | Causa | Solucion |
|---|---|---|
| `No database selected` | No hay base activa | Doble clic sobre la base en el arbol izquierdo, o ejecuta primero la linea `USE nombre_base;` |
| `Table 'x' doesn't exist` | Se ejecuto el `SELECT` sin haber creado las tablas | Ejecuta primero el bloque DDL + INSERT del ejercicio |
| `Unknown database 'ej1_...'` | No se ejecuto el `CREATE DATABASE` | Ejecuta el bloque inicial del script |
| `Cannot add or update a child row: a foreign key constraint fails` | Se insertaron las filas en desorden | Respeta el orden del script: primero las tablas padre (`equipos`, `proyectos`, `carreras`, `directores`) y luego las hijas |
| `Can't create database; database exists` o `Duplicate entry` | La base ya se creo en un intento anterior | Elimina la base (clic derecho sobre ella -> **Eliminar**) y vuelve a ejecutar el script desde el `CREATE DATABASE` |
| Acentos que se ven como `Ã±` | Codificacion equivocada al abrir el archivo | Vuelve a cargarlo indicando **UTF-8** |

---

## 7. Capturas para el informe PDF

Por cada consulta solicitada, toma una captura donde se vea:

1. El **texto SQL** de la consulta en el editor.
2. La **rejilla de resultados** con las filas devueltas.
3. La **base de datos activa** en el arbol de la izquierda.
4. La barra de estado inferior, que indica el numero de filas y el tiempo de
   ejecucion (sirve como evidencia de que la consulta realmente corrio).

Atajo de Windows: `Win + Shift + S` (Recorte) o `Alt + Impr Pant` para capturar
solo la ventana de HeidiSQL.

Son 17 capturas en total: 3 (Ej. 1) + 4 (Ej. 2) + 3 (Ej. 3) + 3 (Ej. 4) +
4 (Ej. 5).

En `docs/RESULTADOS_CONSULTAS.md` estan los resultados que debe devolver cada
consulta, para que compares antes de capturar.

---

## 8. Exportar el archivo `.sql` desde HeidiSQL

El enunciado pide entregar el `.sql` **exportado desde HeidiSQL**, no solo el
archivo escrito a mano.

1. En el arbol de la izquierda, haz **clic derecho sobre la base de datos** (por
   ejemplo `ej2_nube_roja_studio`).
2. Elige **Exportar base de datos como SQL**.
3. Configura el dialogo asi:

   | Opcion | Valor |
   |---|---|
   | Estructura de la base de datos | `CREATE` |
   | Estructura de tabla | `DROP` + `CREATE` |
   | Datos | `INSERT` |
   | Salida | `Archivo unico SQL` |
   | Codificacion | `UTF-8` |

4. Elige la carpeta destino y el nombre, por ejemplo
   `ej2_nube_roja_studio_export.sql`.
5. Pulsa **Exportar**.
6. Repite para las cinco bases de datos, o selecciona todas a la vez con
   `Ctrl + clic` para obtener un solo archivo.

---

## 9. Entrega

Segun el enunciado se entrega el **link de una carpeta de Drive** que contenga:

- [ ] El documento **PDF** con las capturas de las 17 consultas.
- [ ] El archivo **`.sql`** exportado desde HeidiSQL.

Antes de compartir el link, en Drive: clic derecho sobre la carpeta →
**Compartir** → **Cualquier persona con el enlace** → rol **Lector**. Si queda
como "Restringido", el docente no podra abrirla.

---

## 10. Referencias

- HeidiSQL. *Documentation*. https://www.heidisql.com/help.php
- Oracle. *MySQL 8.0 Reference Manual — SELECT Statement*.
  https://dev.mysql.com/doc/refman/8.0/en/select.html
- Oracle. *MySQL 8.0 Reference Manual — JOIN Clause*.
  https://dev.mysql.com/doc/refman/8.0/en/join.html
- Oracle. *MySQL 8.0 Reference Manual — FOREIGN KEY Constraints*.
  https://dev.mysql.com/doc/refman/8.0/en/create-table-foreign-keys.html
