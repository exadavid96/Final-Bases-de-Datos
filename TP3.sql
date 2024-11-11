DROP TABLE Empleado, Proyecto

CREATE TABLE Empleado(
    id int NOT NULL ,
    nombre varchar NOT NULL ,
    proyecto int NOT NULL ,
    CONSTRAINT pk_empleado PRIMARY KEY (id)
);

CREATE TABLE Proyecto(
    id int NOT NULL ,
    nombre varchar NOT NULL ,
    CONSTRAINT pk_proyecto PRIMARY KEY (id)
);

ALTER TABLE Empleado
ADD CONSTRAINT fk_proyecto_empleado
FOREIGN KEY (proyecto)
REFERENCES Proyecto(id)
ON DELETE CASCADE;

INSERT INTO Empleado values(1, 'E1', 101);
INSERT INTO Empleado values(2, 'E2', 101);

INSERT INTO Proyecto values(101, 'PP');
INSERT INTO Proyecto values(102, 'QQ');

SELECT * FROM Empleado;
SELECT * FROM Proyecto;


DELETE FROM Proyecto WHERE id = 101

/*
  -------------------------------------  Ejercicio 1 a -------------------------------------------------------------
  ALTER TABLE TRABAJA_EN
  ADD CONSTRAINT fk_trabaja_en_empleado
  FOREIGN KEY (TipoE, NroE)
  REFERENCES EMPLEADO(TipoE, NroE)
  ON DELETE CASCADE
  ON UPDATE RESTRICT

  ALTER TABLE TRABAJA_EN
  ADD CONSTRAINT fk_trabaja_en_proyecto
  FOREIGN KEY (IdProy)
  REFERENCES PROYECTO(IdProy)
  ON DELETE RESTRICT
  ON UPDATE CASCADE

  ALTER TABLE AUSPICIO
  ADD CONSTRAINT fk_auspicio_proyecto
  FOREIGN KEY(IdProy)
  REFERENCES PROYECTO(IdProy)
  ON DELETE RESTRICT
  ON UPDATE RESTRICT

  ALTER TABLE AUSPICIO
  ADD CONSTRAINT fk_auspicio_empleado
  FOREIGN KEY(TipoE, NroE)
  REFERENCES EMPLEADO(TipoE, NroE)
  ON DELETE SET NULL
  ON UPDATE RESTRICT
*/

 /*
    -------------------------------------  Ejercicio 1 b -------------------------------------------------------------
    EMPLEADO:               PROYECTO:           AUSPICIO:           TRABAJA_EN
    (A, 1, ....)            (1, ....)           (2, ...., A, 2)     (A, 1, 1)
    (B, 2, ....)            (2, ....)                               (A, 2, 2)
    (A, 2, ....)            (3, ....)

    DELETE FROM PROYECTO
    WHERE IdProy = 3

    Se acepta, porque porque el IdProy = 3 no es referenciado en Auspicio ni en Trabaja_En
     EMPLEADO:               PROYECTO:           AUSPICIO:           TRABAJA_EN
    (A, 1, ....)            (1, ....)           (2, ...., A, 2)     (A, 1, 1)
    (B, 2, ....)            (2, ....)                               (A, 2, 2)
    (A, 2, ....)


    UPDATE PROYECTO SET IdProy = 7
    WHERE IdProy = 3

    Idem anterior, se cambia IdProy a 7

    EMPLEADO:               PROYECTO:           AUSPICIO:           TRABAJA_EN
    (A, 1, ....)            (1, ....)           (2, ...., A, 2)     (A, 1, 1)
    (B, 2, ....)            (2, ....)                               (A, 2, 2)
    (A, 2, ....)            (7, ....)

    DELETE FROM PROYECTO
    WHERE IdProy = 1;

    Tiene referencia con la tupla (A, 1, 1) de TRABAJA_EN . Pero como la accion referencial es RESTRICT, no se elimina

    DELETE FROM EMPLEADO
    WHERE TipoE = 'A' AND IdProy = 2;

    Tiene referencia con la tupla (A, 2, 2) de TRABAJA_EN y con la tupla (2, ...., A, 2)
    Como ninguna es restrictiva de eliminacion, se elimina la tupla en EMPLEADO.

    EMPLEADO:               PROYECTO:           AUSPICIO:           TRABAJA_EN
    (A, 1, ....)            (1, ....)           (2, ...., A, 2)     (A, 1, 1)
    (B, 2, ....)            (2, ....)                               (A, 2, 2)
                            (3, ....)

    Caso SET NULL: pone NULL en la FK de Auspicio:

     EMPLEADO:               PROYECTO:           AUSPICIO:                TRABAJA_EN
     (A, 1, ....)            (1, ....)           (2, ...., NULL, NULL)     (A, 1, 1)
     (B, 2, ....)            (2, ....)                                     (A, 2, 2)
                             (3, ....)

    Caso CASCADE: Antes de eliminar (A, 2, 2), se chequea si esta referenciando a otra RIR.
    La tupla referencia a la tupla (2, ....) de Proyecto, que posee Restrict en la eliminacion.
    Por lo tanto, no se elimina la tupla (A, 2, 2)

    UPDATE TRABAJA_EN SET IdProy = 3
    WHERE IdProy = 1;

    Como TRABAJA_EN es referenciante de Proyecto, debe existir el IdProy = 3.
    Como existe, se hace el cambio en la tupla (A, 1, 1)

    EMPLEADO:               PROYECTO:           AUSPICIO:           TRABAJA_EN
    (A, 1, ....)            (1, ....)           (2, ...., A, 2)     (A, 1, 3)
    (B, 2, ....)            (2, ....)                               (A, 2, 2)
    (A, 2, ....)            (3, ....)

    UPDATE PROYECTO SET IdProy = 5
    WHERE IdProy = 2;

    Hay referencias con Auspicio (2, ...., A, 2) y con Trabaja_En ( A, 2, 2 )
    Como una de las referencias tiene restriccion de update en Restrict, no se puede proceder con la actualizacion

    -------------------------------------  Ejercicio 1 c -------------------------------------------------------------

    INSERT INTO AUSPICIO VALUES(1, 'Dell', 'B', null)
    Procede Simple | Partial

    INSERT INTO AUSPICIO VALUES(2, 'Oracle', null , null)
    Procede Simple | Partial | Full

    INSERT INTO AUSPICIO VALUES(3, 'Google', A, 3)
    No procede ninguna

    INSERT INTO AUSPICIO VALUES (1, 'HP', null, 3)
    Procede Simple

*/
   -- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2020-09-24 19:20:52.273

