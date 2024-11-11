DROP TABLE IF EXISTS GRABACION, GRABACION_NO_PROPIA, GRABACION_COMERCIAL, EQUIPO CASCADE;

CREATE TABLE GRABACION(
    nro_grabacion int NOT NULL ,
    casa_discografica varchar(50) NOT NULL ,
    fecha_grabacion date NOT NULL ,
    tipo char(1) NOT NULL ,
    CONSTRAINT pk_grabacion PRIMARY KEY (nro_grabacion)
);

CREATE TABLE GRABACION_NO_PROPIA(
  nro_grabacion int NOT NULL ,
  duracion int NOT NULL ,
  CONSTRAINT pk_grabacion_no_propia PRIMARY KEY (nro_grabacion)
);

CREATE TABLE GRABACION_COMERCIAL(
  nro_grabacion int NOT NULL ,
  nro_equipo int NOT NULL ,
  CONSTRAINT pk_grabacion_comercial PRIMARY KEY (nro_grabacion)
);

CREATE TABLE EQUIPO(
    nro_equipo int NOT NULL ,
    descripcion varchar(50) NOT NULL ,
    CONSTRAINT pk_equipo PRIMARY KEY (nro_equipo)
);

ALTER TABLE GRABACION_NO_PROPIA
  ADD CONSTRAINT fk_grabacion_no_propia_grabacion
  FOREIGN KEY (nro_grabacion)
  REFERENCES GRABACION(nro_grabacion);

ALTER TABLE GRABACION_COMERCIAL
  ADD CONSTRAINT fk_grabacion_comercial_grabacion
  FOREIGN KEY (nro_grabacion)
  REFERENCES GRABACION(nro_grabacion);

ALTER TABLE GRABACION_COMERCIAL
  ADD CONSTRAINT fk_grabacion_comercial_equipo
  FOREIGN KEY (nro_equipo)
  REFERENCES EQUIPO(nro_equipo);

