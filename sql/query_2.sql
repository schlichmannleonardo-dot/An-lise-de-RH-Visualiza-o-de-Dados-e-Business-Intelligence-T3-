-- ============================================================
-- Query 2 - Funcionarios por Regiao (com localizacao)
-- Base: FreeSQL / esquema HR (Human Resources)
-- Objetivo: analisar salarios e distribuicao geografica
--           (Cidade, Estado ou Pais e Regiao).
-- Relacionamento: EMPLOYEES  LEFT JOIN  DEPARTMENTS
--                           LEFT JOIN  LOCATIONS
--                           LEFT JOIN  COUNTRIES
--                           LEFT JOIN  REGIONS
-- Filtro (WHERE simples): considera apenas registros que
--   possuem regiao identificada.
-- ============================================================

SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name,
    j.job_title,
    l.city,
    c.country_name,
    r.region_name
FROM hr.employees e
LEFT JOIN hr.departments d
    ON e.department_id = d.department_id
LEFT JOIN hr.jobs j
    ON e.job_id = j.job_id
LEFT JOIN hr.locations l
    ON d.location_id = l.location_id
LEFT JOIN hr.countries c
    ON l.country_id = c.country_id
LEFT JOIN hr.regions r
    ON c.region_id = r.region_id
WHERE e.salary IS NOT NULL
ORDER BY r.region_name, c.country_name, e.salary DESC;
