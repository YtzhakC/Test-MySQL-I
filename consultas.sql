-- #===============#
-- # Consultas SQL #
-- #===============#

USE pizza_fiesta;


-- 1. Registrar un nuevo cliente:


INSERT INTO clientes (nombre, telefono, direccion)
VALUES ('Juan Pérez', '555-1234', 'Calle Ficticia 123');


-- 2. Agregar un nuevo producto (pizza) al menú:


INSERT INTO pizzas (nombre, precio_pequena, precio_mediana, precio_grande)
VALUES ('Pizza Margarita', 50.00, 75.00, 100.00);


-- 3. Registrar una bebida en el menú:

INSERT INTO bebidas (nombre, precio)
VALUES ('Coca-Cola', 20.00);

-- 4. Agregar un ingrediente a la base de datos:

INSERT INTO ingredientes (nombre, costo_adicional)
VALUES ('Queso Extra', 10.00);

-- 5. Crear un pedido para un cliente:

INSERT INTO pedidos (id_cliente, hora_recogida)
VALUES (1, '19:00:00');

-- 6. Añadir productos a un pedido específico:

INSERT INTO productos_pedido (id_pedido, id_producto, tipo_producto, cantidad, precio)
VALUES (1, 1, 'Pizza', 1, 27500);
INSERT INTO productos_pedido (id_pedido, id_producto, tipo_producto, cantidad, precio)
VALUES (1, 1, 'Bebida', 2, 7000);

-- 7. Añadir ingredientes adicionales a una pizza en un pedido:

INSERT INTO ingredientes_adicionales (id_pedido, id_ingrediente, cantidad, costo_adicional)
VALUES (1, 1, 1, 5000); 

-- 8. Consultar el detalle de un pedido (productos y sus ingredientes):

SELECT p.id_pedido, pr.tipo_producto AS producto, i.nombre AS ingrediente, ip.cantidad AS cantidad_ingrediente
FROM pedidos p
JOIN productos_pedido pr ON p.id_pedido = pr.id_pedido
LEFT JOIN ingredientes_adicionales ip ON pr.id_pedido = ip.id_pedido
LEFT JOIN ingredientes i ON ip.id_ingrediente = i.id_ingrediente
WHERE p.id_pedido = 1;

-- 9. Actualizar el precio de una pizza en el menú:

UPDATE pizzas
SET precio_pequena = 55.00, precio_mediana = 80.00, precio_grande = 105.00
WHERE id_pizza = 1;

-- 10. Actualizar la dirección de un cliente:

UPDATE clientes
SET direccion = 'Calle Real 456'
WHERE id_cliente = 1;

-- 11. Eliminar un producto del menú (bebida):

DELETE FROM bebidas
WHERE id_bebida = 1;

-- 12. Eliminar un ingrediente de la base de datos:
-- NO FUNCIONA :(

-- DELETE FROM ingredientes
-- WHERE id_ingrediente = 1;

-- 13. Consultar todos los pedidos de un cliente:

SELECT * FROM pedidos
WHERE id_cliente = 1;

-- 14. Listar todos los productos disponibles en el menú (pizzas y bebidas):

SELECT 'Pizza' AS tipo_producto, nombre, precio_pequena, precio_mediana, precio_grande FROM pizzas
UNION
SELECT 'Bebida', nombre, precio, precio, precio FROM bebidas;

-- 15. Listar todos los ingredientes disponibles para personalizar una pizza:

SELECT * FROM ingredientes;

-- 16. Calcular el costo total de un pedido (incluyendo ingredientes adicionales):

SELECT SUM(CASE 
            WHEN tipo_producto = 'Pizza' THEN 
                (CASE 
                    WHEN tamano = 'Pequeña' THEN precio_pequena
                    WHEN tamano = 'Mediana' THEN precio_mediana
                    ELSE precio_grande END) 
            WHEN tipo_producto = 'Bebida' THEN precio 
            END) + SUM(i.costo_adicional)
FROM productos_pedido pp
JOIN pizzas p ON pp.id_producto = p.id_pizza
LEFT JOIN ingredientes_adicionales i ON pp.id_pedido = i.id_pedido
WHERE pp.id_pedido = 1;

-- 17. Listar los clientes que han hecho más de 5 pedidos:

SELECT id_cliente, COUNT(*) AS total_pedidos
FROM pedidos
GROUP BY id_cliente
HAVING total_pedidos > 5;

-- 18. Buscar pedidos programados para recogerse después de una hora específica:

SELECT * FROM pedidos
WHERE hora_recogida > '20:00:00';

-- 19. Listar todos los combos de pizzas con bebidas disponibles en el menú:

SELECT c.id_combo, p.nombre AS pizza, b.nombre AS bebida, c.precio_combo
FROM combos c
JOIN pizzas p ON c.id_pizza = p.id_pizza
JOIN bebidas b ON c.id_bebida = b.id_bebida;

-- 20. Buscar pizzas con un precio mayor a $100:

SELECT * FROM pizzas
WHERE precio_grande > 100;

-- 21. Calcular el total de ingresos por día, semana y mes:

-- Ingresos por Día:

SELECT DATE(fecha) AS dia, SUM(precio) AS total_ingresos
FROM pedidos p
JOIN productos_pedido pp ON p.id_pedido = pp.id_pedido
JOIN pizzas pi ON pp.id_producto = pi.id_pizza
GROUP BY dia;

-- Ingresos por Semana:

SELECT YEAR(fecha) AS año, WEEK(fecha) AS semana, SUM(precio) AS total_ingresos
FROM pedidos p
JOIN productos_pedido pp ON p.id_pedido = pp.id_pedido
JOIN pizzas pi ON pp.id_producto = pi.id_pizza
GROUP BY año, semana;

-- Ingresos por Mes:

SELECT YEAR(fecha) AS año, MONTH(fecha) AS mes, SUM(precio) AS total_ingresos
FROM pedidos p
JOIN productos_pedido pp ON p.id_pedido = pp.id_pedido
JOIN pizzas pi ON pp.id_producto = pi.id_pizza
GROUP BY año, mes;




