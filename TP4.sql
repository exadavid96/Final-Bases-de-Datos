------------- Ejemplo de : No puede haber articulos con mas de 15 palabras -------------------------------------------

/*

  RI Declarativa:
  ALTER TABLE CONTIENE
  ADD CONSTRAINT CK_MAXIMO_PL_CLAVES
  CHECK NOT EXISTS (
    SELECT 1
    FROM CONTIENE
    GROUP BY id_articulo
    HAVING COUNT(*) > 15);
  )

  Tabla          INSERT       UPDATE          DELETE
  CONTIENE         Si     Si, id_articulo      NO

  Un trigger en contiene que contemple el insertado, y la actualizacion de id_articulo

  create or replace function fn_trigger_contiene() returns trigger as $$
    begin
        if ( (
               select count(*)
               from contiene
               where id_articulo = new.id_articulo
            ) > 15 ) then
            raise exception 'No se puede realizar el %, viola la restriccion del trigger %', tg_op, tg_name;
        end if;
        return new;
    end $$ language 'plpgsql';


    CREATE OR REPLACE TRIGGER tr_insert_contiene
        AFTER INSERT OR UPDATE OF id_articulo ON contiene
        FOR EACH ROW EXECUTE FUNCTION fn_trigger_contiene();


*/

------------- Ejercicio 5, pasado a Procedural -------------------------------------------

