CREATE TABLE Region( 
    reg_codigo INTEGER PRIMARY KEY, 
    reg_nombre VARCHAR2(20) 
);

CREATE TABLE Comuna( 
    com_codigo INTEGER PRIMARY KEY, 
    com_nombre VARCHAR2(20), 
    reg_codigo INTEGER, 
    FOREIGN KEY (reg_codigo) REFERENCES Region(reg_codigo) 
);

CREATE TABLE Cliente( 
    cli_rut VARCHAR2(12) PRIMARY KEY, 
    cli_nombres VARCHAR2(25), 
    cli_apellidos VARCHAR2(25), 
    cli_telefono VARCHAR2(12), 
    cli_direccion VARCHAR2(20), 
    cli_estado_civil VARCHAR2(20), 
    cli_correo_electronico VARCHAR(50), 
    com_codigo INTEGER, 
    FOREIGN KEY (com_codigo) REFERENCES Comuna(com_codigo) 
);

CREATE TABLE Estado( 
    est_codigo INTEGER PRIMARY KEY, 
    est_descripcion VARCHAR2(30) 
);

CREATE TABLE EMPRESA( 
    emp_codigo INTEGER PRIMARY KEY, 
    emp_descripcion VARCHAR2(30) 
);

CREATE TABLE Patologia( 
    pat_codigo INTEGER PRIMARY KEY, 
    pat_descripcion VARCHAR2(30) 
);

CREATE TABLE Evento( 
    eve_codigo INTEGER PRIMARY KEY, 
    eve_descripcion VARCHAR2(20), 
    eve_hora_inicio VARCHAR2(5), -- Formato HH:MM 
    eve_hora_fin VARCHAR2(5), -- Formato HH:MM 
    eve_valor_arriendo INTEGER, 
    eve_modalidad_pago VARCHAR2(10), -- Preguntar 
    eve_fecha_pago DATE, 
    cli_rut VARCHAR2(12), 
    FOREIGN KEY (cli_rut) REFERENCES Cliente(cli_rut) 
);

CREATE TABLE Cursos( 
    cur_codigo INTEGER PRIMARY KEY, 
    cur_descripcion VARCHAR2(20), 
    cur_valor_sesion INTEGER, 
    cur_duracion INTEGER, 
    cur_num_sesiones INTEGER, 
    cur_fecha_inicio DATE, 
    cur_fecha_termino DATE 
);

CREATE TABLE Profesion( 
    prof_codigo INTEGER PRIMARY KEY, 
    prof_nombre VARCHAR2(25) 
);

CREATE TABLE Instructor( 
    ins_rut VARCHAR2(12) PRIMARY KEY, 
    ins_nombres VARCHAR2(25), 
    ins_apellidos VARCHAR2(25), 
    ins_telefono VARCHAR2(12), 
    ins_direccion VARCHAR2(20), 
    ins_sueldo_base INTEGER, 
    prof_codigo INTEGER, 
    FOREIGN KEY (prof_codigo) REFERENCES Profesion(prof_codigo) 
);

CREATE TABLE Programa( 
    pro_codigo INTEGER PRIMARY KEY, 
    pro_descripcion VARCHAR2(25), 
    pro_valor_sesion INTEGER, 
    pro_duracion INTEGER 
);

CREATE TABLE Salon( 
    sal_codigo INTEGER PRIMARY KEY, 
    sal_nombre VARCHAR2(25), 
    sal_capacidad INTEGER 
);

CREATE TABLE Sesion( 
    ses_codigo INTEGER PRIMARY KEY, 
    ses_descripcion VARCHAR2(25), 
    ses_fecha DATE, 
    ses_hora VARCHAR2(5), -- Formato HH:MM (Consultar) 
    sal_codigo INTEGER, 
    ins_rut VARCHAR2(12), 
    FOREIGN KEY (sal_codigo) REFERENCES Salon(sal_codigo), 
    FOREIGN KEY (ins_rut) REFERENCES Instructor(ins_rut) 
);

CREATE TABLE Plan( 
    pla_codigo INTEGER PRIMARY KEY, 
    pla_modalidad VARCHAR2(20), 
    pla_valor INTEGER, 
    pro_codigo INTEGER, 
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo) 
);

CREATE TABLE Padece( 
    pat_codigo INTEGER, 
    cli_rut VARCHAR2(12), 
    PRIMARY KEY (pat_codigo, cli_rut), 
    FOREIGN KEY (pat_codigo) REFERENCES Patologia(pat_codigo), 
    FOREIGN KEY (cli_rut) REFERENCES Cliente(cli_rut) 
);

CREATE TABLE Trabaja( 
    emp_codigo INTEGER, 
    cli_rut VARCHAR2(12), 
    PRIMARY KEY (emp_codigo, cli_rut), 
    FOREIGN KEY (emp_codigo) REFERENCES Empresa(emp_codigo), 
    FOREIGN KEY (cli_rut) REFERENCES Cliente(cli_rut) 
);

CREATE TABLE Posee( 
    est_codigo INTEGER, 
    fecha_inicio DATE, 
    fecha_termino DATE, 
    cli_rut VARCHAR2(12), 
    PRIMARY KEY (est_codigo, fecha_inicio, cli_rut), 
    FOREIGN KEY (est_codigo) REFERENCES Estado(est_codigo), 
    FOREIGN KEY (cli_rut) REFERENCES Cliente(cli_rut) 
);

CREATE TABLE Contrata( 
    pla_codigo INTEGER, 
    cli_rut VARCHAR2(12), 
    fecha DATE, 
    PRIMARY KEY (pla_codigo, cli_rut), 
    FOREIGN KEY (pla_codigo) REFERENCES Plan(pla_codigo), 
    FOREIGN KEY (cli_rut) REFERENCES Cliente(cli_rut) 
);

CREATE TABLE Inscribe( 
    cur_codigo INTEGER, 
    cli_rut VARCHAR2(20), 
    fecha DATE, 
    PRIMARY KEY (cur_codigo, cli_rut), 
    FOREIGN KEY (cur_codigo) REFERENCES Cursos(cur_codigo), 
    FOREIGN KEY (cli_rut) REFERENCES Cliente(cli_rut) 
);

CREATE TABLE Reside( 
    com_codigo INTEGER, 
    ins_rut VARCHAR2(12), 
    PRIMARY KEY (com_codigo, ins_rut), 
    FOREIGN KEY (com_codigo) REFERENCES Comuna(com_codigo), 
    FOREIGN KEY (ins_rut) REFERENCES Instructor(ins_rut) 
);

