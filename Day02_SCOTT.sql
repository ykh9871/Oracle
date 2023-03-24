--(1)����� �̸��� ������ ����Ͻÿ�. ��, ����� �̸��� ������̸���, ����(JOB)�� ������������Ӹ����� �������� ����Ѵ�.
SELECT ENAME, JOB AS ������� FROM EMP;

--(2)30�� �μ��� �ٹ��ϴ� ��� ����� �̸��� �޿��� ����Ͻÿ�.
SELECT ENAME, SAL FROM EMP
WHERE DEPTNO = 30;

--(3)��� ��ȣ�� �̸�, ���� �޿��� 10% �λ�� �޿�(�� �̸��� ���λ�� �޿���)�� ����Ͻÿ�. ��, ��� ��ȣ������ ����Ѵ�. ������ �޿��п� ���� �� �̸��� �������ס����� �Ѵ�.
SELECT EMPNO, SAL, SAL * 1.1 AS "�λ�� �޿�", SAL * 0.1 AS "������" FROM EMP
ORDER BY EMPNO;

--(4)��S���� �����ϴ� ��� ����� �μ���ȣ�� ����Ͻÿ�.
SELECT ENAME, DEPTNO FROM EMP
WHERE ENAME LIKE 'S%';

--(5)��� ����� �ִ� �� �ּ� �޿�, �հ� �� ��� �޿��� ����Ͻÿ�. 
--   �� �̸��� ���� MAX, MIN, SUM, AVG�� �Ѵ�. ��, �Ҽ��� ���ϴ� �ݿø��Ͽ� ������ ����Ѵ�.
SELECT MAX(SAL) AS "MAX", MIN(SAL) AS "MIN", SUM(SAL) AS "SUM", ROUND(AVG(SAL),0) AS "AVG" FROM EMP;

--(6)�����̸��� �������� ������ ������ �ϴ� ����� ���� ����Ͻÿ�. �� �̸��� ���� ���������� �������� ��������� �Ѵ�.
SELECT JOB AS ����, COUNT(*) AS "������ �����" FROM EMP
GROUP BY JOB;

--(7)����� �ִ� �޿��� �ּ� �޿��� ������ ����Ͻÿ�.
SELECT MAX(SAL) - MIN(SAL) FROM EMP;

--(8)30�� �μ��� ������ ���� ����� �޿��� �հ�� ����� ����Ͻÿ�.
SELECT SUM(SAL), AVG(SAL) FROM EMP
WHERE DEPTNO = 30;

--(9)��ձ޿��� ���� ���� �μ��� ��ȣ�� ����Ͻÿ�.
SELECT DEPTNO FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MAX(AVG(SAL))
                    FROM EMP
                    GROUP BY DEPTNO);

--(10)��������� �����ϰ�, �� ������ ������� �� �޿��� 3000 �̻��� �� ������ ���ؼ�, ������� �� ������ ��� �޿��� ����ϵ�, ��ձ޿��� ������������ ����Ͻÿ�.
SELECT JOB, AVG(SAL) AS ��ձ޿� FROM EMP
WHERE JOB <> 'SALESMAN' AND SAL >= 3000
GROUP BY JOB
ORDER BY ��ձ޿� DESC;

--(11) ��ü ��� ��� ���ӻ���� �ִ� ����� ���� ����Ͻÿ�.
SELECT COUNT(*) FROM EMP
WHERE MGR IS NOT NULL;

--(12) Emp ���̺��� �̸�, �޿�, Ŀ�̼� �ݾ�, �Ѿ�(sal + comm)�� ���Ͽ� �Ѿ��� ���� ������� ����Ͻÿ�. ��, Ŀ�̼��� NULL�� ����� �����Ѵ�.
SELECT ENAME, SAL, COMM, SAL + COMM AS �Ѿ� FROM EMP
WHERE COMM IS NOT NULL
ORDER BY �Ѿ� DESC;

--(13) �� �μ����� ���� ������ �ϴ� ����� �ο����� ���Ͽ� �μ���ȣ, ������, �ο����� ����Ͻÿ�.
SELECT DEPTNO, JOB, COUNT(*) FROM EMP
GROUP BY DEPTNO, JOB;

--(14) ����� �� �� ���� �μ��� �̸��� ����Ͻÿ�.
SELECT DNAME FROM DEPT
WHERE DEPTNO NOT IN (SELECT DEPTNO FROM EMP
                    GROUP BY DEPTNO
                    HAVING COUNT(*) <> 0);
                    
--(15) ���� ������ �ϴ� ����� ���� 4�� �̻��� ������ �ο����� ����Ͻÿ�.
SELECT JOB, COUNT(*) FROM EMP
GROUP BY DEPTNO, JOB
HAVING COUNT(*) >= 4;

--(16) �����ȣ�� 7400 �̻� 7600 ������ ����� �̸��� ����Ͻÿ�.
SELECT ENAME FROM EMP
WHERE EMPNO >= 7400 AND EMPNO <= 7600;

--(17) ����� �̸��� ����� �μ��� ����Ͻÿ�.
SELECT EMP.ENAME, DEPT.DNAME FROM EMP
INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

--(18) ����� �̸��� ������ �̸��� ����Ͻÿ�.
SELECT ENAME AS ���� FROM EMP
WHERE EMPNO IN (SELECT DISTINCT(MGR) FROM EMP
                WHERE MGR IS NOT NULL);