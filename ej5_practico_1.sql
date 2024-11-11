DROP TABLE IF EXISTS OBJETO, COLECCION, REPOSITORIO, AUDIO, VIDEO, DOCUMENTO CASCADE;

CREATE TABLE OBJETO(
    id_coleccion int NOT NULL,
    id_objeto int NOT NULL ,
    titulo varchar NOT NULL ,
    descripcion varchar NOT NULL ,
    fuente varchar NOT NULL ,
    fecha date NOT NULL ,
    id_repositorio int NOT NULL ,
    CONSTRAINT pk_objeto PRIMARY KEY (id_coleccion, id_objeto)
);

CREATE TABLE COLECCION(
    id_coleccion int NOT NULL ,
    titulo_descripcion varchar NOT NULL ,
    descripcion varchar NOT NULL ,
    CONSTRAINT pk_coleccion PRIMARY KEY (id_coleccion)
);

CREATE TABLE REPOSITORIO(
    id_repositorio int NOT NULL ,
    nombre varchar NOT NULL ,
    public bit NOT NULL ,
    descripcion varchar NOT NULL ,
    duenio varchar ,
    CONSTRAINT pk_repositorio PRIMARY KEY (id_repositorio)
);

CREATE TABLE AUDIO(
       id_coleccion int NOT NULL,
       id_objeto int NOT NULL,
       formato varchar NOT NULL,
       duracion int NOT NULL,
       CONSTRAINT pk_audio PRIMARY KEY(id_coleccion, id_objeto)
);

CREATE TABLE VIDEO(
       id_coleccion int NOT NULL,
       id_objeto int NOT NULL,
       resolucion int NOT NULL,
       frames_x_segundo int NOT NULL,
       CONSTRAINT pk_video PRIMARY KEY(id_coleccion, id_objeto)
);

CREATE TABLE DOCUMENTO(
       id_coleccion int NOT NULL,
       id_objeto int NOT NULL,
       tipo_publicacion varchar NOT NULL,
       modos_color varchar NOT NULL,
       resolucion_captura int NOT NULL,
       CONSTRAINT pk_documento PRIMARY KEY(id_coleccion, id_objeto)
);

ALTER TABLE OBJETO
  ADD CONSTRAINT fk_objeto_coleccion
  FOREIGN KEY (id_coleccion)
  REFERENCES COLECCION(id_coleccion);

ALTER TABLE OBJETO
  ADD CONSTRAINT fk_objeto_repositorio
  FOREIGN KEY (id_repositorio)
  REFERENCES REPOSITORIO(id_repositorio);

ALTER TABLE AUDIO
  ADD CONSTRAINT fk_audio_objeto
  FOREIGN KEY (id_coleccion, id_objeto)
  REFERENCES OBJETO(id_coleccion, id_objeto);

ALTER TABLE VIDEO
  ADD CONSTRAINT fk_video_objeto
  FOREIGN KEY (id_coleccion, id_objeto)
  REFERENCES OBJETO(id_coleccion, id_objeto);

ALTER TABLE DOCUMENTO
  ADD CONSTRAINT fk_audio_documento
  FOREIGN KEY (id_coleccion, id_objeto)
  REFERENCES OBJETO(id_coleccion, id_objeto);

