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

-- Creacion de Relaciones - Sin ejecutar
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
    FOREIGN KEY (cur_codigo) REFERENCES Curso(cur_codigo),
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
    FOREIGN KEY (cur_codigo) REFERENCES Curso(cur_codigo),
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
    ins_codigo INTEGER,
    cur_codigo INTEGER,
    PRIMARY KEY (ins_codigo, cur_codigo),
    FOREIGN KEY (ins_codigo) REFERENCES Instructor(ins_codigo),
    FOREIGN KEY (cur_codigo) REFERENCES Curso(cur_codigo)
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

-- SubCategorias (?) - Sin ejecutar
CREATE TABLE Terapia(
    pro_codigo INTEGER,
    PRIMARY KEY (pro_codigo),
    FOREIGN KEY (pro_codigo) REFERENCES Programa(pro_codigo)
);

CREATE TABLE Especialidad(
    esp_codigo INTEGER PRIMARY KEY,
    esp_nombre VARCHAR2(20)
);