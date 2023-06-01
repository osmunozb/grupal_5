-- Parte 1: Crear entorno de trabajo
-- Crear una base de datos

create database db_te_lo_vendo;

-- Crear un usuario con todos los privilegios para trabajar con la base de datos recién creada.

create user admin_tlv@localhost identified by '1234';
grant all privileges on aplicacion to admin_tlv@localhost;
use db_te_lo_vendo;

-- Parte 2: Crear dos tablas.
-- La primera almacena a los usuarios de la aplicación (id_usuario, nombre, apellido, contraseña, zona horaria
-- (por defecto UTC-3), género y teléfono de contacto).

create table usuarios (
	id_usuario int primary key auto_increment,
    nombre varchar(20),
    apellido varchar(20),
    contrasenia varchar(10),
    zona_horaria varchar(10) default 'UTC-3',
    genero varchar(10),
    telefono varchar(15)
);

-- La segunda tabla almacena información relacionada a la fecha-hora de ingreso de los usuarios a la
-- plataforma (id_ingreso, id_usuario y la fecha-hora de ingreso (por defecto la fecha-hora actual)).

create table ingresos (
	id_ingreso int primary key auto_increment,
    id_usuario int,
    fecha DATETIME DEFAULT current_timestamp,
    foreign key (id_usuario) references usuarios(id_usuario)
);

-- Parte 3: Modificación de la tabla
-- Modifique el UTC por defecto.Desde UTC-3 a UTC-2.

alter table usuarios alter column zona_horaria set default 'UTC-2';

-- Parte 4: Creación de registros.
-- Para cada tabla crea 8 registros.

-- registro 'tabla usuarios'
INSERT INTO usuarios(nombre, apellido, contrasenia, genero, telefono)
VALUES
	('luis', 'gonzales', '12345', 'hombre', '82993823'),
	('marta', 'roca', '12ffg4', 'mujer', '67883823'),
	('josé', 'infante', 'plsd72', 'hombre', '951277323'),
	('luis', 'salazar', 'pas628', 'hombre', '973555377'),
	('joaquin', 'selva', '1ki0o3', 'hombre', '120923371'),
	('gabriel', 'matus', '546ggd', 'hombre', '1292376455'),
	('marta', 'sanchez', 'ueii3', 'mujer', '072527373'),
	('lorena', 'clorinda', 'fgfrt34', 'mujer', '334347373');
-- registro 'tabla ingreso'
-- usuario 1
INSERT INTO ingresos (id_usuario, fecha)
VALUES (1, '2023-01-03');
INSERT INTO ingresos (id_usuario)
VALUES (1);
INSERT INTO ingresos (id_usuario, fecha)
VALUES (1, '2023-01-25');
-- usuario 2
INSERT INTO ingresos (id_usuario, fecha)
VALUES (2, '2023-01-25');
INSERT INTO ingresos (id_usuario)
VALUES (2);
-- usuario 3
INSERT INTO ingresos (id_usuario, fecha)
VALUES (3, '2023-05-25');
-- usuario 5
INSERT INTO ingresos (id_usuario)
VALUES (5);
-- usuario 8
INSERT INTO ingresos (id_usuario, fecha)
VALUES (8, '2023-02-21');

-- Parte 5: Justifique cada tipo de dato utilizado. ¿Es el óptimo en cada caso?

/*
En id_usuario se usó int para poder dar auto increment y sus primary key para que no se repitan su id.
En nombre, apellido, contrasenia, genero y telefono se usó varchar para poder ingresar valores según el largo del string y ya que puede recibir caracteres especiales.
En zona_horaria usamos VARCHAR DEFAULT para en caso de que no se especifique al insert, inserte el valor que se dejó por defecto
En fecha usamos DATETIME para dejar registro de fecha y hora de ingreso del usuario a la aplicación Y ademas default los datos de fecha y hora actual
por si el suario no especifica una hora.
*/

-- Parte 6: Creen una nueva tabla llamada Contactos (id_contacto, id_usuario, número de teléfono, correo electrónico).

create table contactos (
    id_contacto int primary key auto_increment,
    id_usuario int,
    telefono varchar(15),
    correo_electronico varchar(50),
    foreign key (id_usuario) references usuarios(id_usuario)
);

-- Parte 7: Modifique la columna teléfono de contacto, para crear un vínculo entre la tabla Usuarios y la tabla Contactos.

alter table usuarios add unique (telefono);
alter table contactos add foreign key (telefono) references usuarios(telefono);
