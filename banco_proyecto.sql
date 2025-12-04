CREATE DATABASE IF NOT EXISTS banco_proyecto;
USE banco_proyecto;

-- TABLA: SEGMENTO_CLIENTE (PyME / Gran Empresa)
CREATE TABLE segmento_cliente (
    id_segmento_cliente INT AUTO_INCREMENT PRIMARY KEY,
    descripcion VARCHAR(50) NOT NULL
);

INSERT INTO segmento_cliente (descripcion)
VALUES ('PyME'),
       ('Gran Empresa');


-- TABLA: SUCURSALES
CREATE TABLE sucursales (
    id_sucursal INT AUTO_INCREMENT PRIMARY KEY,
    nombre_sucursal VARCHAR(120) NOT NULL,
    direccion VARCHAR(150),
    ciudad VARCHAR(80),
    provincia VARCHAR(80),
    telefono VARCHAR(30)
);


-- TABLA: CLIENTES
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(120) NOT NULL,
    cuit VARCHAR(20) NOT NULL UNIQUE,
    telefono VARCHAR(30),
    email VARCHAR(100),
    direccion VARCHAR(150),
    ciudad VARCHAR(80),
    provincia VARCHAR(80),
    id_segmento_cliente INT NOT NULL,
    CONSTRAINT fk_cliente_segmento
        FOREIGN KEY (id_segmento_cliente)
        REFERENCES segmento_cliente(id_segmento_cliente)
);


-- TABLA: EMPLEADOS
CREATE TABLE empleados (
    id_empleado INT AUTO_INCREMENT PRIMARY KEY,
    id_sucursal INT NOT NULL,
    nombre VARCHAR(80) NOT NULL,
    apellido VARCHAR(80) NOT NULL,
    dni VARCHAR(20) NOT NULL UNIQUE,
    cargo VARCHAR(60),
    fecha_ingreso DATE,
    salario DECIMAL(15,2),
    CONSTRAINT fk_empleado_sucursal
        FOREIGN KEY (id_sucursal)
        REFERENCES sucursales(id_sucursal)
);


-- TABLA: PRESTAMOS
CREATE TABLE prestamos (
    id_prestamo INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_empleado INT NOT NULL,
    id_sucursal INT NOT NULL,
    fecha_otorgamiento DATE NOT NULL,
    monto_original DECIMAL(15,2) NOT NULL,
    tasa_interes DECIMAL(5,2) NOT NULL,
    plazo_meses INT NOT NULL,
    CONSTRAINT fk_prestamo_cliente
        FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    CONSTRAINT fk_prestamo_empleado
        FOREIGN KEY (id_empleado) REFERENCES empleados(id_empleado),
    CONSTRAINT fk_prestamo_sucursal
        FOREIGN KEY (id_sucursal) REFERENCES sucursales(id_sucursal)
);