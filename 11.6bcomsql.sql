--RESEARCH부서에서 근무하는 모든 사원의 이름(FNAME, LNAME)과 주소(ADDRESS)를 검색하라
SELECT FNAME, LNAME, ADDRESS
FROM EMPLOYEE E, department D
WHERE UPPER(D.DNAME) = 'RESEARCH' AND e.dno = d.dnumber;

--STAFFORD에 위치한 모든 프로젝트에 대해서 프로젝트 번호, 담당 부서 번호,
--부서관리자의 성, 주소, 생년월일을 검색하라.
SELECT p.pnumber, P.dnum, e.lname, e.address, e.bdate
FROM PROJECT P, DEPARTMENT D, employee E
WHERE UPPER(PLOCATION) = 'STAFFORD' 
AND d.dnumber = p.dnum
AND d.mgrssn = e.ssn;

--4번부서가 담당하는 프로젝트를 수행하는 사원들의 이름을 검색하여라
SELECT E.fname, E.lname
FROM project P, employee E, works_on W
WHERE P.DNUM = 4 --''붙이지 않기
AND p.pnumber = w.pno
AND w.essn = e.ssn;

--4번 부서가 담당하는 프로젝트를 모두 수행하는 사원들의 이름을 검색하여라 (모두는 MINUS사용)
SELECT E.fname, E.lname
FROM EMPLOYEE E 
WHERE NOT EXISTS
((SELECT pnumber          --4번부서가 담당하는 프로젝트
FROM PROJECT
WHERE DNUM = 4)        --{10, 30}인 SET
MINUS
(SELECT PNO
FROM works_on
WHERE E.ssn = Essn)
);

--john smith가 일하는 프로젝트 number를 검색하라
SELECT PNO
FROM works_on W, employee E
WHERE e.ssn = w.essn
AND UPPER(FNAME) = 'JOHN' AND UPPER(LNAME) = 'SMITH';

--john smith가 일하는 프로젝트를 수행하는 사람들의 FNAME, LNAME 을 검색
SELECT FNAME, LNAME 
FROM employee E , works_on W
WHERE E.SSN = w.essn --JOIN해야함
AND W.PNO IN (SELECT PNO  -- =X IN
            FROM WORKS_ON, EMPLOYEE --CHECK
            WHERE SSN = essn        --CHECK
            AND UPPER(FNAME) = 'JOHN' AND UPPER(LNAME) = 'SMITH');--CORRELATION X
--john smith가 일하는 프로젝트를 모두 수행하는 사람들의 FNAME, LNAME 을 검색
SELECT E.FNAME, E.LNAME
FROM EMPLOYEE E --PROJECT를 넣어서 22개나
WHERE NOT EXISTS 
((SELECT PNO
FROM works_on, employee
WHERE ssn = essn
AND UPPER(FNAME) = 'JOHN' AND UPPER(LNAME) = 'SMITH'
)
MINUS
(
SELECT PNO
FROM works_on, EMPLOYEE
WHERE e.ssn = ESSN
));