-- tables
-- Table: TP5_P1_EJ2_AUSPICIO
CREATE TABLE TP5_P1_EJ2_AUSPICIO (
    id_proyecto int  NOT NULL,
    nombre_auspiciante varchar(20)  NOT NULL,
    tipo_empleado char(2)  NULL,
    nro_empleado int  NULL,
    CONSTRAINT TP5_P1_EJ2_AUSPICIO_pk PRIMARY KEY (id_proyecto,nombre_auspiciante)
);

-- Table: TP5_P1_EJ2_EMPLEADO
CREATE TABLE TP5_P1_EJ2_EMPLEADO (
    tipo_empleado char(2)  NOT NULL,
    nro_empleado int  NOT NULL,
    nombre varchar(40)  NOT NULL,
    apellido varchar(40)  NOT NULL,
    cargo varchar(15)  NOT NULL,
    CONSTRAINT TP5_P1_EJ2_EMPLEADO_pk PRIMARY KEY (tipo_empleado,nro_empleado)
);

-- Table: TP5_P1_EJ2_PROYECTO
CREATE TABLE TP5_P1_EJ2_PROYECTO (
    id_proyecto int  NOT NULL,
    nombre_proyecto varchar(40)  NOT NULL,
    anio_inicio int  NOT NULL,
    anio_fin int  NULL,
    CONSTRAINT TP5_P1_EJ2_PROYECTO_pk PRIMARY KEY (id_proyecto)
);

-- Table: TP5_P1_EJ2_TRABAJA_EN
CREATE TABLE TP5_P1_EJ2_TRABAJA_EN (
    tipo_empleado char(2)  NOT NULL,
    nro_empleado int  NOT NULL,
    id_proyecto int  NOT NULL,
    cant_horas int  NOT NULL,
    tarea varchar(20)  NOT NULL,
    CONSTRAINT TP5_P1_EJ2_TRABAJA_EN_pk PRIMARY KEY (tipo_empleado,nro_empleado,id_proyecto)
);

