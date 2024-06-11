-- Inserciones para la tabla pais
INSERT INTO pais (nombre) VALUES ('Argentina'), ('Brasil'), ('Chile'), ('Perú'), ('México');

-- Inserciones para la tabla region
INSERT INTO region (nombre) VALUES ('Región Norte'), ('Región Sur'), ('Región Este'), ('Región Oeste'), ('Región Central');

-- Inserciones para la tabla ciudad
INSERT INTO ciudad (nombre) VALUES ('Buenos Aires'), ('Sao Paulo'), ('Santiago'), ('Lima'), ('Ciudad de México');

-- Inserciones para la tabla cliente
INSERT INTO cliente (nombre, apellido, email) VALUES
('Juan', 'Pérez', 'juan.perez@example.com'),
('Maria', 'Gómez', 'maria.gomez@example.com'),
('Luis', 'Martínez', 'luis.martinez@example.com'),
('Ana', 'Fernández', 'ana.fernandez@example.com'),
('Carlos', 'Rodríguez', 'carlos.rodriguez@example.com');

-- Inserciones para la tabla direccion_cliente
INSERT INTO direccion_cliente (cliente_id, pais_id, region_id, ciudad_id, detalle) VALUES
(1, 1, 1, 1, 'Calle Falsa 123'),
(2, 2, 2, 2, 'Avenida Siempre Viva 742'),
(3, 3, 3, 3, 'Boulevard de los Sueños Rotos 456'),
(4, 4, 4, 4, 'Calle de la Esperanza 789'),
(5, 5, 5, 5, 'Plaza Mayor 1011');

-- Inserciones para la tabla tipo_telefono
INSERT INTO tipo_telefono (tipo) VALUES ('Móvil'), ('Fijo'), ('Trabajo'), ('Casa'), ('Fax');

-- Inserciones para la tabla telefono_cliente
INSERT INTO telefono_cliente (cliente_id, tipo_id, numero) VALUES
(1, 1, '123456789'),
(2, 2, '987654321'),
(3, 3, '123123123'),
(4, 4, '456456456'),
(5, 5, '789789789');

-- Inserciones para la tabla marca
INSERT INTO marca (nombre) VALUES ('Toyota'), ('Ford'), ('Chevrolet'), ('Honda'), ('Nissan');

-- Inserciones para la tabla vehiculo
INSERT INTO vehiculo (placa, marca_id, modelo, año_fabricacion, cliente_id) VALUES
('ABC123', 1, 'Corolla', 2020, 1),
('DEF456', 2, 'Focus', 2019, 2),
('GHI789', 3, 'Camaro', 2018, 3),
('JKL012', 4, 'Civic', 2021, 4),
('MNO345', 5, 'Altima', 2017, 5);

-- Inserciones para la tabla servicio
INSERT INTO servicio (nombre, descripcion, costo) VALUES
('Cambio de Aceite', 'Cambio de aceite y filtro', 50.00),
('Alineación', 'Alineación de las cuatro ruedas', 40.00),
('Balanceo', 'Balanceo de neumáticos', 30.00),
('Revisión General', 'Revisión completa del vehículo', 100.00),
('Cambio de Frenos', 'Cambio de pastillas de freno', 80.00);

-- Inserciones para la tabla cargo
INSERT INTO cargo (puesto) VALUES ('Mecánico'), ('Administrador'), ('Recepcionista'), ('Vendedor'), ('Gerente');

-- Inserciones para la tabla empleado
INSERT INTO empleado (nombre, apellido, cargo_id, email) VALUES
('Pedro', 'Sánchez', 1, 'pedro.sanchez@example.com'),
('Laura', 'Ramírez', 2, 'laura.ramirez@example.com'),
('José', 'López', 3, 'jose.lopez@example.com'),
('Claudia', 'Torres', 4, 'claudia.torres@example.com'),
('Andrés', 'García', 5, 'andres.garcia@example.com');

-- Inserciones para la tabla telefono_empleado
INSERT INTO telefono_empleado (empleado_id, tipo_id, numero) VALUES
(1, 1, '321321321'),
(2, 2, '654654654'),
(3, 3, '987987987'),
(4, 4, '123123123'),
(5, 5, '456456456');

-- Inserciones para la tabla reparacion
INSERT INTO reparacion (fecha, empleado_id, vehiculo_id, costo_total, descripcion) VALUES
('2023-01-10', 1, 1, 150.00, 'Cambio de aceite y revisión general'),
('2023-02-15', 2, 2, 90.00, 'Alineación y balanceo'),
('2023-03-20', 3, 3, 130.00, 'Revisión general y cambio de frenos'),
('2023-04-25', 4, 4, 70.00, 'Cambio de aceite'),
('2023-05-30', 5, 5, 200.00, 'Revisión completa y alineación'),
('2023-03-10', 1, 1, 90.00, 'Cambio de aceite y alineación'),
('2024-01-15', 1, 1, 120.00, 'Cambio de aceite y balanceo de ruedas'),
('2024-09-01', 2, 2, 180.00, 'Alineación y revisión de frenos');

-- Inserciones para la tabla reparacion_servicio
INSERT INTO reparacion_servicio (reparacion_id, servicio_id) VALUES
(1, 1),
(1, 4),
(2, 2),
(2, 3),
(3, 4),
(3, 5),
(4, 1),
(5, 2),
(5, 4),
(6, 1), 
(6, 2),
(7, 1),  
(7, 3),
(8, 2),  
(8, 4);

-- Inserciones para la tabla contacto
INSERT INTO contacto (nombre, apellido, email) VALUES
('Mario', 'Bianchi', 'mario.bianchi@example.com'),
('Luigi', 'Verdi', 'luigi.verdi@example.com'),
('Antonio', 'Rossi', 'antonio.rossi@example.com'),
('Giovanni', 'Neri', 'giovanni.neri@example.com'),
('Roberto', 'Bruni', 'roberto.bruni@example.com');

