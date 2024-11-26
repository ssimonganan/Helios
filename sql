use ProPanels
create proc insertar_cliente
@id_cliente INT,
@nombre VARCHAR(50),
@direccion VARCHAR(50),
@telefono VARCHAR(15),
@correo_electronico VARCHAR(83)
as
insert into cliente (id_cliente, nombre, direccion, telefono, correo_electronico) values (@id_cliente, @nombre, @direccion, @telefono, @correo_electronico)
exec insertar_cliente 11, 'Carlos Miguel', 'cr28c #234C 23', '3244567890', 'miguel2@gmail.com'
select *  from cliente

create procedure modificar_cliente
@id_cliente INT,
@nombre VARCHAR(50),
@direccion VARCHAR(50),
@telefono VARCHAR(15),
@correo_electronico VARCHAR(83)
as
update cliente set nombre=@nombre, direccion=@direccion, telefono=@telefono, correo_electronico=@correo_electronico where id_cliente=5

select * from cliente
create procedure consultar_cliente
@id_cliente int
as
select * from cliente where id_cliente=@id_cliente

ALTER PROCEDURE consultar_cliente
@id_cliente int,
@nombre varchar(50)
as
delete from cliente where id_cliente=@id_cliente and nombre=@nombre

-- Crear cliente
CREATE PROCEDURE CrearCliente
@nombre VARCHAR(50),
@direccion VARCHAR(50),
@telefono VARCHAR(15),
@correo_electronico VARCHAR(83)
AS
BEGIN
INSERT INTO cliente (nombre, direccion, telefono, correo_electronico)
VALUES (@nombre, @direccion, @telefono, @correo_electronico);
END;
CREATE PROCEDURE LeerClientes
AS
BEGIN
SELECT * FROM cliente;
END;

CREATE PROCEDURE ActualizarCliente -- ya esta ejecutado
@id_cliente INT,
@nombre VARCHAR(50),
@direccion VARCHAR(50),
@telefono VARCHAR(15),
@correo_electronico VARCHAR(83)
AS
BEGIN
UPDATE cliente
SET nombre = @nombre,
direccion = @direccion,
telefono = @telefono,
correo_electronico = @correo_electronico
WHERE id_cliente = @id_cliente;
END;

CREATE PROCEDURE EliminarCliente
@id_cliente INT
AS
BEGIN
DELETE FROM cliente
WHERE id_cliente = @id_cliente;
END;
---inicia nuevo siclo
CREATE PROCEDURE RegistrarInstalacion
@id_cliente INT,
@id_panel_solar INT,
@id_empleado INT,
@fecha_instalacion DATETIME,
@direccion_instalacion VARCHAR(290)
AS
BEGIN
INSERT INTO instalacion (id_cliente, id_panel_solar, id_empleado, fecha_instalacion, direccion_instalacion)
VALUES (@id_cliente, @id_panel_solar, @id_empleado, @fecha_instalacion, @direccion_instalacion);
END;

CREATE PROCEDURE ActualizarMantenimiento
@id_mantenimiento INT,
@fecha_mantenimiento DATETIME,
@descripcion VARCHAR(100)
AS
BEGIN
    UPDATE mantenimiento
    SET fecha_mantenimiento = @fecha_mantenimiento,
        descripcion = @descripcion
    WHERE id_mantenimiento = @id_mantenimiento;
END;

CREATE PROCEDURE GenerarFactura
@id_cliente INT,
@fecha_facturacion DATETIME,
@monto DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO facturacion (id_cliente, fecha_facturacion, monto)
    VALUES (@id_cliente, @fecha_facturacion, @monto);
END;

CREATE PROCEDURE ClientesConFacturasMayores
@monto_minimo DECIMAL(10, 2)
AS
BEGIN
    SELECT c.id_cliente, c.nombre, f.monto
    FROM cliente c
    INNER JOIN facturacion f ON c.id_cliente = f.id_cliente
    WHERE f.monto > @monto_minimo;
END;

CREATE PROCEDURE ListarClientesPorInstalaciones
AS
BEGIN
    SELECT c.nombre, COUNT(i.id_instalacion) AS num_instalaciones
    FROM cliente c
    INNER JOIN instalacion i ON c.id_cliente = i.id_cliente
    GROUP BY c.nombre
    HAVING COUNT(i.id_instalacion) > 0;
END;

CREATE PROCEDURE CantidadClientesPorPanel
AS
BEGIN
    SELECT p.id_panel_solar, COUNT(i.id_cliente) AS num_clientes
    FROM panel p
    INNER JOIN instalacion i ON p.id_panel_solar = i.id_panel_solar
    GROUP BY p.id_panel_solar;
END;

CREATE PROCEDURE CantidadPorTipoYFecha
AS
BEGIN
    SELECT p.tipo_panel, i.fecha_instalacion, COUNT(i.id_cliente) AS num_clientes
    FROM panel p
    INNER JOIN instalacion i ON p.id_panel_solar = i.id_panel_solar
    GROUP BY p.tipo_panel, i.fecha_instalacion;
END;

---uno mas


CREATE PROCEDURE CantidadInstalacionesPorTipo
AS
BEGIN
    SELECT p.tipo_panel, COUNT(i.id_instalacion) AS num_instalaciones
    FROM panel p
    INNER JOIN instalacion i ON p.id_panel_solar = i.id_panel_solar
    GROUP BY p.tipo_panel;
END;

CREATE PROCEDURE ListarFacturasPorCliente
AS
BEGIN
    SELECT c.nombre, c.direccion, p.tipo_panel, f.monto
    FROM cliente c
    INNER JOIN facturacion f ON c.id_cliente = f.id_cliente
    INNER JOIN instalacion i ON c.id_cliente = i.id_cliente
    INNER JOIN panel p ON i.id_panel_solar = p.id_panel_solar;
END;

CREATE PROCEDURE ActualizarMontoFactura
@id_factura INT,
@nuevo_monto DECIMAL(10, 2)
AS
BEGIN
    UPDATE facturacion
    SET monto = @nuevo_monto
    WHERE id_factura = @id_factura;
END;

CREATE PROCEDURE InsertarFacturacion
@id_cliente INT,
@fecha_facturacion DATETIME,
@monto DECIMAL(10, 2)
AS
BEGIN
    INSERT INTO facturacion (id_cliente, fecha_facturacion, monto)
    VALUES (@id_cliente, @fecha_facturacion, @monto);
END;

CREATE PROCEDURE InsertarPanel
@tipo_panel VARCHAR(89),
@caracteristicas VARCHAR(100),
@fabricantes VARCHAR(30)
AS
BEGIN
    INSERT INTO panel (tipo_panel, caracteristicas, fabricantes)
    VALUES (@tipo_panel, @caracteristicas, @fabricantes);
END;