-- foreign keys
-- Reference: FK_TP5_P1_EJ2_AUSPICIO_EMPLEADO (table: TP5_P1_EJ2_AUSPICIO)
ALTER TABLE TP5_P1_EJ2_AUSPICIO ADD CONSTRAINT FK_TP5_P1_EJ2_AUSPICIO_EMPLEADO
    FOREIGN KEY (tipo_empleado, nro_empleado)
    REFERENCES TP5_P1_EJ2_EMPLEADO (tipo_empleado, nro_empleado)
	MATCH FULL
    ON DELETE  SET NULL
    ON UPDATE  SET NULL
;

ALTER TABLE TP5_P1_EJ2_AUSPICIO
DROP CONSTRAINT FK_TP5_P1_EJ2_AUSPICIO_EMPLEADO;

-- Reference: FK_TP5_P1_EJ2_AUSPICIO_PROYECTO (table: TP5_P1_EJ2_AUSPICIO)
ALTER TABLE TP5_P1_EJ2_AUSPICIO ADD CONSTRAINT FK_TP5_P1_EJ2_AUSPICIO_PROYECTO
    FOREIGN KEY (id_proyecto)
    REFERENCES TP5_P1_EJ2_PROYECTO (id_proyecto)
    ON DELETE  RESTRICT
    ON UPDATE  RESTRICT
;

-- Reference: FK_TP5_P1_EJ2_TRABAJA_EN_EMPLEADO (table: TP5_P1_EJ2_TRABAJA_EN)
ALTER TABLE TP5_P1_EJ2_TRABAJA_EN ADD CONSTRAINT FK_TP5_P1_EJ2_TRABAJA_EN_EMPLEADO
    FOREIGN KEY (tipo_empleado, nro_empleado)
    REFERENCES TP5_P1_EJ2_EMPLEADO (tipo_empleado, nro_empleado)
    ON DELETE  CASCADE
    ON UPDATE CASCADE
;

ALTER TABLE TP5_P1_EJ2_TRABAJA_EN
DROP CONSTRAINT FK_TP5_P1_EJ2_TRABAJA_EN_EMPLEADO;

-- Reference: FK_TP5_P1_EJ2_TRABAJA_EN_PROYECTO (table: TP5_P1_EJ2_TRABAJA_EN)
ALTER TABLE TP5_P1_EJ2_TRABAJA_EN ADD CONSTRAINT FK_TP5_P1_EJ2_TRABAJA_EN_PROYECTO
    FOREIGN KEY (id_proyecto)
    REFERENCES TP5_P1_EJ2_PROYECTO (id_proyecto)
    ON DELETE  RESTRICT
    ON UPDATE  CASCADE
;

-- End of file.


SELECT * FROM TP5_P1_EJ2_AUSPICIO;

INSERT INTO TP5_P1_EJ2_PROYECTO VALUES (1, 'Gato gordo', 1998, 2004 );
INSERT INTO TP5_P1_EJ2_PROYECTO VALUES (2, 'Gato gordo', 1998, 2004 );

INSERT INTO TP5_P1_EJ2_EMPLEADO VALUES ('A', 1, 'Arielito', 'Martino', 'Pelao');

INSERT INTO TP5_P1_EJ2_AUSPICIO VALUES (1, 'Messi', 'A', 1);


SELECT * FROM TP5_P1_EJ2_EMPLEADO;
SELECT * FROM TP5_P1_EJ2_PROYECTO;

SELECT * FROM TP5_P1_EJ2_AUSPICIO;

 UPDATE TP5_P1_EJ2_EMPLEADO
     SET tipo_empleado = 'Z'
     WHERE tipo_empleado = 'A'

/*
    -------------------------------------  Ejercicio 2 b TUDAI -------------------------------------------------------------

    update TP5_P1_EJ2_AUSPICIO set id_proyecto= 66, nro_empleado = 10
    where id_proyecto = 1
    and tipo_empleado = 'A'
    and nro_empleado = 1;

    Respuesta : ninguna de las anteriores, cuál?
    No se permite la actualizacion porque no existe el id_proyecto 66 en Proyecto ni
    el nro_empleado 10 en Empleado. Viola ambas RIR de la referenciante a la referenciada
*/


