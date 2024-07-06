-- Creación de Tablas
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
-- Inserción de Datos

-- Inserción de Regiones
INSERT ALL
    INTO Region (reg_codigo, reg_nombre) VALUES (1, 'Tarapaca')
    INTO Region (reg_codigo, reg_nombre) VALUES (2, 'Antofagasta')
    INTO Region (reg_codigo, reg_nombre) VALUES (3, 'Atacama')
    INTO Region (reg_codigo, reg_nombre) VALUES (4, 'Coquimbo')
    INTO Region (reg_codigo, reg_nombre) VALUES (5, 'Valparaiso')
    INTO Region (reg_codigo, reg_nombre) VALUES (6, 'OHiggins')
    INTO Region (reg_codigo, reg_nombre) VALUES (7, 'Maule')
    INTO Region (reg_codigo, reg_nombre) VALUES (8, 'Ñuble')
    INTO Region (reg_codigo, reg_nombre) VALUES (9, 'Biobio')
    INTO Region (reg_codigo, reg_nombre) VALUES (10, 'Araucania')
    INTO Region (reg_codigo, reg_nombre) VALUES (11, 'Los Rios')
    INTO Region (reg_codigo, reg_nombre) VALUES (12, 'Los Lagos')
    INTO Region (reg_codigo, reg_nombre) VALUES (13, 'Aysen')
    INTO Region (reg_codigo, reg_nombre) VALUES (14, 'Magallanes')
    INTO Region (reg_codigo, reg_nombre) VALUES (15, 'Metropolitana')
    INTO Region (reg_codigo, reg_nombre) VALUES (16, 'Arica y Parinacota')
SELECT * FROM dual;

-- Inserción de Comunas
INSERT ALL
    -- Región de Tarapacá
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (1, 'Iquique', 1)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (2, 'Alto Hospicio', 1)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (3, 'Pozo Almonte', 1)
    -- Región de Antofagasta
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (4, 'Antofagasta', 2)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (5, 'Mejillones', 2)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (6, 'Taltal', 2)
    -- Región de Atacama
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (7, 'Copiapo', 3)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (8, 'Caldera', 3)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (9, 'Chañaral', 3)
    -- Región de Coquimbo
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (10, 'La Serena', 4)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (11, 'Coquimbo', 4)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (12, 'Ovalle', 4)
    -- Región de Valparaíso
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (13, 'Valparaiso', 5)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (14, 'Viña del Mar', 5)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (15, 'Quilpue', 5)
    -- Región de O’Higgins
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (16, 'Rancagua', 6)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (17, 'San Fernando', 6)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (18, 'Pichilemu', 6)
    -- Región del Maule
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (19, 'Talca', 7)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (20, 'Curico', 7)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (21, 'Linares', 7)
    -- Región de Ñuble
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (22, 'Chillan', 8)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (23, 'Bulnes', 8)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (24, 'San Carlos', 8)
    -- Región del Biobío
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (25, 'Concepcion', 9)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (26, 'Talcahuano', 9)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (27, 'Los Angeles', 9)
    -- Región de la Araucanía
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (28, 'Temuco', 10)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (29, 'Villarrica', 10)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (30, 'Pucon', 10)
    -- Región de Los Ríos
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (31, 'Valdivia', 11)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (32, 'La Union', 11)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (33, 'Panguipulli', 11)
    -- Región de Los Lagos
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (34, 'Puerto Montt', 12)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (35, 'Castro', 12)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (36, 'Ancud', 12)
    -- Región de Aysén
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (37, 'Coyhaique', 13)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (38, 'Puerto Aysen', 13)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (39, 'Chile Chico', 13)
    -- Región de Magallanes
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (40, 'Punta Arenas', 14)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (41, 'Puerto Natales', 14)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (42, 'Porvenir', 14)
    -- Región Metropolitana
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (43, 'Santiago', 15)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (44, 'Puente Alto', 15)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (45, 'Maipu', 15)
    -- Región de Arica y Parinacota
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (46, 'Arica', 16)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (47, 'Putre', 16)
    INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (48, 'Camarones', 16)
SELECT * FROM dual;