CREATE TABLE Se_da( 
    cur_codigo INTEGER, 
    ses_codigo INTEGER, 
    PRIMARY KEY (cur_codigo, ses_codigo), 
    FOREIGN KEY (cur_codigo) REFERENCES Cursos(cur_codigo), 
    FOREIGN KEY (ses_codigo) REFERENCES Sesion(ses_codigo) 
);

CREATE TABLE Se_da_dos( 
    pro_codigo INTEGER, 
    ses_codigo INTEGER, 
    PRIMARY KEY (pro_codigo, ses_codigo), 
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo), 
    FOREIGN KEY (ses_codigo) REFERENCES Sesion(ses_codigo) 
);

CREATE TABLE Agenda( 
    ses_codigo INTEGER, 
    cli_rut VARCHAR2(12), 
    PRIMARY KEY (ses_codigo, cli_rut), 
    FOREIGN KEY (ses_codigo) REFERENCES Sesion(ses_codigo), 
    FOREIGN KEY (cli_rut) REFERENCES Cliente(cli_rut) 
);

CREATE TABLE Arrienda( 
    sal_codigo INTEGER, 
    eve_codigo INTEGER, 
    PRIMARY KEY (sal_codigo, eve_codigo), 
    FOREIGN KEY (sal_codigo) REFERENCES Salon(sal_codigo), 
    FOREIGN KEY (eve_codigo) REFERENCES Evento(eve_codigo) 
);

CREATE TABLE Imparte( 
    ins_rut VARCHAR2(12), 
    cur_codigo INTEGER, 
    PRIMARY KEY (ins_rut, cur_codigo), 
    FOREIGN KEY (ins_rut) REFERENCES Instructor(ins_rut), 
    FOREIGN KEY (cur_codigo) REFERENCES Cursos(cur_codigo) 
);

CREATE TABLE Es_asociado( 
    pro_codigo INTEGER, 
    ins_rut VARCHAR2(12), 
    PRIMARY KEY (pro_codigo, ins_rut), 
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo), 
    FOREIGN KEY (ins_rut) REFERENCES Instructor(ins_rut) 
);

CREATE TABLE Inscribe_dos( 
    pro_codigo INTEGER, 
    fecha DATE, 
    cli_rut VARCHAR2(12), 
    PRIMARY KEY (pro_codigo, cli_rut), 
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo), 
    FOREIGN KEY (cli_rut) REFERENCES Cliente(cli_rut) 
);

CREATE TABLE Terapia( 
    pro_codigo INTEGER PRIMARY KEY, 
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo) 
);

CREATE TABLE Especialidad( 
    esp_codigo INTEGER PRIMARY KEY, 
    esp_nombre VARCHAR2(20) 
);

CREATE TABLE Entrenamiento( 
    pro_codigo INTEGER Primary Key, 
    pro_tipo VARCHAR2(20), 
    esp_codigo INTEGER, 
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo), 
    FOREIGN KEY (esp_codigo) REFERENCES Especialidad(esp_codigo) 
);

--1)REGIONES----------------------------------------------------------------------------------------------------

INSERT ALL
    
INTO Region(reg_codigo, reg_nombre)
VALUES(1,'Arica y Parinacota')

INTO Region(reg_codigo, reg_nombre)
VALUES(2,'Tarapaca')

INTO Region(reg_codigo, reg_nombre)
VALUES(3,'Antafogasta')

INTO Region(reg_codigo, reg_nombre)
VALUES(4,'Atacama')

INTO Region(reg_codigo, reg_nombre)
VALUES(5,'Coquimbo')

INTO Region(reg_codigo, reg_nombre)
VALUES(6,'Valparaiso')

INTO Region(reg_codigo, reg_nombre)
VALUES(7,'Metropolitana')

INTO Region(reg_codigo, reg_nombre)
VALUES(8,'Ohiggins')

INTO Region(reg_codigo, reg_nombre)
VALUES(9,'Maula')

INTO Region(reg_codigo, reg_nombre)
VALUES(10,'Nuble')

INTO Region(reg_codigo, reg_nombre)
VALUES(11,'Bio Bio')

INTO Region(reg_codigo, reg_nombre)
VALUES(12,'Araucania')

INTO Region(reg_codigo, reg_nombre)
VALUES(13,'Rios')

INTO Region(reg_codigo, reg_nombre)
VALUES(14,'Lagos')

INTO Region(reg_codigo, reg_nombre)
VALUES(15,'Aysen')

INTO Region(reg_codigo, reg_nombre)
VALUES(16,'Magallanes')

SELECT * FROM dual;

--2)COMUNAS------------------------------------------------------------------------------------------------

INSERT ALL    

    -- Arica y Parinacota
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (1, 'Arica', 1)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (2, 'Camarones', 1)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (3, 'Putre', 1)
    
    -- Tarapacá
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (4, 'Iquique', 2)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (5, 'Alto Hospicio', 2)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (6, 'Pica', 2)
    
    -- Antofagasta
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (7, 'Antofagasta', 3)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (8, 'Mejillones', 3)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (9, 'Tocopilla', 3)
    
    -- Atacama
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (10, 'Copiapó', 4)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (11, 'Caldera', 4)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (12, 'Tierra Amarilla', 4)
    
    -- Coquimbo
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (13, 'La Serena', 5)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (14, 'Coquimbo', 5)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (15, 'Ovalle', 5)
    
    -- Valparaíso
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (16, 'Valparaíso', 6)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (17, 'Viña del Mar', 6)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (18, 'Quilpué', 6)

    -- Región Metropolitana de Santiago
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (19, 'Santiago', 7)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (20, 'Nunoa', 7)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (21, 'Las Condes', 7)
    
    -- Región del Libertador General Bernardo O'Higgins
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (22, 'Rancagua', 8)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (23, 'San Fernando', 8)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (24, 'Pichilemu', 8)
    
    -- Región del Maule
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (25, 'Talca', 9)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (26, 'Curicó', 9)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (27, 'Linares', 9)
    
    -- Región de Ñuble
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (28, 'Chillán', 10)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (29, 'Quirihue', 10)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (30, 'San Carlos', 10)
    
    -- Región del Biobío
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (31, 'Concepción', 11)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (32, 'Talcahuano', 11)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (33, 'Los Ángeles', 11)
    
    -- Región de La Araucanía
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (34, 'Temuco', 12)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (35, 'Villarrica', 12)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (36, 'Pucón', 12)
    
    -- Región de Los Ríos
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (37, 'Valdivia', 13)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (38, 'La Unión', 13)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (39, 'Panguipulli', 13)
    
    -- Región de Los Lagos
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (40, 'Puerto Montt', 14)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (41, 'Castro', 14)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (42, 'Ancud', 14)
    
    -- Región de Aysén del General Carlos Ibáñez del Campo
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (43, 'Coyhaique', 15)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (44, 'Puerto Aysén', 15)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (45, 'Chile Chico', 15)
    
    -- Región de Magallanes y de la Antártica Chilena
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (46, 'Punta Arenas', 16)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (47, 'Puerto Natales', 16)
    INTO Comuna(com_codigo, com_nombre, reg_codigo) VALUES (48, 'Porvenir', 16)
    

