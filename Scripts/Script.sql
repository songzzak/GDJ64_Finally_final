SELECT * FROM MEMBER_TB;

SELECT * FROM JOB_TB;

SELECT * FROM DEPARTMENT_TB;

SELECT * FROM MEMBER_TB JOIN DEPARTMENT_TB USING(DEPT_CODE) WHERE DEPT_NAME ='운영팀';