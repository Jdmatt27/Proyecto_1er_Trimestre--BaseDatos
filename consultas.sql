
/*1. Mostrar los Pokémon de cada personaje*/
SELECT p.nombre AS pokemon, pe.nombre AS personaje
FROM pokemon p
JOIN pokemon_personaje pp ON p.id_pokemon = pp.id_pokemon
JOIN personajes pe ON pe.id_personaje = pp.id_personaje;

/*2. Listar los objetos que tiene cada personaje (pasando por inventario)*/
SELECT per.nombre AS personaje, obj.nombre AS objeto
FROM personajes per
JOIN inventarios inv ON per.id_personaje = inv.id_personaje
JOIN objetos_inventario oi ON inv.id_inventario = oi.id_inventario
JOIN objetos obj ON oi.id_objeto = obj.id_objetos;

/*3. Eventos con su ubicación y personaje involucrado*/
SELECT e.nombre AS evento, u.nombre AS ubicacion, p.nombre AS personaje_involucrado
FROM eventos e
JOIN ubicaciones u ON e.id_ubicacion = u.id_ubicacion
LEFT JOIN personajes p ON e.id_personaje_involucrado = p.id_personaje;

/*4. Pokémon con su evolución y la piedra necesaria*/
SELECT p.nombre AS pokemon,
       evo.nombre AS evolucion,
       o.nombre AS piedra_evolucion
FROM pokemon p
LEFT JOIN pokemon evo ON p.id_evolucion = evo.id_pokemon
LEFT JOIN objetos o ON p.id_piedra_evolucion = o.id_objetos;

/*5. Mostrar los ataques de cada Pokémon*/
SELECT po.nombre AS pokemon, a.nombre AS ataque, a.maximo_daño
FROM ataques a
JOIN pokemon po ON a.id_pokemon = po.id_pokemon;

/*6. Objetos disponibles en cada ubicación*/
SELECT u.nombre AS ubicacion, o.nombre AS objeto
FROM ubicacion_objetos uo
JOIN ubicaciones u ON uo.id_ubicacion = u.id_ubicacion
JOIN objetos o ON uo.id_objeto = o.id_objetos;

/*7. Número de objetos por inventario*/
SELECT id_inventario, COUNT(id_objeto) AS cantidad_objetos
FROM objetos_inventario
GROUP BY id_inventario;

/*8. Número de ataques por Pokémon*/
SELECT p.nombre AS pokemon, COUNT(a.id_ataque) AS total_ataques
FROM pokemon p
JOIN ataques a ON p.id_pokemon = a.id_pokemon
GROUP BY p.id_pokemon;

/*9. Pokémon con más de 150 de vida*/
SELECT nombre, tipo, vida
FROM pokemon
WHERE vida > 150;

/*10. Objetos que son de tipo “Piedra evolución”*/
SELECT nombre
FROM objetos
WHERE tipo = 'Piedra evolucion';

/*11. Contar cuántos Pokémon tiene cada personaje */
SELECT pe.nombre AS personaje,
       (SELECT COUNT(*) 
        FROM pokemon_personaje pp 
        WHERE pp.id_personaje = pe.id_personaje) AS total_pokemon
FROM personajes pe;

/*12. Pokémon con vida por encima de la vida media de todos los Pokémon */
SELECT nombre, tipo, vida
FROM pokemon
WHERE vida > (SELECT AVG(vida) FROM pokemon);

/*13. Personajes que tienen una Pokeball en su inventario */
SELECT p.nombre
FROM personajes p
WHERE p.id_personaje IN (
  SELECT i.id_personaje
  FROM inventarios i
  JOIN objetos_inventario oi ON i.id_inventario = oi.id_inventario
  WHERE oi.id_objeto = (
    SELECT id_objetos FROM objetos WHERE nombre = 'Pokeball' LIMIT 1
  )
);


/*14. Pokémons cuya media de daño de ataques es mayor que la media global de daños */
SELECT po.nombre
FROM pokemon po
WHERE (SELECT AVG(a.maximo_daño) FROM ataques a WHERE a.id_pokemon = po.id_pokemon)
      > (SELECT AVG(maximo_daño) FROM ataques);


/*15. Ubicaciones que contienen objetos que aparecen en más de una ubicación */
SELECT DISTINCT u.nombre
FROM ubicaciones u
WHERE u.id_ubicacion IN (
  SELECT uo.id_ubicacion
  FROM ubicacion_objetos uo
  WHERE uo.id_objeto IN (
    SELECT id_objeto
    FROM ubicacion_objetos
    GROUP BY id_objeto
    HAVING COUNT(*) > 1
  )
);

/*16. Eventos cuyo objeto requerido está en algún inventario */
SELECT e.nombre AS evento
FROM eventos e
WHERE e.id_objeto_usable IS NOT NULL
  AND EXISTS (
    SELECT 1
    FROM objetos_inventario oi
    WHERE oi.id_objeto = e.id_objeto_usable
  );

/*17. Personajes que no poseen ningún Pokémon */
SELECT p.nombre
FROM personajes p
LEFT JOIN pokemon_personaje pp
       ON p.id_personaje = pp.id_personaje
WHERE pp.id_personaje IS NULL;

/*18. Para cada personaje, el máximo daño que puede hacer con sus pokémon */
SELECT pe.nombre AS personaje,
       (SELECT MAX(a.maximo_daño)
        FROM pokemon_personaje pp
        JOIN ataques a ON pp.id_pokemon = a.id_pokemon
        WHERE pp.id_personaje = pe.id_personaje) AS max_daño_posible
FROM personajes pe;

/*19. Pokémons que necesitan una piedra de evolución que existe en la tabla objetos*/
SELECT nombre
FROM pokemon
WHERE id_piedra_evolucion IS NOT NULL
  AND id_piedra_evolucion IN (SELECT id_objetos FROM objetos);

/*20. Eventos que ocurren en ubicaciones donde hay al menos una "Herramienta"*/
SELECT e.nombre AS evento
FROM eventos e
WHERE EXISTS (
  SELECT 1
  FROM ubicacion_objetos uo
  JOIN objetos o ON uo.id_objeto = o.id_objetos
  WHERE uo.id_ubicacion = e.id_ubicacion
    AND o.tipo = 'Herramienta'
);


/*21. Pokémons que pertenecen al Profesor */
SELECT po.nombre
FROM pokemon po
WHERE po.id_pokemon IN (
  SELECT pp.id_pokemon
  FROM pokemon_personaje pp
  WHERE pp.id_personaje = (
    SELECT id_personaje FROM personajes WHERE nombre = 'Profesor' LIMIT 1
  )
);

/*22. Objetos que no están en ningún inventario pero sí están en alguna ubicación */
SELECT o.nombre
FROM objetos o
WHERE o.id_objetos NOT IN (SELECT id_objeto FROM objetos_inventario)
  AND o.id_objetos IN (SELECT id_objeto FROM ubicacion_objetos);

