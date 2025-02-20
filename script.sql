DROP DATABASE IF EXISTS pizza_fiesta;

CREATE DATABASE IF NOT EXISTS pizza_fiesta;

USE pizza_fiesta;

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    direccion VARCHAR(255)
);

CREATE TABLE pizzas (
    id_pizza INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio_pequena DECIMAL(10, 2) NOT NULL,
    precio_mediana DECIMAL(10, 2) NOT NULL,
    precio_grande DECIMAL(10, 2) NOT NULL
);

CREATE TABLE bebidas (
    id_bebida INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    precio DECIMAL(10, 2) NOT NULL
);	

CREATE TABLE ingredientes (
    id_ingrediente INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    costo_adicional DECIMAL(10, 2) NOT NULL
);

CREATE TABLE pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    hora_recogida TIME NOT NULL,
    estado ENUM('Pendiente', 'Preparando', 'Listo') DEFAULT 'Pendiente',
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente)
);

CREATE TABLE productos_pedido (
    id_producto_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_producto INT NOT NULL,
    tipo_producto ENUM('Pizza', 'Bebida') NOT NULL,
    tamano ENUM('Pequeña', 'Mediana', 'Grande') NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido)
);

CREATE TABLE ingredientes_pizza (
    id_ingrediente_pizza INT AUTO_INCREMENT PRIMARY KEY,
    id_pizza INT NOT NULL,
    id_ingrediente INT NOT NULL,
    FOREIGN KEY (id_pizza) REFERENCES pizzas(id_pizza),
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente)
);

CREATE TABLE ingredientes_adicionales (
    id_ingrediente_adicional INT AUTO_INCREMENT PRIMARY KEY,
    id_pedido INT NOT NULL,
    id_ingrediente INT NOT NULL,
    cantidad INT NOT NULL,
    costo_adicional DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pedido) REFERENCES pedidos(id_pedido),
    FOREIGN KEY (id_ingrediente) REFERENCES ingredientes(id_ingrediente)
);

CREATE TABLE combos (
    id_combo INT AUTO_INCREMENT PRIMARY KEY,
    id_pizza INT NOT NULL,
    id_bebida INT NOT NULL,
    precio_combo DECIMAL(10, 2) NOT NULL,
    FOREIGN KEY (id_pizza) REFERENCES pizzas(id_pizza),
    FOREIGN KEY (id_bebida) REFERENCES bebidas(id_bebida)
);