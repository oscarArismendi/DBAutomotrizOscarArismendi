-- Creacion de base de datos
DROP DATABASE IF EXISTS automotriz;
CREATE DATABASE automotriz;
-- Seleccion de base de datos
USE automotriz;

-- Creación de la tabla pais
CREATE TABLE pais (
	id INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Pais_Id PRIMARY KEY(id)
);
-- Creación de la tabla region
CREATE TABLE region (
	id INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Region_Id PRIMARY KEY(id)
);
-- Creación de la tabla ciudad
CREATE TABLE ciudad (
	id INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Ciudad_Id PRIMARY KEY(id)
);

-- Creación de la tabla cliente
CREATE TABLE cliente (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(254) NOT NULL UNIQUE,
    CONSTRAINT PK_Cliente_Id PRIMARY KEY(id)
);

-- Creación de la tabla direccion_cliente
CREATE TABLE direccion_cliente (
	id INT NOT NULL AUTO_INCREMENT,
	cliente_id INT NOT NULL,
	pais_id INT NOT NULL,
	region_id INT NOT NULL,
	ciudad_id INT NOT NULL,
	detalle TEXT NULL,
	CONSTRAINT PK_DireccionCliente_Id PRIMARY KEY(id),
	CONSTRAINT FK_Cliente_DireccionCliente_Id FOREIGN KEY(cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_Pais_DireccionCliente_Id FOREIGN KEY(pais_id) REFERENCES pais(id),
	CONSTRAINT FK_Region_DireccionCliente_Id FOREIGN KEY(region_id) REFERENCES region(id),
	CONSTRAINT FK_Ciudad_DireccionCliente_Id FOREIGN KEY(ciudad_id) REFERENCES ciudad(id)
);

-- Creación de la tabla tipo_telefono
CREATE TABLE tipo_telefono (
	id INT NOT NULL AUTO_INCREMENT,
	tipo VARCHAR(50) NOT NULL,
	CONSTRAINT PK_tipoTelefono_Id PRIMARY KEY(id)
);

-- Creación de la tabla telefono_cliente
CREATE TABLE telefono_cliente (
	id INT NOT NULL AUTO_INCREMENT,
	cliente_id INT NOT NULL,
	tipo_id INT NOT NULL,
	numero VARCHAR(50) NOT NULL,
	CONSTRAINT PK_TelefonoCliente_Id PRIMARY KEY(id),
	CONSTRAINT FK_Cliente_TelefonoCliente_Id FOREIGN KEY(cliente_id) REFERENCES cliente(id),
	CONSTRAINT FK_Tipo_TelefonoCliente_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id)
);

-- Creación de la tabla marca
CREATE TABLE marca(
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Marca_Id PRIMARY KEY(id)
);

-- Creación de la tabla vehiculo
CREATE TABLE vehiculo (
    id INT NOT NULL AUTO_INCREMENT,
    placa VARCHAR(10) NOT NULL UNIQUE,
    marca_id INT NOT NULL,
    modelo VARCHAR(50) NULL ,
    año_fabricacion YEAR NOT NULL,
    cliente_id INT NOT NULL,
    CONSTRAINT PK_Vehiculo_Id PRIMARY KEY (id),
    CONSTRAINT FK_Marca_Vehiculo_Id FOREIGN KEY (marca_id) REFERENCES marca(id),
	CONSTRAINT FK_Cliente_Vehiculo_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

-- Creación de la tabla servicio
CREATE TABLE servicio (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NULL,
    costo DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Servicio_Id PRIMARY KEY(id)
);

-- Creación de la tabla cargo
CREATE TABLE cargo(
	id INT NOT NULL AUTO_INCREMENT,
	puesto VARCHAR(50) NOT NULL,
    CONSTRAINT PK_Cargo_Id PRIMARY KEY(id)
);

-- Creación de la tabla empleado
CREATE TABLE empleado (
    id INT NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    cargo_id INT NOT NULL,
    email VARCHAR(254) NOT NULL,
    CONSTRAINT PK_Empleado_Id PRIMARY KEY (id),
    CONSTRAINT FK_Cargo_Empleado_Id FOREIGN KEY (cargo_id) REFERENCES cargo(id)
);

-- Creación de la tabla telefono_empleado
CREATE TABLE telefono_empleado (
	id INT NOT NULL AUTO_INCREMENT,
	empleado_id INT NOT NULL,
	tipo_id INT NOT NULL,
	numero VARCHAR(50) NOT NULL,
	CONSTRAINT PK_TelefonoEmpleado_Id PRIMARY KEY(id),
	CONSTRAINT FK_Empleado_TelefonoEmpleado_Id FOREIGN KEY(empleado_id) REFERENCES empleado(id),
	CONSTRAINT FK_Tipo_TelefonoEmpleado_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id)
);

