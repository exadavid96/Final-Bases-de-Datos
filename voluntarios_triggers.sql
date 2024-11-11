----------------------------------------------------------------------
--- Creación de Tablas
----------------------------------------------------------------------

drop table if exists voluntario cascade;
drop table if exists historico cascade;
drop table if exists institucion cascade;
drop table if exists voluntario cascade;
drop table if exists tarea cascade;
drop table if exists direccion cascade;
drop table if exists pais cascade;
drop table if exists continente cascade;

----------------------------------------------------------------------

CREATE TABLE tarea (
    nombre_tarea character varying(40) NOT NULL,
    min_horas numeric(6,0),
    id_tarea character varying(10) NOT NULL,
    max_horas numeric(6,0)
)
WITH (autovacuum_enabled='true');

--
-- Name: voluntario; Type: TABLE; Schema: unc_esq_voluntario; Owner: postgres
--

CREATE TABLE voluntario (
    nombre character varying(20),
    apellido character varying(25) NOT NULL,
    e_mail character varying(40) NOT NULL,
    telefono character varying(20),
    fecha_nacimiento date NOT NULL,
    id_tarea character varying(10) NOT NULL,
    nro_voluntario numeric(6,0) NOT NULL,
    horas_aportadas numeric(8,2),
    porcentaje numeric(2,2),
    id_institucion numeric(4,0),
    id_coordinador numeric(6,0),
    CONSTRAINT chk_hs_ap CHECK ((horas_aportadas > (0)::numeric)),
    CONSTRAINT ck_horas_aportadas CHECK (((horas_aportadas <= (24000)::numeric) AND (id_coordinador < (206)::numeric)))
)
WITH (autovacuum_enabled='true');

--
-- Name: continente; Type: TABLE; Schema: unc_esq_voluntario; Owner: postgres
--

CREATE TABLE continente (
    nombre_continente character varying(25),
    id_continente numeric NOT NULL
)
WITH (autovacuum_enabled='true');

--
-- Name: direccion; Type: TABLE; Schema: unc_esq_voluntario; Owner: postgres
--

CREATE TABLE direccion (
    calle character varying(40),
    codigo_postal character varying(12),
    ciudad character varying(30) NOT NULL,
    provincia character varying(25),
    id_pais character(2) NOT NULL,
    id_direccion numeric(4,0) NOT NULL
)
WITH (autovacuum_enabled='true');

--
-- Name: historico; Type: TABLE; Schema: unc_esq_voluntario; Owner: postgres
--

CREATE TABLE historico (
    fecha_inicio date NOT NULL,
    nro_voluntario numeric(6,0) NOT NULL,
    fecha_fin date NOT NULL,
    id_tarea character varying(10) NOT NULL,
    id_institucion numeric(4,0),
    CONSTRAINT historico_check CHECK ((fecha_fin > fecha_inicio))
)
WITH (autovacuum_enabled='true');

--
-- Name: institucion; Type: TABLE; Schema: unc_esq_voluntario; Owner: postgres
--

CREATE TABLE institucion (
    nombre_institucion character varying(60) NOT NULL,
    id_director numeric(6,0),
    id_direccion numeric(4,0),
    id_institucion numeric(4,0) NOT NULL
)
WITH (autovacuum_enabled='true');

--
-- Name: pais; Type: TABLE; Schema: unc_esq_voluntario; Owner: postgres
--

CREATE TABLE pais (
    nombre_pais character varying(40),
    id_continente numeric NOT NULL,
    id_pais character(2) NOT NULL
)
WITH (autovacuum_enabled='true');

--
-- Data for Name: continente; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: postgres
--

INSERT INTO continente VALUES ('Europeo', 1);
INSERT INTO continente VALUES ('Norte Americano', 2);
INSERT INTO continente VALUES ('Asiatico', 3);
INSERT INTO continente VALUES ('Africano', 4);
INSERT INTO continente VALUES ('Sud Americano', 5);
INSERT INTO continente VALUES ('Oceania', 6);

--
-- Data for Name: direccion; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: postgres
--

INSERT INTO direccion VALUES ('1297 Via Cola di Rie', '00989', 'Roma', NULL, 'IT', 1000);
INSERT INTO direccion VALUES ('93091 Calle della Testa', '10934', 'Venice', NULL, 'IT', 1100);
INSERT INTO direccion VALUES ('2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo Prefecture', 'JP', 1200);
INSERT INTO direccion VALUES ('9450 Kamiya-cho', '6823', 'Hiroshima', NULL, 'JP', 1300);
INSERT INTO direccion VALUES ('2014 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US', 1400);
INSERT INTO direccion VALUES ('2011 Interiors Blvd', '99236', 'South San Francisco', 'California', 'US', 1500);
INSERT INTO direccion VALUES ('2007 Zagora St', '50090', 'South Brunswick', 'New Jersey', 'US', 1600);
INSERT INTO direccion VALUES ('2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US', 1700);
INSERT INTO direccion VALUES ('147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA', 1800);
INSERT INTO direccion VALUES ('6092 Boxwood St', 'YSW 9T2', 'Whitehorse', 'Yukon', 'CA', 1900);
INSERT INTO direccion VALUES ('40-5-12 Laogianggen', '190518', 'Beijing', NULL, 'CN', 2000);
INSERT INTO direccion VALUES ('1298 Vileparle (E)', '490231', 'Bombay', 'Maharashtra', 'IN', 2100);
INSERT INTO direccion VALUES ('12-98 Victoria Street', '2901', 'Sydney', 'New South Wales', 'AU', 2200);
INSERT INTO direccion VALUES ('198 Clementi North', '540198', 'Singapore', NULL, 'SG', 2300);
INSERT INTO direccion VALUES ('8204 Arthur St', NULL, 'London', NULL, 'UK', 2400);
INSERT INTO direccion VALUES ('Magdalen Centre, The Oxford Science Park', 'OX9 9ZB', 'Oxford', 'Oxford', 'UK', 2500);
INSERT INTO direccion VALUES ('9702 Chester Road', '09629850293', 'Stretford', 'Manchester', 'UK', 2600);
INSERT INTO direccion VALUES ('Schwanthalerstr. 7031', '80925', 'Munich', 'Bavaria', 'DE', 2700);
INSERT INTO direccion VALUES ('Rua Frei Caneca 1360 ', '01307-002', 'Sao Paulo', 'Sao Paulo', 'BR', 2800);
INSERT INTO direccion VALUES ('20 Rue des Corps-Saints', '1730', 'Geneva', 'Geneve', 'CH', 2900);
INSERT INTO direccion VALUES ('Murtenstrasse 921', '3095', 'Bern', 'BE', 'CH', 3000);
INSERT INTO direccion VALUES ('Pieter Breughelstraat 837', '3029SK', 'Utrecht', 'Utrecht', 'NL', 3100);
INSERT INTO direccion VALUES ('Mariano Escobedo 9991', '11932', 'Mexico City', 'Distrito Federal,', 'MX', 3200);

