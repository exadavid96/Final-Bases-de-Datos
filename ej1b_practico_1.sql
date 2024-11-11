DROP TABLE IF EXISTS EJEMPLAR, LIBRO CASCADE;

CREATE TABLE EJEMPLAR(
    Libro_ISBN varchar NOT NULL,
    NumeroEjemplar int NOT NULL,
    EsPrestable bit NOT NULL,
    EstaDisponible bit NOT NULL,
    CONSTRAINT pk_ejemplar PRIMARY KEY(Libro_ISBN, NumeroEjemplar)
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

ALTER TABLE EJEMPLAR
 ADD CONSTRAINT fk_ejemplar_libro
 FOREIGN KEY(Libro_ISBN)
 REFERENCES LIBRO(ISBN);

