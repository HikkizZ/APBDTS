-- Creación de Tablas
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

CREATE TABLE Cursos(
    cur_codigo INTEGER PRIMARY KEY,
    cur_descripcion VARCHAR2(20),
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

-- Inserción de Datos

-- Inserción de Regiones
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (1, 'Tarapacá');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (2, 'Antofagasta');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (3, 'Atacama');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (4, 'Coquimbo');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (5, 'Valparaíso');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (6, 'O’Higgins');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (7, 'Maule');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (8, 'Ñuble');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (9, 'Biobío');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (10, 'Araucanía');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (11, 'Los Ríos');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (12, 'Los Lagos');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (13, 'Aysén');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (14, 'Magallanes');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (15, 'Metropolitana');
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (16, 'Arica y Parinacota');

-- Inserción de Comunas
-- Región de Tarapacá
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (1, 'Iquique', 1);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (2, 'Alto Hospicio', 1);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (3, 'Pozo Almonte', 1);

-- Región de Antofagasta
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (4, 'Antofagasta', 2);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (5, 'Mejillones', 2);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (6, 'Taltal', 2);

-- Región de Atacama (3)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (7, 'Copiapó', 3);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (8, 'Caldera', 3);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (9, 'Chañaral', 3);

-- Región de Coquimbo (4)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (10, 'La Serena', 4);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (11, 'Coquimbo', 4);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (12, 'Ovalle', 4);

-- Región de Valparaíso (5)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (13, 'Valparaíso', 5);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (14, 'Viña del Mar', 5);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (15, 'Quilpué', 5);

-- Región de O’Higgins (6)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (16, 'Rancagua', 6);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (17, 'San Fernando', 6);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (18, 'Pichilemu', 6);

-- Región del Maule (7)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (19, 'Talca', 7);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (20, 'Curicó', 7);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (21, 'Linares', 7);

-- Región de Ñuble (8)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (22, 'Chillán', 8);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (23, 'Bulnes', 8);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (24, 'San Carlos', 8);

-- Región del Biobío (9)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (25, 'Concepción', 9);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (26, 'Talcahuano', 9);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (27, 'Los Ángeles', 9);

-- Región de la Araucanía (10)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (28, 'Temuco', 10);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (29, 'Villarrica', 10);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (30, 'Pucón', 10);

-- Región de Los Ríos (11)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (31, 'Valdivia', 11);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (32, 'La Unión', 11);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (33, 'Panguipulli', 11);

-- Región de Los Lagos (12)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (34, 'Puerto Montt', 12);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (35, 'Castro', 12);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (36, 'Ancud', 12);

-- Región de Aysén (13)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (37, 'Coyhaique', 13);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (38, 'Puerto Aysén', 13);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (39, 'Chile Chico', 13);

-- Región de Magallanes (14)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (40, 'Punta Arenas', 14);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (41, 'Puerto Natales', 14);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (42, 'Porvenir', 14);

-- Región Metropolitana (15)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (43, 'Santiago', 15);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (44, 'Puente Alto', 15);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (45, 'Maipú', 15);

-- Región de Arica y Parinacota (16)
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (46, 'Arica', 16);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (47, 'Putre', 16);
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (48, 'Camarones', 16);

-- Inserción de Estados
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (1, 'Habilitado');
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (2, 'No habilitado');

-- Inserción de Empresa
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (1, 'Nestle');
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (2, 'EA Sports');
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (3, 'Carozzi');
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (4, 'Steam');
INSERT INTO Empresa (emp_codigo, emp_descripcion) VALUES (5, 'Estudio Ghibli');

-- Inserción de Clientes
INSERT ALL
INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('11111111-1', 'Juan', 'Pérez', '912345678', 'Calle 1', 'Soltero', 'juan.perez@example.com', 1)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('22222222-2', 'María', 'González', '922345678', 'Calle 2', 'Casado', 'maria.gonzalez@example.com', 2)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('33333333-3', 'Pedro', 'Martínez', '932345678', 'Calle 3', 'Divorciado', 'pedro.martinez@example.com', 3)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('44444444-4', 'Ana', 'Rodríguez', '942345678', 'Calle 4', 'Viudo', 'ana.rodriguez@example.com', 4)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('55555555-5', 'Luis', 'Hernández', '952345678', 'Calle 5', 'Soltero', 'luis.hernandez@example.com', 5)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('66666666-6', 'Carmen', 'Morales', '962345678', 'Calle 6', 'Casado', 'carmen.morales@example.com', 6)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('77777777-7', 'José', 'López', '972345678', 'Calle 7', 'Divorciado', 'jose.lopez@example.com', 7)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('88888888-8', 'Laura', 'Ramírez', '982345678', 'Calle 8', 'Viudo', 'laura.ramirez@example.com', 8)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('99999999-9', 'Miguel', 'Torres', '992345678', 'Calle 9', 'Soltero', 'miguel.torres@example.com', 9)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('10101010-0', 'Isabel', 'Flores', '902345678', 'Calle 10', 'Casado', 'isabel.flores@example.com', 10)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('11111112-1', 'Francisco', 'Díaz', '912346789', 'Calle 11', 'Divorciado', 'francisco.diaz@example.com', 11)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('12121212-2', 'Elena', 'Fuentes', '922346789', 'Calle 12', 'Viudo', 'elena.fuentes@example.com', 12)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('13131313-3', 'Diego', 'Gutiérrez', '932346789', 'Calle 13', 'Soltero', 'diego.gutierrez@example.com', 13)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('14141414-4', 'Paula', 'Castro', '942346789', 'Calle 14', 'Casado', 'paula.castro@example.com', 14)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('15151515-5', 'Andrés', 'Vargas', '952346789', 'Calle 15', 'Divorciado', 'andres.vargas@example.com', 15)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('16161616-6', 'Daniela', 'Reyes', '962346789', 'Calle 16', 'Viudo', 'daniela.reyes@example.com', 16)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('17171717-7', 'Carlos', 'Ortiz', '972346789', 'Calle 17', 'Soltero', 'carlos.ortiz@example.com', 1)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('18181818-8', 'Natalia', 'Rivas', '982346789', 'Calle 18', 'Casado', 'natalia.rivas@example.com', 2)

INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo)
VALUES ('19191919-9', 'Sebastián', 'Peña', '992346789', 'Calle 19', 'Divorciado', 'sebastian.pena@example.com', 3)
SELECT * FROM dual;

