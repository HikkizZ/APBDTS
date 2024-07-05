-- Creaci�n de Tablas
CREATE TABLE Cliente(
    cli_rut VARCHAR2(12) PRIMARY KEY,
    cli_nombres VARCHAR2(25),
    cli_apellidos VARCHAR2(25),
    cli_telefono VARCHAR2(12),
    cli_direccion VARCHAR2(25),
    cli_estado_civil VARCHAR2(20),
    cli_correo_electronico VARCHAR(50),
    com_codigo INTEGER,
    FOREIGN KEY (com_codigo) REFERENCES Comuna(com_codigo)
);

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
    eve_descripcion VARCHAR2(35),
    eve_hora_inicio VARCHAR2(5), -- Formato HH:MM
    eve_hora_fin VARCHAR2(5), -- Formato HH:MM
    eve_valor_arriendo INTEGER,
    eve_modalidad_pago VARCHAR2(25), -- Preguntar
    eve_fecha_pago DATE,
    cli_rut VARCHAR2(12),
    FOREIGN KEY (cli_rut) REFERENCES Cliente(cli_rut)
);

CREATE TABLE Cursos(
    cur_codigo INTEGER PRIMARY KEY,
    cur_descripcion VARCHAR2(35),
    cur_valor_sesion INTEGER,
    cur_duracion INTEGER,
    cur_num_sesiones INTEGER,
    cur_fecha_inicio DATE,
    cur_fecha_termino DATE
);