SELECT * FROM dual;

--3)CLIENTES----------------------------------------------------------------------------------------

INSERT ALL
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('22032005-1', 'Kratos', 'Dios de la guerra', '918884475', 'Midgard', 'Viudo', 'Kratos.TheFuckingGod@hotmail.com', 47)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('10121993-0', 'Doom', 'Slayer', '912345678', 'Infierno', 'Soltero', 'slayer.666@example.com', 25)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('34567890-1', 'Pedro', 'Pascal', '923456789', 'Nueva York', 'Divorciado', 'pedro.pascal@gmail.com', 21)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('15012013-3', 'Ellie', 'Miller', '934567890', 'Jackson', 'Casado', 'ellie.millerz@yahoo.com', 25)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('56789012-3', 'Samus', 'Aran', '945678901', 'Zebes', 'Soltero', 'samus.aran@metroid.com', 1)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('02122013-1', 'Rick', 'Sánchez', '956789012', 'Avenida Smith', 'Viudo', 'anonimo.noeslacuentadericksanchez@gmail.com', 21)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('24042012-3', 'Clementine', 'Everett', '967890123', 'Macon', 'Soltero', 'Clementine.Everett@hotmail.com', 22)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('25101996-5', 'Lara', 'Croft', '981342255', 'Croft Manor', 'Soltera', 'lara.croft@gmail.com', 21)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('15112001-5', 'Master', 'Chief', '959753468', 'UNSC Infinity', 'Soltero', 'master.chief@gmail.com', 25)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('22032002-0', 'Jill', 'Valentine', '975928445', 'Raccoon City', 'Soltera', 'jill.valentine@gmail.com', 37)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('20051985-1', 'Cristiano', 'Ronaldo', '987654321', 'Turín', 'Casado', 'cristiano.ronaldo@gmail.com', 35)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('24061984-7', 'Lionel', 'Messi', '923456789', 'Barcelona', 'Casado', 'lionel.messi@gmail.com', 28)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('10021992-2', 'Neymar', 'Jr.', '955444333', 'Paris', 'Casado', 'neymar.jr@gmail.com', 43)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('10041977-2', 'John', 'Cena', '923456789', 'West Newbury', 'Casado', 'john.cena@gmail.com', 35)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES  ('10051987-2', 'Roman', 'Reigns', '987654321', 'Pensacola', 'Casado', 'roman.reigns@gmail.com', 25)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('10051986-2', 'Seth', 'Rollins', '999888777', 'Davenport', 'Casado', 'seth.rollins@gmail.com', 17)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('10011987-3', 'Becky', 'Lynch', '977666555', 'Dublin', 'Casada', 'becky.lynch@gmail.com', 17)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('19240319-3', 'The', 'Undertaker', '955444333', 'Death Valley', 'Casado', 'undertaker@gmail.com', 42)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('19261967-3', 'Demon', 'Kane', '923125459', 'Death Valley', 'Casado', 'Kanes@gmail.com', 42)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('12306198-5', 'Cody', 'Rhodes', '977888999', 'Marietta', 'Casado', 'cody.rhodes@gmail.com', 26)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES ('13220311-1', 'Daniel', 'Bryan', '921654987', 'Aberdeen', 'Casado', 'daniel.bryan@gmail.com', 16)
    
    INTO Cliente(cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) 
    VALUES  ('11041980-7', 'Randy', 'Orton', '944555666', 'St. Louis', 'Casado', 'randy.orton@gmail.com', 8)
    
SELECT * FROM dual;


--4)ESTADO------------------------------------------------------------------------------------------

INSERT ALL
    
	INTO Estado(est_codigo, est_descripcion)
    VALUES (1, 'Habilitado')

    INTO Estado(est_codigo, est_descripcion)
    VALUES (2, 'No Habilitado')
        
SELECT * FROM dual;

--5)EMPRESA--------------------------------------------------------------------------------

INSERT ALL
    
	INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (1, 'Black Mesa')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (2,'OCP')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (3,'Acme Corporation')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (4, 'Los Pollos Hermanos')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (5, 'Weyland-Yutani')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (6, 'Stark Industries')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (7, 'Wayne Enterprises')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (8, 'Umbrella Corporation')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (9, 'Aperture Science')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (10, 'Oscorp Industries')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (11, 'Chupalo entonces')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (12, 'S.T.A.R. Labs')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (13, 'Mas me crece')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (14, 'Planet Express')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (15, 'Cerberus Network')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (16, 'MAD')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (17, 'Dexter Laboratory')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (18, 'Massive Dynamic')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (19, 'Oscorp Industries')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (20, 'LexCorp')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (21, 'Oracle')

    INTO Empresa(emp_codigo, emp_descripcion)
    VALUES (22, 'InGen')
    
SELECT * FROM dual;


--6)PATOLOGIA----------------------------------------------------------

INSERT ALL

    INTO Patologia(pat_codigo, pat_descripcion)
    VALUES (1,'Epicondilitis')

    INTO Patologia(pat_codigo, pat_descripcion)
    VALUES (2,'Lumbalgia')

    INTO Patologia(pat_codigo, pat_descripcion)
    VALUES (3,'Radiculopatia')

    INTO Patologia(pat_codigo, pat_descripcion)
    VALUES (4,'Bursitis')

    INTO Patologia(pat_codigo, pat_descripcion)
    VALUES (5,'Escoliosis')

    INTO Patologia(pat_codigo, pat_descripcion)
    VALUES (6,'Fibromialgia')

    INTO Patologia(pat_codigo, pat_descripcion)
    VALUES (7,'Artritis')

    INTO Patologia (pat_codigo, pat_descripcion)
    VALUES (8,'Dolor crónico')

    INTO Patologia (pat_codigo, pat_descripcion)
    VALUES (9,'Parálisis cerebral')

    INTO Patologia (pat_codigo, pat_descripcion)
    VALUES (10,'Lesiones')
    
SELECT * FROM dual;

--7)EVENTO-------------------------------------------------

