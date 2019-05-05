--REPORTES

CREATE OR REPLACE PROCEDURE SYSMATRICULAS.SP_LISTADO_CURSO_MATRICULADOS(
                                                    RESULTADO OUT SYS_REFCURSOR)
IS
BEGIN    
    OPEN RESULTADO FOR
   SELECT NOMBRECURSO,COUNT(*) MATRICULADOS FROM SYSMATRICULAS.ALUMNO_NOTAS group by NOMBRECURSO;
END;


CREATE OR REPLACE PROCEDURE SYSMATRICULAS.SP_RESUMEN_ALUMNO
(
    p_alumnocodigo varchar2,
    RESULTADO OUT SYS_REFCURSOR
)
IS
BEGIN    
    OPEN RESULTADO FOR    
    SELECT a.alumnonombre,d.cursonombre,c.notacurso,
      CASE
          WHEN c.notacurso <= 10 THEN 'DESAPROBADO'
          WHEN c.notacurso > 10 THEN  'APROBADO'
          ELSE 'NOTA PENDIENTE'
      END AS estado
    FROM sysmatriculas.alumno A 
    INNER JOIN sysmatriculas.matricula b on a.alumnocodigo=b.alumnocodigo 
    inner join sysmatriculas.alumno_notas c on b.cursocodigo=c.cursocodigo and a.alumnocodigo=c.alumnocodigo 
    inner join sysmatriculas.curso d on b.cursocodigo=d.cursocodigo
    where a.alumnocodigo=p_alumnocodigo;
   
END;
