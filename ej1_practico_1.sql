DROP TABLE IF EXISTS ARTICULO, PALABRA, CONTIENE CASCADE;

CREATE TABLE ARTICULO(
  id_articulo int4 NOT NULL,
  titulo varchar(120) NOT NULL,
  autor varchar(30) NOT NULL,
  fecha_pub date NOT NULL,
  CONSTRAINT pk_articulo PRIMARY KEY(id_articulo));

CREATE TABLE PALABRA(
  cod_p int4 NOT NULL,
  idioma char(2) NOT NULL,
  descripcion varchar(25) NOT NULL,
  CONSTRAINT pk_palabra PRIMARY KEY(cod_p,idioma));

CREATE TABLE CONTIENE(
  id_articulo int4 NOT NULL,
  cod_p int4 NOT NULL,
  idioma char(2) NOT NULL,
  CONSTRAINT pk_contiene PRIMARY KEY(id_articulo,cod_p,idioma));

ALTER TABLE CONTIENE
  ADD CONSTRAINT fk_contiene_articulo
  FOREIGN KEY(id_articulo)
  REFERENCES ARTICULO(id_articulo);

ALTER TABLE CONTIENE
  ADD CONSTRAINT fk_contiene_palabra
  FOREIGN KEY (cod_p, idioma)
  REFERENCES PALABRA(cod_p, idioma);

INSERT INTO ARTICULO VALUES (1, 'El corazon delator', 'Umberto Eco', '1996/11/14');
INSERT INTO ARTICULO VALUES (2, 'Metamorfosis', 'Franz Kafka', '1934/01/11');
INSERT INTO ARTICULO VALUES (3, 'La iliada', 'Homero', '234/03/08');
INSERT INTO ARTICULO VALUES (4, 'You', 'Sandra Kafnes', '2021/09/24');

INSERT INTO PALABRA VALUES (1, 'ES', 'Prueba en espaniol');
INSERT INTO PALABRA VALUES (1, 'EN', 'Test in english');
INSERT INTO PALABRA VALUES (2, 'ES', 'Prueba 2 en espaniol');
INSERT INTO PALABRA VALUES (2, 'EN', 'Test 2 in english');

INSERT INTO CONTIENE VALUES (1, 1, 'ES');
INSERT INTO CONTIENE VALUES (4, 1, 'EN');
INSERT INTO CONTIENE VALUES (2, 1, 'EN');

SELECT * FROM ARTICULO;

SELECT * FROM PALABRA;

SELECT * FROM CONTIENE;