INSERT ALL

    INTO Evento(eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut)
    VALUES(1,'Danza para Chile', '16:00' , '17:30', 35000, 'Efectivo', TO_DATE('2024-07-05','YYYY-MM-DD'),'25101996-5')

    INTO Evento(eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut)
    VALUES(2,'Tela', '17:00' , '18:30', 40000, 'Deposito', TO_DATE('2024-07-05','YYYY-MM-DD'),'56789012-3')

    INTO Evento(eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut)
    VALUES(3,'Arte y meditacion', '17:00' , '18:30', 3000, 'Efectivo', TO_DATE('2024-07-05','YYYY-MM-DD'),'10121993-0')
    
SELECT * FROM dual;

--8)CURSOS----------------------------------------------------------------------

INSERT ALL

    INTO Cursos(cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino)
    VALUES(1,'Pilates',20000,90,4,TO_DATE('2024-07-01','YYYY-MM-DD'),TO_DATE('2024-08-01','YYYY-MM-DD'))

    INTO Cursos(cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino)
    VALUES(2,'Yoga',23500,90,4,TO_DATE('2024-05-06','YYYY-MM-DD'),TO_DATE('2024-07-29','YYYY-MM-DD'))

    INTO Cursos(cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino)
    VALUES(3,'Hidroterapia',25000,90,4,TO_DATE('2024-05-06','YYYY-MM-DD'),TO_DATE('2024-07-29','YYYY-MM-DD'))

    INTO Cursos(cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino)
    VALUES(4,'Electroterapia',50000,90,4,TO_DATE('2024-07-01','YYYY-MM-DD'),TO_DATE('2024-09-29','YYYY-MM-DD'))

    INTO Cursos(cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino)
    VALUES(5,'Terapia Manual',100000,90,4,TO_DATE('2024-06-04','YYYY-MM-DD'),TO_DATE('2024-08-29','YYYY-MM-DD'))

    INTO Cursos(cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino)
    VALUES(6,'Rehabilitacion',75000,90,4,TO_DATE('2024-06-04','YYYY-MM-DD'),TO_DATE('2024-08-29','YYYY-MM-DD'))


SELECT * FROM dual;

--9)PROFESION--------------------------------------------------------------------------------------------------

INSERT ALL

	INTO Profesion(prof_codigo, prof_nombre)
    VALUES(1,'Especialista Reh')

    INTO Profesion(prof_codigo, prof_nombre)
    VALUES(2,'Instructor Pilates')

    INTO Profesion(prof_codigo, prof_nombre)
    VALUES(3,'Instructor Yoga')

    INTO Profesion(prof_codigo, prof_nombre)
    VALUES(4,'Hidroterapeuta')

    INTO Profesion(prof_codigo, prof_nombre)
    VALUES(5,'Especialista Ele')

    INTO Profesion(prof_codigo, prof_nombre)
    VALUES(6,'Terapeuta Manual')
    
SELECT * FROM dual;

--10)INSTRUCTOR----------------------------------------------------------------------------------------------------

