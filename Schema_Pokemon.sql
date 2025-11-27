-- =====================================================
-- ELIMINACIÓN DE TABLAS EN ORDEN CORRECTO
-- =====================================================
DROP TABLE IF EXISTS personajes;
DROP TABLE IF EXISTS pokemon;
DROP TABLE IF EXISTS objetos;
DROP TABLE IF EXISTS ubicaciones;
DROP TABLE IF EXISTS objetos_de_la_ubicacion;
DROP TABLE IF EXISTS eventos;
DROP TABLE IF EXISTS inventarios;
DROP TABLE IF EXISTS objetos_inventario;
DROP TABLE IF EXISTS pokemon_personaje;
DROP TABLE IF EXISTS ataques;

-- =====================================================
-- CREACIÓN DE TABLAS
-- =====================================================

CREATE TABLE `personajes` (
  `id_personaje` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `rol` VARCHAR(45) NULL,
  `descripcion` VARCHAR(45) NULL,
  PRIMARY KEY (`id_personaje`));
  
  CREATE TABLE `objetos` (
  `id_objetos` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_objetos`));
  
  CREATE TABLE `ubicaciones` (
  `id_ubicacion` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_ubicacion`));

CREATE TABLE `pokemon` (
  `id_pokemon` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(45) NOT NULL,
  `vida` INT NOT NULL,
   `id_evolucion` INT NULL,
  `id_piedra_evolucion` INT NULL,
  PRIMARY KEY (`id_pokemon`));