--
-- Data for Name: historico; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: postgres
--

INSERT INTO historico VALUES ('1993-01-13', 102, '1998-07-24', 'IT_PROG', 60);
INSERT INTO historico VALUES ('1989-09-21', 101, '1993-10-27', 'AC_ACCOUNT', 110);
INSERT INTO historico VALUES ('1993-10-28', 101, '1997-03-15', 'AC_MGR', 110);
INSERT INTO historico VALUES ('1996-02-17', 201, '1999-12-19', 'MK_REP', 20);
INSERT INTO historico VALUES ('1998-03-24', 114, '1999-12-31', 'ST_CLERK', 50);
INSERT INTO historico VALUES ('1999-01-01', 122, '1999-12-31', 'ST_CLERK', 50);
INSERT INTO historico VALUES ('1987-09-17', 200, '1993-06-17', 'AD_ASST', 90);
INSERT INTO historico VALUES ('1998-03-24', 176, '1998-12-31', 'SA_REP', 80);
INSERT INTO historico VALUES ('1999-01-01', 176, '1999-12-31', 'SA_MAN', 80);
INSERT INTO historico VALUES ('1994-07-01', 200, '1998-12-31', 'AC_ACCOUNT', 90);
INSERT INTO historico VALUES ('1970-01-06', 176, '2019-08-28', 'SA_MAN', 20);

--
-- Data for Name: institucion; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: postgres
--

INSERT INTO institucion VALUES ('CASA DE LA PROVIDENCIA', 200, 1700, 10);
INSERT INTO institucion VALUES ('CORPORACION URRACAS DE EMAUS', 201, 1800, 20);
INSERT INTO institucion VALUES ('FUNDACION CIVITAS', 114, 1700, 30);
INSERT INTO institucion VALUES ('FUNDACION LAS ROSAS DE AYUDA FRATERNA', 203, 2400, 40);
INSERT INTO institucion VALUES ('FUNDACION HOGAR DE CRISTO', 121, 1500, 50);
INSERT INTO institucion VALUES ('FUNDACION MI CASA', 103, 1400, 60);
INSERT INTO institucion VALUES ('CORPORACION SOLIDARIDAD Y DESARROLLO', 204, 2700, 70);
INSERT INTO institucion VALUES ('FUNDACION REGAZO', 145, 2500, 80);
INSERT INTO institucion VALUES ('FUNDACION ALERTA BOSQUES', 100, 1700, 90);
INSERT INTO institucion VALUES ('BOSQUEDUCA', 108, 1700, 100);
INSERT INTO institucion VALUES ('COMITE NACIONAL PRO DEFENSA DE LA FLORA Y LA FAUNA', 205, 1700, 110);
INSERT INTO institucion VALUES ('CONSEJO ECOLOGICO COMUNAL', NULL, 1700, 120);
INSERT INTO institucion VALUES ('CORPORACION AMBIENTAL', NULL, 1700, 130);
INSERT INTO institucion VALUES ('FUNDACION VIDA RURAL', NULL, 1700, 140);
INSERT INTO institucion VALUES ('CENTRO DE AYUDA MAPUCHE', NULL, 1700, 150);
INSERT INTO institucion VALUES ('SIERRAS PROTEGIDAS', NULL, 1700, 160);
INSERT INTO institucion VALUES ('CENTRO DE EDUCACION AMBIENTAL', NULL, 1700, 170);
INSERT INTO institucion VALUES ('RENACE- RED DE ACCION ECOLOGICA', NULL, 1700, 180);
INSERT INTO institucion VALUES ('Contracting', NULL, 1700, 190);
INSERT INTO institucion VALUES ('CONSEJO NACIONAL DE LA JUVENTUD', NULL, 1700, 200);
INSERT INTO institucion VALUES ('DEFENSA DE LOS DERECHOC DEL NIÑO', NULL, 1700, 210);
INSERT INTO institucion VALUES ('FUNDACION CHILDREN', NULL, 1700, 220);
INSERT INTO institucion VALUES ('CORPORACION ANGLICANA', NULL, 1700, 230);
INSERT INTO institucion VALUES ('CORPORACION EVANGELICA', NULL, 1700, 240);
INSERT INTO institucion VALUES ('CENTRO ECUMENICO', NULL, 1700, 250);
INSERT INTO institucion VALUES ('FUNDACION MARISTA PARA LA SOLIDARIDAD', NULL, 1700, 260);
INSERT INTO institucion VALUES ('FUNDACION VIDA', NULL, 1700, 270);

