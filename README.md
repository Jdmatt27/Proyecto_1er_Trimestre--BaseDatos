# Base de Datos - Proyecto Pokémon

## Descripción
Este repositorio contiene la base de datos correspondiente a la parte del proyecto de **Pokémon**. La base de datos está compuesta por 10 tablas:

- `personajes`
- `pokemon`
- `objetos`
- `ubicaciones`
- `objetos_de_la_ubicacion`
- `eventos`
- `inventarios`
- `objetos_inventario`
- `pokemon_personaje`
- `ataques`

Se ha diseñado un **modelo entidad-relación (MER)** que muestra todas las tablas y sus relaciones, incluyendo relaciones muchos a muchos (N-N) mediante tablas intermedias (`objetos_de_la_ubicacion` y `pokemon_personaje`) y una relación reflexiva entre `pokemon` y su evolución.  

También se incluyen 10 consultas de ejemplo que simulan consultas que el juego podría realizar en tiempo real.

## Tecnologías utilizadas

- **MySQL**: Sistema de gestión de bases de datos relacional (RDBMS).  
- **SQL**: Lenguaje de consulta para creación, manipulación y consulta de datos.  
- **Herramienta de modelado ER**: Para diseñar el modelo entidad-relación (puede ser MySQL Workbench, Lucidchart, etc.).  
- **Git y GitHub**: Para control de versiones y alojamiento del repositorio.  

## Requisitos del proyecto

- **MySQL Server** instalado (versión recomendada: 8.0 o superior).  
- **Cliente de MySQL** o herramienta como MySQL Workbench.  
- **Acceso a Git** para clonar el repositorio.  
- **Sistema operativo compatible**: Windows, macOS o Linux.  

Opcional: herramienta de visualización de diagramas ER para explorar el modelo entidad-relación.

## Despliegue de la base de datos

Para implementar la base de datos en MySQL:

1. Clonar el repositorio:
    ```bash
    git clone https://github.com/Jdmatt27/Proyecto_1er_Trimestre--BaseDatos.git
    ```
2. Acceder a la carpeta del proyecto:
    ```bash
    cd Proyecto_1er_Trimestre--BaseDatos
    ```
3. Abrir MySQL y ejecutar el script:
    ```sql
    Schema_Pokemon.sql;
    ```
   Esto creará todas las tablas y cargará los datos de ejemplo.

## Ejecución del proyecto

Para probar y ejecutar la base de datos:

1. **Conectarse a MySQL**
2. **Seleccionar la base de datos** creada con el script
3. **Ejecutar consultas de prueba**
4. **Verificar resultados** de las consultas para comprobar que los datos y relaciones funcionan correctamente.  

## Modelo Entidad-Relación (MER)

A continuación se incluye la imagen del MER que representa la estructura de la base de datos y las relaciones entre las tablas:

<img width="1268" height="834" alt="Diagrama ER-Pokemon" src="https://github.com/user-attachments/assets/87920584-2f9f-4f4a-8391-774117502a45" />

**Notas sobre las relaciones:**

- Relaciones N-N:  
  - `pokemon_personaje` → relaciona los Pokémon que tiene cada personaje.  
  - `objetos_de_la_ubicacion` → relaciona los objetos disponibles en cada ubicación.  
- Relación reflexiva:  
  - `pokemon` → representa la evolución de los Pokémon.

## Explicación de las tablas

| Tabla                  | Descripción |
|------------------------|------------|
| `personajes`           | Contiene la información de los personajes del juego. |
| `pokemon`              | Contiene los Pokémon disponibles y sus características. |
| `objetos`              | Lista de objetos que pueden encontrarse en el juego. |
| `ubicaciones`          | Lista de ubicaciones del juego. |
| `objetos_de_la_ubicacion` | Relaciona los objetos que se encuentran en cada ubicación. |
| `eventos`              | Registra eventos del juego. |
| `inventarios`          | Contiene los inventarios de cada personaje. |
| `objetos_inventario`   | Relaciona los objetos que tiene cada personaje en su inventario. |
| `pokemon_personaje`    | Relaciona los Pokémon que posee cada personaje. |
| `ataques`              | Contiene los ataques disponibles para los Pokémon. |

## Consultas de prueba

Se incluyen 22 consultas SQL de ejemplo para probar la base de datos y verificar su funcionamiento. Estas consultas simulan la información que podría requerir el juego en distintos escenarios.

## Autores

- Juan David Matteucci Angel
- Javier Clemente Barahona
- Laura Otero Martín
- Noemí Cano Conesa
