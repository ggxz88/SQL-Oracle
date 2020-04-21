--��� ����� �޿��� �˻�
SELECT SALARY
FROM EMPLOYEE
ORDER BY salary;

--�����Ǵ� �޿� �˻�
SELECT DISTINCT SALARY
FROM EMPLOYEE
ORDER BY salary;

--�ּҰ� 'Houston, TX'�� ����� �˻��Ͻÿ� (wild card %, LIKE ���)
SELECT address
FROM EMPLOYEE
WHERE address LIKE '%Houston, TX%'; -- �ڿ��� %�ֱ�

--SALARY�� 30000�� 40000 �����̸鼭 5�� DEPT�� ���ϴ� ����� �̸��� �˻�(between ���) 
SELECT fname, lname
FROM employee
WHERE (salary BETWEEN 30000 AND 40000) --��ȣ �ֱ�
and dno = 5;

--�ξ簡���� �̸�(fname)�� ������ ���� ������� (fname, lname)�� �˻�!(correlated inner query �Ǵ� simple join ���)
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
                  
--�ξ簡���� ���� �������� �̸��� �˻�(correlated inner query ���)
SELECT FNAME, LNAME
FROM employee e
WHERE NOT EXISTS --2������ 3����� �� ��� ����
(SELECT *
FROM dependent d
where e.ssn = d.essn);

--�ξ簡���� ��� �� �� �̻� �ִ� �������� �̸��� �˻�
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

--������Ʈ ��ȣ 1, 2, 3�� �����ϴ� ����� �̸��� SSN�� �˻�(�ٽ�)
SELECT FNAME, LNAME, SSN 
FROM EMPLOYEE, project, works_on
WHERE PNO = pnumber
AND ESSN = SSN
AND (PNUMBER = 1 AND pnumber = 2 AND pnumber = 3);

--������Ʈ ��ȣ 1, 2, 3�� ��� �����ϴ� ����� �̸��� SSN�� �˻�
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
--'HARDWARE'�μ��� ���ϴ� �������� SALARY�� �� �޴� ������ �̸��� �˻�(ANY OR MIN ���)
SELECT FNAME, LNAME
FROM EMPLOYEE E
WHERE  SALARY > ANY
(SELECT SALARY
FROM employee, department
WHERE dno = dnumber --����
and DNAME = 'Hardware');

SELECT FNAME, LNAME
FROM EMPLOYEE E
WHERE  SALARY >
(SELECT min(SALARY)
FROM employee, department
WHERE dno = dnumber --����
and DNAME = 'Hardware');

--'HARDWARE'�μ��� ���ϴ� ��� �������� SALARY�� �� �޴� ������ �̸��� �˻�(ALL �Ǵ� MAX ���)
SELECT FNAME, LNAME
FROM EMPLOYEE E
WHERE  SALARY  > all
(SELECT SALARY
FROM employee, department
WHERE dno = dnumber --����
and DNAME = 'Hardware');

SELECT FNAME, LNAME
FROM EMPLOYEE E
WHERE  SALARY >
(SELECT max(SALARY)
FROM employee, department
WHERE dno = dnumber --����
and DNAME = 'Hardware');