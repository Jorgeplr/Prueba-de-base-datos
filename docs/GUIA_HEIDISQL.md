# Guia: como ejecutar las consultas en HeidiSQL

Documento aparte con el paso a paso para montar las bases de datos de la
Tarea 1, ejecutar las consultas, tomar las capturas del informe y exportar el
archivo `.sql` que se entrega.

---

## 1. Requisitos previos

| Herramienta | Para que sirve | Donde se obtiene |
|---|---|---|
| Servidor MySQL o MariaDB | Guarda las bases de datos | XAMPP, Laragon, MySQL Installer o MariaDB Server |
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
   | Tipo de red | `MariaDB or MySQL (TCP/IP)` |
   | Nombre de host / IP | `127.0.0.1` |
   | Usuario | `root` |
   | Contrasena | vacia en XAMPP; la que definiste si instalaste MySQL aparte |
   | Puerto | `3306` |

4. Pulsa **Guardar** y luego **Abrir**.

> Si sale el error `Can't connect to MySQL server on '127.0.0.1'`, el servidor
> no esta encendido o el puerto no es el 3306.

---

## 3. Cargar el script de la tarea

Hay dos formas; cualquiera es valida.

### Opcion A - abrir el archivo (recomendada)

1. Menu **Archivo → Cargar archivo SQL...** (`Ctrl + O`).
2. Elige el script que quieras:
   - `sql/00_tarea1_completo.sql` para crear los cinco ejercicios de una vez, o
   - `sql/01_productos.sql`, `sql/02_...` para trabajar ejercicio por ejercicio.
3. Si HeidiSQL pregunta por la codificacion, deja **UTF-8**.
4. El contenido aparece en la pestana **Consulta**.

### Opcion B - copiar y pegar

Abre el `.sql` con el Bloc de notas, copia todo y pegalo en la pestana
**Consulta** de HeidiSQL.

---

## 4. Ejecutar

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

---

## 5. Errores frecuentes y como resolverlos

| Mensaje | Causa | Solucion |
|---|---|---|
| `No database selected` | No hay base activa | Doble clic sobre la base en el arbol izquierdo, o ejecuta primero la linea `USE nombre_base;` |
| `Table 'x' doesn't exist` | Se ejecuto el `SELECT` sin haber creado las tablas | Ejecuta primero el bloque DDL + INSERT del ejercicio |
| `Unknown database 'ej1_...'` | No se ejecuto el `CREATE DATABASE` | Ejecuta el bloque inicial del script |
| `Cannot add or update a child row: a foreign key constraint fails` | Se insertaron las filas en desorden | Respeta el orden del script: primero las tablas padre (`equipos`, `proyectos`, `carreras`, `directores`) y luego las hijas |
| `Duplicate entry` al reejecutar | Los `INSERT` ya se habian ejecutado | Vuelve a correr el script completo del ejercicio: el `DROP DATABASE IF EXISTS` del inicio limpia todo |
| Acentos que se ven como `Ã±` | Codificacion equivocada al abrir el archivo | Vuelve a cargarlo indicando **UTF-8** |

---

## 6. Capturas para el informe PDF

Por cada consulta solicitada, toma una captura donde se vea:

1. El **texto SQL** de la consulta en el editor.
2. La **rejilla de resultados** con las filas devueltas.
3. La **base de datos activa** en el arbol de la izquierda.
4. La barra de estado inferior, que indica el numero de filas y el tiempo de
   ejecucion (sirve como evidencia de que la consulta realmente corrio).

Atajo de Windows: `Win + Shift + S` (Recorte) o `Alt + Impr Pant` para capturar
solo la ventana de HeidiSQL.

Son 18 capturas en total: 3 (Ej. 1) + 4 (Ej. 2) + 3 (Ej. 3) + 3 (Ej. 4) +
5 (Ej. 5, contando la variante compacta de la consulta 4).

En `docs/RESULTADOS_CONSULTAS.md` estan los resultados que debe devolver cada
consulta, para que compares antes de capturar.

---

## 7. Exportar el archivo `.sql` desde HeidiSQL

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

## 8. Entrega

Segun el enunciado se entrega el **link de una carpeta de Drive** que contenga:

- [ ] El documento **PDF** con las capturas de las 18 consultas.
- [ ] El archivo **`.sql`** exportado desde HeidiSQL.

Antes de compartir el link, en Drive: clic derecho sobre la carpeta →
**Compartir** → **Cualquier persona con el enlace** → rol **Lector**. Si queda
como "Restringido", el docente no podra abrirla.

---

## 9. Referencias

- HeidiSQL. *Documentation*. https://www.heidisql.com/help.php
- Oracle. *MySQL 8.0 Reference Manual — SELECT Statement*.
  https://dev.mysql.com/doc/refman/8.0/en/select.html
- Oracle. *MySQL 8.0 Reference Manual — JOIN Clause*.
  https://dev.mysql.com/doc/refman/8.0/en/join.html
- MariaDB Foundation. *Foreign Keys*.
  https://mariadb.com/kb/en/foreign-keys/
