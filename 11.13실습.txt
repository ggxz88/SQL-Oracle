--모든 사원의 급여를 검색
SELECT SALARY
FROM EMPLOYEE
ORDER BY salary;

--구별되는 급여 검색
SELECT DISTINCT SALARY
FROM EMPLOYEE
ORDER BY salary;

--주소가 'Houston, TX'인 사원을 검색하시오 (wild card %, LIKE 사용)
SELECT address
FROM EMPLOYEE
WHERE address LIKE '%Houston, TX%'; -- 뒤에도 %넣기

--SALARY가 30000과 40000 사이이면서 5번 DEPT에 속하는 사원의 이름을 검색(between 사용) 
SELECT fname, lname
FROM employee
WHERE (salary BETWEEN 30000 AND 40000) --괄호 넣기
and dno = 5;

--부양가족과 이름(fname)과 성별이 같은 사원들의 (fname, lname)를 검색!(correlated inner query 또는 simple join 사용)
SELECT FNAME, LNAME
FROM EMPLOYEE E, dependent D
WHERE e.fname = d.dependent_name
AND E.SEX = D.SEX;

SELECT FNAME, LNAME
FROM EMPLOYEE E
WHERE E.SSN IN (SELECT D.ESSN
                    FROM DEPENDENT D
                    WHERE E.FNAME = d.dependent_name
                    AND e.sex = d.sex);
                  
--부양가족이 없는 종업원의 이름을 검색(correlated inner query 사용)
SELECT FNAME, LNAME
FROM employee e
WHERE NOT EXISTS --2번경우와 3번경우 다 사용 가능
(SELECT *
FROM dependent d
where e.ssn = d.essn);

--부양가족이 적어도 한 명 이상 있는 관리자의 이름을 검색
SELECT distinct e.fname, e.lname
FROM employee e, department d, dependent de
where d.mgrssn = de.essn
and d.mgrssn = e.ssn;

SELECT FNAME, LNAME
FROM employee E
WHERE E.SSN IN 
(SELECT MGRSSN FROM DEPARTMENT 
WHERE e.ssn = MGRSSN)
AND E.SSN IN 
(SELECT ESSN 
FROM dependent
WHERE E.SSN = ESSN);

--프로젝트 번호 1, 2, 3을 수행하는 사원의 이름과 SSN을 검색(다시)
SELECT FNAME, LNAME, SSN 
FROM EMPLOYEE, project, works_on
WHERE PNO = pnumber
AND ESSN = SSN
AND (PNUMBER = 1 AND pnumber = 2 AND pnumber = 3);

--프로젝트 번호 1, 2, 3을 모두 수행하는 사원의 이름과 SSN을 검색
SELECT FNAME, LNAME, SSN 
FROM EMPLOYEE E
WHERE EXISTS
(
(SELECT PNUMBER 
FROM project
WHERE PNUMBER IN( 1, 2, 3 ))
MINUS
(SELECT PNO 
FROM works_on
WHERE E.SSN = essn)
);
--'HARDWARE'부서에 속하는 직원보다 SALARY를 더 받는 직원의 이름을 검색(ANY OR MIN 사용)
SELECT FNAME, LNAME
FROM EMPLOYEE E
WHERE  SALARY > ANY
(SELECT SALARY
FROM employee, department
WHERE dno = dnumber --조인
and DNAME = 'Hardware');

SELECT FNAME, LNAME
FROM EMPLOYEE E
WHERE  SALARY >
(SELECT min(SALARY)
FROM employee, department
WHERE dno = dnumber --조인
and DNAME = 'Hardware');

--'HARDWARE'부서에 속하는 모든 직원보다 SALARY를 더 받는 직원의 이름을 검색(ALL 또는 MAX 사용)
SELECT FNAME, LNAME
FROM EMPLOYEE E
WHERE  SALARY  > all
(SELECT SALARY
FROM employee, department
WHERE dno = dnumber --조인
and DNAME = 'Hardware');

SELECT FNAME, LNAME
FROM EMPLOYEE E
WHERE  SALARY >
(SELECT max(SALARY)
FROM employee, department
WHERE dno = dnumber --조인
and DNAME = 'Hardware');