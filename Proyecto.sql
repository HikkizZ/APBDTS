-- Creaci�n de Tablas
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

-- Se cambia longitud del correo 01-06-24
ALTER TABLE Cliente MODIFY (cli_correo_electronico VARCHAR2(40));

CREATE TABLE Comuna(
    com_codigo INTEGER PRIMARY KEY,
    com_nombre VARCHAR2(20),
    reg_codigo INTEGER,
    FOREIGN KEY (reg_codigo) REFERENCES Region(reg_codigo)
);

CREATE TABLE Region(
    reg_codigo INTEGER PRIMARY KEY,
    reg_nombre VARCHAR2(20)
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

-- Se cambia longitud de descripci�n de evento 05-07-2024
ALTER TABLE Evento MODIFY (eve_descripcion VARCHAR2(30));
-- Se cambia longitud de modalidad de pago de evento 05-07-2024
ALTER TABLE Evento MODIFY (eve_modalidad_pago VARCHAR2(20));

CREATE TABLE Cursos(
    cur_codigo INTEGER PRIMARY KEY,
    cur_descripcion VARCHAR2(20),
    cur_valor_sesion INTEGER,
    cur_duracion INTEGER,
    cur_num_sesiones INTEGER,
    cur_fecha_inicio DATE,
    cur_fecha_termino DATE
);

-- Se cambia longitud de descripci�n de cursos 05-07-2024
ALTER TABLE Cursos MODIFY (cur_descripcion VARCHAR2(35));

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

CREATE TABLE Profesion(
    prof_codigo INTEGER PRIMARY KEY,
    prof_nombre VARCHAR2(25)
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

-- Modificacion longitud descripcion sesion 04-07-2024
ALTER TABLE Sesion MODIFY (ses_descripcion VARCHAR2(35));

CREATE TABLE Plan(
    pla_codigo INTEGER PRIMARY KEY,
    pla_modalidad VARCHAR2(20),
    pla_valor INTEGER,
    pro_codigo INTEGER,
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo)
);

-- Creacion de Relaciones
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

CREATE TABLE Entrenamiento(
    pro_codigo INTEGER Primary Key,
    pro_tipo VARCHAR2(20),
    esp_codigo INTEGER,
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo),
    FOREIGN KEY (esp_codigo) REFERENCES Especialidad(esp_codigo)
);

-- SubCategorias (?)
CREATE TABLE Terapia(
    pro_codigo INTEGER PRIMARY KEY,
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo)
);

CREATE TABLE Especialidad(
    esp_codigo INTEGER PRIMARY KEY,
    esp_nombre VARCHAR2(20)
);

-- Inserci�n de Datos

-- Inserci�n de Regiones
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (1, 'Tarapac�');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (2, 'Antofagasta');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (3, 'Atacama');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (4, 'Coquimbo');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (5, 'Valpara�so');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (6, 'O�Higgins');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (7, 'Maule');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (8, '�uble');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (9, 'Biob�o');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (10, 'Araucan�a');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (11, 'Los R�os');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (12, 'Los Lagos');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (13, 'Ays�n');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (14, 'Magallanes');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (15, 'Metropolitana');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (16, 'Arica y Parinacota');

-- Inserci�n de Comunas
-- Regi�n de Tarapac�
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (1, 'Iquique', 1);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (2, 'Alto Hospicio', 1);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (3, 'Pozo Almonte', 1);

-- Regi�n de Antofagasta
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (4, 'Antofagasta', 2);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (5, 'Mejillones', 2);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (6, 'Taltal', 2);

-- Regi�n de Atacama (3)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (7, 'Copiap�', 3);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (8, 'Caldera', 3);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (9, 'Cha�aral', 3);

-- Regi�n de Coquimbo (4)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (10, 'La Serena', 4);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (11, 'Coquimbo', 4);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (12, 'Ovalle', 4);

-- Regi�n de Valpara�so (5)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (13, 'Valpara�so', 5);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (14, 'Vi�a del Mar', 5);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (15, 'Quilpu�', 5);

