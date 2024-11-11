DROP TABLE IF EXISTS CURSO, INSCRIPTO, ALUMNO CASCADE;

CREATE TABLE CURSO(
    cod char(4) NOT NULL ,
    descripcion varchar(40) NOT NULL,
    tipo char(1) NOT NULL,
    cod_inscripcion varchar,
    LU_inscrpcion int,
    CONSTRAINT pk_curso PRIMARY KEY(cod)
);

CREATE TABLE INSCRIPTO(
    cod char(4) NOT NULL ,
    LU  varchar NOT NULL,
    CONSTRAINT pk_inscripto PRIMARY KEY (cod, LU)
);

CREATE TABLE ALUMNO(
    LU  varchar NOT NULL,
    nombre varchar(40) NOT NULL ,
    provincia varchar(30) NOT NULL,
    CONSTRAINT pk_alumno PRIMARY KEY (LU)
);

ALTER TABLE CURSO
 ADD CONSTRAINT fk_curso_inscripto
 FOREIGN KEY (LU_inscrpcion, cod_inscripcion)
 REFERENCES INSCRIPTO(LU, cod);

ALTER TABLE INSCRIPTO
 ADD CONSTRAINT  fk_inscripto_curso
 FOREIGN KEY (cod)
 REFERENCES CURSO(cod);

ALTER TABLE INSCRIPTO
 ADD CONSTRAINT  fk_inscripto_alumno
 FOREIGN KEY (LU)
 REFERENCES ALUMNO(LU);