--
-- Data for Name: pais; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: postgres
--

INSERT INTO pais VALUES ('Italia', 1, 'IT');
INSERT INTO pais VALUES ('Japon', 3, 'JP');
INSERT INTO pais VALUES ('Estados Unidos', 2, 'US');
INSERT INTO pais VALUES ('Canada', 2, 'CA');
INSERT INTO pais VALUES ('China', 3, 'CN');
INSERT INTO pais VALUES ('India', 3, 'IN');
INSERT INTO pais VALUES ('Australia', 3, 'AU');
INSERT INTO pais VALUES ('Zimbabwe', 4, 'ZW');
INSERT INTO pais VALUES ('Singapor', 3, 'SG');
INSERT INTO pais VALUES ('Reino Unido', 1, 'UK');
INSERT INTO pais VALUES ('Francia', 1, 'FR');
INSERT INTO pais VALUES ('Alemania', 1, 'DE');
INSERT INTO pais VALUES ('Zambia', 4, 'ZM');
INSERT INTO pais VALUES ('Egipto', 4, 'EG');
INSERT INTO pais VALUES ('Brasil', 2, 'BR');
INSERT INTO pais VALUES ('Suiza', 1, 'CH');
INSERT INTO pais VALUES ('Holanda', 1, 'NL');
INSERT INTO pais VALUES ('Mexico', 2, 'MX');
INSERT INTO pais VALUES ('Kuwait', 4, 'KW');
INSERT INTO pais VALUES ('Israel', 4, 'IL');
INSERT INTO pais VALUES ('Dinamarca', 1, 'DK');
INSERT INTO pais VALUES ('Hong Kong', 3, 'HK');
INSERT INTO pais VALUES ('Nigeria', 4, 'NG');
INSERT INTO pais VALUES ('Argentina', 2, 'AR');
INSERT INTO pais VALUES ('Belgica', 1, 'BE');

--
-- Data for Name: tarea; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: postgres
--

INSERT INTO tarea VALUES ('PROMOCION', 20000, 'AD_PRES', 40000);
INSERT INTO tarea VALUES ('PREVENCION', 15000, 'AD_VP', 30000);
INSERT INTO tarea VALUES ('AISTENCIA ANCIANOS', 3000, 'AD_ASST', 6000);
INSERT INTO tarea VALUES ('FORESTACION', 8200, 'FI_MGR', 16000);
INSERT INTO tarea VALUES ('PLANTACION', 4200, 'FI_ACCOUNT', 9000);
INSERT INTO tarea VALUES ('ORG.CAMPAÑAS LIMPIEZA', 8200, 'AC_MGR', 16000);
INSERT INTO tarea VALUES ('FISCALIZACION DE RECURSOS NATURALES', 4200, 'AC_ACCOUNT', 9000);
INSERT INTO tarea VALUES ('CLASES ESPECIALES', 10000, 'SA_MAN', 20000);
INSERT INTO tarea VALUES ('ORGANIZACION CAMPAMENTOS RECREATIVOS', 6000, 'SA_REP', 12000);
INSERT INTO tarea VALUES ('ORGANIZACION DE COLECTAS', 8000, 'PU_MAN', 15000);
INSERT INTO tarea VALUES ('CLASIFICACION DE ALIMENTOS', 2500, 'PU_CLERK', 5500);
INSERT INTO tarea VALUES ('ATENCION DE COMEDORES', 5500, 'ST_MAN', 8500);
INSERT INTO tarea VALUES ('ATENCION DE ROPERITOS', 2000, 'ST_CLERK', 5000);
INSERT INTO tarea VALUES ('AYUDA DISCAPACITADOS', 2500, 'SH_CLERK', 5500);
INSERT INTO tarea VALUES ('CONSTRUCTOR', 4000, 'IT_PROG', 10000);
INSERT INTO tarea VALUES ('ASISTENCIA A ENFERMOS', 9000, 'MK_MAN', 15000);
INSERT INTO tarea VALUES ('COCINERO', 4000, 'MK_REP', 9000);
INSERT INTO tarea VALUES ('MAESTRO ESPECIAL', 4000, 'HR_REP', 9000);
INSERT INTO tarea VALUES ('RELACIONES INSTITUCIONALES', 4500, 'PR_REP', 10500);
INSERT INTO tarea VALUES ('Nueva Tarea', 100, 'OT_NEW', 3000);

--
-- Data for Name: voluntario; Type: TABLE DATA; Schema: unc_esq_voluntario; Owner: postgres
--

