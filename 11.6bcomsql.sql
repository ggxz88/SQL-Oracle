--RESEARCH�μ����� �ٹ��ϴ� ��� ����� �̸�(FNAME, LNAME)�� �ּ�(ADDRESS)�� �˻��϶�
SELECT FNAME, LNAME, ADDRESS
FROM EMPLOYEE E, department D
WHERE UPPER(D.DNAME) = 'RESEARCH' AND e.dno = d.dnumber;

--STAFFORD�� ��ġ�� ��� ������Ʈ�� ���ؼ� ������Ʈ ��ȣ, ��� �μ� ��ȣ,
--�μ��������� ��, �ּ�, ��������� �˻��϶�.
SELECT p.pnumber, P.dnum, e.lname, e.address, e.bdate
FROM PROJECT P, DEPARTMENT D, employee E
WHERE UPPER(PLOCATION) = 'STAFFORD' 
AND d.dnumber = p.dnum
AND d.mgrssn = e.ssn;

--4���μ��� ����ϴ� ������Ʈ�� �����ϴ� ������� �̸��� �˻��Ͽ���
SELECT E.fname, E.lname
FROM project P, employee E, works_on W
WHERE P.DNUM = 4 --''������ �ʱ�
AND p.pnumber = w.pno
AND w.essn = e.ssn;

--4�� �μ��� ����ϴ� ������Ʈ�� ��� �����ϴ� ������� �̸��� �˻��Ͽ��� (��δ� MINUS���)
SELECT E.fname, E.lname
FROM EMPLOYEE E 
WHERE NOT EXISTS
((SELECT pnumber          --4���μ��� ����ϴ� ������Ʈ
FROM PROJECT
WHERE DNUM = 4)        --{10, 30}�� SET
MINUS
(SELECT PNO
FROM works_on
WHERE E.ssn = Essn)
);

--john smith�� ���ϴ� ������Ʈ number�� �˻��϶�
SELECT PNO
FROM works_on W, employee E
WHERE e.ssn = w.essn
AND UPPER(FNAME) = 'JOHN' AND UPPER(LNAME) = 'SMITH';

--john smith�� ���ϴ� ������Ʈ�� �����ϴ� ������� FNAME, LNAME �� �˻�
SELECT FNAME, LNAME 
FROM employee E , works_on W
WHERE E.SSN = w.essn --JOIN�ؾ���
AND W.PNO IN (SELECT PNO  -- =X IN
            FROM WORKS_ON, EMPLOYEE --CHECK
            WHERE SSN = essn        --CHECK
            AND UPPER(FNAME) = 'JOHN' AND UPPER(LNAME) = 'SMITH');--CORRELATION X
--john smith�� ���ϴ� ������Ʈ�� ��� �����ϴ� ������� FNAME, LNAME �� �˻�
SELECT E.FNAME, E.LNAME
FROM EMPLOYEE E --PROJECT�� �־ 22����
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