INSERT ALL

	INTO Instructor(ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
    VALUES('78945612-3','Johnathan','Smith','994613758','Maple Avenue,',45000,1)

    INTO Instructor(ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
    VALUES('67894561-0','Emily','Johnson','934619752','Elm Street',52500,2)

    INTO Instructor(ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
    VALUES('56789456-7','Michael','Williams','925663121','Oak Drive',60000,3)

    INTO Instructor(ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
    VALUES('45678945-1','Olivia','Brown','987654321','Pine Road',55000,4)

    INTO Instructor(ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
    VALUES('26983254-7','Ruth','Ortiz','924245581','Talcahuano',75000,5)

    INTO Instructor(ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
    VALUES('10527349-4','Felipe','Miranda','931346791','Nacimiento',550000,6)
    
SELECT * FROM dual;

--11)PROGRAMA-------------------------------------------------------------------------------------------------------

INSERT ALL

	INTO Programa(pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion)
	VALUES(1,'Meditacion y Natacion',5000,90)

    INTO Programa(pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion)
	VALUES(2,'Yoga y Elasticidad',5500,90)

    INTO Programa(pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion)
	VALUES(3,'Telas y fuerza ritmica ',3500,90)

    INTO Programa(pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion)
	VALUES(4,'Aumento fuerza corporal',6500,90)

    INTO Programa(pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion)
	VALUES(5,'Lira moderna', 4000,90)

    INTO Programa(pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion)
    VALUES(6,'Música y más', 10000,90)

    INTO Programa(pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion)
   	VALUES(7,'Pilates y más', 100,90)
    
    
SELECT * FROM dual;

--12)SALON--------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Salon(sal_codigo, sal_nombre, sal_capacidad)
	VALUES(1,'salon 1', 20)

    INTO Salon(sal_codigo, sal_nombre, sal_capacidad)
	VALUES(2, 'salon 2', 30)

    INTO Salon(sal_codigo, sal_nombre, sal_capacidad)
	VALUES(3, 'salon 3', 30)

    INTO Salon(sal_codigo, sal_nombre, sal_capacidad)
	VALUES(4, 'salon 4', 20)

    INTO Salon(sal_codigo, sal_nombre, sal_capacidad)
	VALUES(5,'salon 5', 10)

    INTO Salon(sal_codigo, sal_nombre, sal_capacidad)
	VALUES(6,'salon 6', 40)
    
SELECT * FROM dual;

--13)SESION---------------------------------------------------------------------------------------------------------------

INSERT ALL


--LUNES------------------------------------------------------------------------------------------------------------------------------

    ----Cursos----------------------------------------
    
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(1,'Pilates',TO_DATE('2024-07-01','YYYY-MM-DD'),'09:00',2,'78945612-3')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(2,'Yoga',TO_DATE('2024-05-06','YYYY-MM-DD'),'10:30',3,'56789456-7')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(3,'Hidroterapia',TO_DATE('2024-05-06','YYYY-MM-DD'),'12:00',6,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(4,'Electroterapia',TO_DATE('2024-07-01','YYYY-MM-DD'),'13:30',5,'78945612-3')
    
    --Programas--------------------------------------------
     INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(24,'Meditacion y Natacion',TO_DATE('2024-07-08','YYYY-MM-DD'),'15:00',6,'45678945-1')

     INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(25,'Lira Moderna',TO_DATE('2024-07-08','YYYY-MM-DD'),'16:30',1,'26983254-7')

     INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(26,'Aumento Fuerza Corporal',TO_DATE('2024-07-08','YYYY-MM-DD'),'18:00',2,'45678945-1')

     INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(27,'Musica y mas',TO_DATE('2024-07-08','YYYY-MM-DD'),'19:30',4,'45678945-1')
    
--MARTES------------------------------------------------------------------------------------------------------------------------------

    ----Cursos----------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(5,'Terapia Manual',TO_DATE('2024-06-04','YYYY-MM-DD'),'09:00',5,'10527349-4')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(6,'Rehabilitación',TO_DATE('2024-06-04','YYYY-MM-DD'),'10:30',5,'78945612-3')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(7,'Pilates',TO_DATE('2024-07-02','YYYY-MM-DD'),'12:00',3,'78945612-3')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(8,'Yoga',TO_DATE('2024-07-02','YYYY-MM-DD'),'13:30',2,'56789456-7')

    
	--Programas--------------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(28,'Meditacion y Natacion',TO_DATE('2024-07-09','YYYY-MM-DD'),'15:00',6,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(29,'Yoga y Elasticidad',TO_DATE('2024-07-09','YYYY-MM-DD'),'16:30',2,'56789456-7')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(30,'Pilates y mas',TO_DATE('2024-07-09','YYYY-MM-DD'),'18:00',4,'67894561-0')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(31,'Aumento Fuerza Corporal',TO_DATE('2024-07-09','YYYY-MM-DD'),'19:30',2,'45678945-1')

--MIERCOLES------------------------------------------------------------------------------------------------------------------------------

    ----Cursos----------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(9,'Hidroterapia',TO_DATE('2024-05-08','YYYY-MM-DD'),'09:00',6,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(10,'Electroterapia',TO_DATE('2024-07-03','YYYY-MM-DD'),'10:30',5,'26983254-7')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(11,'Terapia Manual',TO_DATE('2024-07-03','YYYY-MM-DD'),'12:00',5,'10527349-4')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(12,'Rehabilitacion',TO_DATE('2024-06-05','YYYY-MM-DD'),'13:30',5,'78945612-3')

    --Programas--------------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(32,'Telas y fuerza',TO_DATE('2024-07-10','YYYY-MM-DD'),'15:00',1,'56789456-7')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(33,'Yoga y Elasticidad',TO_DATE('2024-07-10','YYYY-MM-DD'),'16:30',2,'56789456-7')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(34,'Aumento Fuerza Corporal',TO_DATE('2024-07-10','YYYY-MM-DD'),'19:30',4,'45678945-1')

--JUEVES------------------------------------------------------------------------------------------------------------------------------

    ----Cursos----------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(13,'Pilates',TO_DATE('2024-07-04','YYYY-MM-DD'),'09:00',2,'78945612-3')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(14,'Yoga',TO_DATE('2024-05-09','YYYY-MM-DD'),'10:30',3,'56789456-7')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(15,'Hedroterapia',TO_DATE('2024-05-09','YYYY-MM-DD'),'12:00',6,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(16,'Electroterapia',TO_DATE('2024-07-04','YYYY-MM-DD'),'13:30',5,'26983254-7')

    --Programas--------------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(35,'Telas y fuerza',TO_DATE('2024-07-11','YYYY-MM-DD'),'14:00',3,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(36,'Lira moderna',TO_DATE('2024-07-11','YYYY-MM-DD'),'16:30',2,'26983254-7')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(37,'Aumento Fuerza Corporal',TO_DATE('2024-07-11','YYYY-MM-DD'),'18:00',4,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(38,'Musica y mas',TO_DATE('2024-07-11','YYYY-MM-DD'),'19:30',1,'45678945-1')

--VIERNES------------------------------------------------------------------------------------------------------------------------------

    ----Cursos----------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(17,'Terapia Manual',TO_DATE('2024-06-07','YYYY-MM-DD'),'09:00',5,'10527349-4')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(18,'Rehabilitacion',TO_DATE('2024-06-07','YYYY-MM-DD'),'10:30',5,'78945612-3')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(19,'Pilates',TO_DATE('2024-07-05','YYYY-MM-DD'),'12:00',3,'78945612-3')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(20,'Yoga',TO_DATE('2024-07-10','YYYY-MM-DD'),'13:30',2,'56789456-7')

    --Programas--------------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(39,'Meditacion y Natacion',TO_DATE('2024-07-01','YYYY-MM-DD'),'15:00',6,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(40,'Lira  moderna',TO_DATE('2024-07-12','YYYY-MM-DD'),'16:30',3,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(41,'Pilates y mas',TO_DATE('2024-07-12','YYYY-MM-DD'),'18:00',2,'67894561-0')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(42,'Telas y fuerza',TO_DATE('2024-07-12','YYYY-MM-DD'),'19:30',2,'56789456-7')
    
--SABADO-------------------------------------------------------------------------------------------------------------------------------

    ----Cursos----------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(21,'Hidroterapia',TO_DATE('2024-05-11','YYYY-MM-DD'),'09:00',6,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(22,'Electroterapia',TO_DATE('2024-07-06','YYYY-MM-DD'),'10:30',5,'26983254-7')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(23,'Terapia Manual',TO_DATE('2024-06-08','YYYY-MM-DD'),'12:00',5,'10527349-4')

    --Programas--------------------------------------------
    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(43,'Meditacion y Natacion',TO_DATE('2024-07-13','YYYY-MM-DD'),'15:00',6,'45678945-1')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(44,'Yoga y Elasticidad',TO_DATE('2024-07-13','YYYY-MM-DD'),'16:30',3,'56789456-7')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(45,'Pilates y mas',TO_DATE('2024-07-13','YYYY-MM-DD'),'18:00',2,'67894561-0')

    INTO Sesion(ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    VALUES(46,'Musica y mas',TO_DATE('2024-07-13','YYYY-MM-DD'),'19:30',1,'10527349-4')
    
SELECT * FROM dual;

--14)PLAN----------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Plan(pla_codigo, pla_modalidad, pla_valor, pro_codigo)
	VALUES(1,'4 veces a la semana',21990,1)

	INTO Plan(pla_codigo, pla_modalidad, pla_valor, pro_codigo)
	VALUES(2,'3 veces a la semana',30000,2)

    INTO Plan(pla_codigo, pla_modalidad, pla_valor, pro_codigo)
	VALUES(3,'3 veces a la semana',10000,3)

    INTO Plan(pla_codigo, pla_modalidad, pla_valor, pro_codigo)
	VALUES(4,'4 veces a la semana', 22990,4)

    INTO Plan(pla_codigo, pla_modalidad, pla_valor, pro_codigo)
	VALUES(5,'3 veces a la semana',10000,5)

    INTO Plan(pla_codigo, pla_modalidad, pla_valor, pro_codigo)
	VALUES(6,'3 veces a la semana',59990,6)

    INTO Plan(pla_codigo, pla_modalidad, pla_valor, pro_codigo)
	VALUES(7,'4 veces a la semana',590,7)
  
SELECT * FROM dual;

--15)PADECE--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Padece(pat_codigo, cli_rut)
	VALUES(5,'19261967-3')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(2,'20051985-1')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(1,'10021992-2')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(4,'19240319-3')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(7,'12306198-5')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(4,'10011987-3')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(4,'56789012-3')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(10,'22032002-0')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(1,'10041977-2')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(10,'22032005-1')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(6,'10051986-2')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(1,'11041980-7')

    INTO Padece(pat_codigo, cli_rut)
	VALUES(9,'24061984-7')


SELECT * FROM dual;

--16)TRABAJA--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(1,'22032005-1')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(2,'10121993-0')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(3,'34567890-1')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(4,'15012013-3')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(5,'56789012-3')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(6,'02122013-1')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(7,'24042012-3')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(8,'10051986-2')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(9,'15112001-5')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(10,'22032002-0')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(11,'20051985-1')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(12,'24061984-7')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(13,'10021992-2')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(14,'10041977-2')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(15,'10051987-2')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(16,'10051986-2')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(17,'10011987-3')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(18,'19240319-3')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(19,'19261967-3')
    
    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(20,'12306198-5')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(21,'13220311-1')

    INTO Trabaja(emp_codigo, cli_rut)
	VALUES(22,'11041980-7')
    
SELECT * FROM dual;

--17)POSEE--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'22032005-1')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'10121993-0')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(2,TO_DATE('2024-01-01','YYYY-MM-DD'),TO_DATE('2024-03-31','YYYY-MM-DD'),'34567890-1')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'15012013-3')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'56789012-3')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'02122013-1')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(2,TO_DATE('2024-01-01','YYYY-MM-DD'),TO_DATE('2024-03-31','YYYY-MM-DD'),'24042012-3')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'25101996-5')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'15112001-5')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(2,TO_DATE('2024-01-01','YYYY-MM-DD'),TO_DATE('2024-03-31','YYYY-MM-DD'),'22032002-0')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(2,TO_DATE('2024-01-01','YYYY-MM-DD'),TO_DATE('2024-03-31','YYYY-MM-DD'),'20051985-1')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(2,TO_DATE('2024-01-01','YYYY-MM-DD'),TO_DATE('2024-03-31','YYYY-MM-DD'),'24061984-7')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'10021992-2')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'10041977-2')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'10051987-2')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'10051986-2')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'10011987-3')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'19240319-3')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'19261967-3')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'12306198-5')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(1,TO_DATE('2024-01-03','YYYY-MM-DD'),TO_DATE('2024-12-29','YYYY-MM-DD'),'13220311-1')

    INTO Posee(est_codigo, fecha_inicio, fecha_termino, cli_rut)
    VALUES(2,TO_DATE('2024-01-01','YYYY-MM-DD'),TO_DATE('2024-03-31','YYYY-MM-DD'),'11041980-7')
    
