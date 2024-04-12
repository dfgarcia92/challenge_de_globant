# list of ids, name and number of employees hired of each department that hired more employees than the mean of employees in 2021 for all departments

WITH DepartmentStats AS (
    SELECT
        id,
        department_id,
        COUNT(id) AS num_employees
    FROM
        hired_employees
    WHERE
        datetime BETWEEN '2021-01-01' AND '2021-12-31'
    GROUP BY
        department_id
),
AverageHiring AS (
    SELECT
        AVG(num_employees) AS average_hiring
    FROM
        DepartmentStats
)

SELECT
    ds.department_id AS id,
    ds.department_name AS name,
    ds.num_employees
FROM
    DepartmentStats ds,
    AverageHiring ah
WHERE
    ds.num_employees > ah.average_hiring
ORDER BY
    ds.num_employees DESC;