CREATE TABLE Instructor(
    ins_rut VARCHAR2(12) PRIMARY KEY,
    ins_nombres VARCHAR2(25),
    ins_apellidos VARCHAR2(25),
    ins_telefono VARCHAR2(12),
    ins_direccion VARCHAR2(25),
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
    pro_descripcion VARCHAR2(35),
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
    ses_descripcion VARCHAR2(35),
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
    pro_tipo VARCHAR2(35),
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

----------------------------------------------------------------------------------------------------------------------------------------------
-- Inserci�n de Datos

-- Inserci�n de Regiones
INSERT ALL
    INTO Region (reg_codigo, reg_nombre) VALUES (1, 'Tarapaca')
    INTO Region (reg_codigo, reg_nombre) VALUES (2, 'Antofagasta')
    INTO Region (reg_codigo, reg_nombre) VALUES (3, 'Atacama')
    INTO Region (reg_codigo, reg_nombre) VALUES (4, 'Coquimbo')
    INTO Region (reg_codigo, reg_nombre) VALUES (5, 'Valparaiso')
    INTO Region (reg_codigo, reg_nombre) VALUES (6, 'OHiggins')
    INTO Region (reg_codigo, reg_nombre) VALUES (7, 'Maule')
    INTO Region (reg_codigo, reg_nombre) VALUES (8, '�uble')
    INTO Region (reg_codigo, reg_nombre) VALUES (9, 'Biobio')
    INTO Region (reg_codigo, reg_nombre) VALUES (10, 'Araucania')
    INTO Region (reg_codigo, reg_nombre) VALUES (11, 'Los Rios')
    INTO Region (reg_codigo, reg_nombre) VALUES (12, 'Los Lagos')
    INTO Region (reg_codigo, reg_nombre) VALUES (13, 'Aysen')
    INTO Region (reg_codigo, reg_nombre) VALUES (14, 'Magallanes')
    INTO Region (reg_codigo, reg_nombre) VALUES (15, 'Metropolitana')
    INTO Region (reg_codigo, reg_nombre) VALUES (16, 'Arica y Parinacota')
SELECT * FROM dual;

-- Inserci�n de Comunas
INSERT ALL
    -- Regi�n de Tarapac�
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (1, 'Iquique', 1)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (2, 'Alto Hospicio', 1)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (3, 'Pozo Almonte', 1)
    -- Regi�n de Antofagasta
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (4, 'Antofagasta', 2)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (5, 'Mejillones', 2)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (6, 'Taltal', 2)
    -- Regi�n de Atacama
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (7, 'Copiapo', 3)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (8, 'Caldera', 3)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (9, 'Cha�aral', 3)
    -- Regi�n de Coquimbo
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (10, 'La Serena', 4)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (11, 'Coquimbo', 4)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (12, 'Ovalle', 4)
    -- Regi�n de Valpara�so
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (13, 'Valparaiso', 5)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (14, 'Vi�a del Mar', 5)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (15, 'Quilpue', 5)
    -- Regi�n de O�Higgins
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (16, 'Rancagua', 6)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (17, 'San Fernando', 6)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (18, 'Pichilemu', 6)
    -- Regi�n del Maule
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (19, 'Talca', 7)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (20, 'Curico', 7)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (21, 'Linares', 7)
    -- Regi�n de �uble
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (22, 'Chillan', 8)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (23, 'Bulnes', 8)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (24, 'San Carlos', 8)
    -- Regi�n del Biob�o
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (25, 'Concepcion', 9)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (26, 'Talcahuano', 9)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (27, 'Los Angeles', 9)
    -- Regi�n de la Araucan�a
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (28, 'Temuco', 10)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (29, 'Villarrica', 10)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (30, 'Pucon', 10)
    -- Regi�n de Los R�os
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (31, 'Valdivia', 11)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (32, 'La Union', 11)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (33, 'Panguipulli', 11)
    -- Regi�n de Los Lagos
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (34, 'Puerto Montt', 12)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (35, 'Castro', 12)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (36, 'Ancud', 12)
    -- Regi�n de Ays�n
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (37, 'Coyhaique', 13)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (38, 'Puerto Aysen', 13)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (39, 'Chile Chico', 13)
    -- Regi�n de Magallanes
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (40, 'Punta Arenas', 14)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (41, 'Puerto Natales', 14)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (42, 'Porvenir', 14)
    -- Regi�n Metropolitana
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (43, 'Santiago', 15)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (44, 'Puente Alto', 15)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (45, 'Maipu', 15)
    -- Regi�n de Arica y Parinacota
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (46, 'Arica', 16)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (47, 'Putre', 16)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (48, 'Camarones', 16)
SELECT * FROM dual;

-- Inserci�n de Estados
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (1, 'Habilitado');
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (2, 'No habilitado');

-- Inserci�n de Empresa
INSERT ALL
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (1, 'Nestle')
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (2, 'EA Sports')
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (3, 'Ripley')
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (4, 'Steam')
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (5, 'Estudio Ghibli')
SELECT * FROM dual;

-- Inserci�n de Clientes
INSERT ALL
    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('11111111-1', 'Juan', 'P�rez', '912345678', 'Calle 1', 'Soltero', 'juan.perez@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('22222222-2', 'Mar�a', 'Gonz�lez', '922345678', 'Calle 2', 'Casado', 'maria.gonzalez@example.com', 2)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('33333333-3', 'Pedro', 'Mart�nez', '932345678', 'Calle 3', 'Divorciado', 'pedro.martinez@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('44444444-4', 'Ana', 'Rodr�guez', '942345678', 'Calle 4', 'Viudo', 'ana.rodriguez@example.com', 4)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('55555555-5', 'Luis', 'Hern�ndez', '952345678', 'Calle 5', 'Soltero', 'luis.hernandez@example.com', 5)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('66666666-6', 'Carmen', 'Morales', '962345678', 'Calle 6', 'Casado', 'carmen.morales@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('77777777-7', 'Jos�', 'L�pez', '972345678', 'Calle 7', 'Divorciado', 'jose.lopez@example.com', 7)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('88888888-8', 'Laura', 'Ram�rez', '982345678', 'Calle 8', 'Viudo', 'laura.ramirez@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('99999999-9', 'Miguel', 'Torres', '992345678', 'Calle 9', 'Soltero', 'miguel.torres@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('10101010-0', 'Isabel', 'Flores', '902345678', 'Calle 10', 'Casado', 'isabel.flores@example.com', 10)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('11111112-1', 'Francisco', 'D�az', '912346789', 'Calle 11', 'Divorciado', 'francisco.diaz@example.com', 27)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('12121212-2', 'Elena', 'Fuentes', '922346789', 'Calle 12', 'Viudo', 'elena.fuentes@example.com', 27)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('13131313-3', 'Diego', 'Guti�rrez', '932346789', 'Calle 13', 'Soltero', 'diego.gutierrez@example.com', 27)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('14141414-4', 'Paula', 'Castro', '942346789', 'Calle 14', 'Casado', 'paula.castro@example.com', 14)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('15151515-5', 'Andr�s', 'Vargas', '952346789', 'Calle 15', 'Divorciado', 'andres.vargas@example.com', 43)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('16161616-6', 'Daniela', 'Reyes', '962346789', 'Calle 16', 'Viudo', 'daniela.reyes@example.com', 16)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('17171717-7', 'Carlos', 'Ortiz', '972346789', 'Calle 17', 'Soltero', 'carlos.ortiz@example.com', 43)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('18181818-8', 'Natalia', 'Rivas', '982346789', 'Calle 18', 'Casado', 'natalia.rivas@example.com', 2)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('19191919-9', 'Sebasti�n', 'Pe�a', '992346789', 'Calle 19', 'Divorciado', 'sebastian.pena@example.com', 43)
SELECT * FROM dual;

-- Inserci�n de Profesiones
INSERT ALL
    INTO Profesion (prof_codigo, prof_nombre) VALUES (1, 'Kinesiologo')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (2, 'Instructor de Yoga')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (3, 'Instructor de Pilates')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (4, 'Nutricionista')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (5, 'Psicologo')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (6, 'Instructor de Zumba')
SELECT * FROM dual;

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
    INTO Instructor (ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
        VALUES ('20393210-3', 'Juan', 'Yanez', '985908558', 'Av Venga la Paz', 650000, 6)
    INTO Instructor (ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
        VALUES ('19385987-1', 'Sophia', 'Ibanez', '983569875', 'Av San Martin', 480000, 5)
SELECT * FROM dual;

-- Inserci�n de Programas
INSERT ALL
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (1, 'Yoga para principiantes', 17000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (2, 'Pilates Intermedio', 18000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (3, 'Yoga Intermedio', 18500, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (4, 'Kinesiologia aplicada al pilates', 18000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (5, 'Aero Yoga', 16000, 50)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (6, 'Pilates Reformer', 20000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (7, 'Pilates con Maquinas', 15000, 50)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (8, 'Yoga Avanzado', 19000, 75)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (9, 'Pilates prenatal', 18000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (10, 'Yoga restaurativo', 16000, 60)
SELECT * FROM dual;

-- Inserci�n de Planes
INSERT ALL
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (1, '2 veces a la semana', 31990, 1)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (2, '3 veces a la semana', 49990, 2)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (3, '2 veces a la semana', 35990, 3)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (4, '3 veces a la semana', 51990, 4)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (5, '4 veces a la semana', 59990, 5)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (6, '3 veces a la semana', 59990, 6)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (7, '3 veces a la semana', 42990, 7)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (8, '2 veces a la semana', 34990, 8)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (9, '2 veces a la semana', 29990, 9)
    INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (10, '4 veces a la semana', 59990, 10)
SELECT * FROM dual;

-- Insercion de Especialidades
INSERT ALL
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (1, 'Yoga Inicial')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (2, 'Pilates Reformer')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (3, 'Yoga Amateur')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (4, 'Kinesiologia Pilates')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (5, 'Aero Yoga')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (6, 'Pilates Reformer')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (7, 'Pilates con Maquinas')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (8, 'Yoga Avanzado')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (9, 'Pilates Prenatal')
    INTO Especialidad (esp_codigo, esp_nombre) VALUES (10, 'Yoga Restaurativo')
SELECT * FROM dual;

-- Inserci�n de Entrenamientos
INSERT ALL
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (1, 'Yoga', 1)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (2, 'Pilates', 2)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (3, 'Yoga', 3)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (4, 'Pilates', 4)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (5, 'Yoga', 5)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (6, 'Pilates', 6)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (7, 'Pilates', 7)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (8, 'Yoga', 8)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (9, 'Pilates', 9)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (10, 'Yoga', 10)
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
        VALUES (1, 'Clase de Zumba', '13:00', '15:00', 50000, 'Efectivo', TO_DATE('2024-07-01', 'YYYY-MM-DD'), '22222222-2')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (2, 'Fiesta de cumplea�os', '10:00', '00:00', 80000, 'Tarjeta', TO_DATE('2024-07-19', 'YYYY-MM-DD'), '44444444-4')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (3, 'Seminario de Nutrici�n', '14:00', '16:00', 50000, 'Transferencia', TO_DATE('2024-07-02', 'YYYY-MM-DD'), '18181818-8')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (4, 'Clase de Danza Moderna', '17:00', '18:00', 30000, 'Efectivo', TO_DATE('2024-06-21', 'YYYY-MM-DD'), '14141414-4')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (5, 'Taller de Resiliencia', '11:00', '13:00', 65000, 'Tarjeta', TO_DATE('2024-07-04', 'YYYY-MM-DD'), '11111112-1')

    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (6, 'Workshop de Fitness', '10:00', '12:00', 40000, 'Transferencia', TO_DATE('2023-12-12', 'YYYY-MM-DD'), '99999999-9')
SELECT * FROM dual;

