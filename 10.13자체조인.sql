--자체 조인
select e.empname as 사원이름, m.empname as 매니저이름
from employee e, employee m
where e.manager = m.empno;