SELECT * FROM dual;

--18)CONTRATA--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(7,'22032005-1',TO_DATE('2024-02-27','YYYY-MM-DD'))

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(7,'10121993-0',TO_DATE('2024-02-27','YYYY-MM-DD'))

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(7,'56789012-3',TO_DATE('2024-02-27','YYYY-MM-DD'))

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(7,'25101996-5',TO_DATE('2024-02-27','YYYY-MM-DD'))

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(4,'15112001-5',TO_DATE('2024-02-27','YYYY-MM-DD'))

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(2,'10051986-2',TO_DATE('2024-02-27','YYYY-MM-DD'))

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(2,'10011987-3',TO_DATE('2024-02-27','YYYY-MM-DD'))

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(6,'19240319-3',TO_DATE('2024-02-27','YYYY-MM-DD'))

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(7,'19261967-3',TO_DATE('2024-02-27','YYYY-MM-DD'))

    INTO Contrata(pla_codigo, cli_rut, fecha)
	VALUES(6,'13220311-1',TO_DATE('2024-02-27','YYYY-MM-DD'))
    
    
SELECT * FROM dual;

--19)INSCRIBE--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Inscribe(cur_codigo, cli_rut, fecha)
	VALUES(5,'22032005-1',TO_DATE('2024-02-25','YYYY-MM-DD'))

    INTO Inscribe(cur_codigo, cli_rut, fecha)
	VALUES(1,'10121993-0',TO_DATE('2024-02-25','YYYY-MM-DD'))

    INTO Inscribe(cur_codigo, cli_rut, fecha)
	VALUES(1,'56789012-3',TO_DATE('2024-02-25','YYYY-MM-DD'))
    
    INTO Inscribe(cur_codigo, cli_rut, fecha)
	VALUES(6,'02122013-1',TO_DATE('2024-02-25','YYYY-MM-DD'))

    INTO Inscribe(cur_codigo, cli_rut, fecha)
	VALUES(1,'25101996-5',TO_DATE('2024-02-25','YYYY-MM-DD'))

    INTO Inscribe(cur_codigo, cli_rut, fecha)
	VALUES(1,'15112001-5',TO_DATE('2024-02-25','YYYY-MM-DD'))

    INTO Inscribe(cur_codigo, cli_rut, fecha)
	VALUES(3,'10051987-2',TO_DATE('2024-02-25','YYYY-MM-DD'))

    INTO Inscribe(cur_codigo, cli_rut, fecha)
	VALUES(3,'10051986-2',TO_DATE('2024-02-25','YYYY-MM-DD'))
    
SELECT * FROM dual;

--20)RESIDE--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Reside(com_codigo, ins_rut)
	VALUES(27,'78945612-3')

    INTO Reside(com_codigo, ins_rut)
	VALUES(21,'67894561-0')

    INTO Reside(com_codigo, ins_rut)
	VALUES(13,'56789456-7')

    INTO Reside(com_codigo, ins_rut)
	VALUES(8,'45678945-1')

    INTO Reside(com_codigo, ins_rut)
	VALUES(28,'26983254-7')

    INTO Reside(com_codigo, ins_rut)
	VALUES(5,'10527349-4')
    
SELECT * FROM dual;

--21)SE_DA--------------------------------------------------------------------------------------------------------------------