-- Creación de la tabla reparacion
CREATE TABLE reparacion (
    id INT NOT NULL AUTO_INCREMENT,
    fecha DATE NOT NULL,
    empleado_id INT NOT NULL,
    vehiculo_id INT NOT NULL,
    costo_total DECIMAL(10, 2) NOT NULL,
    descripcion TEXT NULL,
    CONSTRAINT PK_Reparacion_Id PRIMARY KEY (id),
    CONSTRAINT FK_Empleado_Reparacion_Id FOREIGN KEY (empleado_id) REFERENCES empleado(id),
    CONSTRAINT FK_Vehiculo_Reparacion_Id FOREIGN KEY (vehiculo_id) REFERENCES vehiculo(id)
);

-- Creación de la tabla intermedia reparacion_servicio
CREATE TABLE reparacion_servicio(
	reparacion_id INT NOT NULL,
	servicio_id INT NOT NULL,
	CONSTRAINT PK_Reparacion_Id PRIMARY KEY(reparacion_id, servicio_id),
	CONSTRAINT FK_Reparacion_ReparacionServicio_Id FOREIGN KEY (reparacion_id) REFERENCES reparacion(id),
	CONSTRAINT FK_Servicio_ReparacionServicio_Id FOREIGN KEY (servicio_id) REFERENCES servicio(id)
);

-- Creación de la tabla contacto
CREATE TABLE contacto (
	id INT NOT NULL AUTO_INCREMENT,
	nombre VARCHAR(50) NOT NULL,
	apellido VARCHAR(50) NOT NULL,
	email VARCHAR(254) NOT NULL,
	CONSTRAINT PK_Contacto_Id PRIMARY KEY(id)
);


-- Creación de la tabla proveedor
CREATE TABLE proveedor (
    id INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    contacto_id INT NOT NULL,
    email VARCHAR(254) NOT NULL,
    CONSTRAINT PK_Proveedor_Id PRIMARY KEY (id),
    CONSTRAINT FK_Contacto_Proveedor_Id FOREIGN KEY (contacto_id) REFERENCES contacto(id)
);

-- Creación de la tabla telefono_proveedor
CREATE TABLE telefono_proveedor (
	id INT AUTO_INCREMENT NOT NULL,
	proveedor_id INT NOT NULL,
	tipo_id INT NOT NULL,
	numero VARCHAR(50) NOT NULL,
	CONSTRAINT PK_TelefonoProveedor_Id PRIMARY KEY(id),
	CONSTRAINT FK_Proveedor_TelefonoProveedor_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id),
	CONSTRAINT FK_Tipo_TelefonoProveedor_Id FOREIGN KEY(tipo_id) REFERENCES tipo_telefono(id)
);

-- Creación de la tabla pieza
CREATE TABLE pieza (
    id INT AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(50) NOT NULL,
    descripcion TEXT NULL,
    CONSTRAINT PK_Pieza_Id PRIMARY KEY (id)
);

-- Creación de la tabla intermedia precio
CREATE TABLE precio (
	proveedor_id INT NOT NULL,
	pieza_id INT NOT NULL,
	precio_venta DECIMAL(10, 2) NOT NULL,
	precio_proveedor DECIMAL(10, 2) NOT NULL,
	CONSTRAINT PK_Precio_Id PRIMARY KEY (proveedor_id, pieza_id),
	CONSTRAINT FK_Proveedor_Precio_Id FOREIGN KEY(proveedor_id) REFERENCES proveedor(id),
	CONSTRAINT FK_Pieza_Precio_Id FOREIGN KEY (pieza_id) REFERENCES pieza(id)
);

-- Creación de la tabla intermedia reparacion_piezas
CREATE TABLE reparacion_piezas(
    reparacion_id INT NOT NULL,
    pieza_id INT NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT PK_ReparacionPieza_Id PRIMARY KEY (reparacion_id, pieza_id),
    CONSTRAINT FK_Reparacion_ReparacionPieza_Id FOREIGN KEY (reparacion_id) REFERENCES reparacion(id),
    CONSTRAINT FK_Pieza_ReparacionPieza_Id FOREIGN KEY (pieza_id) REFERENCES pieza(id)
);