INSERT INTO voluntario VALUES ('Michael', 'Rogers', 'MRogers@OUTLOOK.COM', '+41 643 165 6647', '1998-08-26', 'ST_CLERK', 134, 2900.00, NULL, 50, 122);
INSERT INTO voluntario VALUES ('Ki', 'Gee', 'KGee@HOTMAIL.COM', '+55 357 58 9144', '1999-12-12', 'ST_CLERK', 135, 2400.00, NULL, 50, 122);
INSERT INTO voluntario VALUES ('Hazel', 'Philtanker', 'HPhiltanker@OUTLOOK.COM', '+43 431 515 9767', '2000-02-06', 'ST_CLERK', 136, 2200.00, NULL, 50, 122);
INSERT INTO voluntario VALUES ('Renske', 'Ladwig', 'RLadwig@OUTLOOK.COM', '+17 82 716 4661', '1995-07-14', 'ST_CLERK', 137, 3600.00, NULL, 50, 123);
INSERT INTO voluntario VALUES ('Stephen', 'Stiles', 'SStiles@GMAIL.COM', '+41 423 875 1325', '1997-10-26', 'ST_CLERK', 138, 3200.00, NULL, 50, 123);
INSERT INTO voluntario VALUES ('John', 'Seo', 'JSeo@GMAIL.COM', '+1 922 272 4307', '1998-02-12', 'ST_CLERK', 139, 2700.00, NULL, 50, 123);
INSERT INTO voluntario VALUES ('Joshua', 'Patel', 'JPatel@HOTMAIL.COM', '+25 550 381 2350', '1998-04-06', 'ST_CLERK', 140, 2500.00, NULL, 50, 123);
INSERT INTO voluntario VALUES ('Trenna', 'Rajs', 'TRajs@GMAIL.COM', '+38 827 260 2926', '1995-10-17', 'ST_CLERK', 141, 3500.00, NULL, 50, 124);
INSERT INTO voluntario VALUES ('Curtis', 'Davies', 'CDavies@GMAIL.COM', '+29 424 957 3791', '1997-01-29', 'ST_CLERK', 142, 3100.00, NULL, 50, 124);
INSERT INTO voluntario VALUES ('Randall', 'Matos', 'RMatos@HOTMAIL.COM', '+47 15 294 4948', '1998-03-15', 'ST_CLERK', 143, 2600.00, NULL, 50, 124);
INSERT INTO voluntario VALUES ('Peter', 'Vargas', 'PVargas@OUTLOOK.COM', '+27 808 472 7168', '1998-07-09', 'ST_CLERK', 144, 2500.00, NULL, 50, 124);
INSERT INTO voluntario VALUES ('John', 'Russell', 'JRussell@OUTLOOK.COM', '+54 188 183 5634', '1996-10-01', 'SA_MAN', 145, 14000.00, 0.40, 80, 100);
INSERT INTO voluntario VALUES ('Karen', 'Partners', 'KPartners@GMAIL.COM', '+37 59 696 6276', '1997-01-05', 'SA_MAN', 146, 13500.00, 0.30, 80, 100);
INSERT INTO voluntario VALUES ('Alberto', 'Errazuriz', 'AErrazuriz@HOTMAIL.COM', '+59 967 59 3949', '1997-03-10', 'SA_MAN', 147, 12000.00, 0.30, 80, 100);
INSERT INTO voluntario VALUES ('Gerald', 'Cambrault', 'GCambrault@OUTLOOK.COM', '+32 439 630 1375', '1999-10-15', 'SA_MAN', 148, 11000.00, 0.30, 80, 100);
INSERT INTO voluntario VALUES ('Eleni', 'Zlotkey', 'EZlotkey@GMAIL.COM', '+16 889 430 7376', '2000-01-29', 'SA_MAN', 149, 10500.00, 0.20, 80, 100);
INSERT INTO voluntario VALUES ('Peter', 'Tucker', 'PTucker@HOTMAIL.COM', '+19 387 117 950', '1997-01-30', 'SA_REP', 150, 10000.00, 0.30, 80, 145);
INSERT INTO voluntario VALUES ('David', 'Bernstein', 'DBernstein@OUTLOOK.COM', '+25 410 590 8482', '1997-03-24', 'SA_REP', 151, 9500.00, 0.25, 80, 145);
INSERT INTO voluntario VALUES ('Peter', 'Hall', 'PHall@OUTLOOK.COM', '+14 62 565 1080', '1997-08-20', 'SA_REP', 152, 9000.00, 0.25, 80, 145);
INSERT INTO voluntario VALUES ('Christopher', 'Olsen', 'COlsen@GMAIL.COM', '+15 748 671 8601', '1998-03-30', 'SA_REP', 153, 8000.00, 0.20, 80, 145);
INSERT INTO voluntario VALUES ('Nanette', 'Cambrault', 'NCambrault@OUTLOOK.COM', '+49 367 488 7873', '1998-12-09', 'SA_REP', 154, 7500.00, 0.20, 80, 145);
INSERT INTO voluntario VALUES ('Oliver', 'Tuvault', 'OTuvault@HOTMAIL.COM', '+21 546 183 8531', '1999-11-23', 'SA_REP', 155, 7000.00, 0.15, 80, 145);
INSERT INTO voluntario VALUES ('Janette', 'King', 'JKing@OUTLOOK.COM', '+60 812 990 2513', '1996-01-30', 'SA_REP', 156, 10000.00, 0.35, 80, 146);
INSERT INTO voluntario VALUES ('Patrick', 'Sully', 'PSully@GMAIL.COM', '+43 421 988 149', '1996-03-04', 'SA_REP', 157, 9500.00, 0.35, 80, 146);
INSERT INTO voluntario VALUES ('Allan', 'McEwen', 'AMcEwen@GMAIL.COM', '+49 106 110 2102', '1996-08-01', 'SA_REP', 158, 9000.00, 0.35, 80, 146);
INSERT INTO voluntario VALUES ('Lindsey', 'Smith', 'LSmith@OUTLOOK.COM', '+31 699 59 7345', '1997-03-10', 'SA_REP', 159, 8000.00, 0.30, 80, 146);
INSERT INTO voluntario VALUES ('Louise', 'Doran', 'LDoran@OUTLOOK.COM', '+46 623 842 99', '1997-12-15', 'SA_REP', 160, 7500.00, 0.30, 80, 146);
INSERT INTO voluntario VALUES ('Sarath', 'Sewall', 'SSewall@HOTMAIL.COM', '+23 514 870 1783', '1998-11-03', 'SA_REP', 161, 7000.00, 0.25, 80, 146);
INSERT INTO voluntario VALUES ('Clara', 'Vishney', 'CVishney@GMAIL.COM', '+53 358 965 2166', '1997-11-11', 'SA_REP', 162, 10500.00, 0.25, 80, 147);
INSERT INTO voluntario VALUES ('Danielle', 'Greene', 'DGreene@OUTLOOK.COM', '+55 148 70 8885', '1999-03-19', 'SA_REP', 163, 9500.00, 0.15, 80, 147);
INSERT INTO voluntario VALUES ('Mattea', 'Marvins', 'MMarvins@HOTMAIL.COM', '+58 61 140 6611', '2000-01-24', 'SA_REP', 164, 7200.00, 0.10, 80, 147);
INSERT INTO voluntario VALUES ('David', 'Lee', 'DLee@GMAIL.COM', '+29 129 676 2889', '2000-02-23', 'SA_REP', 165, 6800.00, 0.10, 80, 147);
INSERT INTO voluntario VALUES ('Sundar', 'Ande', 'SAnde@GMAIL.COM', '+15 785 499 7503', '2000-03-24', 'SA_REP', 166, 6400.00, 0.10, 80, 147);
INSERT INTO voluntario VALUES ('Amit', 'Banda', 'ABanda@GMAIL.COM', '+30 557 485 2459', '2000-04-21', 'SA_REP', 167, 6200.00, 0.10, 80, 147);
INSERT INTO voluntario VALUES ('Lisa', 'Ozer', 'LOzer@OUTLOOK.COM', '+11 328 256 5525', '1997-03-11', 'SA_REP', 168, 11500.00, 0.25, 80, 148);
INSERT INTO voluntario VALUES ('Harrison', 'Bloom', 'HBloom@GMAIL.COM', '+51 126 731 7227', '1998-03-23', 'SA_REP', 169, 10000.00, 0.20, 80, 148);
INSERT INTO voluntario VALUES ('Tayler', 'Fox', 'TFox@HOTMAIL.COM', '+30 696 939 3872', '1998-01-24', 'SA_REP', 170, 9600.00, 0.20, 80, 148);
INSERT INTO voluntario VALUES ('William', 'Smith', 'WSmith@GMAIL.COM', '+51 9 276 8038', '1999-02-23', 'SA_REP', 171, 7400.00, 0.15, 80, 148);
INSERT INTO voluntario VALUES ('Elizabeth', 'Bates', 'EBates@GMAIL.COM', '+5 416 465 5503', '1999-03-24', 'SA_REP', 172, 7300.00, 0.15, 80, 148);
INSERT INTO voluntario VALUES ('Sundita', 'Kumar', 'SKumar@HOTMAIL.COM', '+33 141 839 7785', '2000-04-21', 'SA_REP', 173, 6100.00, 0.10, 80, 148);
INSERT INTO voluntario VALUES ('Ellen', 'Abel', 'EAbel@OUTLOOK.COM', '+56 338 529 4116', '1996-05-11', 'SA_REP', 174, 11000.00, 0.30, 80, 149);
INSERT INTO voluntario VALUES ('Alyssa', 'Hutton', 'AHutton@GMAIL.COM', '+54 14 657 766', '1997-03-19', 'SA_REP', 175, 8800.00, 0.25, 80, 149);
INSERT INTO voluntario VALUES ('Jonathon', 'Taylor', 'JTaylor@HOTMAIL.COM', '+21 913 629 1825', '1998-03-24', 'SA_REP', 176, 8600.00, 0.20, 80, 149);
INSERT INTO voluntario VALUES ('Jack', 'Livingston', 'JLivingston@OUTLOOK.COM', '+3 360 905 5221', '1998-04-23', 'SA_REP', 177, 8400.00, 0.20, 80, 149);
INSERT INTO voluntario VALUES ('Kimberely', 'Grant', 'KGrant@OUTLOOK.COM', '+4 844 909 9003', '1999-05-24', 'SA_REP', 178, 7000.00, 0.15, NULL, 149);
INSERT INTO voluntario VALUES ('Charles', 'Johnson', 'CJohnson@GMAIL.COM', '+52 185 704 9227', '2000-01-04', 'SA_REP', 179, 6200.00, 0.10, 80, 149);
INSERT INTO voluntario VALUES ('Winston', 'Taylor', 'WTaylor@GMAIL.COM', '+37 170 473 1447', '1998-01-24', 'SH_CLERK', 180, 3200.00, NULL, 50, 120);
INSERT INTO voluntario VALUES ('Jean', 'Fleaur', 'JFleaur@GMAIL.COM', '+19 312 923 2365', '1998-02-23', 'SH_CLERK', 181, 3100.00, NULL, 50, 120);
INSERT INTO voluntario VALUES ('Martha', 'Sullivan', 'MSullivan@GMAIL.COM', '+40 452 648 5461', '1999-06-21', 'SH_CLERK', 182, 2500.00, NULL, 50, 120);
INSERT INTO voluntario VALUES ('Girard', 'Geoni', 'GGeoni@OUTLOOK.COM', '+28 306 623 8066', '2000-02-03', 'SH_CLERK', 183, 2800.00, NULL, 50, 120);
INSERT INTO voluntario VALUES ('Nandita', 'Sarchand', 'NSarchand@HOTMAIL.COM', '+14 252 989 2573', '1996-01-27', 'SH_CLERK', 184, 4200.00, NULL, 50, 121);
INSERT INTO voluntario VALUES ('Alexis', 'Bull', 'ABull@OUTLOOK.COM', '+37 894 779 6680', '1997-02-20', 'SH_CLERK', 185, 4100.00, NULL, 50, 121);
INSERT INTO voluntario VALUES ('Julia', 'Dellinger', 'JDellinger@GMAIL.COM', '+45 689 568 5920', '1998-06-24', 'SH_CLERK', 186, 3400.00, NULL, 50, 121);
INSERT INTO voluntario VALUES ('Anthony', 'Cabrio', 'ACabrio@GMAIL.COM', '+53 273 515 4741', '1999-02-07', 'SH_CLERK', 187, 3000.00, NULL, 50, 121);
INSERT INTO voluntario VALUES ('Kelly', 'Chung', 'KChung@OUTLOOK.COM', '+27 987 619 7518', '1997-06-14', 'SH_CLERK', 188, 3800.00, NULL, 50, 122);
INSERT INTO voluntario VALUES ('Steven', 'King', 'SKing@HOTMAIL.COM', '+6 504 595 1964', '1987-06-17', 'AD_PRES', 100, 24000.00, NULL, 90, NULL);
INSERT INTO voluntario VALUES ('Neena', 'Kochhar', 'NKochhar@GMAIL.COM', '+36 821 666 7623', '1989-09-21', 'AD_VP', 101, 17000.00, NULL, 90, 100);
INSERT INTO voluntario VALUES ('Lex', 'De Haan', 'LDe Haan@OUTLOOK.COM', '+42 553 468 9181', '1993-01-13', 'AD_VP', 102, 17000.00, NULL, 90, 100);
INSERT INTO voluntario VALUES ('Alexander', 'Hunold', 'AHunold@OUTLOOK.COM', '+58 489 69 4169', '1990-01-03', 'IT_PROG', 103, 9000.00, NULL, 60, 102);
INSERT INTO voluntario VALUES ('Bruce', 'Ernst', 'BErnst@GMAIL.COM', '+38 55 437 3033', '1991-05-21', 'IT_PROG', 104, 6000.00, NULL, 60, 103);
INSERT INTO voluntario VALUES ('David', 'Austin', 'DAustin@HOTMAIL.COM', '+60 566 179 6327', '1997-06-25', 'IT_PROG', 105, 4800.00, NULL, 60, 103);
INSERT INTO voluntario VALUES ('Valli', 'Pataballa', 'VPataballa@GMAIL.COM', '+55 521 825 4031', '1998-02-05', 'IT_PROG', 106, 4800.00, NULL, 60, 103);
INSERT INTO voluntario VALUES ('Diana', 'Lorentz', 'DLorentz@GMAIL.COM', '+42 923 969 7797', '1999-02-07', 'IT_PROG', 107, 4200.00, NULL, 60, 103);
INSERT INTO voluntario VALUES ('Nancy', 'Greenberg', 'NGreenberg@OUTLOOK.COM', '+26 564 976 170', '1994-08-17', 'FI_MGR', 108, 12000.00, NULL, 100, 101);
INSERT INTO voluntario VALUES ('Daniel', 'Faviet', 'DFaviet@HOTMAIL.COM', '+24 642 779 744', '1994-08-16', 'FI_ACCOUNT', 109, 9000.00, NULL, 100, 108);
INSERT INTO voluntario VALUES ('John', 'Chen', 'JChen@GMAIL.COM', '+12 248 992 1593', '1997-09-28', 'FI_ACCOUNT', 110, 8200.00, NULL, 100, 108);
INSERT INTO voluntario VALUES ('Ismael', 'Sciarra', 'ISciarra@GMAIL.COM', '+45 61 576 3699', '1997-09-30', 'FI_ACCOUNT', 111, 7700.00, NULL, 100, 108);
INSERT INTO voluntario VALUES ('Jose Manuel', 'Urman', 'JUrman@OUTLOOK.COM', '+7 14 673 1112', '1998-03-07', 'FI_ACCOUNT', 112, 7800.00, NULL, 100, 108);
INSERT INTO voluntario VALUES ('Luis', 'Popp', 'LPopp@GMAIL.COM', '+35 852 744 4861', '1999-12-07', 'FI_ACCOUNT', 113, 6900.00, NULL, 100, 108);
INSERT INTO voluntario VALUES ('Den', 'Raphaely', 'DRaphaely@GMAIL.COM', '+23 569 889 598', '1994-12-07', 'PU_MAN', 114, 11000.00, NULL, 30, 100);
INSERT INTO voluntario VALUES ('Alexander', 'Khoo', 'AKhoo@HOTMAIL.COM', '+30 858 839 9182', '1995-05-18', 'PU_CLERK', 115, 3100.00, NULL, 30, 114);
INSERT INTO voluntario VALUES ('Shelli', 'Baida', 'SBaida@GMAIL.COM', '+26 815 935 8085', '1997-12-24', 'PU_CLERK', 116, 2900.00, NULL, 30, 114);
INSERT INTO voluntario VALUES ('Sigal', 'Tobias', 'STobias@HOTMAIL.COM', '+28 714 882 6528', '1997-07-24', 'PU_CLERK', 117, 2800.00, NULL, 30, 114);
INSERT INTO voluntario VALUES ('Guy', 'Himuro', 'GHimuro@OUTLOOK.COM', '+58 875 812 6986', '1998-11-15', 'PU_CLERK', 118, 2600.00, NULL, 30, 114);
INSERT INTO voluntario VALUES ('Karen', 'Colmenares', 'KColmenares@OUTLOOK.COM', '+57 388 69 524', '1999-08-10', 'PU_CLERK', 119, 2500.00, NULL, 30, 114);
INSERT INTO voluntario VALUES ('Matthew', 'Weiss', 'MWeiss@GMAIL.COM', '+25 742 164 9803', '1996-07-18', 'ST_MAN', 120, 8000.00, NULL, 50, 100);
INSERT INTO voluntario VALUES ('Adam', 'Fripp', 'AFripp@GMAIL.COM', '+36 907 466 9664', '1997-04-10', 'ST_MAN', 121, 8200.00, NULL, 50, 100);
INSERT INTO voluntario VALUES ('Payam', 'Kaufling', 'PKaufling@OUTLOOK.COM', '+29 356 27 9677', '1995-05-01', 'ST_MAN', 122, 7900.00, NULL, 50, 100);
INSERT INTO voluntario VALUES ('Shanta', 'Vollman', 'SVollman@HOTMAIL.COM', '+13 865 886 6371', '1997-10-10', 'ST_MAN', 123, 6500.00, NULL, 50, 100);
INSERT INTO voluntario VALUES ('Kevin', 'Mourgos', 'KMourgos@GMAIL.COM', '+41 821 446 1386', '1999-11-16', 'ST_MAN', 124, 5800.00, NULL, 50, 100);
INSERT INTO voluntario VALUES ('Julia', 'Nayer', 'JNayer@OUTLOOK.COM', '+33 329 791 4975', '1997-07-16', 'ST_CLERK', 125, 3200.00, NULL, 50, 120);
INSERT INTO voluntario VALUES ('Irene', 'Mikkilineni', 'IMikkilineni@GMAIL.COM', '+13 603 196 1402', '1998-09-28', 'ST_CLERK', 126, 2700.00, NULL, 50, 120);
INSERT INTO voluntario VALUES ('James', 'Landry', 'JLandry@GMAIL.COM', '+60 265 193 3930', '1999-01-14', 'ST_CLERK', 127, 2400.00, NULL, 50, 120);
INSERT INTO voluntario VALUES ('Steven', 'Markle', 'SMarkle@GMAIL.COM', '+1 356 373 6001', '2000-03-08', 'ST_CLERK', 128, 2200.00, NULL, 50, 120);
INSERT INTO voluntario VALUES ('Laura', 'Bissot', 'LBissot@HOTMAIL.COM', '+16 839 567 7394', '1997-08-20', 'ST_CLERK', 129, 3300.00, NULL, 50, 121);
INSERT INTO voluntario VALUES ('Jennifer', 'Dilly', 'JDilly@GMAIL.COM', '+18 542 988 9504', '1997-08-13', 'SH_CLERK', 189, 3600.00, NULL, 50, 122);
INSERT INTO voluntario VALUES ('Timothy', 'Gates', 'TGates@HOTMAIL.COM', '+60 636 496 4596', '1998-07-11', 'SH_CLERK', 190, 2900.00, NULL, 50, 122);
INSERT INTO voluntario VALUES ('Randall', 'Perkins', 'RPerkins@HOTMAIL.COM', '+57 120 266 1605', '1999-12-19', 'SH_CLERK', 191, 2500.00, NULL, 50, 122);
INSERT INTO voluntario VALUES ('Sarah', 'Bell', 'SBell@OUTLOOK.COM', '+23 256 418 9826', '1996-02-04', 'SH_CLERK', 192, 4000.00, NULL, 50, 123);
INSERT INTO voluntario VALUES ('Britney', 'Everett', 'BEverett@HOTMAIL.COM', '+9 198 650 8881', '1997-03-03', 'SH_CLERK', 193, 3900.00, NULL, 50, 123);
INSERT INTO voluntario VALUES ('Samuel', 'McCain', 'SMcCain@OUTLOOK.COM', '+54 219 480 7596', '1998-07-01', 'SH_CLERK', 194, 3200.00, NULL, 50, 123);
INSERT INTO voluntario VALUES ('Vance', 'Jones', 'VJones@HOTMAIL.COM', '+30 994 234 9333', '1999-03-17', 'SH_CLERK', 195, 2800.00, NULL, 50, 123);
INSERT INTO voluntario VALUES ('Alana', 'Walsh', 'AWalsh@HOTMAIL.COM', '+59 852 685 2826', '1998-04-24', 'SH_CLERK', 196, 3100.00, NULL, 50, 124);
INSERT INTO voluntario VALUES ('Kevin', 'Feeney', 'KFeeney@OUTLOOK.COM', '+24 673 233 3885', '1998-05-23', 'SH_CLERK', 197, 3000.00, NULL, 50, 124);
INSERT INTO voluntario VALUES ('Donald', 'OConnell', 'DOConnell@HOTMAIL.COM', '+19 729 848 2518', '1999-06-21', 'SH_CLERK', 198, 2600.00, NULL, 50, 124);
INSERT INTO voluntario VALUES ('Douglas', 'Grant', 'DGrant@GMAIL.COM', '+51 115 412 2195', '2000-01-13', 'SH_CLERK', 199, 2600.00, NULL, 50, 124);
INSERT INTO voluntario VALUES ('Jennifer', 'Whalen', 'JWhalen@GMAIL.COM', '+23 830 202 5190', '1987-09-17', 'AD_ASST', 200, 4400.00, NULL, 10, 101);
INSERT INTO voluntario VALUES ('Mozhe', 'Atkinson', 'MAtkinson@GMAIL.COM', '+12 593 707 4095', '1997-10-30', 'ST_CLERK', 130, 2800.00, NULL, 50, 121);
INSERT INTO voluntario VALUES ('James', 'Marlow', 'JMarlow@HOTMAIL.COM', '+28 593 47 1396', '1997-02-16', 'ST_CLERK', 131, 2500.00, NULL, 50, 121);
INSERT INTO voluntario VALUES ('TJ', 'Olson', 'TOlson@OUTLOOK.COM', '+25 492 278 9498', '1999-04-10', 'ST_CLERK', 132, 2100.00, NULL, 50, 121);
INSERT INTO voluntario VALUES ('Jason', 'Mallin', 'JMallin@GMAIL.COM', '+50 70 447 246', '1996-06-14', 'ST_CLERK', 133, 3300.00, NULL, 50, 122);
INSERT INTO voluntario VALUES ('Michael', 'Hartstein', 'MHartstein@HOTMAIL.COM', '+2 852 407 9132', '1996-02-17', 'MK_MAN', 201, 13000.00, NULL, 20, 100);
INSERT INTO voluntario VALUES ('Pat', 'Fay', 'PFay@GMAIL.COM', '+5 887 673 5634', '1997-08-17', 'MK_REP', 202, 6000.00, NULL, 20, 201);
INSERT INTO voluntario VALUES ('Susan', 'Mavris', 'SMavris@GMAIL.COM', '+53 906 497 8648', '1994-06-07', 'HR_REP', 203, 6500.00, NULL, 40, 101);
INSERT INTO voluntario VALUES ('Hermann', 'Baer', 'HBaer@OUTLOOK.COM', '+46 182 148 1538', '1994-06-07', 'PR_REP', 204, 10000.00, NULL, 70, 101);
INSERT INTO voluntario VALUES ('Shelley', 'Higgins', 'SHiggins@OUTLOOK.COM', '+52 381 542 1654', '1994-06-07', 'AC_MGR', 205, 12000.00, NULL, 110, 101);
INSERT INTO voluntario VALUES ('William', 'Gietz', 'WGietz@GMAIL.COM', '+7 390 417 9585', '1994-06-07', 'AC_ACCOUNT', 206, 8300.00, NULL, 110, 205);