INSERT ALL

	--Lunes-----------------
    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(1,1)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(2,2)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(3,3)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(4,4)

    --Martes-----------------
    
	INTO Se_da(cur_codigo, ses_codigo)
	VALUES(5,5)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(6,6)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(1,7)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(2,8)
    
   --Miercoles-----------------

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(3,9)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(4,10)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(5,11)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(6,12)

    --Jueves-----------------

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(1,13)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(2,14)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(3,15)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(4,16)

    --Viernes-----------------

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(5,17)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(6,18)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(1,19)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(2,20)
    
    --Sabado-----------------

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(3,21)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(4,22)

    INTO Se_da(cur_codigo, ses_codigo)
	VALUES(5,23)
    
    
SELECT * FROM dual;

--22)SE_DA_DOS--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(1,1)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(2,2)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(3,3)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(4,4)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(1,24)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(5,25)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(4,26)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(6,27)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(5,28)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(2,29)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(7,30)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(4,31)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(6,32)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(2,33)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(4,34)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(1,35)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(5,36)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(4,37)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(6,38)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(3,39)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(2,40)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(7,41)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(5,42)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(3,43)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(2,44)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(7,45)

    INTO Se_da_dos(pro_codigo, ses_codigo)
	VALUES(6,46)
SELECT * FROM dual;

--23)AGENDA--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(1,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(2,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(5,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(10,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(14,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(26,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(27,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(28,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(29,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(30,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(40,'10041977-2')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(1,'56789012-3')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(3,'56789012-3')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(4,'56789012-3')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(26,'56789012-3')

    INTO Agenda(ses_codigo, cli_rut)
	VALUES(30,'56789012-3')
    
SELECT * FROM dual;

--24)ARRIENDA--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Arrienda(sal_codigo, eve_codigo)
	VALUES(6,1)

    
SELECT * FROM dual;

--25)IMPARTE--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Imparte( ins_rut, cur_codigo)
	VALUES('78945612-3',1)

    INTO Imparte( ins_rut, cur_codigo)
	VALUES('67894561-0',2)

    INTO Imparte( ins_rut, cur_codigo)
	VALUES('56789456-7',3)

    INTO Imparte( ins_rut, cur_codigo)
	VALUES('45678945-1',4)

    INTO Imparte( ins_rut, cur_codigo)
	VALUES('26983254-7',5)

    INTO Imparte( ins_rut, cur_codigo)
	VALUES('10527349-4',6)

    
SELECT * FROM dual;

--26)ES_ASOCIADO--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Es_asociado(pro_codigo, ins_rut)
	VALUES(1, '78945612-3')  
    
	INTO Es_asociado(pro_codigo, ins_rut)
	VALUES(2, '56789456-7') 
    
	INTO Es_asociado(pro_codigo, ins_rut)
	VALUES(3, '45678945-1') 
    
	INTO Es_asociado(pro_codigo, ins_rut)
	VALUES(4, '45678945-1') 
    
	INTO Es_asociado(pro_codigo, ins_rut)
	VALUES(5, '26983254-7')
    
	INTO Es_asociado(pro_codigo, ins_rut)
	VALUES(6, '10527349-4') 
    
	INTO Es_asociado(pro_codigo, ins_rut)
	VALUES(7, '26983254-7')
    
SELECT * FROM dual;

--27)INSCRIBE_DOS--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Inscribe_dos(pro_codigo, fecha, cli_rut)
	VALUES(1,TO_DATE('2024-01-30','YYYY-MM-DD'),'34567890-1')

    INTO Inscribe_dos(pro_codigo, fecha, cli_rut)
	VALUES(1,TO_DATE('2024-01-30','YYYY-MM-DD'),'15012013-3')

    INTO Inscribe_dos(pro_codigo, fecha, cli_rut)
	VALUES(7,TO_DATE('2024-01-30','YYYY-MM-DD'),'10051986-2')

    INTO Inscribe_dos(pro_codigo, fecha, cli_rut)
	VALUES(4,TO_DATE('2024-01-30','YYYY-MM-DD'),'19240319-3')

    INTO Inscribe_dos(pro_codigo, fecha, cli_rut)
	VALUES(5,TO_DATE('2024-01-30','YYYY-MM-DD'),'15112001-5')

    INTO Inscribe_dos(pro_codigo, fecha, cli_rut)
	VALUES(2,TO_DATE('2024-01-30','YYYY-MM-DD'),'19261967-3')

    INTO Inscribe_dos(pro_codigo, fecha, cli_rut)
	VALUES(3,TO_DATE('2024-01-30','YYYY-MM-DD'),'11041980-7')

SELECT * FROM dual;

--28)TERAPIA--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Terapia(pro_codigo)
	VALUES(1)

    
SELECT * FROM dual;

--29)ESPECIALIDAD--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Especialidad(esp_codigo, esp_nombre)
	VALUES(1,'Relajacion acuatica')

    INTO Especialidad(esp_codigo, esp_nombre)
	VALUES(2,'Flexibilidad mental')

    INTO Especialidad(esp_codigo, esp_nombre)
	VALUES(3,'Fuerza y ritmo')

    INTO Especialidad(esp_codigo, esp_nombre)
	VALUES(4,'Aumento de fuerza')

    INTO Especialidad(esp_codigo, esp_nombre)
	VALUES(5,'Aerea y danza')

    INTO Especialidad(esp_codigo, esp_nombre)
	VALUES(6,'Musica y movimiento')

    INTO Especialidad(esp_codigo, esp_nombre)
	VALUES(7,'Pilates Max')
    
SELECT * FROM dual;

--30)ENTRENAMIENTO--------------------------------------------------------------------------------------------------------------------

INSERT ALL

    INTO Entrenamiento(pro_codigo, pro_tipo, esp_codigo)
	VALUES(1,'Acuatico',1)

    INTO Entrenamiento(pro_codigo, pro_tipo, esp_codigo)
	VALUES(2,'Yoga',2)

    INTO Entrenamiento(pro_codigo, pro_tipo, esp_codigo)
	VALUES(3,'Telas',3)

    INTO Entrenamiento(pro_codigo, pro_tipo, esp_codigo)
	VALUES(4,'Calistenia',4)

    INTO Entrenamiento(pro_codigo, pro_tipo, esp_codigo)
	VALUES(5,'Lira',5)

    INTO Entrenamiento(pro_codigo, pro_tipo, esp_codigo)
	VALUES(6,'Musica',6)

    INTO Entrenamiento(pro_codigo, pro_tipo, esp_codigo)
	VALUES(7,'Pilates',7)
    
SELECT * FROM dual;

-- Habilitar la salida de DBMS_OUTPUT
SET SERVEROUTPUT ON;

-- Declaración del bloque PL/SQL
DECLARE
    -- Tipos compuestos para almacenar nombres de comunas y sus cantidades
    TYPE t_comuna_nombres IS TABLE OF VARCHAR2(20);
    TYPE t_comuna_cantidades IS TABLE OF INTEGER;
    
    -- Variables para las colecciones
    comunas t_comuna_nombres;
    cantidades t_comuna_cantidades;
BEGIN
    -- Inicialización de las colecciones
    comunas := t_comuna_nombres();
    cantidades := t_comuna_cantidades();

    -- Consulta que recolecta nombres de comunas y sus respectivas cantidades
    SELECT com.com_nombre, COUNT(*) AS cantidad
    BULK COLLECT INTO comunas, cantidades
    FROM Cliente cli
    JOIN Comuna com ON cli.com_codigo = com.com_codigo
    JOIN Posee pos ON cli.cli_rut = pos.cli_rut
    JOIN Contrata con ON cli.cli_rut = con.cli_rut
    JOIN Plan pla ON con.pla_codigo = pla.pla_codigo
    JOIN Programa pro ON pla.pro_codigo = pro.pro_codigo
    JOIN Entrenamiento ent ON pro.pro_codigo = ent.pro_codigo
    WHERE pos.est_codigo = 1 -- Estado Habilitado
    AND ent.pro_tipo = 'Pilates'
    AND con.fecha >= ADD_MONTHS(SYSDATE, -6) -- Últimos seis meses
    GROUP BY com.com_nombre
    ORDER BY cantidad DESC;

    -- Verificar y mostrar los resultados
    IF comunas.COUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Ranking de Comunas:');
        FOR idx IN 1 .. comunas.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(comunas(idx) || ' - ' || cantidades(idx));
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('No se encontraron resultados.');
    END IF;
END;

-- Ejercicio 2
DECLARE
    v_cli_rut Cliente.cli_rut%TYPE := '&Ingrese_el_v_cli_rut';
    TYPE t_programa IS TABLE OF VARCHAR2(35);
    TYPE t_curso IS TABLE OF VARCHAR2(35);
    TYPE t_cantidad IS TABLE OF INTEGER;
    v_programas t_programa;
    v_cursos t_curso;
    v_cantidades_prog t_cantidad;
    v_cantidades_cur t_cantidad;
BEGIN
    -- Obtener cantidad de sesiones agendadas por programa
    SELECT pro.pro_descripcion, COUNT(*) AS cantidad
    BULK COLLECT INTO v_programas, v_cantidades_prog
    FROM Sesion ses
    JOIN Agenda age ON ses.ses_codigo = age.ses_codigo
    JOIN Se_da_dos sdd ON ses.ses_codigo = sdd.ses_codigo
    JOIN Programa pro ON sdd.pro_codigo = pro.pro_codigo
    WHERE age.cli_rut = v_cli_rut
    AND EXTRACT(MONTH FROM ses.ses_fecha) = EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM ses.ses_fecha) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY pro.pro_descripcion;

    -- Obtener cantidad de sesiones agendadas por curso
    SELECT cur.cur_descripcion, COUNT(*) AS cantidad
    BULK COLLECT INTO v_cursos, v_cantidades_cur
    FROM Sesion ses
    JOIN Agenda age ON ses.ses_codigo = age.ses_codigo
    JOIN Se_da sd ON ses.ses_codigo = sd.ses_codigo
    JOIN Cursos cur ON sd.cur_codigo = cur.cur_codigo
    WHERE age.cli_rut = v_cli_rut
    AND EXTRACT(MONTH FROM ses.ses_fecha) = EXTRACT(MONTH FROM SYSDATE)
    AND EXTRACT(YEAR FROM ses.ses_fecha) = EXTRACT(YEAR FROM SYSDATE)
    GROUP BY cur.cur_descripcion;

    -- Mostrar resultados
    DBMS_OUTPUT.PUT_LINE('Cantidad de Sesiones Agendadas por Programa:');
    FOR i IN 1 .. v_programas.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_programas(i) || ': ' || v_cantidades_prog(i));
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Cantidad de Sesiones Agendadas por Curso:');
    FOR i IN 1 .. v_cursos.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_cursos(i) || ': ' || v_cantidades_cur(i));
    END LOOP;