CREATE TABLE `ubicacion_objetos` (
  `id_objeto` INT NOT NULL,
  `id_ubicacion` INT NOT NULL,
  INDEX `id_objeto_idx` (`id_objeto` ASC) VISIBLE,
  INDEX `id_ubicacion_idx` (`id_ubicacion` ASC) VISIBLE,
  CONSTRAINT `id_objeto`
    FOREIGN KEY (`id_objeto`)
    REFERENCES `objetos` (`id_objetos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_ubicacion`
    FOREIGN KEY (`id_ubicacion`)
    REFERENCES `ubicaciones` (`id_ubicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `eventos` (
  `id_evento` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `tipo_recomendado` VARCHAR(45) NULL,
  `id_objeto_usable` INT NULL,
  `id_personaje_involucrado` INT NULL,
  `id_ubicacion` INT NOT NULL,
  PRIMARY KEY (`id_evento`),
  INDEX `id_objeto_usable_idx` (`id_objeto_usable` ASC) VISIBLE,
  INDEX `id_personaje_involucrado_idx` (`id_personaje_involucrado` ASC) VISIBLE,
  INDEX `id_ubicacion_idx` (`id_ubicacion` ASC) VISIBLE,
  CONSTRAINT `id_objeto_usable`
    FOREIGN KEY (`id_objeto_usable`)
    REFERENCES `objetos` (`id_objetos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_personaje_involucrado`
    FOREIGN KEY (`id_personaje_involucrado`)
    REFERENCES `personajes` (`id_personaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
      FOREIGN KEY (`id_ubicacion`)
    REFERENCES `ubicaciones` (`id_ubicacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `inventarios` (
  `id_inventario` INT NOT NULL AUTO_INCREMENT,
  `id_personaje` INT NOT NULL,
  PRIMARY KEY (`id_inventario`),
  INDEX `id_personaje_idx` (`id_personaje` ASC) VISIBLE,
  CONSTRAINT `id_personaje`
    FOREIGN KEY (`id_personaje`)
    REFERENCES `personajes` (`id_personaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `ataques` (
  `id_ataque` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `id_pokemon` INT NOT NULL,
  `maximo_daño` INT NOT NULL,
  PRIMARY KEY (`id_ataque`),
  INDEX `id_pokemon_idx` (`id_pokemon` ASC) VISIBLE,
  CONSTRAINT `id_pokemon`
    FOREIGN KEY (`id_pokemon`)
    REFERENCES `pokemon` (`id_pokemon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `objetos_inventario` (
  `id_objeto` INT NULL,
  `id_inventario` INT NOT NULL,
  INDEX `id_inventario_idx` (`id_inventario` ASC) VISIBLE,
  INDEX `id_objeto_idx` (`id_objeto` ASC) VISIBLE,
    FOREIGN KEY (`id_inventario`)
    REFERENCES `inventarios` (`id_inventario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`id_objeto`)
    REFERENCES `objetos` (`id_objetos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `pokemon_personaje` (
  `id_pokemon` INT NOT NULL,
  `id_personaje` INT NOT NULL,
  INDEX `id_pokemon_idx` (`id_pokemon` ASC) VISIBLE,
  INDEX `id_personaje_idx` (`id_personaje` ASC) VISIBLE,
    FOREIGN KEY (`id_pokemon`)
    REFERENCES `pokemon`.`pokemon` (`id_pokemon`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
    FOREIGN KEY (`id_personaje`)
    REFERENCES `pokemon`.`personajes` (`id_personaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
    
    ALTER TABLE `pokemon` 
ADD INDEX `id_piedra_evolucion_idx` (`id_piedra_evolucion` ASC) VISIBLE;
;
ALTER TABLE `pokemon` 
ADD CONSTRAINT `id_piedra_evolucion`
  FOREIGN KEY (`id_piedra_evolucion`)
  REFERENCES `objetos` (`id_objetos`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

ALTER TABLE `pokemon` 
ADD INDEX `id_evolucion_idx` (`id_evolucion` ASC) VISIBLE;
;
ALTER TABLE `pokemon` 
ADD CONSTRAINT `id_evolucion`
  FOREIGN KEY (`id_evolucion`)
  REFERENCES `pokemon` (`id_pokemon`)
  ON DELETE NO ACTION
  ON UPDATE NO ACTION;

-- =====================================================
-- INSERCIÓN DE INFORMACIÓN
-- =====================================================

INSERT INTO personajes (id_personaje, nombre, rol, descripcion) VALUES
(1, 'Jugador', 'Protagonista', 'Entrenador pokemon'),
(2, 'Sombras Errantes', 'Enemigo', 'Criaturas que atacan'),
(3, 'Anciano Sabio', 'NPC', 'Da pistas para escapar de la pesadilla'),
(4, 'Profesor', 'NPC', 'Puedes consultarle informacion de los pokemon'),
(5, 'Darkrai', 'Enemigo', 'Es el boss final');

INSERT INTO objetos (id_objetos, nombre, tipo) VALUES
(1, 'Linterna', 'Herramienta'),
(2, 'Cuerda', 'Herramienta'),
(3, 'Mapa', 'Herramienta'),
(4, 'Pokeball', 'Consumible'),
(5, 'Piedras brillantes', 'Objeto mágico'),
(6, 'Cristal brillante', 'Objeto mágico'),
(7, 'Balsa vieja', 'Herramienta'),
(8, 'Poción', 'Consumible'),
(9, 'Amuleto de protección', 'Objeto mágico'),
(10, 'Revivir', 'Consumible'),
(11, 'Piedra Fuego', 'Piedra evolucion'),
(12, 'Piedra Agua', 'Piedra evolucion'),
(13, 'Piedra Lunar', 'Piedra evolucion');

INSERT INTO ubicaciones (id_ubicacion, nombre) VALUES
(1, 'Camino de Sombras'),
(2, 'Camino del Lago Ilusorio'),
(3, 'Camino de Luz Distorsionada'),
(4, 'Centro Pokemon'),
(5, 'Batalla final'),
(6, 'Explanada con cofre'),
(7, 'Explanada'),
(8, 'Casa jugador');

INSERT INTO ubicacion_objetos (id_objeto, id_ubicacion) VALUES
(1, 4),
(4, 6),
(8, 4),
(10, 4),
(11, 1),
(12, 2),
(13, 3),
(8, 6);
INSERT INTO inventarios (id_inventario, id_personaje) VALUES
(1, 1),
(2, 4),
(3, 3),
(4, 2);

INSERT INTO eventos (id_evento, nombre, tipo_recomendado, id_objeto_usable, id_personaje_involucrado, id_ubicacion) VALUES
(1, 'Sombras Errantes atacan', NULL, 1, 2, 1),
(2, 'Pelea final contra Darkrai', NULL, 8, 5, 2),
(3, 'Camino correcto para Vulpix', 'Fuego', 11, 1, 1),
(4, 'Camino correcto para Staryu', 'Agua', 12, 1, 2),
(5, 'Camino correcto para Nidoran', 'Veneno', 13, 1, 3),
(6, 'Coseguir tu primer pokemon', NULL, 4, 4, 4);

INSERT INTO pokemon (id_pokemon, nombre, tipo, vida, id_evolucion, id_piedra_evolucion) VALUES
(4, 'Ninetales', 'Fuego', 160, NULL, NULL),
(5, 'Starmie', 'Agua', 170, NULL, NULL),
(6, 'Nidoking', 'Veneno', 180, NULL, NULL),
(7, 'Darkrai', 'Siniestro', 180, NULL, NULL);

INSERT INTO pokemon (id_pokemon, nombre, tipo, vida, id_evolucion, id_piedra_evolucion) VALUES
(1, 'Vulpix', 'Fuego', 100, 4, 11),
(2, 'Staryu', 'Agua', 110, 5, 12),
(3, 'Nidoran', 'Veneno', 120, 6, 13);

INSERT INTO objetos_inventario (id_inventario, id_objeto) VALUES
(1, 1),
(3, 1),
(1, 8),
(3, 4),
(2, 12),
(2, 13);

INSERT INTO pokemon_personaje (id_pokemon, id_personaje) VALUES
(1, 4),
(2, 4),
(3, 4),
(1, 1),
(5, 1);

INSERT INTO ataques (id_ataque, id_pokemon, nombre, maximo_daño) VALUES
(1, 1, 'Llamarada', 60),
(2, 1, 'Placaje', 40),
(3, 2, 'Hidropulso', 60),
(4, 2, 'Placaje', 40),
(5, 3, 'Onda toxica', 60),
(6, 3, 'Placaje', 40),
(7, 4, 'Llamarada', 80),
(8, 4, 'Placaje', 60),
(9, 5, 'Hidropulso', 80),
(10, 5, 'Placaje', 60),
(11, 6, 'Onda toxica', 80),
(12, 6, 'Placaje', 60),
(13, 7, 'Pulso Umbrío', 60),
(14, 7, 'Bomba lodo', 80);
