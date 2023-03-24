--(1)사원의 이름과 직위를 출력하시오. 단, 사원의 이름은 ‘사원이름’, 직무(JOB)는 ‘사원직무’머리글이 나오도록 출력한다.
SELECT ENAME, JOB AS 사원직무 FROM EMP;

--(2)30번 부서에 근무하는 모든 사원의 이름과 급여를 출력하시오.
SELECT ENAME, SAL FROM EMP
WHERE DEPTNO = 30;

--(3)사원 번호와 이름, 현재 급여와 10% 인상된 급여(열 이름은 ‘인상된 급여’)를 출력하시오. 단, 사원 번호순으로 출력한다. 증가된 급여분에 대한 열 이름은 ‘증가액’으로 한다.
SELECT EMPNO, SAL, SAL * 1.1 AS "인상된 급여", SAL * 0.1 AS "증가액" FROM EMP
ORDER BY EMPNO;

--(4)‘S’로 시작하는 모든 사원과 부서번호를 출력하시오.
SELECT ENAME, DEPTNO FROM EMP
WHERE ENAME LIKE 'S%';

--(5)모든 사원의 최대 및 최소 급여, 합계 및 평균 급여를 출력하시오. 
--   열 이름은 각각 MAX, MIN, SUM, AVG로 한다. 단, 소수점 이하는 반올림하여 정수로 출력한다.
SELECT MAX(SAL) AS "MAX", MIN(SAL) AS "MIN", SUM(SAL) AS "SUM", ROUND(AVG(SAL),0) AS "AVG" FROM EMP;

--(6)업무이름과 업무별로 동일한 업무를 하는 사원의 수를 출력하시오. 열 이름은 각각 ‘업무’와 ‘업무별 사원수’로 한다.
SELECT JOB AS 업무, COUNT(*) AS "업무별 사원수" FROM EMP
GROUP BY JOB;

--(7)사원의 최대 급여와 최소 급여의 차액을 출력하시오.
SELECT MAX(SAL) - MIN(SAL) FROM EMP;

--(8)30번 부서의 구성원 수와 사원들 급여의 합계와 평균을 출력하시오.
SELECT SUM(SAL), AVG(SAL) FROM EMP
WHERE DEPTNO = 30;

--(9)평균급여가 가장 높은 부서의 번호를 출력하시오.
SELECT DEPTNO FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL) = (SELECT MAX(AVG(SAL))
                    FROM EMP
                    GROUP BY DEPTNO);

--(10)세일즈맨을 제외하고, 각 업무별 사원들의 총 급여가 3000 이상인 각 업무에 대해서, 업무명과 각 업무별 평균 급여를 출력하되, 평균급여의 내림차순으로 출력하시오.
SELECT JOB, AVG(SAL) AS 평균급여 FROM EMP
WHERE JOB <> 'SALESMAN' AND SAL >= 3000
GROUP BY JOB
ORDER BY 평균급여 DESC;

--(11) 전체 사원 가운데 직속상관이 있는 사원의 수를 출력하시오.
SELECT COUNT(*) FROM EMP
WHERE MGR IS NOT NULL;

--(12) Emp 테이블에서 이름, 급여, 커미션 금액, 총액(sal + comm)을 구하여 총액이 많은 순서대로 출력하시오. 단, 커미션이 NULL인 사람은 제외한다.
SELECT ENAME, SAL, COMM, SAL + COMM AS 총액 FROM EMP
WHERE COMM IS NOT NULL
ORDER BY 총액 DESC;

--(13) 각 부서별로 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무명, 인원수를 출력하시오.
SELECT DEPTNO, JOB, COUNT(*) FROM EMP
GROUP BY DEPTNO, JOB;

--(14) 사원이 한 명도 없는 부서의 이름을 출력하시오.
SELECT DNAME FROM DEPT
WHERE DEPTNO NOT IN (SELECT DEPTNO FROM EMP
                    GROUP BY DEPTNO
                    HAVING COUNT(*) <> 0);
                    
--(15) 같은 업무를 하는 사람의 수가 4명 이상인 업무와 인원수를 출력하시오.
SELECT JOB, COUNT(*) FROM EMP
GROUP BY DEPTNO, JOB
HAVING COUNT(*) >= 4;

--(16) 사원번호가 7400 이상 7600 이하인 사원의 이름을 출력하시오.
SELECT ENAME FROM EMP
WHERE EMPNO >= 7400 AND EMPNO <= 7600;

--(17) 사원의 이름과 사원의 부서를 출력하시오.
SELECT EMP.ENAME, DEPT.DNAME FROM EMP
INNER JOIN DEPT
ON EMP.DEPTNO = DEPT.DEPTNO;

--(18) 사원의 이름과 팀장의 이름을 출력하시오.
SELECT ENAME AS 팀장 FROM EMP
WHERE EMPNO IN (SELECT DISTINCT(MGR) FROM EMP
                WHERE MGR IS NOT NULL);