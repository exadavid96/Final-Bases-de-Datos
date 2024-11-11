DROP TABLE IF EXISTS PRODUCTO, PROVEE, SUCURSAL, PROVEEDOR CASCADE;

CREATE TABLE PRODUCTO(
    cod_prod int NOT NULL,
    descripcion varchar(40) NOT NULL,
    tipo char(10) NOT NULL ,
    CONSTRAINT pk_producto PRIMARY KEY(cod_prod)
);

CREATE TABLE PROVEE(
    cod_prod int NOT NULL ,
    cod_prov int NOT NULL ,
    cod_suc int ,
    CONSTRAINT pk_provee PRIMARY KEY (cod_prod, cod_prov)
);

CREATE TABLE SUCURSAL(
    cod_suc int NOT NULL ,
    nombre varchar(40) NOT NULL ,
    localidad varchar(30) NOT NULL ,
    CONSTRAINT pk_sucursal PRIMARY KEY (cod_suc)
);

CREATE TABLE PROVEEDOR(
    cod_prov int NOT NULL ,
    razon_social varchar(40) NOT NULL ,
    calle varchar(60) NOT NULL ,
    altura int NOT NULL ,
    piso_depto varchar(10) NOT NULL ,
    ciudad varchar(30) NOT NULL ,
    fecha_nac  date NOT NULL ,
    CONSTRAINT pk_proveedor PRIMARY KEY (cod_prov)
);

ALTER TABLE PROVEE
   ADD CONSTRAINT fk_provee_producto
   FOREIGN KEY (cod_prod)
   REFERENCES PRODUCTO(cod_prod);

ALTER TABLE PROVEE
   ADD CONSTRAINT fk_provee_sucursal
   FOREIGN KEY (cod_suc)
   REFERENCES SUCURSAL(cod_suc);

ALTER TABLE PROVEE
   ADD CONSTRAINT fk_provee_proveedor
   FOREIGN KEY (cod_prov)
   REFERENCES PROVEEDOR(cod_prov);