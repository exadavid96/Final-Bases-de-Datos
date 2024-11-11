DROP TABLE IF EXISTS AUTOR, LIBRO, ES_AUTOR CASCADE;

CREATE TABLE AUTOR(
    CodAutor int NOT NULL,
    Apellido varchar NOT NULL,
    Nombre varchar NOT NULL,
    Nacionalidad varchar NOT NULL,
    CONSTRAINT pk_autor PRIMARY KEY(CodAutor)
);

CREATE TABLE LIBRO(
    ISBN char NOT NULL,
    titulo varchar NOT NULL,
    FechaEdicion date NOT NULL,
    NumeroEdicion int NOT NULL,
    LugarEdicion varchar NOT NULL,
    NombreGenero varchar NOT NULL,
    NombreSubGenero varchar,
    CONSTRAINT pk_libro PRIMARY KEY(ISBN)
);

CREATE TABLE ES_AUTOR(
    CodAutor int NOT NULL,
    ISBN char NOT NULL,
    CONSTRAINT pk_es_autor PRIMARY KEY(CodAutor, ISBN)
);

ALTER TABLE ES_AUTOR
  ADD CONSTRAINT fk_es_autor_autor
  FOREIGN KEY(CodAutor)
  REFERENCES AUTOR(CodAutor);

ALTER TABLE ES_AUTOR
  ADD CONSTRAINT fk_es_autor_libro
  FOREIGN KEY(ISBN)
  REFERENCES LIBRO(ISBN);