-- Regi�n de O�Higgins (6)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (16, 'Rancagua', 6);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (17, 'San Fernando', 6);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (18, 'Pichilemu', 6);

-- Regi�n del Maule (7)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (19, 'Talca', 7);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (20, 'Curic�', 7);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (21, 'Linares', 7);

-- Regi�n de �uble (8)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (22, 'Chill�n', 8);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (23, 'Bulnes', 8);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (24, 'San Carlos', 8);

-- Regi�n del Biob�o (9)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (25, 'Concepci�n', 9);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (26, 'Talcahuano', 9);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (27, 'Los �ngeles', 9);

-- Regi�n de la Araucan�a (10)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (28, 'Temuco', 10);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (29, 'Villarrica', 10);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (30, 'Puc�n', 10);

-- Regi�n de Los R�os (11)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (31, 'Valdivia', 11);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (32, 'La Uni�n', 11);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (33, 'Panguipulli', 11);

-- Regi�n de Los Lagos (12)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (34, 'Puerto Montt', 12);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (35, 'Castro', 12);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (36, 'Ancud', 12);

-- Regi�n de Ays�n (13)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (37, 'Coyhaique', 13);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (38, 'Puerto Ays�n', 13);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (39, 'Chile Chico', 13);

-- Regi�n de Magallanes (14)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (40, 'Punta Arenas', 14);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (41, 'Puerto Natales', 14);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (42, 'Porvenir', 14);

-- Regi�n Metropolitana (15)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (43, 'Santiago', 15);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (44, 'Puente Alto', 15);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (45, 'Maip�', 15);

-- Regi�n de Arica y Parinacota (16)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (46, 'Arica', 16);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (47, 'Putre', 16);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (48, 'Camarones', 16);

-- Inserci�n de Estados
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (1, 'Habilitado');
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (2, 'No habilitado');

-- Inserci�n de Empresa
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (1, 'Nestle');
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (2, 'EA Sports');
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (3, 'Carozzi');
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (4, 'Steam');
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (5, 'Estudio Ghibli');

-- Inserci�n de Clientes
INSERT ALL
INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('11111111-1', 'Juan', 'P�rez', '912345678', 'Calle 1', 'Soltero', 'juan.perez@example.com', 1)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('22222222-2', 'Mar�a', 'Gonz�lez', '922345678', 'Calle 2', 'Casado', 'maria.gonzalez@example.com', 2)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('33333333-3', 'Pedro', 'Mart�nez', '932345678', 'Calle 3', 'Divorciado', 'pedro.martinez@example.com', 3)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('44444444-4', 'Ana', 'Rodr�guez', '942345678', 'Calle 4', 'Viudo', 'ana.rodriguez@example.com', 4)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('55555555-5', 'Luis', 'Hern�ndez', '952345678', 'Calle 5', 'Soltero', 'luis.hernandez@example.com', 5)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('66666666-6', 'Carmen', 'Morales', '962345678', 'Calle 6', 'Casado', 'carmen.morales@example.com', 6)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('77777777-7', 'Jos�', 'L�pez', '972345678', 'Calle 7', 'Divorciado', 'jose.lopez@example.com', 7)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('88888888-8', 'Laura', 'Ram�rez', '982345678', 'Calle 8', 'Viudo', 'laura.ramirez@example.com', 8)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('99999999-9', 'Miguel', 'Torres', '992345678', 'Calle 9', 'Soltero', 'miguel.torres@example.com', 9)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('10101010-0', 'Isabel', 'Flores', '902345678', 'Calle 10', 'Casado', 'isabel.flores@example.com', 10)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('11111112-1', 'Francisco', 'D�az', '912346789', 'Calle 11', 'Divorciado', 'francisco.diaz@example.com', 11)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('12121212-2', 'Elena', 'Fuentes', '922346789', 'Calle 12', 'Viudo', 'elena.fuentes@example.com', 12)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('13131313-3', 'Diego', 'Guti�rrez', '932346789', 'Calle 13', 'Soltero', 'diego.gutierrez@example.com', 13)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('14141414-4', 'Paula', 'Castro', '942346789', 'Calle 14', 'Casado', 'paula.castro@example.com', 14)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('15151515-5', 'Andr�s', 'Vargas', '952346789', 'Calle 15', 'Divorciado', 'andres.vargas@example.com', 15)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('16161616-6', 'Daniela', 'Reyes', '962346789', 'Calle 16', 'Viudo', 'daniela.reyes@example.com', 16)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('17171717-7', 'Carlos', 'Ortiz', '972346789', 'Calle 17', 'Soltero', 'carlos.ortiz@example.com', 1)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('18181818-8', 'Natalia', 'Rivas', '982346789', 'Calle 18', 'Casado', 'natalia.rivas@example.com', 2)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('19191919-9', 'Sebasti�n', 'Pe�a', '992346789', 'Calle 19', 'Divorciado', 'sebastian.pena@example.com', 3)
SELECT * FROM dual;