-- Inserción de Profesiones
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (1, 'Kinesiologo');
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (2, 'Instructor de Yoga');
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (3, 'Instructor de Pilates');
INSERT INTO Profesion (prof_codigo, prof_nombre) VALUES (4, 'Nutricionista');

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
SELECT * FROM dual;

-- Inserción de Programas
INSERT ALL
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (1, 'Pilates Reformer', 20000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (2, 'Yoga Inicial', 15000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (3, 'Yoga Intermedio', 17000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (4, 'Pilates Suelo', 18000, 60)
    INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (5, 'Aero Yoga', 16000, 60)
SELECT * FROM dual;

-- Inserción de Planes
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

-- Inserción de Entrenamientos
INSERT ALL
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (1, 'Pilates', 1)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (2, 'Yoga', 2)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (3, 'Yoga', 3)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (4, 'Pilates', 4)
    INTO Entrenamiento (pro_codigo, pro_tipo, esp_codigo) VALUES (5, 'Yoga', 5)
SELECT * FROM dual;

-- Inserción de Sesiones
INSERT ALL
    -- Lunes
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (1, 'Pilates Reformer Clase 1', TO_DATE('2024-07-08', 'YYYY-MM-DD'), '10:00', 1, '44444444-4')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (2, 'Yoga Inicial Clase 1', TO_DATE('2024-07-08', 'YYYY-MM-DD'), '12:00', 2, '55555555-5')

    -- Martes
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (3, 'Yoga Intermedio Clase 1', TO_DATE('2024-07-09', 'YYYY-MM-DD'), '10:00', 1, '66666666-6')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (4, 'Pilates Suelo Clase 1', TO_DATE('2024-07-09', 'YYYY-MM-DD'), '12:00', 2, '77777777-7')

    -- Miércoles
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (5, 'Aero Yoga Clase 1', TO_DATE('2024-07-10', 'YYYY-MM-DD'), '10:00', 1, '88888888-8')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (6, 'Pilates Reformer Clase 2', TO_DATE('2024-07-10', 'YYYY-MM-DD'), '12:00', 2, '44444444-4')

    -- Jueves
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (7, 'Yoga Inicial Clase 2', TO_DATE('2024-07-11', 'YYYY-MM-DD'), '10:00', 1, '55555555-5')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (8, 'Yoga Intermedio Clase 2', TO_DATE('2024-07-11', 'YYYY-MM-DD'), '12:00', 2, '66666666-6')

    -- Viernes
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (9, 'Pilates Suelo Clase 2', TO_DATE('2024-07-12', 'YYYY-MM-DD'), '10:00', 1, '77777777-7')
    INTO Sesion (ses_codigo, ses_descripcion, ses_fecha, ses_hora, sal_codigo, ins_rut)
        VALUES (10, 'Aero Yoga Clase 2', TO_DATE('2024-07-12', 'YYYY-MM-DD'), '12:00', 2, '88888888-8')



-- Ejercicio 1
SET SERVEROUTPUT ON;

DECLARE
  CURSOR cur_comunas IS
    SELECT c.com_nombre, COUNT(*) AS num_clientes
    FROM Cliente cli
    JOIN Comuna c ON cli.com_codigo = c.com_codigo
    JOIN Posee pose ON cli.cli_rut = pose.cli_rut AND pose.est_codigo = 1 AND pose.fecha_termino >= SYSDATE -- estado vigente
    JOIN Contrata contr ON cli.cli_rut = contr.cli_rut
    JOIN Plan pl ON contr.pla_codigo = pl.pla_codigo
    JOIN Programa prog ON pl.pro_codigo = prog.pro_codigo AND prog.pro_descripcion LIKE '%Pilates%'
    WHERE contr.fecha >= ADD_MONTHS(SYSDATE, -6) -- contratos en los últimos 6 meses
    GROUP BY c.com_nombre
    ORDER BY num_clientes DESC;
BEGIN
  DBMS_OUTPUT.PUT_LINE('Ranking de comunas con clientes activos en Pilates:');
  FOR rec IN cur_comunas LOOP
    DBMS_OUTPUT.PUT_LINE('Comuna: ' || rec.com_nombre || ' - Número de Clientes: ' || rec.num_clientes);
  END LOOP;
END;