-- Inserciones para la tabla proveedor
INSERT INTO proveedor (nombre, contacto_id, email) VALUES
('Proveedor A', 1, 'contactoA@example.com'),
('Proveedor B', 2, 'contactoB@example.com'),
('Proveedor C', 3, 'contactoC@example.com'),
('Proveedor D', 4, 'contactoD@example.com'),
('Proveedor E', 5, 'contactoE@example.com');

-- Inserciones para la tabla telefono_proveedor
INSERT INTO telefono_proveedor (proveedor_id, tipo_id, numero) VALUES
(1, 1, '789789789'),
(2, 2, '654654654'),
(3, 3, '321321321'),
(4, 4, '123123123'),
(5, 5, '987987987');

-- Inserciones para la tabla pieza
INSERT INTO pieza (nombre, descripcion) VALUES
('Filtro de Aceite', 'Filtro de aceite para motor'),
('Pastillas de Freno', 'Pastillas de freno de alta calidad'),
('Neumático', 'Neumático de 17 pulgadas'),
('Batería', 'Batería de 12V'),
('Amortiguador', 'Amortiguador delantero');

-- Inserciones para la tabla precio
INSERT INTO precio (proveedor_id, pieza_id, precio_venta, precio_proveedor) VALUES
(1, 1, 15.00, 10.00),
(2, 2, 50.00, 30.00),
(3, 3, 100.00, 70.00),
(4, 4, 80.00, 50.00),
(5, 5, 120.00, 90.00),
(1, 2, 50.00, 30.00);

-- Inserciones para la tabla reparacion_piezas
INSERT INTO reparacion_piezas (reparacion_id, pieza_id, cantidad) VALUES
(1, 1, 31),
(2, 2, 2),
(3, 3, 4),
(4, 4, 1),
(5, 5, 2),
(6, 1, 33),
(7, 1, 35),
(8, 2, 7);

-- Inserciones para la tabla cita
INSERT INTO cita (fecha_hora, cliente_id, vehiculo_id) VALUES
('2023-06-01 09:00:00', 1, 1),
('2023-06-02 10:00:00', 2, 2),
('2023-06-03 11:00:00', 3, 3),
('2023-06-04 12:00:00', 4, 4),
('2023-06-05 13:00:00', 5, 5),
('2023-03-10 14:00:00', 1, 1),
('2024-01-15 10:00:00', 1, 1),
('2024-09-01 14:00:00', 2, 2);

-- Inserciones para la tabla cita_servicio
INSERT INTO cita_servicio (cita_id, servicio_id) VALUES
(1, 1),  -- Cambio de Aceite 
(1, 4),  -- Revisión general
(2, 2),  -- Alineación
(3, 3),  -- Balanceo  
(4, 1),  -- Cambio de Aceite 
(5, 5),  -- cambio de frenos
(6, 1),  -- Cambio de Aceite 
(6, 2),  -- Alineación
(7, 1),  -- Cambio de Aceite
(7, 3),  -- balanceo
(8, 2),  -- Alineación
(8, 4);  -- cambio de frenos

-- Inserciones para la tabla ubicacion
INSERT INTO ubicacion (nombre) VALUES ('Depósito Central'), ('Almacén Norte'), ('Almacén Sur'), ('Almacén Este'), ('Almacén Oeste');

-- Inserciones para la tabla inventario
INSERT INTO inventario (cantidad, ubicacion_id) VALUES
(100, 1),
(150, 2),
(200, 3),
(250, 4),
(300, 5);

-- Inserciones para la tabla pieza_inventario
INSERT INTO pieza_inventario (inventario_id, pieza_id) VALUES
(1, 1),
(2, 2),
(3, 3),
(4, 4),
(5, 5);

-- Inserciones para la tabla orden_compra
INSERT INTO orden_compra (fecha, proveedor_id, empleado_id, total) VALUES
('2023-01-05', 1, 1, 150.00),
('2023-02-10', 2, 2, 300.00),
('2023-03-15', 3, 3, 450.00),
('2023-04-20', 4, 4, 600.00),
('2023-05-25', 5, 5, 750.00);

-- Inserciones para la tabla orden_detalle
INSERT INTO orden_detalle (orden_id, pieza_id, cantidad, precio) VALUES
(1, 1, 10, 15.00),
(2, 2, 20, 50.00),
(3, 3, 30, 100.00),
(4, 4, 40, 80.00),
(5, 5, 50, 120.00);

-- Inserciones para la tabla factura
INSERT INTO factura (fecha, cliente_id, total) VALUES
('2023-01-10', 1, 178.50),
('2023-02-15', 2, 107.10),
('2023-03-20', 3, 154.70),
('2023-04-25', 4, 83.30),
('2023-05-30', 5, 238.00),
('2023-03-10', 1, 107.10),
('2024-01-15', 1, 142.80),
('2024-09-01', 2, 214.20);

-- Inserciones para la tabla factura_detalle
INSERT INTO factura_detalle (factura_id, reparacion_id, cantidad, precio) VALUES
(1, 1, 1, 150.00),
(2, 2, 1, 90.00),
(3, 3, 1, 130.00),
(4, 4, 1, 70.00),
(5, 5, 1, 200.00),
(6, 6, 1, 90.00),
(7, 7, 1, 120.00),
(8, 8, 1, 180.00);

-- Inserciones para la tabla kilometraje_vehiculo
INSERT INTO kilometraje_vehiculo (vehiculo_id, kilometraje) VALUES
(1, 15000),
(2, 25000),
(3, 5000),
(4, 30000),
(5, 45000);