-- Inserci�n de Profesiones
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (1, 'Kinesiologo');
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (2, 'Instructor de Yoga');
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (3, 'Instructor de Pilates');
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (4, 'Nutricionista');
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (5, 'Psicologo');
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (6, 'Instructor de Zumba');

-- Inserci�n de Instructores
INSERT ALL
    INTO Instructor (ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
        VALUES ('12345678-9', 'Aquiles', 'Brinco', '968574235', 'Av Sebastian Pi�era', 500000, 1)
    INTO Instructor (ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
        VALUES ('23456789-0', 'Mary', 'Conazo', '995243698', 'Av Siempre Viva 12', 600000, 2)
    INTO Instructor (ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
        VALUES ('34567890-1', 'Elva', 'Gina', '912654869', 'Fondo de Bikini', 550000, 3)
    INTO Instructor (ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
        VALUES ('45678901-2', 'Elvis', 'Tek', '965874215', 'Calle 48', 520000, 4)
    INTO Instructor (ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
        VALUES ('56789012-3', 'Esteban', 'Dido', '915369428', 'Santa Margarita', 580000, 2)
SELECT * FROM dual;
-- Se agrega otro instructor
INSERT INTO Instructor (ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
    VALUES ('20393210-3', 'Juan', 'Yanez', '985908558', 'Av Venga la Paz', 650000, 6);

-- Inserci�n de Programas
INSERT ALL
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (1, 'Pilates Reformer', 20000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (2, 'Yoga Inicial', 15000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (3, 'Yoga Intermedio', 17000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (4, 'Pilates Suelo', 18000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (5, 'Aero Yoga', 16000, 60)
SELECT * FROM dual;

-- Inserci�n de Planes
INSERT ALL
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (1, '2 veces a la semana', 34990, 1)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (2, '3 veces a la semana', 39990, 2)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (3, '2 veces a la semana', 29990, 3)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (4, '3 veces a la semana', 34990, 4)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (5, '2 veces a la semana', 32990, 5)
SELECT * FROM dual;

-- Insercion de Especialidades
INSERT ALL
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (1, 'Pilates Reformer')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (2, 'Yoga Inicial')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (3, 'Yoga Intermedio')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (4, 'Pilates Suelo')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (5, 'Aero Yoga')
SELECT * FROM dual;

-- Inserci�n de Entrenamientos
INSERT ALL
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (1, 'Pilates', 1)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (2, 'Yoga', 2)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (3, 'Yoga', 3)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (4, 'Pilates', 4)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (5, 'Yoga', 5)
SELECT * FROM dual;

-- Inserci�n de Patolog�as
INSERT ALL
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (1, 'Diabetes')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (2, 'Hipertensi�n')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (3, 'Asma')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (4, 'Autismo')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (5, 'Artritis')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (6, 'C�ncer')
SELECT * FROM dual;

-- Inserci�n de Eventos
INSERT ALL
    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (1, 'Clase de Zumba', '13:00', '14:30', 20000, 'Efectivo', TO_DATE('2024-07-01', 'YYYY-MM-DD'), '22222222-2')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (2, 'Taller de Meditaci�n', '08:00', '09:00', 15000, 'Tarjeta', TO_DATE('2024-04-25', 'YYYY-MM-DD'), '44444444-4')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (3, 'Seminario de Nutrici�n', '14:00', '16:00', 30000, 'Transferencia', TO_DATE('2024-07-02', 'YYYY-MM-DD'), '18181818-8')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (4, 'Clase de Danza Moderna', '17:00', '18:00', 25000, 'Efectivo', TO_DATE('2024-06-21', 'YYYY-MM-DD'), '14141414-4')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (5, 'Taller de Resiliencia', '11:00', '13:00', 18000, 'Tarjeta', TO_DATE('2024-07-04', 'YYYY-MM-DD'), '11111112-1')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (6, 'Workshop de Fitness', '10:00', '12:00', 22000, 'Transferencia', TO_DATE('2024-05-23', 'YYYY-MM-DD'), '99999999-9')
SELECT * FROM dual;

-- Inserci�n de Cursos
INSERT ALL
    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (1, 'Curso de Yoga Avanzado', 24990, 60, 8, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-12', 'YYYY-MM-DD'))

    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (2, 'Curso de Pilates Suelo', 23990, 60, 6, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-01-26', 'YYYY-MM-DD'))

    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (3, 'Curso de Meditaci�n', 35990, 45, 9, TO_DATE('2023-12-12', 'YYYY-MM-DD'), TO_DATE('2023-12-29', 'YYYY-MM-DD'))

    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (4, 'Curso de Danza', 23990, 60, 6, TO_DATE('2024-03-04', 'YYYY-MM-DD'), TO_DATE('2024-03-21', 'YYYY-MM-DD'))

    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (5, 'Curso de Nutrici�n y Bienestar', 14990, 90, 3, TO_DATE('2023-09-06', 'YYYY-MM-DD'), TO_DATE('2023-09-20', 'YYYY-MM-DD'))
SELECT * FROM dual;

-- Inserci�n de Salones
INSERT ALL
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (1, 'Sal�n 101AA', 30)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (2, 'Sal�n 102AA', 25)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (3, 'Sal�n 202AB', 20)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (4, 'Sal�n 201D', 35)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (5, 'Sal�n 202D', 40)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (6, 'Sal�n 102AC', 15)
SELECT * FROM dual;

-- Inserci�n de Sesiones
INSERT ALL
-- Lunes
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (13, 'Sesi�n de Pilates Suelo 1', TO_DATE('2024-01-15', 'YYYY-MM-DD'), '10:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (16, 'Sesi�n de Pilates Suelo 4', TO_DATE('2024-01-22', 'YYYY-MM-DD'), '10:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (19, 'Sesi�n de Danza 1', TO_DATE('2024-03-04', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (21, 'Sesi�n de Danza 3', TO_DATE('2024-03-11', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (23, 'Sesi�n de Danza 5', TO_DATE('2024-03-18', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (25, 'Sesi�n de Yoga Avanzado 1', TO_DATE('2024-07-01', 'YYYY-MM-DD'), '09:00', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (29, 'Sesi�n de Yoga Avanzado 5', TO_DATE('2024-07-08', 'YYYY-MM-DD'), '09:00', 1, '56789012-3')
-- Martes
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (4, 'Sesi�n de Meditaci�n 1', TO_DATE('2023-12-12', 'YYYY-MM-DD'), '10:30', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (7, 'Sesi�n de Meditaci�n 4', TO_DATE('2023-12-19', 'YYYY-MM-DD'), '10:30', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (10, 'Sesi�n de Meditaci�n 7', TO_DATE('2023-12-26', 'YYYY-MM-DD'), '10:30', 3, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (26, 'Sesi�n de Yoga Avanzado 2', TO_DATE('2024-07-02', 'YYYY-MM-DD'), '09:00', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (30, 'Sesi�n de Yoga Avanzado 6', TO_DATE('2024-07-09', 'YYYY-MM-DD'), '09:00', 1, '56789012-3')
-- Miercoles
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (1, 'Sesi�n de Nutrici�n y Bienestar 1', TO_DATE('2023-09-06', 'YYYY-MM-DD'), '11:00', 5, '45678901-2')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (2, 'Sesi�n de Nutrici�n y Bienestar 2', TO_DATE('2023-09-13', 'YYYY-MM-DD'), '11:00', 5, '45678901-2')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (3, 'Sesi�n de Nutrici�n y Bienestar 3', TO_DATE('2023-09-20', 'YYYY-MM-DD'), '11:00', 5, '45678901-2')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (5, 'Sesi�n de Meditaci�n 2', TO_DATE('2023-12-13', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (8, 'Sesi�n de Meditaci�n 5', TO_DATE('2023-12-20', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (11, 'Sesi�n de Meditaci�n 8', TO_DATE('2023-12-27', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (14, 'Sesi�n de Pilates Suelo 2', TO_DATE('2024-01-17', 'YYYY-MM-DD'), '11:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (17, 'Sesi�n de Pilates Suelo 5', TO_DATE('2024-01-24', 'YYYY-MM-DD'), '11:00', 2, '34567890-1')

-- Jueves
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (27, 'Sesi�n de Yoga Avanzado 3', TO_DATE('2024-07-04', 'YYYY-MM-DD'), '10:00', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (31, 'Sesi�n de Yoga Avanzado 7', TO_DATE('2024-07-11', 'YYYY-MM-DD'), '10:00', 1, '56789012-3')
-- Viernes
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (6, 'Sesi�n de Meditaci�n 3', TO_DATE('2023-12-15', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (9, 'Sesi�n de Meditaci�n 6', TO_DATE('2023-12-22', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (12, 'Sesi�n de Meditaci�n 9', TO_DATE('2023-12-29', 'YYYY-MM-DD'), '08:00', 3, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (15, 'Sesi�n de Pilates Suelo 3', TO_DATE('2024-01-19', 'YYYY-MM-DD'), '10:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (18, 'Sesi�n de Pilates Suelo 6', TO_DATE('2024-01-26', 'YYYY-MM-DD'), '10:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (20, 'Sesi�n de Danza 2', TO_DATE('2024-03-08', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (22, 'Sesi�n de Danza 4', TO_DATE('2024-03-15', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (24, 'Sesi�n de Danza 6', TO_DATE('2024-03-22', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (28, 'Sesi�n de Yoga Avanzado 4', TO_DATE('2024-07-05', 'YYYY-MM-DD'), '09:00', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (32, 'Sesi�n de Yoga Avanzado 8', TO_DATE('2024-07-12', 'YYYY-MM-DD'), '09:00', 1, '23456789-0')
SELECT * FROM dual;

-- Inserci�n Relaci�n Padece (Cliente - Patolog�a)
INSERT ALL
    INTO Padece (pat_codigo, cli_rut) VALUES (1, '22222222-2') -- Cliente padece Diabetes
    INTO Padece (pat_codigo, cli_rut) VALUES (2, '22222222-2') -- Cliente padece Hipertensi�n
    INTO Padece (pat_codigo, cli_rut) VALUES (3, '33333333-3') -- Cliente padece Asma
    INTO Padece (pat_codigo, cli_rut) VALUES (4, '55555555-5') -- Cliente padece Autismo
    INTO Padece (pat_codigo, cli_rut) VALUES (5, '44444444-4') -- Cliente padece Artritis
    INTO Padece (pat_codigo, cli_rut) VALUES (6, '33333333-3') -- Cliente padece C�ncer
    INTO Padece (pat_codigo, cli_rut) VALUES (2, '11111112-1') -- Cliente padece Hipertensi�n
    INTO Padece (pat_codigo, cli_rut) VALUES (3, '12121212-2') -- Cliente padece Asma
    INTO Padece (pat_codigo, cli_rut) VALUES (2, '14141414-4') -- Cliente padece Hipertensi�n
    INTO Padece (pat_codigo, cli_rut) VALUES (1, '15151515-5') -- Cliente padece Diabetes
    INTO Padece (pat_codigo, cli_rut) VALUES (1, '18181818-8') -- Cliente padece Diabetes
    INTO Padece (pat_codigo, cli_rut) VALUES (2, '18181818-8') -- Cliente padece Hipertensi�n
SELECT * FROM dual;