END;

DROP TRIGGER trg_validar_agenda_sesion

CREATE OR REPLACE TRIGGER trg_validar_agenda_sesion
BEFORE INSERT ON Agenda
FOR EACH ROW
DECLARE
    v_programa_count INTEGER := 0;
    v_curso_count INTEGER := 0;
    v_estado VARCHAR2(30);
    v_fecha_sesion DATE;
BEGIN
    -- Obtener la fecha de la sesión
    BEGIN
        SELECT ses_fecha INTO v_fecha_sesion
        FROM Sesion
        WHERE ses_codigo = :NEW.ses_codigo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            RAISE_APPLICATION_ERROR(-20003, 'No se encontró la sesión especificada.');
    END;

    -- Validar si el cliente está inscrito en el programa de la sesión
    BEGIN
        SELECT COUNT(*)
        INTO v_programa_count
        FROM Inscribe_dos id
        JOIN Se_da_dos sdd ON id.pro_codigo = sdd.pro_codigo
        WHERE id.cli_rut = :NEW.cli_rut
        AND sdd.ses_codigo = :NEW.ses_codigo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_programa_count := 0;
    END;

    -- Validar si el cliente está inscrito en el curso de la sesión
    BEGIN
        SELECT COUNT(*)
        INTO v_curso_count
        FROM Inscribe i
        JOIN Se_da sd ON i.cur_codigo = sd.cur_codigo
        WHERE i.cli_rut = :NEW.cli_rut
        AND sd.ses_codigo = :NEW.ses_codigo;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_curso_count := 0;
    END;

    -- Obtener el estado del cliente
    BEGIN
        SELECT e.est_descripcion
        INTO v_estado
        FROM Posee p
        JOIN Estado e ON p.est_codigo = e.est_codigo
        WHERE p.cli_rut = :NEW.cli_rut
        AND v_fecha_sesion BETWEEN p.fecha_inicio AND p.fecha_termino;
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            v_estado := 'No Habilitado';
    END;

    -- Validar si el cliente tiene el estado vigente y está inscrito en el programa o curso
    IF v_programa_count = 0 AND v_curso_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'El cliente no está inscrito en el programa o curso de la sesión.');
    ELSIF v_estado != 'Habilitado' THEN
        RAISE_APPLICATION_ERROR(-20002, 'El cliente no está en estado vigente para agendar la sesión.');
    END IF;
END;