--
-- Name: continente pk_continente; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY continente
    ADD CONSTRAINT pk_continente PRIMARY KEY (id_continente);

--
-- Name: direccion pk_direccion; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY direccion
    ADD CONSTRAINT pk_direccion PRIMARY KEY (id_direccion);

--
-- Name: historico pk_historico; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY historico
    ADD CONSTRAINT pk_historico PRIMARY KEY (fecha_inicio, nro_voluntario);

--
-- Name: institucion pk_institucion; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY institucion
    ADD CONSTRAINT pk_institucion PRIMARY KEY (id_institucion);

--
-- Name: pais pk_pais; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT pk_pais PRIMARY KEY (id_pais);

--
-- Name: tarea pk_tarea; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY tarea
    ADD CONSTRAINT pk_tarea PRIMARY KEY (id_tarea);

--
-- Name: voluntario pk_voluntario; Type: CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY voluntario
    ADD CONSTRAINT pk_voluntario PRIMARY KEY (nro_voluntario);

--
-- Name: emp_email_uk; Type: INDEX; Schema: unc_esq_voluntario; Owner: postgres
--

CREATE UNIQUE INDEX emp_email_uk ON voluntario USING btree (e_mail);

--
-- Name: pais fk_continente; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY pais
    ADD CONSTRAINT fk_continente FOREIGN KEY (id_continente) REFERENCES continente(id_continente);