/*
     ----------------------------------------- Ejercicio 2 ------------------------------------------------------------------

     CLIENTE                                   SERVICIO
     Zona   NroC   Nombre      Ciudad          IdServ   NomServ   AnioComienzo  AnioFinal
       A     1     Juan Ro       C1              S1      Serv1        2010         2012
       A     2     Alberto Efe   C1              S2      Serv2        2012         2012
       B     1     Esteban Hache C1              S3      Serv3        2009           N
       C     2     Jose Ge       C3
       D     3     Luis Ene      C2

     INSTALACION                                        REFERENCIA
     Zona  NroC  IdServ Mes Anio CantHoras Tarea        IdServ   Motivo        Zona  NroC
       A    1       S1   5  2011     5       T1           S1     Puntualidad    D     3
       B    1       S2   5  2012     7       T1           S2     Calidad inst.  C     2
       C    2       S1   4  2010     9       T2           S3     Costo          C     2
       A    2       S3   8  2009     6       T2           S1     Atencion       D     3

      DELETE FROM CLIENTE
      WHERE NroC = 1

      Cliente es referenciada por las RIRs R1 y R4. Con R1 se puede eliminar en Cascada, y con R4 no se puede eliminar
      si hay referencia de las tuplas a eliminar. Como el restrict manda, primero hay que revisar si hay tuplas
      involucradas en Referencia. Como no las hay, se puede eliminar.

      Luego de la eliminacion quedaria:

      CLIENTE                                   SERVICIO
      Zona   NroC   Nombre      Ciudad          IdServ   NomServ   AnioComienzo  AnioFinal
       A     2     Alberto Efe   C1              S1      Serv1        2010         2012
       C     2     Jose Ge       C3              S2      Serv2        2012         2012
       D     3     Luis Ene      C2              S3      Serv3        2009           N



     INSTALACION                                        REFERENCIA
     Zona  NroC  IdServ Mes Anio CantHoras Tarea        IdServ   Motivo        Zona  NroC
       A    1       S1   5  2011     5       T1           S1     Puntualidad    D     3
       B    1       S2   5  2012     7       T1           S2     Calidad inst.  C     2
       C    2       S1   4  2010     9       T2           S3     Costo          C     2
       A    2       S3   8  2009     6       T2           S1     Atencion       D     3

      Ahora, como la R1 era en cascada, y hay tuplas en INSTALACION con referencia de las recien eliminadas, se podrian
      eliminar de esta tabla. De hecho, INSTALACION no es referenciada por nadie, asi que se puede eliminar con
      seguridad:

      CLIENTE                                   SERVICIO
      Zona   NroC   Nombre      Ciudad          IdServ   NomServ   AnioComienzo  AnioFinal
       A     2     Alberto Efe   C1              S1      Serv1        2010         2012
       C     2     Jose Ge       C3              S2      Serv2        2012         2012
       D     3     Luis Ene      C2              S3      Serv3        2009           N



     INSTALACION                                        REFERENCIA
     Zona  NroC  IdServ Mes Anio CantHoras Tarea        IdServ   Motivo        Zona  NroC
       C    2       S1   4  2010     9       T2           S1     Puntualidad    D     3
       A    2       S3   8  2009     6       T2           S2     Calidad inst.  C     2
                                                          S3     Costo          C     2
                                                          S1     Atencion       D     3

     UPDATE INSTALACION
     SET IdServ = 'S5'
     WHERE  IdServ = S2

    Luego de la eliminacion anterior, no quedaron tuplas que cumplan con la condicion, asi que no hay cambios

     UPDATE CLIENTE
     SET Zona = 'Z'
     WHERE Zona = 'D'

     En Cliente hay una zona D, por lo que hay para actualizar. Al ser referenciada por Instalacion y Referencia,
     En R1 es restricta la actualizacion, pero como no hay tuplas en instalacion con zona D, se puede.
     En R4 es set null, y hay dos tuplas en Referencia con Zona D. Por lo tanto, se puede actualizar la zona a Z,
     sin haber cambios en Instalacion y se setea NULL en Referencia:

      CLIENTE                                   SERVICIO
      Zona   NroC   Nombre      Ciudad          IdServ   NomServ   AnioComienzo  AnioFinal
       A     2     Alberto Efe   C1              S1      Serv1        2010         2012
       C     2     Jose Ge       C3              S2      Serv2        2012         2012
       Z     3     Luis Ene      C2              S3      Serv3        2009           N



     INSTALACION                                        REFERENCIA
     Zona  NroC  IdServ Mes Anio CantHoras Tarea        IdServ   Motivo        Zona  NroC
       C    2       S1   4  2010     9       T2           S1     Puntualidad    N     3
       A    2       S3   8  2009     6       T2           S2     Calidad inst.  C     2
                                                          S3     Costo          C     2
                                                          S1     Atencion       N     3
 */



   ------------------------------------ Ejercicio 3 ---------------------------------------------------------------

    /*
    a)
    Restriccion: chk_nacionalidad_articulo
    Tabla: Articulo
    Atributo/s : nacionalidad
    Tipo Restriccion: atributo

    ALTER TABLE ARTICULO
    ADD CONSTRAINT chk_nacionalidad_articulo
    CHECK ( nacionalidad IN ('Argentina', 'Español','Inglesa', 'Alemana', 'Chilena' )

    b)
    Restriccion: chk_fecha_publicacion_superior
    Tabla: Articulo
    Atributo/s : fecha_pub
    Tipo Restriccion: atributo

    ALTER TABLE ARTICULO
    ADD CONSTRAINT chk_fecha_publicacion_superior
    CHECK ( EXTRACT( year from fecha_pub ) >= 2010 )

    c)
    Restriccion: chk_fecha_publicacion_superior_argentina
    Tabla: Articulo
    Atributo/s : fecha_pub, nacionalidad
    Tipo Restriccion: tupla

    ALTER TABLE ARTICULO
    ADD CONSTRAINT chk_fecha_publicacion_superior_argentina
    CHECK ( EXTRACT(year from fecha_pub) > 2017 AND nacionalidad LIKE 'Argentina'
            OR EXTRACT(year from fecha_pub) <=2017
           )

    */


   ------------------------------------ Ejercicio 5 ---------------------------------------------------------------


   /*
   a)
   Restriccion: chk_edad_voluntario
   Tabla: Voluntario
   Atributo/s : fecha_nacimiento
   Tipo Restriccion: atributo

   ALTER TABLE voluntario
   ADD CONSTRAINT chk_edad_voluntario
   CHECK ( EXTRACT( year from AGE(fecha_nacimiento) ) <= 70);

   b)
   Restriccion: chk_horas_voluntario_coordinador
   Tabla: Voluntario
   Atributo/s : horas_aportadas, id_coordinador, nro_voluntario
   Tipo Restriccion: Tabla

   ALTER TABLE voluntario
   ADD CONSTRAINT chk_horas_voluntario_coordinador
   CHECK ( NOT EXISTS (SELECT 1
                    FROM voluntario v
                    WHERE v.horas_aportadas > (SELECT v1.horas_aportadas
                                               FROM voluntario v1
                                               WHERE v.id_coordinador = v1.nro_voluntario))
    )
   c)
   Restriccion: rango_tarea_horas_aportadas
   Tabla: Voluntario, Tarea
   Atributo/s : horas_aportadas, min_horas, max_horas
   Tipo Restriccion: Base de Datos

    CREATE ASSERTION rango_tarea_horas_aportadas
    CHECK ( NOT EXISTS (
        SELECT 1
        FROM voluntario v
        JOIN tarea t ON v.id_tarea = t.id_tarea
        WHERE v.horas_aportadas NOT BETWEEN t.min_horas AND t.max_horas
        )
    )
   d)
   Restriccion: chk_tarea_voluntario_coordinador
   Tabla: Voluntario
   Atributo/s : id_tarea, id_coordinador, nro_voluntario
   Tipo Restriccion: Tabla

   ALTER TABLE voluntario
   ADD CONSTRAINT chk_tarea_voluntario_coordinador
   CHECK ( NOT EXISTS (
      SELECT 1
      FROM voluntario v
      WHERE v.id_tarea <> (
          SELECT v1.id_tarea
          FROM voluntario v1
          WHERE v.id_coordinador = v1.nro_voluntario
      )
   )
   e)
   Restriccion: chk_cambio_institucion_voluntarios
   Tabla: Historico
   Atributo/s : nro_voluntario, fecha_fin
   Tipo Restriccion: Tabla

   ALTER TABLE historico
   ADD CONSTRAINT chk_cambio_institucion_voluntarios
   CHECK ( NOT EXISTS (
       SELECT 1 FROM historico
       WHERE id_institucion IS NOT NULL
       GROUP BY nro_voluntario, EXTRACT (year from fecha_fin)
       HAVING COUNT(*) > 3
       )
    )
     f) TUDAI
     Restriccion: chk_correctitud_rango_fechas
     Tabla: Historico
     Atributo/s : fecha_inicio, fecha_fin
     Tipo Restriccion: Tupla

     ALTER TABLE historico
     ADD CONSTRAINT heroe
     CHECK( fecha_inicio < fecha_fin)
   */

 ------------------------------------ Ejercicio 2 TUDAI ---------------------------------------------------------------

 /*
   a)
   Restriccion: chk_correctitud_rango_sueldos
   Tabla: Tarea
   Atributo/s : sueldo_min, sueldo_max
   Tipo Restriccion: Tupla

   ALTER TABLE tarea
   ADD CONSTRAINT chk_correctitud_rango_sueldos
   CHECK ( sueldo_max > sueldo_min );


   b)
   Restriccion: chk_limite_empleados_departamento
   Tabla: Empleado
   Atributo/s : id_departamento
   Tipo Restriccion: Tabla


   ALTER TABLE EMPLEADO
   ADD CONSTRAINT chk_limite_empleados_departamento
   CHECK( NOT EXISTS (
        SELECT 1
        FROM empleado e
        GROUP BY e.id_departamento
        HAVING COUNT(*) > 70
      )
   )

   c)
   Restriccion: chk_mismo_dep_empleado_jefe
   Tabla: Empleado
   Atributo/s : id_departamento, id_empleado, id_jefe
   Tipo Restriccion: Tabla

   ALTER TABLE EMPLEADO
   ADD CONSTRAINT chk_mismo_dep_empleado_jefe
   CHECK ( NOT EXISTS (
       SELECT 1
       FROM EMPLEADO e
       WHERE e.id_departamento <> (
           SELECT e1.id_departamento
           FROM EMPLEADO e1
           WHERE e.id_jefe = e1.id_empleado
       )
   )

   d)

   e) Restriccion: chk_limite_empresa_ciudad
      Tabla: Empresa_Productora
      Atributo/s :
      Tipo Restriccion: Tabla


      ALTER TABLE EMPLEADO
      ADD CONSTRAINT chk_limite_empresa_ciudad
      CHECK( NOT EXISTS (
        SELECT 1
        FROM empresa_productora e
        GROUP BY e.id_ciudad
        HAVING COUNT(*) > 10
      )
   )

   ------------------------------------ Ejercicio 4 ---------------------------------------------------------------

   1) Cada proveedor no puede proveer mas de 20 productos
   ALTER TABLE PROVEE
   ADD CONSTRAINT chk_proveedor_lim_prod
   CHECK ( NOT EXISTS (
      SELECT nro_proveedor
      FROM PROVEE
      GROUP BY nro_proveedor
      HAVING COUNT(*) > 20
   ) )

   2) Los codigos de sucursal deben comenzar con el string 'S_'
   ALTER TABLE sucursal
   ADD CONSTRAINT chk_prefijo_suc
   CHECK ( cod_suc LIKE 'S%' )

   3) La descripcion y la presentacion de un producto no pueden ser ambas nulas
   ALTER TABLE producto
   ADD CONSTRAINT chk_nulidad_prod
   CHECK( NOT ( presentacion IS NULL AND descripcion IS NULL ) )

   4) Cada proveedor solo puede proveer productos a sucursales de su localidad
   CREATE ASSERTION chk_proveedor_localidad_sucursal
   CHECK ( NOT EXISTS (
        SELECT 1
        FROM proveedor p
        JOIN provee pr ON p.nro_prov = pr.nro_prov
        JOIN sucursal s ON pr.cod_suc = s.cod_suc
        WHERE p.localidad <> s.localidad
     )
   )


 */