/*ALTER TABLE voluntario
   ADD CONSTRAINT chk_horas_voluntario_coordinador
   CHECK ( NOT EXISTS (SELECT 1
                    FROM voluntario v
                    WHERE v.horas_aportadas > (SELECT v1.horas_aportadas
                                               FROM voluntario v1
                                               WHERE v.id_coordinador = v1.nro_voluntario))
    )


  Tabla              INSERT        UPDATE                                         DELETE
  Voluntario           SI          SI, horas_aportadas, id_coordinador              NO


   create or replace function fn_voluntario_1() returns trigger as $$

    begin
       if (exists (
          select 1
          from voluntario v
          where v.nro_voluntario = new.nro_voluntario and v.horas_aportadas > (
                select v1.horas_aportadas
                from voluntario v1
                where v1.nro_voluntario = new.id_coordinador
              )

       )
           ) then
              raise exception 'No se puede realizar la operacion %, por el trigger %', tg_op, tg_name;
       end if;
       return new;
    end
$$ language 'plpgsql';

CREATE OR REPLACE TRIGGER tr_voluntario_1
    AFTER INSERT OR UPDATE OF horas_aportadas, id_coordinador ON voluntario
    FOR EACH ROW EXECUTE FUNCTION fn_voluntario_1();



    ALTER TABLE historico
    ADD CONSTRAINT chk_cambio_institucion_voluntarios
    CHECK ( NOT EXISTS (
       SELECT 1 FROM historico
       WHERE id_institucion IS NOT NULL
       GROUP BY nro_voluntario, EXTRACT (year from fecha_fin)
       HAVING COUNT(*) > 3
       )
    )

    Tabla       INSERT    UPDATE                            DELETE
    Historico     SI        SI, fecha_fin, nro_voluntario    NO

    create or replace function fn_historico_1() returns trigger as $$
    begin
        if ( (
            select count(*)
            from historico h
            where new.nro_voluntario = h.nro_voluntario and extract(year from new.fecha_fin) = extract(year from h.fecha_fin)
            ) > 1 ) then
            raise exception 'No se puede realizar la operacion %, por el trigger %', tg_op, tg_name;
        end if;
        return new;
    end;

    $$ language 'plpgsql';

    CREATE OR REPLACE TRIGGER tn_insert_historico1
    AFTER INSERT ON historico
    FOR EACH ROW EXECUTE FUNCTION fn_historico_1();

    CREATE OR REPLACE TRIGGER tn_update_historico1
    AFTER UPDATE OF nro_voluntario, fecha_fin ON historico
    FOR EACH ROW EXECUTE FUNCTION fn_historico_1();


------------- Ejercicio 4, pasado a Procedural -------------------------------------------

     ALTER TABLE PROVEE
     ADD CONSTRAINT chk_proveedor_lim_prod
     CHECK ( NOT EXISTS (
       SELECT nro_proveedor
       FROM PROVEE
       GROUP BY nro_proveedor
       HAVING COUNT(*) > 20
       )
     )

      Tabla       INSERT       UPDATE                         DELETE
      Provee        SI        SI, nro_prov                      NO

    create or replace function fn_provee1() returns trigger as $$
    begin
       if ( ( select count(*)
            from provee p
            where new.nro_prov = p.nro_prov
          ) > 20 ) then
       raise exception 'No se puede realizar la operacion %, por el trigger %', tg_op, tg_name;
       end if;
       return new;
    end
    $$ language 'plpgsql';

    CREATE OR REPLACE TRIGGER tn_provee1
    AFTER INSERT OR UPDATE of nro_prov ON provee
    FOR EACH ROW EXECUTE FUNCTION fn_provee_1();




   CREATE ASSERTION chk_proveedor_localidad_sucursal
   CHECK ( NOT EXISTS (
        SELECT 1
        FROM proveedor p
        JOIN provee pr ON p.nro_prov = pr.nro_prov
        JOIN sucursal s ON pr.cod_suc = s.cod_suc
        WHERE p.localidad <> s.localidad
     )
   )

     Tabla       INSERT    UPDATE                 DELETE
   proveedor     NO      Si, localidad            No
   provee        Si      Si, cod_suc, nro_prov    No
   sucursal      NO      Si, localidad            No


   create or replace function fn_proveedor() returns trigger as $$
   begin

       if ( exists (
           select 1
           from proveedor p
           join provee pr on p.nro_prov = pr.nro_prov
           join sucursal s on pr.cod_suc = s.cod_suc
           where new.nro_prov = p.nro_prov and new.localidad <> s.localidad
        )
      ) then
         raise exception 'No se puede realizar la operacion %, por el trigger %', tg_op, tg_name;
         end if;
         return new;
   end
   $$ language 'plpgsql';

  create or replace function fn_sucursal() returns trigger as $$
   begin

       if ( exists (

           select 1
           from sucursal s
           join provee pr on s.cod_suc = pr.cod_suc
           join proveedor p on pr.nro_prov = p.nro_prov
           where new.cod_suc = s.cod_suc and new.localidad <> s.localidad
        )
      ) then
         raise exception 'No se puede realizar la operacion %, por el trigger %', tg_op, tg_name;
         end if;
         return new;
   end
   $$ language 'plpgsql';

  CREATE OR REPLACE TRIGGER tr_proveedor
  AFTER UPDATE OF localidad ON proveedor
  FOR EACH ROW EXECUTE FUNCTION fn_proveedor();

  CREATE OR REPLACE TRIGGER tn_provee
  AFTER INSERT OR UPDATE OF nro_prov, cod_suc ON provee
  FOR EACH ROW EXECUTE FUNCTION fn_proveedor();

  CREATE OR REPLACE TRIGGER tn_provee
  AFTER INSERT OR UPDATE OF nro_prov, cod_suc ON provee
  FOR EACH ROW EXECUTE FUNCTION fn_sucursal();


------------- Ejercicio 3 g, pasado a Procedural -------------------------------------------

   CREATE ASSERTION chk_director_voluntarios
   CHECK ( NOT EXISTS (
        SELECT 1
        FROM INSTITUCION i
        WHERE i.id_director NOT IN (
             SELECT v.id_coordinador
             FROM VOLUNTARIO v
             WHERE i.id_director = v.id_coordinador
        )
     )
   )

   Tabla              INSERT           UPDATE                 DELETE
   Institucion          SI             SI, id_director          NO
   Voluntario           NO             SI, id_coordinador       SI


   CREATE OR REPLACE TRIGGER tr_institucion
   AFTER INSERT OR UPDATE of id_director ON INSTITUCION
   FOR EACH ROW EXECUTE FUNCTION fn_institucion();

   CREATE OR REPLACE TRIGGER tr_voluntario
   AFTER UPDATE of id_coordinador OR DELETE ON VOLUNTARIO
   FOR EACH ROW EXECUTE FUNCTION fn_voluntario();


   create or replace function fn_institucion() returns trigger as $$
        if ( exists (

              select 1
              from institucion i
              where i.id_institucion = new.id_institucion and i.id_director not in (
                   select v.id_coordinador
                   from voluntario v
                   where v.id_coordinador = i.id_director
              )
           )
        ) then
          raise exception 'No se puede realizar la operacion %, por el trigger %', tg_op, tg_name;
        end if;
        return new
   $$ language 'plpgsql';


  */




