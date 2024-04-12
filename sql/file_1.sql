# number of employees hired for each job an department in 2021 by quarter.

select
    department,
    job_id,
    count(case when EXTRACT(QUARTER FROM datetime) = 1 then employee_id ELSE NULL END) AS q1,
    count(case when EXTRACT(QUARTER FROM datetime) = 2 then employee_id ELSE NULL END) AS q2,
    count(case when EXTRACT(QUARTER FROM datetime) = 3 then employee_id ELSE NULL END) AS q3,
    count(case when EXTRACT(QUARTER FROM datetime) = 4 then employee_id ELSE NULL END) AS q4
FROM
    hired_employees
WHERE
    datetime BETWEEN '2021-01-01' AND '2021-12-31'
GROUP BY
    department,
    job_id
ORDER BY
    department,
    job_id;