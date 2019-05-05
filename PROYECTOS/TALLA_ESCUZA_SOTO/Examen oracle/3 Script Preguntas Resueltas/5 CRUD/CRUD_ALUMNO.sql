CREATE OR REPLACE PACKAGE crud_alumno AS
    TYPE ref_type IS REF CURSOR;
    PROCEDURE sp_insertar_alumno (
        p_nombre      IN VARCHAR,
        p_direccion   IN VARCHAR,
        p_telefono    IN VARCHAR,
        p_email       IN VARCHAR,
        p_estado      IN VARCHAR,
        p_mensaje     OUT VARCHAR,
        r_resultado   OUT NUMBER
    );

    PROCEDURE sp_eliminar_alumno (
        p_codigo    IN VARCHAR,
        p_mensaje   OUT VARCHAR
    );

    PROCEDURE sp_actualizar_alumno (
        p_codigo      IN VARCHAR,
        p_nombre      IN VARCHAR,
        p_direccion   IN VARCHAR,
        p_telefono    IN VARCHAR,
        p_email       IN VARCHAR,
        p_estado      IN VARCHAR,
        p_mensaje     OUT VARCHAR
    );
    
    PROCEDURE sp_buscar_alumno (
        p_codigo       IN VARCHAR,
        p_nombre       IN VARCHAR,
        vc_resultado   OUT SYS_REFCURSOR
    );

END crud_alumno;