-- Asegurarse de tener creada la base, sino, descomentar la siguiente l�nea
CREATE DATABASE AccessRequests;

USE AccessRequests;

-- Creaci�n tabla de supervisores
CREATE TABLE Supervisor (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del registro
"Name" varchar(30) NOT NULL, -- Nombre del supervisor
LastName varchar(30) NOT NULL, -- Apellido del supervisor
Email varchar(40) NOT NULL); -- Correo del supervisor


-- Creaci�n tabla de posiciones
CREATE TABLE Position (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id de la posici�n/puesto
Position varchar(30) NOT NULL); -- Nombre de la posici�n

INSERT INTO Position(Position) 
VALUES ('Dry Operator');
INSERT INTO Position(Position) 
VALUES ('Dry MultiSkill');
INSERT INTO Position(Position) 
VALUES ('Dry PST1');
INSERT INTO Position(Position) 
VALUES ('Dry PST2');
INSERT INTO Position(Position) 
VALUES ('Dry PST3');
INSERT INTO Position(Position) 
VALUES ('Wet Operator');
INSERT INTO Position(Position) 
VALUES ('Wet MultiSkill');
INSERT INTO Position(Position) 
VALUES ('Wet PST1');
INSERT INTO Position(Position) 
VALUES ('Wet PST2');
INSERT INTO Position(Position) 
VALUES ('Wet PST3');
INSERT INTO Position(Position) 
VALUES ('MFG Process Flow Lead');
INSERT INTO Position(Position) 
VALUES ('MFG Lead');

select * from Position




-- Creaci�n tabla de estados (de las solicitudes)
CREATE TABLE "Status" (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del estado
"Status" varchar(30) NOT NULL); -- Nombre del estado


-- Creaci�n tabla de sistemas
CREATE TABLE "System" (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del sistema
"System" varchar(30) NOT NULL); -- Nombre del sistema

INSERT INTO System("System") 
VALUES ('WLC');
INSERT INTO System("System") 
VALUES ('DLC');
INSERT INTO System("System") 
VALUES ('EBR');
INSERT INTO System("System") 
VALUES ('GETLOTS');
INSERT INTO System("System") 
VALUES ('SCANBAG');
select * from System

-- Creaci�n tabla de sedes
CREATE TABLE Headquarter (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id de la sede
Headquarter varchar(2) NOT NULL); -- Abreviatura de la sede


-- Creaci�n tabla aprobadores
CREATE TABLE Approver (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del aprobador
"Name" varchar(30) NOT NULL, -- Nombre del supervisor
LastName varchar(30) NOT NULL, -- Apellido del supervisor
Email varchar(40) NOT NULL, -- Correo del supervisor
IdHeadquarter bigint NOT NULL -- Sede donde labora el aprobador (CR o PR)
CONSTRAINT FkHeadquarter FOREIGN KEY (IdHeadquarter) REFERENCES Headquarter (ID)); -- Llave for�nea del id de la sede




-- Creaci�n tabla de empleados
CREATE TABLE Employee (
ID bigint PRIMARY KEY, -- Id/N�mero del empleado. Se ingresa al hacer la solicitud
Employee varchar(30) NOT NULL, -- Nombre del empleado
LastName1 varchar(30) NOT NULL, -- Primer apellido del empleado
LastName2 varchar(30) NOT NULL); -- Segundo apellido del empleado


-- Creaci�n tabla de solicitudes
CREATE TABLE Request (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id de la solicitud
IdEmployee bigint, -- Id/N�mero de empleado
IdPosition bigint, -- Id de la posici�n/puesto
RequestDate datetime, -- Fecha en que se realiza la solicitud
IdSupervisor bigint, -- Id del supervisor que realiza la solicitud
CONSTRAINT FkEmployee FOREIGN KEY (IdEmployee) REFERENCES Employee (ID), -- Llave for�nea del n�mero de empleado
CONSTRAINT FkPosition FOREIGN KEY (IdPosition) REFERENCES Position (ID), -- Llave for�nea del id de la posici�n
CONSTRAINT FkSupervisor FOREIGN KEY (IdSupervisor) REFERENCES Supervisor (ID) -- Llave for�nea del id del supervisor
);


-- Creaci�n tabla de accesos o permisos
CREATE TABLE Access (
ID bigint IDENTITY (1,1) PRIMARY KEY, -- Id del acceso
Access varchar(30) NOT NULL, -- Nombre del acceso
IdSystem bigint NOT NULL, -- Id del sistema al que pertenece el acceso
"Level" varchar(30) NOT NULL, -- Nivel al que pertenece el acceso
IdApprover bigint NOT NULL, -- Id del aprobador del acceso o permiso
CONSTRAINT FkSystem FOREIGN KEY (IdSystem) REFERENCES "System" (ID), -- Llave for�nea del id del sistema
CONSTRAINT FkApprover FOREIGN KEY (IdApprover) REFERENCES Approver (ID)); -- Llave for�nea del id del aprobador del permiso

INSERT INTO Access(Access,IdSystem,"Level",IdApprover) 
VALUES ('Close S.O.', 1, 'WLCSOCLOSE', 1);

INSERT INTO Access(Access,IdSystem,"Level",IdApprover) 
VALUES ('DLC MoldMaintenance', 2, 'DLCMM', 1);

INSERT INTO Access(Access,IdSystem,"Level",IdApprover) 
VALUES ('Dry Lot Creation', 2, 'DLC', 1);

INSERT INTO Access(Access,IdSystem,"Level",IdApprover) 
VALUES ('EBR ALL Access', 3, 'EBRALL', 1);

INSERT INTO Access(Access,IdSystem,"Level",IdApprover) 
VALUES ('EBR Dry Mechanic', 3, 'EBRDME', 1);


select * from System


-- Creaci�n tabla de relaci�n accesos-posiciones
CREATE TABLE AccessPosition(
IdPosition bigint, -- Id de la posici�n/puesto. Hay accesos (como el de correo electr�nico) que no est�n relacionados a una posici�n espec�fica
IdAccess bigint NOT NULL, -- Id del acceso solicitado
CONSTRAINT FkPosition2 FOREIGN KEY (IdPosition) REFERENCES Position (ID), -- Llave for�nea del id de la posici�n
CONSTRAINT FkAccess FOREIGN KEY (IdAccess) REFERENCES Access (ID)); -- Llave for�nea del id del acceso


-- Creaci�n tabla de relaci�n accesos-solicitud
CREATE TABLE AccessRequested (
IdRequest bigint NOT NULL, -- Id de la solicitud
IdAccess bigint NOT NULL, -- Id del acceso solicitado
IdStatus bigint NOT NULL, -- Id del estado en que se encuentra la solicitud
UpdateDate datetime, -- Fecha en la que se acepta o deniega el permiso
Comments varchar(200), -- Comentarios que puede que haga el aprobador
CONSTRAINT FkRequest FOREIGN KEY (IdRequest) REFERENCES Request (ID), -- Llave for�nea del id de la solicitud
CONSTRAINT FkAccess2 FOREIGN KEY (IdAccess) REFERENCES Access (ID), -- Llave for�nea del id del acceso
CONSTRAINT FkStatus FOREIGN KEY (IdStatus) REFERENCES "Status" (ID)); -- Llave for�nea del id del estado