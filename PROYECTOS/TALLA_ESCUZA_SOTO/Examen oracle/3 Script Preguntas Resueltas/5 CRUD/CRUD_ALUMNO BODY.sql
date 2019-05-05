CREATE OR REPLACE PACKAGE BODY crud_alumno AS

    PROCEDURE sp_insertar_alumno (
        p_nombre      IN VARCHAR,
        p_direccion   IN VARCHAR,
        p_telefono    IN VARCHAR,
        p_email       IN VARCHAR,
        p_estado      IN VARCHAR,
        p_mensaje     OUT VARCHAR,
        r_resultado   OUT NUMBER
    ) AS
        p_codigo   NUMBER;
    BEGIN
        SELECT
            MAX(alumnocodigo) + 1
        INTO p_codigo
        FROM
            alumno;

        INSERT INTO alumno (
            alumnocodigo,
            alumnonombre,
            alumnodireccion,
            alumnotelefono,
            alumnoemail,
            alumnoestado
        ) VALUES (
            '00' || p_codigo,
            p_nombre,
            p_direccion,
            p_telefono,
            p_email,
            p_estado
        ) RETURNING alumnocodigo INTO r_resultado;

        IF ( r_resultado > 0 ) THEN
            p_mensaje := 'Se registró correctamente el alumno';
            dbms_output.put_line(p_mensaje);
        END IF;

    EXCEPTION
        WHEN dup_val_on_index THEN
            r_resultado := 0;
        WHEN OTHERS THEN
            r_resultado :=-1;
    END;

    PROCEDURE sp_eliminar_alumno (
        p_codigo    IN VARCHAR,
        p_mensaje   OUT VARCHAR
    ) AS
    BEGIN
        DELETE FROM alumno
        WHERE
            alumnocodigo = p_codigo;

        p_mensaje := 'El alumno se eliminó correctamente';
    END;

    PROCEDURE sp_actualizar_alumno (
        p_codigo      IN VARCHAR,
        p_nombre      IN VARCHAR,
        p_direccion   IN VARCHAR,
        p_telefono    IN VARCHAR,
        p_email       IN VARCHAR,
        p_estado      IN VARCHAR,
        p_mensaje     OUT VARCHAR
    ) IS
    BEGIN
        UPDATE alumno
        SET
            alumnonombre = p_nombre,
            alumnodireccion = p_direccion,
            alumnotelefono = p_telefono,
            alumnoemail = p_email,
            alumnoestado = p_estado
        WHERE
            alumnocodigo = p_codigo;

        p_mensaje := 'Los datos del alumno:  '
                     || p_codigo
                     || ' se han actualizado correctamente';
    END;

    PROCEDURE sp_buscar_alumno (
        p_codigo       IN VARCHAR,
        p_nombre       IN VARCHAR,
        vc_resultado   OUT SYS_REFCURSOR
    ) IS
    BEGIN
        OPEN vc_resultado FOR SELECT
                                  alumnocodigo,
                                  alumnonombre,
                                  alumnodireccion,
                                  alumnotelefono,
                                  alumnoemail,
                                  alumnoestado
                              FROM
                                  alumno
                              WHERE
                                  alumnocodigo = p_codigo
                                  OR alumnonombre = p_nombre;

    END;

END crud_alumno;