-- Inserción de Estados
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (1, 'Habilitado');
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (2, 'No habilitado');

-- Inserción de Empresa
INSERT ALL
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (1, 'Nestle')
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (2, 'EA Sports')
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (3, 'Ripley')
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (4, 'Steam')
    INTO Empresa (emp_codigo, emp_descripcion) VALUES (5, 'Estudio Ghibli')
SELECT * FROM dual;

-- Inserción de Clientes
INSERT ALL
    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('11111111-1', 'Juan', 'Pérez', '912345678', 'Calle 1', 'Soltero', 'juan.perez@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('22222222-2', 'María', 'González', '922345678', 'Calle 2', 'Casado', 'maria.gonzalez@example.com', 2)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('33333333-3', 'Pedro', 'Martínez', '932345678', 'Calle 3', 'Divorciado', 'pedro.martinez@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('44444444-4', 'Ana', 'Rodríguez', '942345678', 'Calle 4', 'Viudo', 'ana.rodriguez@example.com', 4)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('55555555-5', 'Luis', 'Hernández', '952345678', 'Calle 5', 'Soltero', 'luis.hernandez@example.com', 5)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('66666666-6', 'Carmen', 'Morales', '962345678', 'Calle 6', 'Casado', 'carmen.morales@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('77777777-7', 'José', 'López', '972345678', 'Calle 7', 'Divorciado', 'jose.lopez@example.com', 7)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('88888888-8', 'Laura', 'Ramírez', '982345678', 'Calle 8', 'Viudo', 'laura.ramirez@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('99999999-9', 'Miguel', 'Torres', '992345678', 'Calle 9', 'Soltero', 'miguel.torres@example.com', 25)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('10101010-0', 'Isabel', 'Flores', '902345678', 'Calle 10', 'Casado', 'isabel.flores@example.com', 10)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('11111112-1', 'Francisco', 'Díaz', '912346789', 'Calle 11', 'Divorciado', 'francisco.diaz@example.com', 27)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('12121212-2', 'Elena', 'Fuentes', '922346789', 'Calle 12', 'Viudo', 'elena.fuentes@example.com', 27)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('13131313-3', 'Diego', 'Gutiérrez', '932346789', 'Calle 13', 'Soltero', 'diego.gutierrez@example.com', 27)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('14141414-4', 'Paula', 'Castro', '942346789', 'Calle 14', 'Casado', 'paula.castro@example.com', 14)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('15151515-5', 'Andrés', 'Vargas', '952346789', 'Calle 15', 'Divorciado', 'andres.vargas@example.com', 43)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('16161616-6', 'Daniela', 'Reyes', '962346789', 'Calle 16', 'Viudo', 'daniela.reyes@example.com', 16)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('17171717-7', 'Carlos', 'Ortiz', '972346789', 'Calle 17', 'Soltero', 'carlos.ortiz@example.com', 43)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('18181818-8', 'Natalia', 'Rivas', '982346789', 'Calle 18', 'Casado', 'natalia.rivas@example.com', 2)

    INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
        VALUES ('19191919-9', 'Sebastián', 'Peña', '992346789', 'Calle 19', 'Divorciado', 'sebastian.pena@example.com', 43)
SELECT * FROM dual;

-- Inserción de Profesiones
INSERT ALL
    INTO Profesion (prof_codigo, prof_nombre) VALUES (1, 'Kinesiologo')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (2, 'Instructor de Yoga')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (3, 'Instructor de Pilates')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (4, 'Nutricionista')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (5, 'Psicologo')
    INTO Profesion (prof_codigo, prof_nombre) VALUES (6, 'Instructor de Zumba')
SELECT * FROM dual;

-- Inserción de Instructores
INSERT ALL
    INTO Instructor (ins_rut, ins_nombres, ins_apellidos, ins_telefono, ins_direccion, ins_sueldo_base, prof_codigo)
        VALUES ('12345678-9', 'Aquiles', 'Brinco', '968574235', 'Av Sebastian Piñera', 500000, 1)
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

-- Inserción de Programas
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

-- Inserción de Planes
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

-- Inserción de Entrenamientos
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

-- Inserción de Patologías
INSERT ALL
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (1, 'Diabetes')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (2, 'Hipertensión')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (3, 'Asma')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (4, 'Autismo')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (5, 'Artritis')
    INTO Patologia (pat_codigo, pat_descripcion) VALUES (6, 'Cáncer')
SELECT * FROM dual;

-- Inserción de Eventos
INSERT ALL
    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (1, 'Clase de Zumba', '13:00', '15:00', 50000, 'Efectivo', TO_DATE('2024-07-01', 'YYYY-MM-DD'), '22222222-2')
    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (2, 'Fiesta de cumpleaños', '10:00', '00:00', 80000, 'Tarjeta', TO_DATE('2024-07-19', 'YYYY-MM-DD'), '44444444-4')
    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (3, 'Seminario de Nutrición', '14:00', '16:00', 50000, 'Transferencia', TO_DATE('2024-07-02', 'YYYY-MM-DD'), '18181818-8')
    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (4, 'Clase de Danza Moderna', '17:00', '18:00', 30000, 'Efectivo', TO_DATE('2024-06-21', 'YYYY-MM-DD'), '14141414-4')
    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (5, 'Taller de Resiliencia', '11:00', '13:00', 65000, 'Tarjeta', TO_DATE('2024-07-04', 'YYYY-MM-DD'), '11111112-1')
    INTO Evento (eve_codigo, eve_descripcion, eve_hora_inicio, eve_hora_fin, eve_valor_arriendo, eve_modalidad_pago, eve_fecha_pago, cli_rut) 
        VALUES (6, 'Workshop de Fitness', '10:00', '12:00', 40000, 'Transferencia', TO_DATE('2023-12-12', 'YYYY-MM-DD'), '99999999-9')
SELECT * FROM dual;

-- Inserción de Cursos
INSERT ALL
    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (1, 'Curso de Yoga Avanzado', 69990, 60, 8, TO_DATE('2024-07-01', 'YYYY-MM-DD'), TO_DATE('2024-07-12', 'YYYY-MM-DD'))

    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (2, 'Curso de Pilates Suelo', 49990, 60, 6, TO_DATE('2024-01-15', 'YYYY-MM-DD'), TO_DATE('2024-01-26', 'YYYY-MM-DD'))

    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (3, 'Curso de Meditación', 65990, 45, 9, TO_DATE('2023-12-12', 'YYYY-MM-DD'), TO_DATE('2023-12-29', 'YYYY-MM-DD'))

    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (4, 'Curso de Danza', 54990, 60, 6, TO_DATE('2024-03-04', 'YYYY-MM-DD'), TO_DATE('2024-03-21', 'YYYY-MM-DD'))

    INTO Cursos (cur_codigo, cur_descripcion, cur_valor_sesion, cur_duracion, cur_num_sesiones, cur_fecha_inicio, cur_fecha_termino) 
        VALUES (5, 'Curso de Nutrición y Bienestar', 24990, 90, 3, TO_DATE('2023-09-06', 'YYYY-MM-DD'), TO_DATE('2023-09-20', 'YYYY-MM-DD'))
SELECT * FROM dual;

-- Inserción de Salones
INSERT ALL
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (1, 'Salón 101AA', 30)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (2, 'Salón 102AA', 25)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (3, 'Salón 202AB', 20)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (4, 'Salón 201D', 35)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (5, 'Salón 202D', 40)
    INTO Salon (sal_codigo, sal_nombre, sal_capacidad) VALUES (6, 'Salón 102AC', 15)
SELECT * FROM dual;

-- Inserción de Sesiones
INSERT ALL
-- Lunes
    -- Cursos
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (13, 'Sesión de Pilates Suelo 1', TO_DATE('2024-01-15', 'YYYY-MM-DD'), '10:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (16, 'Sesión de Pilates Suelo 4', TO_DATE('2024-01-22', 'YYYY-MM-DD'), '10:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (19, 'Sesión de Danza 1', TO_DATE('2024-03-04', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (21, 'Sesión de Danza 3', TO_DATE('2024-03-11', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (23, 'Sesión de Danza 5', TO_DATE('2024-03-18', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (25, 'Sesión de Yoga Avanzado 1', TO_DATE('2024-07-01', 'YYYY-MM-DD'), '09:00', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (29, 'Sesión de Yoga Avanzado 5', TO_DATE('2024-07-08', 'YYYY-MM-DD'), '09:00', 1, '56789012-3')
    -- Programas
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (33, 'Sesión de Yoga Principiante', TO_DATE('2024-07-08', 'YYYY-MM-DD'), '14:30', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (34, 'Sesión de Pilates Nivel Intermedio', TO_DATE('2024-07-08', 'YYYY-MM-DD'), '16:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (35, 'Sesión de Pilates prenatal', TO_DATE('2024-07-08', 'YYYY-MM-DD'), '17:30', 2, '34567890-1')
-- Martes
    -- Cursos
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (4, 'Sesión de Meditación 1', TO_DATE('2023-12-12', 'YYYY-MM-DD'), '10:30', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (7, 'Sesión de Meditación 4', TO_DATE('2023-12-19', 'YYYY-MM-DD'), '10:30', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (10, 'Sesión de Meditación 7', TO_DATE('2023-12-26', 'YYYY-MM-DD'), '10:30', 3, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (26, 'Sesión de Yoga Avanzado 2', TO_DATE('2024-07-02', 'YYYY-MM-DD'), '09:00', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (30, 'Sesión de Yoga Avanzado 6', TO_DATE('2024-07-09', 'YYYY-MM-DD'), '09:00', 1, '56789012-3')
    -- Programas
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (36, 'Sesión de Kinesiologia con Pilates', TO_DATE('2024-07-09', 'YYYY-MM-DD'), '14:30', 6, '12345678-9')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (37, 'Sesión de Yoga Nivel Intermedio', TO_DATE('2024-07-09', 'YYYY-MM-DD'), '16:00', 4, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (38, 'Sesión de Pilates Nivel Intermedio', TO_DATE('2024-07-09', 'YYYY-MM-DD'), '18:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (39, 'Sesión de Pilates con Maquinas', TO_DATE('2024-07-09', 'YYYY-MM-DD'), '20:00', 2, '34567890-1')
-- Miercoles
    -- Cursos
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (1, 'Sesión de Nutrición y Bienestar 1', TO_DATE('2023-09-06', 'YYYY-MM-DD'), '11:00', 5, '45678901-2')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (2, 'Sesión de Nutrición y Bienestar 2', TO_DATE('2023-09-13', 'YYYY-MM-DD'), '11:00', 5, '45678901-2')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (3, 'Sesión de Nutrición y Bienestar 3', TO_DATE('2023-09-20', 'YYYY-MM-DD'), '11:00', 5, '45678901-2')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (5, 'Sesión de Meditación 2', TO_DATE('2023-12-13', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (8, 'Sesión de Meditación 5', TO_DATE('2023-12-20', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (11, 'Sesión de Meditación 8', TO_DATE('2023-12-27', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (14, 'Sesión de Pilates Suelo 2', TO_DATE('2024-01-17', 'YYYY-MM-DD'), '11:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (17, 'Sesión de Pilates Suelo 5', TO_DATE('2024-01-24', 'YYYY-MM-DD'), '11:00', 2, '34567890-1')
    -- Programas
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (40, 'Sesión de Yoga Principiante', TO_DATE('2024-07-10', 'YYYY-MM-DD'), '14:30', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (41, 'Sesion Aero Yoga', TO_DATE('2024-07-10', 'YYYY-MM-DD'), '16:00', 1, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (42, 'Sesión de Pilates con Maquina', TO_DATE('2024-07-10', 'YYYY-MM-DD'), '17:30', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (43, 'Sesión de Pilates Reformer', TO_DATE('2024-07-10', 'YYYY-MM-DD'), '19:30', 2, '34567890-1')
-- Jueves
    -- Cursos
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (27, 'Sesión de Yoga Avanzado 3', TO_DATE('2024-07-04', 'YYYY-MM-DD'), '10:00', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (31, 'Sesión de Yoga Avanzado 7', TO_DATE('2024-07-11', 'YYYY-MM-DD'), '10:00', 1, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
    -- Programa
        VALUES (44, 'Sesión de Pilates Reformer', TO_DATE('2024-07-11', 'YYYY-MM-DD'), '14:30', 4, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (45, 'Sesión de Yoga Avanzado', TO_DATE('2024-07-11', 'YYYY-MM-DD'), '16:00', 4, '23456789-0') 
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (46, 'Sesión de Kinesiologia con Pilates', TO_DATE('2024-07-11', 'YYYY-MM-DD'), '18:30', 6, '12345678-9')
-- Viernes
    -- Cursos
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (6, 'Sesión de Meditación 3', TO_DATE('2023-12-15', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (9, 'Sesión de Meditación 6', TO_DATE('2023-12-22', 'YYYY-MM-DD'), '09:00', 3, '56789012-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (12, 'Sesión de Meditación 9', TO_DATE('2023-12-29', 'YYYY-MM-DD'), '08:00', 3, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (15, 'Sesión de Pilates Suelo 3', TO_DATE('2024-01-19', 'YYYY-MM-DD'), '10:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (18, 'Sesión de Pilates Suelo 6', TO_DATE('2024-01-26', 'YYYY-MM-DD'), '10:00', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (20, 'Sesión de Danza 2', TO_DATE('2024-03-08', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (22, 'Sesión de Danza 4', TO_DATE('2024-03-15', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (24, 'Sesión de Danza 6', TO_DATE('2024-03-22', 'YYYY-MM-DD'), '17:00', 4, '20393210-3')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (28, 'Sesión de Yoga Avanzado 4', TO_DATE('2024-07-05', 'YYYY-MM-DD'), '09:00', 1, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (32, 'Sesión de Yoga Avanzado 8', TO_DATE('2024-07-12', 'YYYY-MM-DD'), '09:00', 1, '23456789-0')
    -- Programas
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (47, 'Sesión de Yoga Nivel Intermedio', TO_DATE('2024-07-12', 'YYYY-MM-DD'), '14:30', 4, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (48, 'Sesión de Yoga Restaurativo', TO_DATE('2024-07-12', 'YYYY-MM-DD'), '16:00', 6, '23456789-0')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (49, 'Sesión de Pilates Nivel Intermedio', TO_DATE('2024-07-12', 'YYYY-MM-DD'), '17:30', 2, '34567890-1')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut) 
        VALUES (50, 'Sesión de Pilates Prenatal', TO_DATE('2024-07-12', 'YYYY-MM-DD'), '19:00', 1, '56789012-3')  
SELECT * FROM dual;

-- Inserción Relación Padece (Cliente - Patología)
INSERT ALL
    INTO Padece (pat_codigo, cli_rut) VALUES (1, '22222222-2') -- Cliente padece Diabetes
    INTO Padece (pat_codigo, cli_rut) VALUES (2, '22222222-2') -- Cliente padece Hipertensión
    INTO Padece (pat_codigo, cli_rut) VALUES (3, '33333333-3') -- Cliente padece Asma
    INTO Padece (pat_codigo, cli_rut) VALUES (4, '55555555-5') -- Cliente padece Autismo
    INTO Padece (pat_codigo, cli_rut) VALUES (5, '44444444-4') -- Cliente padece Artritis
    INTO Padece (pat_codigo, cli_rut) VALUES (6, '33333333-3') -- Cliente padece Cáncer
    INTO Padece (pat_codigo, cli_rut) VALUES (2, '11111112-1') -- Cliente padece Hipertensión
    INTO Padece (pat_codigo, cli_rut) VALUES (3, '12121212-2') -- Cliente padece Asma
    INTO Padece (pat_codigo, cli_rut) VALUES (2, '14141414-4') -- Cliente padece Hipertensión
    INTO Padece (pat_codigo, cli_rut) VALUES (1, '15151515-5') -- Cliente padece Diabetes
    INTO Padece (pat_codigo, cli_rut) VALUES (1, '18181818-8') -- Cliente padece Diabetes
    INTO Padece (pat_codigo, cli_rut) VALUES (2, '18181818-8') -- Cliente padece Hipertensión
SELECT * FROM dual;

-- Inserción Relación Padece (Cliente - Empresa)
INSERT ALL
    INTO Trabaja (emp_codigo, cli_rut) VALUES (1, '11111111-1') -- Cliente trabaja en Nestle
    INTO Trabaja (emp_codigo, cli_rut) VALUES (2, '22222222-2') -- Cliente trabaja en EA Sports
    INTO Trabaja (emp_codigo, cli_rut) VALUES (3, '33333333-3') -- Cliente trabaja en Carozzi
    INTO Trabaja (emp_codigo, cli_rut) VALUES (4, '44444444-4') -- Cliente trabaja en Steam
    INTO Trabaja (emp_codigo, cli_rut) VALUES (5, '55555555-5') -- Cliente trabaja en Estudio Ghibli
    INTO Trabaja (emp_codigo, cli_rut) VALUES (1, '66666666-6') -- Cliente trabaja en Nestle
    INTO Trabaja (emp_codigo, cli_rut) VALUES (2, '77777777-7') -- Cliente trabaja en EA Sports
    INTO Trabaja (emp_codigo, cli_rut) VALUES (3, '88888888-8') -- Cliente trabaja en Carozzi
    INTO Trabaja (emp_codigo, cli_rut) VALUES (4, '99999999-9') -- Cliente trabaja en Steam
    INTO Trabaja (emp_codigo, cli_rut) VALUES (5, '10101010-0') -- Cliente trabaja en Estudio Ghibli
    INTO Trabaja (emp_codigo, cli_rut) VALUES (1, '11111112-1') -- Cliente trabaja en Nestle
    INTO Trabaja (emp_codigo, cli_rut) VALUES (2, '12121212-2') -- Cliente trabaja en EA Sports
    INTO Trabaja (emp_codigo, cli_rut) VALUES (3, '13131313-3') -- Cliente trabaja en Carozzi
    INTO Trabaja (emp_codigo, cli_rut) VALUES (4, '14141414-4') -- Cliente trabaja en Steam
    INTO Trabaja (emp_codigo, cli_rut) VALUES (5, '15151515-5') -- Cliente trabaja en Estudio Ghibli
    INTO Trabaja (emp_codigo, cli_rut) VALUES (1, '16161616-6') -- Cliente trabaja en Nestle
    INTO Trabaja (emp_codigo, cli_rut) VALUES (2, '17171717-7') -- Cliente trabaja en EA Sports
    INTO Trabaja (emp_codigo, cli_rut) VALUES (3, '18181818-8') -- Cliente trabaja en Carozzi
    INTO Trabaja (emp_codigo, cli_rut) VALUES (4, '19191919-9') -- Cliente trabaja en Steam
SELECT * FROM dual;

-- Inserción Relación Posee (Cliente - Estado)
INSERT ALL
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2023-06-21', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'), '11111111-1')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2024-01-09', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), '22222222-2')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2023-04-05', 'YYYY-MM-DD'), TO_DATE('2024-03-31', 'YYYY-MM-DD'), '33333333-3')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2023-01-10', 'YYYY-MM-DD'), TO_DATE('2023-12-31', 'YYYY-MM-DD'), '44444444-4')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2023-09-05', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), '55555555-5')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (2, TO_DATE('2024-05-07', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), '66666666-6')
        INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2023-11-06', 'YYYY-MM-DD'), TO_DATE('2024-10-31', 'YYYY-MM-DD'), '77777777-7')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2023-07-07', 'YYYY-MM-DD'), TO_DATE('2024-06-30', 'YYYY-MM-DD'), '88888888-8')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2023-05-08', 'YYYY-MM-DD'), TO_DATE('2024-04-30', 'YYYY-MM-DD'), '99999999-9')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2024-06-28', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'), '10101010-0')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (2, TO_DATE('2023-07-03', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'), '11111112-1')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2023-09-04', 'YYYY-MM-DD'), TO_DATE('2024-08-31', 'YYYY-MM-DD'), '12121212-2')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2023-10-02', 'YYYY-MM-DD'), TO_DATE('2024-09-30', 'YYYY-MM-DD'), '13131313-3')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2024-01-03', 'YYYY-MM-DD'), TO_DATE('2024-12-31', 'YYYY-MM-DD'), '14141414-4')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2024-03-04', 'YYYY-MM-DD'), TO_DATE('2025-02-28', 'YYYY-MM-DD'), '15151515-5')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2024-05-28', 'YYYY-MM-DD'), TO_DATE('2025-04-30', 'YYYY-MM-DD'), '16161616-6')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (1, TO_DATE('2024-07-05', 'YYYY-MM-DD'), TO_DATE('2025-06-30', 'YYYY-MM-DD'), '17171717-7')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (2, TO_DATE('2024-06-27', 'YYYY-MM-DD'), TO_DATE('2024-07-26', 'YYYY-MM-DD'), '18181818-8')
    INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut)
        VALUES (2, TO_DATE('2024-06-14', 'YYYY-MM-DD'), TO_DATE('2024-07-31', 'YYYY-MM-DD'), '19191919-9')       
SELECT * FROM dual;

delete from posee

-- Inserciones en la tabla Contrata
INSERT ALL
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (4, '22222222-2', TO_DATE('2024-07-01', 'YYYY-MM-DD'))
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (6, '55555555-5', TO_DATE('2024-06-12', 'YYYY-MM-DD'))
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (1, '14141414-4', TO_DATE('2024-01-15', 'YYYY-MM-DD'))
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (7, '33333333-3', TO_DATE('2024-03-12', 'YYYY-MM-DD'))
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (4, '11111112-1', TO_DATE('2023-12-04', 'YYYY-MM-DD'))
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (9, '18181818-8', TO_DATE('2024-04-09', 'YYYY-MM-DD'))
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (2, '15151515-5', TO_DATE('2024-02-14', 'YYYY-MM-DD'))
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (10, '16161616-6', TO_DATE('2024-06-17', 'YYYY-MM-DD'))
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (6, '19191919-9', TO_DATE('2023-11-15', 'YYYY-MM-DD'))
    INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (1, '17171717-7', TO_DATE('2023-12-20', 'YYYY-MM-DD'))
SELECT * FROM dual;

-- Inserciones en la tabla Se_da
INSERT ALL
    INTO Se_da (cur_codigo, ses_codigo) VALUES (5,1)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (5,2)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (5,3)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (3,4)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (3,5)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (3,6)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (3,7)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (3,8)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (3,9)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (3,10)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (3,11)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (3,12)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (2,13)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (2,14)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (2,15)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (2,16)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (2,17)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (2,18)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (4,19)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (4,20)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (4,21)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (4,22)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (4,23)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (4,24)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (1,25)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (1,26)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (1,27)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (1,28)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (1,29)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (1,30)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (1,31)
    INTO Se_da (cur_codigo, ses_codigo) VALUES (1,32)
SELECT * FROM dual;
-- Inserciones en la tabla Inscribe
INSERT ALL
    INTO Inscribe (cur_codigo, cli_rut, fecha) VALUES (1, '11111111-1', TO_DATE('2024-07-01', 'YYYY-MM-DD'))
    INTO Inscribe (cur_codigo, cli_rut, fecha) VALUES (2, '44444444-4', TO_DATE('2024-01-08', 'YYYY-MM-DD'))
    INTO Inscribe (cur_codigo, cli_rut, fecha) VALUES (3, '66666666-6', TO_DATE('2023-11-23', 'YYYY-MM-DD'))
    INTO Inscribe (cur_codigo, cli_rut, fecha) VALUES (4, '77777777-7', TO_DATE('2024-02-20', 'YYYY-MM-DD'))
    INTO Inscribe (cur_codigo, cli_rut, fecha) VALUES (5, '88888888-8', TO_DATE('2024-08-21', 'YYYY-MM-DD'))
    INTO Inscribe (cur_codigo, cli_rut, fecha) VALUES (5, '99999999-9', TO_DATE('2024-08-15', 'YYYY-MM-DD'))
    INTO Inscribe (cur_codigo, cli_rut, fecha) VALUES (1, '10101010-0', TO_DATE('2024-07-02', 'YYYY-MM-DD'))
    INTO Inscribe (cur_codigo, cli_rut, fecha) VALUES (3, '12121212-2', TO_DATE('2023-12-01', 'YYYY-MM-DD'))
    INTO Inscribe (cur_codigo, cli_rut, fecha) VALUES (2, '13131313-3', TO_DATE('2024-01-03', 'YYYY-MM-DD'))
SELECT * FROM dual;

-- Inserciones en la tabla Agenda
INSERT ALL
    INTO Agenda (ses_codigo, cli_rut) VALUES (25, '11111111-1')
    INTO Agenda (ses_codigo, cli_rut) VALUES (26, '11111111-1')
    INTO Agenda (ses_codigo, cli_rut) VALUES (27, '11111111-1')
    INTO Agenda (ses_codigo, cli_rut) VALUES (28, '11111111-1')
    INTO Agenda (ses_codigo, cli_rut) VALUES (29, '11111111-1')
    INTO Agenda (ses_codigo, cli_rut) VALUES (30, '11111111-1')
    INTO Agenda (ses_codigo, cli_rut) VALUES (31, '11111111-1')
    INTO Agenda (ses_codigo, cli_rut) VALUES (32, '11111111-1')
    INTO Agenda (ses_codigo, cli_rut) VALUES (25, '10101010-0')
    INTO Agenda (ses_codigo, cli_rut) VALUES (26, '10101010-0')
    INTO Agenda (ses_codigo, cli_rut) VALUES (27, '10101010-0')
    INTO Agenda (ses_codigo, cli_rut) VALUES (28, '10101010-0')
    INTO Agenda (ses_codigo, cli_rut) VALUES (29, '10101010-0')
    INTO Agenda (ses_codigo, cli_rut) VALUES (30, '10101010-0')
    INTO Agenda (ses_codigo, cli_rut) VALUES (31, '10101010-0')
    INTO Agenda (ses_codigo, cli_rut) VALUES (32, '10101010-0')
    INTO Agenda (ses_codigo, cli_rut) VALUES (1, '88888888-8')
    INTO Agenda (ses_codigo, cli_rut) VALUES (2, '88888888-8')
    INTO Agenda (ses_codigo, cli_rut) VALUES (3, '88888888-8')
SELECT * FROM dual;





----------------------------------------------------------------------------------------------------------------------------------------------
-- Ejercicio 1
-- Habilitar la salida de DBMS_OUTPUT (Ejecutar al abrir el archivo)
SET SERVEROUTPUT ON;

-- Declaración del bloque PL/SQL
DECLARE
    TYPE t_comuna IS TABLE OF VARCHAR2(20);
    TYPE t_cantidad IS TABLE OF INTEGER;
    v_comunas t_comuna;
    v_cantidades t_cantidad;
BEGIN
    SELECT com.com_nombre, COUNT(*) AS cantidad
    BULK COLLECT INTO v_comunas, v_cantidades
    FROM Cliente cli
    JOIN Comuna com ON cli.com_codigo = com.com_codigo
    JOIN Posee pos ON cli.cli_rut = pos.cli_rut
    JOIN Contrata con ON cli.cli_rut = con.cli_rut
    JOIN Plan pla ON con.pla_codigo = pla.pla_codigo
    JOIN Programa pro ON pla.pro_codigo = pro.pro_codigo
    JOIN Entrenamiento ent ON pro.pro_codigo = ent.pro_codigo
    WHERE pos.est_codigo = 1 -- Estado Habilitado
    AND ent.pro_tipo = 'Pilates'
    AND con.fecha >= ADD_MONTHS(SYSDATE, -6) -- Últimos 6 meses
    GROUP BY com.com_nombre
    ORDER BY cantidad DESC;

    DBMS_OUTPUT.PUT_LINE('Ranking de Comunas');
    FOR i IN 1 .. v_comunas.COUNT LOOP
        DBMS_OUTPUT.PUT_LINE(v_comunas(i) || ': ' || v_cantidades(i));
    END LOOP;
END;

-- Ejercicio 2
-- Habilitar la salida de DBMS_OUTPUT
SET SERVEROUTPUT ON;

-- Declaración del bloque PL/SQL
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
