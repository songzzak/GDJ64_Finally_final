SELECT * FROM MEMBER_TB JOIN DEPARTMENT_TB USING(DEPT_CODE) JOIN JOB_TB USING(JOB_CODE) WHERE DEPT_NAME = '운영팀';