--
-- Name: voluntario fk_coordinador; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY voluntario
    ADD CONSTRAINT fk_coordinador FOREIGN KEY (id_coordinador) REFERENCES voluntario(nro_voluntario);

--
-- Name: institucion fk_direccion; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY institucion
    ADD CONSTRAINT fk_direccion FOREIGN KEY (id_direccion) REFERENCES direccion(id_direccion);

--
-- Name: institucion fk_director; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY institucion
    ADD CONSTRAINT fk_director FOREIGN KEY (id_director) REFERENCES voluntario(nro_voluntario);

--
-- Name: historico fk_institucion_h; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY historico
    ADD CONSTRAINT fk_institucion_h FOREIGN KEY (id_institucion) REFERENCES institucion(id_institucion);

--
-- Name: voluntario fk_institucion_v; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY voluntario
    ADD CONSTRAINT fk_institucion_v FOREIGN KEY (id_institucion) REFERENCES institucion(id_institucion);

--
-- Name: direccion fk_pais; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY direccion
    ADD CONSTRAINT fk_pais FOREIGN KEY (id_pais) REFERENCES pais(id_pais);

--
-- Name: historico fk_tarea_h; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY historico
    ADD CONSTRAINT fk_tarea_h FOREIGN KEY (id_tarea) REFERENCES tarea(id_tarea);

--
-- Name: voluntario fk_tarea_v; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY voluntario
    ADD CONSTRAINT fk_tarea_v FOREIGN KEY (id_tarea) REFERENCES tarea(id_tarea);

--
-- Name: historico fk_voluntario_h; Type: FK CONSTRAINT; Schema: unc_esq_voluntario; Owner: postgres
--

ALTER TABLE ONLY historico
    ADD CONSTRAINT fk_voluntario_h FOREIGN KEY (nro_voluntario) REFERENCES voluntario(nro_voluntario);
