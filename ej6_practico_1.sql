CREATE TABLE USUARIO(
    id_usuario int NOT NULL ,
    tipo_doc varchar NOT NULL ,
    nro_doc int NOT NULL ,
    apellido varchar NOT NULL ,
    nombre varchar NOT NULL ,
    email varchar NOT NULL ,
    tipo_usuario bit NOT NULL ,
    CONSTRAINT pk_usuario PRIMARY KEY (id_usuario)
);

CREATE TABLE SIN_CARNET(
    id_usuario int NOT NULL ,
    nro_celular int NOT NULL ,
    CONSTRAINT pk_usuario_sin_carnet PRIMARY KEY (id_usuario)
);

CREATE TABLE CON_CARNET(
    id_usuario int NOT NULL ,
    nro_carnet int NOT NULL ,
    CONSTRAINT pk_usuario_con_carnet PRIMARY KEY (id_usuario)
);

CREATE TABLE PRESTAMO(
    id_prestamo int NOT NULL ,
    fecha_desde date NOT NULL ,
    fecha_hasta date NOT NULL ,
    id_usuario int NOT NULL ,
    CONSTRAINT pk_prestamo PRIMARY KEY (id_prestamo)
);

CREATE TABLE CATALOGO_LIBRO(
    cod_catalogo int NOT NULL ,
    titulo varchar NOT NULL ,
    formato varchar NOT NULL ,
    editorial varchar NOT NULL ,
    CONSTRAINT pk_catalogo_libro PRIMARY KEY (cod_catalogo)
);

CREATE TABLE AUTOR_LIBRO(
    cod_catalogo int NOT NULL ,
    nombre varchar NOT NULL ,
    CONSTRAINT pk_autor_libro PRIMARY KEY (cod_catalogo, nombre)
);

CREATE TABLE EJEMPLAR_LIBRO(
    cod_catalogo int NOT NULL ,
    nro_ejemplar int NOT NULL ,
    anio_edicion int NOT NULL ,
    nro_edicion int NOT NULL ,
    CONSTRAINT pk_ejemplar_libro PRIMARY KEY (cod_catalogo, nro_ejemplar)
);

CREATE TABLE LO_INTEGRAN(
    cod_catalogo int NOT NULL ,
    nro_ejemplar int NOT NULL ,
    id_prestamo int NOT NULL ,
    CONSTRAINT pk_lo_integran PRIMARY KEY (cod_catalogo, nro_ejemplar, id_prestamo)
);

ALTER TABLE CON_CARNET
ADD CONSTRAINT fk_con_carnet_usuario
FOREIGN KEY (id_usuario)
REFERENCES USUARIO(id_usuario);

ALTER TABLE SIN_CARNET
ADD CONSTRAINT fk_sin_carnet_usuario
FOREIGN KEY (id_usuario)
REFERENCES USUARIO(id_usuario);

ALTER TABLE PRESTAMO
ADD CONSTRAINT fk_prestamo_sin_carnet
FOREIGN KEY (id_usuario)
REFERENCES SIN_CARNET(id_usuario);

ALTER TABLE AUTOR_LIBRO
ADD CONSTRAINT fk_autor_libro_catalogo_libro
FOREIGN KEY (cod_catalogo)
REFERENCES CATALOGO_LIBRO(cod_catalogo);

ALTER TABLE EJEMPLAR_LIBRO
ADD CONSTRAINT fk_ejemplar_libro_catalogo_libro
FOREIGN KEY (cod_catalogo)
REFERENCES CATALOGO_LIBRO(cod_catalogo);

ALTER TABLE LO_INTEGRAN
ADD CONSTRAINT fk_lo_integran_ejemplar_libro
FOREIGN KEY (cod_catalogo, nro_ejemplar)
REFERENCES EJEMPLAR_LIBRO(cod_catalogo, nro_ejemplar);

ALTER TABLE LO_INTEGRAN
ADD CONSTRAINT fk_lo_integran_prestamo
FOREIGN KEY (id_prestamo)
REFERENCES PRESTAMO(id_prestamo);

