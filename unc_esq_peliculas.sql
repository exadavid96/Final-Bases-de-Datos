SELECT * FROM unc_esq_peliculas.pelicula;
SELECT * FROM unc_esq_peliculas.tarea;

 SELECT d.*
        FROM unc_esq_peliculas.departamento d
        WHERE (
             SELECT COUNT(*)
             FROM unc_esq_peliculas.empleado e
             WHERE e.id_departamento = d.id_departamento
             ) > 70;


SELECT unc_esq_peliculas.empleado.id_departamento , COUNT(*)
             FROM unc_esq_peliculas.empleado
             GROUP BY unc_esq_peliculas.empleado.id_departamento
             HAVING COUNT(*) > 70
             ORDER BY count(*);


ALTER TABLE unc_esq_peliculas.tarea
   ADD CONSTRAINT chk_correctitud_rango_sueldos
   CHECK ( sueldo_maximo > sueldo_minimo );

ALTER TABLE unc_esq_peliculas.tarea
DROP CONSTRAINT chk_correctitud_rango_sueldos;


CREATE TABLE COPIA_PELICULA AS
    SELECT * FROM unc_esq_peliculas.pelicula;

CREATE TABLE ESTADISTICA AS
    SELECT genero, COUNT(*) total_peliculas, COUNT(distinct idioma) cantidad_idiomas
    FROM COPIA_PELICULA GROUP BY genero;

SELECT * FROM ESTADISTICA;

create or replace function fn_update_estad_insert() returns trigger as $$

    declare
        row_genero estadistica%rowtype;
        cant_p estadistica.total_peliculas%type;
        cant_i estadistica.cantidad_idiomas%type;

    begin
        select * into row_genero from estadistica where genero = new.genero;
        if (found) then
            cant_p := row_genero.total_peliculas + 1;
            cant_i := row_genero.cantidad_idiomas;
            if(new.idioma not in (
              select distinct idioma from unc_esq_peliculas.pelicula where genero = row_genero.genero
              ) ) then
                cant_i := cant_i + 1;
           end if;
            update estadistica set total_peliculas = cant_p , cantidad_idiomas = cant_i where genero = row_genero.genero;
        else
            insert into estadistica values (new.genero, 1, 1);
        end if;
        return new;
end
    $$ language 'plpgsql';

CREATE OR REPLACE TRIGGER tn_update_estad_insert AFTER INSERT ON unc_esq_peliculas.pelicula
    FOR EACH ROW EXECUTE FUNCTION fn_update_estad_insert();

SELECT * FROM estadistica;

DELETE FROM unc_esq_peliculas.pelicula WHERE codigo_pelicula = 76787 OR codigo_pelicula = 76788;
DELETE FROM estadistica where genero = 'Cualca';


INSERT INTO unc_esq_peliculas.pelicula VALUES (76787, 'Charito', 'Argentino', 'Formato 3', 'Western', 586428);
INSERT INTO unc_esq_peliculas.pelicula VALUES (76788, 'Charito', 'Birmano', 'Formato 3', 'Cualca', 586428);

--Revisar, porque no funciona correctamente el agregado. No reconoce si el genero ya existe, y lo agrega al final