-- Creación de la tabla cita
CREATE TABLE cita (
    id INT AUTO_INCREMENT NOT NULL,
    fecha_hora DATETIME NOT NULL,
    cliente_id INT NOT NULL,
    vehiculo_id INT NOT NULL,
    CONSTRAINT PK_Cita_Id PRIMARY KEY (id),
    CONSTRAINT FK_Cliente_Cita_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id),
    CONSTRAINT FK_Vehiculo_Cita_Id FOREIGN KEY (vehiculo_id) REFERENCES vehiculo(id)
);

-- Creación de la tabla intermedia cita_servicio
CREATE TABLE cita_servicio (
	cita_id INT NOT NULL,
	servicio_id INT NOT NULL,
	CONSTRAINT PK_CitaServicio_Id PRIMARY KEY (cita_id, servicio_id),
	CONSTRAINT FK_Cita_CitaServicio_Id FOREIGN KEY (cita_id) REFERENCES cita(id),
	CONSTRAINT FK_Servicio_CitaServicio_Id FOREIGN KEY (servicio_id) REFERENCES servicio(id)
);

-- Creación de la tabla ubicacion
CREATE TABLE ubicacion (
	id INT AUTO_INCREMENT NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	CONSTRAINT PK_Ubicacion_Id PRIMARY KEY(id)
);

-- Creación de la tabla inventario
CREATE TABLE inventario (
    id INT AUTO_INCREMENT NOT NULL,
    cantidad INT NOT NULL,
    ubicacion_id INT NOT NULL,
    CONSTRAINT PK_Inventario_Id PRIMARY KEY (id),
    CONSTRAINT FK_Ubicacion_Inventario_Id FOREIGN KEY (ubicacion_id) REFERENCES ubicacion(id)
);

-- Creación de la tabla intermedia pieza_inventario
CREATE TABLE pieza_inventario(
	inventario_id INT NOT NULL,
	pieza_id INT NOT NULL,
	CONSTRAINT PK_PiezaInventario_Id PRIMARY KEY(inventario_id, pieza_id),
	CONSTRAINT FK_Inventario_PiezaInventario_Id FOREIGN KEY (inventario_id) REFERENCES inventario(id),
    CONSTRAINT FK_Pieza_PiezaInventario_Id FOREIGN KEY (pieza_id) REFERENCES pieza(id)
);

-- Creación de la tabla orden_compra
CREATE TABLE orden_compra (
    id INT AUTO_INCREMENT NOT NULL,
    fecha DATE NOT NULL,
    proveedor_id INT NOT NULL,
    empleado_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_OrdenCompra_Id PRIMARY KEY (id),
    CONSTRAINT FK_Proveedor_OrdenCompra_Id FOREIGN KEY (proveedor_id) REFERENCES proveedor(id),
    CONSTRAINT FK_Empleado_OrdenCompra_Id FOREIGN KEY (empleado_id) REFERENCES empleado(id)
);

-- Creación de la tabla intermedia orden_detalle
CREATE TABLE orden_detalle (
    orden_id INT NOT NULL,
    pieza_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_OrdenDetalle_Id PRIMARY KEY (orden_id, pieza_id),
    CONSTRAINT FK_OrdenCompra_OrdenDetalle_Id FOREIGN KEY (orden_id) REFERENCES orden_compra(id),
    CONSTRAINT FK_Pieza_OrdenDetalle_Id FOREIGN KEY (pieza_id) REFERENCES pieza(id)
);

-- Creación de la tabla factura
CREATE TABLE factura (
    id INT AUTO_INCREMENT NOT NULL,
    fecha DATE NOT NULL,
    cliente_id INT NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_Factura_Id PRIMARY KEY (id),
    CONSTRAINT FK_Cliente_Factura_Id FOREIGN KEY (cliente_id) REFERENCES cliente(id)
);

-- Creación de la tabla intermedia factura_detalle
CREATE TABLE factura_detalle (
    factura_id INT NOT NULL,
    reparacion_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio DECIMAL(10, 2) NOT NULL,
    CONSTRAINT PK_FacturaDetalle_Id PRIMARY KEY (factura_id, reparacion_id),
    CONSTRAINT FK_Factura_FacturaDetalle_Id FOREIGN KEY (factura_id) REFERENCES factura(id),
    CONSTRAINT FK_Reparacion_FacturaDetalle_Id FOREIGN KEY (reparacion_id) REFERENCES reparacion(id)
);

-- Creacion de tabla kilometraje

CREATE TABLE kilometraje_vehiculo (
    id INT AUTO_INCREMENT NOT NULL,
    vehiculo_id INT,
    kilometraje INT,
    CONSTRAINT PK_KilometrajeVehiculo_Id PRIMARY KEY (id),
    CONSTRAINT FK_KilometrajeVehiculo_Id FOREIGN KEY (vehiculo_id) REFERENCES vehiculo(id)
);