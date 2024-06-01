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

-- Insertar algunas regiones y comunas
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (1, 'Region Metropolitana');
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (101, 'Providencia', 1);
INSERT INTO Region (reg_codigo, reg_nombre) VALUES (2, 'Region de Valparaiso');
INSERT INTO Comuna (com_codigo, com_nombre, reg_codigo) VALUES (102, 'Viña del Mar', 2);

-- Insertar algunos clientes
INSERT INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) VALUES ('12345678-9', 'Juan', 'Pérez', '12345678', 'Calle Falsa 123', 'Soltero', 'juan.perez@example.com', 101);
INSERT INTO Cliente (cli_rut, cli_nombres, cli_apellidos, cli_telefono, cli_direccion, cli_estado_civil, cli_correo_electronico, com_codigo) VALUES ('23456789-0', 'Ana', 'Gomez', '98765432', 'Avenida Xd 742', 'Casado', 'ana.gomez@example.com', 102);

-- Insertar estado para clientes
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (1, 'Vigente');
INSERT INTO Estado (est_codigo, est_descripcion) VALUES (2, 'No Vigente');

INSERT INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut) VALUES (1, TO_DATE('2023-01-01', 'YYYY-MM-DD'), TO_DATE('2024-01-01', 'YYYY-MM-DD'), '12345678-9');
INSERT INTO Posee (est_codigo, fecha_inicio, fecha_termino, cli_rut) VALUES (1, TO_DATE('2022-01-01', 'YYYY-MM-DD'), TO_DATE('2023-01-01', 'YYYY-MM-DD'), '23456789-0');

-- Insertar programas y planes
INSERT INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (1, 'Pilates Reformer', 15000, 60);
INSERT INTO Programa (pro_codigo, pro_descripcion, pro_valor_sesion, pro_duracion) VALUES (2, 'Yoga', 10000, 45);

INSERT INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (1, '3 veces a la semana', 40000, 1);
INSERT INTO Plan (pla_codigo, pla_modalidad, pla_valor, pro_codigo) VALUES (2, '2 veces a la semana', 30000, 2);


-- Insertar contratación de un plan
INSERT INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (1, '12345678-9', TO_DATE('2023-06-01', 'YYYY-MM-DD'));
INSERT INTO Contrata (pla_codigo, cli_rut, fecha) VALUES (2, '23456789-0', TO_DATE('2024-02-01', 'YYYY-MM-DD'));

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

